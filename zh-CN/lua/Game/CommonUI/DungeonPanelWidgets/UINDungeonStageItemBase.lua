local UINDungeonStageItemBase = class("UINDungeonStageItemBase", UIBaseNode)
local base = UIBaseNode
local FriendshipEnum = require("Game.Friendship.FriendshipEnum")
local eDungeonStageState = (require("Game.Dungeon.DungeonStageData")).eDungeonStageState
UINDungeonStageItemBase.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).levelItem, self, self.__onClick)
  self.onClickAction = nil
  self.mbDropIdList = nil
  self.costItemData = {}
  self.costStrengthNum = 0
  self.state = nil
  self.dailyLimit = 0
  ;
  ((self.ui).obj_Complete):SetActive(false)
end

UINDungeonStageItemBase.InitWithStageData = function(self, dungeonStageData, index, fstRwdPool, mbRwdPool)
  -- function num : 0_1 , upvalues : _ENV, FriendshipEnum
  self.dungeonStageData = dungeonStageData
  self.state = dungeonStageData:GetDungeonStageState()
  if not dungeonStageData:GetDungeonStageIsUnlock() then
    self.lockReason = dungeonStageData:GetDungeonStageUnlockInfo()
    self.lockDatas = dungeonStageData:GetDungeonStageUnlockData()
  end
  self.cfg = dungeonStageData:GetDungeonStageCfg()
  self.chapterId = (self.cfg).id
  local epIndex = (string.format)("%02d", index)
  ;
  ((self.ui).tex_LevelName):SetIndex(0, epIndex)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.gameObject).name = tostring(epIndex)
  self.fstRewardPool = fstRwdPool
  self.mbRewardPool = mbRwdPool
  self.mbDropIdList = (self.cfg).normal_drop
  local costIds = (self.cfg).cost_itemIds
  local costIdNums = (self.cfg).cost_itemNums
  if costIds ~= nil and #costIds > 0 then
    for k,v in ipairs(costIds) do
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R13 in 'UnsetPending'

      if v ~= FriendshipEnum.StaminaeId then
        (self.costItemData)[v] = costIdNums[k]
      else
        self.costStrengthNum = costIdNums[k]
      end
    end
  end
  do
    ;
    ((self.ui).obj_Complete):SetActive((self.dungeonStageData):GetIsReach2Limit())
    self:UpdateChapterData()
  end
end

UINDungeonStageItemBase.InitEmptyStageItem = function(self)
  -- function num : 0_2 , upvalues : eDungeonStageState
  self.state = eDungeonStageState.noData
  ;
  ((self.ui).tex_LevelName):SetIndex(1)
  self:UpdateChapterData()
end

UINDungeonStageItemBase.UpdateChapterData = function(self)
  -- function num : 0_3
  ((self.ui).img_State):SetIndex(self.state)
end

UINDungeonStageItemBase.__onClick = function(self)
  -- function num : 0_4 , upvalues : eDungeonStageState
  if self.state == eDungeonStageState.noData then
    return 
  end
  if self.onClickAction ~= nil then
    local showDetail = (self.onClickAction)(true, self)
    if showDetail then
      self:ShowRewardsItem()
    end
  end
end

UINDungeonStageItemBase.ShowRewardsItem = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.fstRewardPool ~= nil then
    (self.fstRewardPool):HideAll()
    local rewardPicked = PlayerDataCenter:GetTotalBattleTimes(self.chapterId) > 0
    local rwdCount = 0
    for index,rewardId in ipairs((self.cfg).first_reward_ids) do
      local itemCfg = (ConfigData.item)[rewardId]
      if itemCfg == nil then
        error("can not find item,id =" .. tostring(k))
      else
        local rwdItem = (self.fstRewardPool):GetOne()
        local rwdNum = ((self.cfg).first_reward_nums)[index] or 0
        rwdItem:InitBaseItem(itemCfg, nil)
        ;
        ((rwdItem.ui).obj_isPicked):SetActive(rewardPicked)
        -- DECOMPILER ERROR at PC56: Confused about usage of register: R11 in 'UnsetPending'

        ;
        ((rwdItem.ui).tex_Count).text = tostring(rwdNum)
        rwdCount = rwdCount + 1
      end
    end
    if rwdCount <= 1 then
      ((self.ui).obj_EmptyItem):SetActive(true)
    else
      ((self.ui).obj_EmptyItem):SetActive(false)
    end
  end
  if self.mbRewardPool ~= nil then
    (self.mbRewardPool):HideAll()
    for k,v in ipairs(self.mbDropIdList) do
      if v ~= nil then
        local itemCfg = (ConfigData.item)[v]
        if itemCfg == nil then
          error("can not find item,id =" .. tostring(v))
        else
          local rwdItem = (self.mbRewardPool):GetOne()
          rwdItem:InitBaseItem(itemCfg, nil)
        end
      end
    end
  end
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

UINDungeonStageItemBase.OnHide = function(self)
  -- function num : 0_6
  self.onClickAction = nil
  self.mbDropIdList = nil
  self.costItemData = {}
  self.costStrengthNum = 0
  self.state = nil
end

UINDungeonStageItemBase.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINDungeonStageItemBase

