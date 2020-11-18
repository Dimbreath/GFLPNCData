-- params : ...
-- function num : 0 , upvalues : _ENV
local UILevelRewards = class("UILevelRewards", UIBaseNode)
local base = UIBaseNode
local UICommonItem = require("Game.CommonUI.Item.UICommonItem")
local cs_ResLoader = CS.ResLoader
UILevelRewards.Create = function(gameObject)
  -- function num : 0_0 , upvalues : UILevelRewards
  local node = (UILevelRewards.New)()
  node:Init(gameObject)
  return node
end

UILevelRewards.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, cs_ResLoader
  self.OnShowItemDetailEvent = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).mask_Close, self, self.__OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).getReward, self, self.__OnClickGetReward)
  ;
  ((self.ui).firstItem):SetActive(false)
  ;
  ((self.ui).regularItem):SetActive(false)
  self.resloader = (cs_ResLoader.Create)()
  self.firstRewardItems = {}
  self.firstRewardItemPool = {}
  self.regularRewardItems = {}
  self.regularRewardItemPool = {}
  self.sectorNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  self.__OnGetRewardComplete = BindCallback(self, self.OnGetRewardComplete)
  self.__OnSectorStageUpdate = BindCallback(self, self.OnSectorStageUpdate)
  MsgCenter:AddListener(eMsgEventId.PickFirstReward, self.__OnGetRewardComplete)
  MsgCenter:AddListener(eMsgEventId.SectorStateUpdate, self.__OnSectorStageUpdate)
end

UILevelRewards.InitLevelRewards = function(self, sectorStageCfg)
  -- function num : 0_2 , upvalues : _ENV, UICommonItem
  self.__sectorStageCfg = sectorStageCfg
  for _,rewardId in ipairs(sectorStageCfg.first_reward_ids) do
    local rewardNum = (sectorStageCfg.first_reward_nums)[rewardId]
    local itemCfg = (ConfigData.item)[rewardId]
    local rewardItem = nil
    if #self.firstRewardItemPool > 0 then
      rewardItem = (table.remove)(self.firstRewardItemPool, 1)
    else
      local go = ((self.ui).firstItem):Instantiate()
      rewardItem = (UICommonItem.New)()
      rewardItem:Init(go)
    end
    do
      do
        rewardItem:Show()
        rewardItem:InitItem(itemCfg, rewardNum, self.resloader)
        rewardItem.clickEvent = BindCallback(self, self.__OnClickRewardItem)
        ;
        (table.insert)(self.firstRewardItems, rewardItem)
        -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self:OnSectorStageUpdate()
  for _,itemId in ipairs(sectorStageCfg.normal_drop) do
    local itemCfg = (ConfigData.item)[itemId]
    local rewardItem = nil
    if #self.regularRewardItemPool > 0 then
      rewardItem = (table.remove)(self.regularRewardItemPool, 1)
    else
      local go = ((self.ui).regularItem):Instantiate()
      rewardItem = (UICommonItem.New)()
      rewardItem:Init(go)
    end
    do
      do
        rewardItem:Show()
        rewardItem:InitItem(itemCfg, nil, self.resloader)
        rewardItem.clickEvent = BindCallback(self, self.__OnClickRewardItem)
        ;
        (table.insert)(self.regularRewardItems, rewardItem)
        -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

UILevelRewards.__OnClickRewardItem = function(self, item)
  -- function num : 0_3
  if self.OnShowItemDetailEvent ~= nil then
    if self.__clickedItemId ~= item then
      self.__clickedItemId = item
      ;
      (self.OnShowItemDetailEvent)(true, item.itemCfg)
    else
      ;
      (self.OnShowItemDetailEvent)(false)
      self.__clickedItemId = nil
    end
  end
end

UILevelRewards.__OnClickClose = function(self)
  -- function num : 0_4
  self:Hide()
  if self.OnShowItemDetailEvent ~= nil then
    (self.OnShowItemDetailEvent)(false)
  end
end

UILevelRewards.__OnClickGetReward = function(self)
  -- function num : 0_5
  (self.sectorNetworkCtrl):Send_SECTOR_BattleFirstRewardPick((self.__sectorStageCfg).id)
end

UILevelRewards.OnGetRewardComplete = function(self, rewards)
  -- function num : 0_6 , upvalues : _ENV
  if not self.active then
    return 
  end
  local rewardIds = {}
  local rewardNums = {}
  for k,v in pairs(rewards) do
    local itemCfg = (ConfigData.item)[k]
    if itemCfg == nil then
      error("Can\'t find item, id = " .. tostring(k))
      break
    end
    ;
    (table.insert)(rewardIds, k)
    ;
    (table.insert)(rewardNums, v)
  end
  do
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_6_0 , upvalues : rewardIds, rewardNums
    if window == nil then
      return 
    end
    window:InitRewardsItem(rewardIds, rewardNums)
  end
)
  end
end

UILevelRewards.OnSectorStageUpdate = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if not self.active then
    return 
  end
  local stageState = (PlayerDataCenter.sectorStage):GetStageState((self.__sectorStageCfg).id)
  ;
  ((self.ui).tet_getReward):SetIndex(stageState)
  ;
  ((self.ui).getReward_image):SetIndex(stageState)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).getReward).enabled = stageState == proto_object_DungeonStageState.DungeonStageStateCompleted
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UILevelRewards.OnHide = function(self)
  -- function num : 0_8 , upvalues : _ENV
  for k,v in ipairs(self.firstRewardItems) do
    v:Hide()
    ;
    (table.insert)(self.firstRewardItemPool, v)
  end
  self.firstRewardItems = {}
  for k,v in ipairs(self.regularRewardItems) do
    v:Hide()
    ;
    (table.insert)(self.regularRewardItemPool, v)
  end
  self.regularRewardItems = {}
end

UILevelRewards.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.PickFirstReward, self.__OnGetRewardComplete)
  MsgCenter:RemoveListener(eMsgEventId.SectorStateUpdate, self.__OnSectorStageUpdate)
  ;
  (base.OnDelete)(self)
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
end

return UILevelRewards

