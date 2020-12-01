-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroChapterItem = class("UIHeroChapterItem", UIBaseNode)
local base = UIBaseNode
local FriendshipEnum = require("Game.Friendship.FriendshipEnum")
local ChapterState = (require("Game.CommonUI.DungeonPanelWidgets.UIDungeonData.UIDungeonConfig")).ChapterState
UIHeroChapterItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).levelItem, self, self.__onClick)
  self.onClickAction = nil
  self.fstRewardItemData = {}
  self.mbDropIdList = nil
  self.costItemData = {}
  self.costStrengthNum = 0
  self.state = nil
  self.dailyLimit = 0
  self.usedLimit = 0
end

UIHeroChapterItem.CheckDailyLimit = function(self)
  -- function num : 0_1
  do return self.usedLimit < self.dailyLimit end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIHeroChapterItem.InitWithData = function(self, chapterCfg, state, index, fstRwdPool, mbRwdPool, moduleID, lockReason)
  -- function num : 0_2 , upvalues : _ENV, FriendshipEnum
  ((self.ui).obj_Complete):SetActive(false)
  self.lockReason = lockReason
  self.cfg = chapterCfg
  self.state = state
  self.moduleId = moduleID
  self.chapterId = (self.cfg).id
  local epIndex = (string.format)("%02d", index)
  ;
  ((self.ui).tex_LevelName):SetIndex(0, epIndex)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (self.gameObject).name = (((self.ui).tex_LevelName).text).text
  self.fstRewardPool = fstRwdPool
  self.mbRewardPool = mbRwdPool
  local fstRewardIds = (self.cfg).first_reward_ids
  local fstRewardNums = (self.cfg).first_reward_nums
  if fstRewardIds ~= nil and #fstRewardIds > 0 then
    for k,v in ipairs(fstRewardIds) do
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R16 in 'UnsetPending'

      (self.fstRewardItemData)[v] = fstRewardNums[k]
    end
  end
  do
    self.mbDropIdList = (self.cfg).normal_drop
    local costIds = (self.cfg).cost_itemIds
    local costIdNums = (self.cfg).cost_itemNums
    if costIds ~= nil and #costIds > 0 then
      for k,v in ipairs(costIds) do
        -- DECOMPILER ERROR at PC70: Confused about usage of register: R18 in 'UnsetPending'

        if v ~= FriendshipEnum.StaminaeId then
          (self.costItemData)[v] = costIdNums[k]
        else
          self.costStrengthNum = costIdNums[k]
        end
      end
    end
    do
      self:UpdateLimit()
      if not self:CheckDailyLimit() then
        ((self.ui).obj_Complete):SetActive(true)
      end
      self:UpdateChapterData()
    end
  end
end

UIHeroChapterItem.UpdateChapterData = function(self)
  -- function num : 0_3
  ((self.ui).img_State):SetIndex(self.state)
end

UIHeroChapterItem.UpdateLimit = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.dailyLimit = (self.cfg).frequency_day
  if PlayerDataCenter.dungeonDailyBattleTimes ~= nil and (PlayerDataCenter.dungeonDailyBattleTimes)[self.moduleId] ~= nil then
    local dungeonStageDict = ((PlayerDataCenter.dungeonDailyBattleTimes)[self.moduleId]).data
    if dungeonStageDict[self.chapterId] ~= nil then
      self.usedLimit = dungeonStageDict[self.chapterId]
    end
  end
end

UIHeroChapterItem.__onClick = function(self)
  -- function num : 0_5
  if self.onClickAction ~= nil then
    local showDetail = (self.onClickAction)(true, self)
    if showDetail then
      self:ShowRewardsItem()
    end
  end
end

UIHeroChapterItem.ShowRewardsItem = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.fstRewardPool ~= nil then
    (self.fstRewardPool):HideAll()
    local rewardPicked = PlayerDataCenter:GetTotalBattleTimes(self.chapterId) > 0
    local rwdCount = 0
    for k,v in pairs(self.fstRewardItemData) do
      if k ~= nil and v ~= nil then
        local itemCfg = (ConfigData.item)[k]
        if itemCfg == nil then
          error("can not find item,id =" .. tostring(k))
        else
          local rwdItem = (self.fstRewardPool):GetOne()
          rwdItem:InitBaseItem(itemCfg, nil)
          ;
          ((rwdItem.ui).obj_isPicked):SetActive(rewardPicked)
          -- DECOMPILER ERROR at PC53: Confused about usage of register: R10 in 'UnsetPending'

          ;
          ((rwdItem.ui).tex_Count).text = tostring(v)
          rwdCount = rwdCount + 1
        end
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
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

UIHeroChapterItem.OnHide = function(self)
  -- function num : 0_7
  self.onClickAction = nil
  self.fstRewardItemData = {}
  self.mbDropIdList = nil
  self.costItemData = {}
  self.costStrengthNum = 0
  self.state = nil
  self.dailyLimit = 0
  self.usedLimit = 0
end

UIHeroChapterItem.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeroChapterItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroChapterItem = class("UIHeroChapterItem", UIBaseNode)
local base = UIBaseNode
local FriendshipEnum = require("Game.Friendship.FriendshipEnum")
local ChapterState = (require(
                         "Game.CommonUI.DungeonPanelWidgets.UIDungeonData.UIDungeonConfig")).ChapterState
UIHeroChapterItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).levelItem, self, self.__onClick)
    self.onClickAction = nil
    self.fstRewardItemData = {}
    self.mbDropIdList = nil
    self.costItemData = {}
    self.costStrengthNum = 0
    self.state = nil
    self.dailyLimit = 0
    self.usedLimit = 0
end

UIHeroChapterItem.CheckDailyLimit = function(self)
    -- function num : 0_1
    do return self.usedLimit < self.dailyLimit end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIHeroChapterItem.InitWithData = function(self, chapterCfg, state, index,
                                          fstRwdPool, mbRwdPool, moduleID,
                                          lockReason)
    -- function num : 0_2 , upvalues : _ENV, FriendshipEnum
    ((self.ui).obj_Complete):SetActive(false)
    self.lockReason = lockReason
    self.cfg = chapterCfg
    self.state = state
    self.moduleId = moduleID
    self.chapterId = (self.cfg).id
    local epIndex = (string.format)("%02d", index);
    ((self.ui).tex_LevelName):SetIndex(0, epIndex) -- DECOMPILER ERROR at PC28: Confused about usage of register: R9 in 'UnsetPending'
    ;
    (self.gameObject).name = (((self.ui).tex_LevelName).text).text
    self.fstRewardPool = fstRwdPool
    self.mbRewardPool = mbRwdPool
    local fstRewardIds = (self.cfg).first_reward_ids
    local fstRewardNums = (self.cfg).first_reward_nums
    if fstRewardIds ~= nil and #fstRewardIds > 0 then
        for k, v in ipairs(fstRewardIds) do
            -- DECOMPILER ERROR at PC46: Confused about usage of register: R16 in 'UnsetPending'

            (self.fstRewardItemData)[v] = fstRewardNums[k]
        end
    end
    do
        self.mbDropIdList = (self.cfg).normal_drop
        local costIds = (self.cfg).cost_itemIds
        local costIdNums = (self.cfg).cost_itemNums
        if costIds ~= nil and #costIds > 0 then
            for k, v in ipairs(costIds) do
                -- DECOMPILER ERROR at PC70: Confused about usage of register: R18 in 'UnsetPending'

                if v ~= FriendshipEnum.StaminaeId then
                    (self.costItemData)[v] = costIdNums[k]
                else
                    self.costStrengthNum = costIdNums[k]
                end
            end
        end
        do
            self:UpdateLimit()
            if not self:CheckDailyLimit() then
                ((self.ui).obj_Complete):SetActive(true)
            end
            self:UpdateChapterData()
        end
    end
end

UIHeroChapterItem.UpdateChapterData = function(self)
    -- function num : 0_3
    ((self.ui).img_State):SetIndex(self.state)
end

UIHeroChapterItem.UpdateLimit = function(self)
    -- function num : 0_4 , upvalues : _ENV
    self.dailyLimit = (self.cfg).frequency_day
    if PlayerDataCenter.dungeonDailyBattleTimes ~= nil and
        (PlayerDataCenter.dungeonDailyBattleTimes)[self.moduleId] ~= nil then
        local dungeonStageDict =
            ((PlayerDataCenter.dungeonDailyBattleTimes)[self.moduleId]).data
        if dungeonStageDict[self.chapterId] ~= nil then
            self.usedLimit = dungeonStageDict[self.chapterId]
        end
    end
end

UIHeroChapterItem.__onClick = function(self)
    -- function num : 0_5
    if self.onClickAction ~= nil then
        local showDetail = (self.onClickAction)(true, self)
        if showDetail then self:ShowRewardsItem() end
    end
end

UIHeroChapterItem.ShowRewardsItem = function(self)
    -- function num : 0_6 , upvalues : _ENV
    if self.fstRewardPool ~= nil then
        (self.fstRewardPool):HideAll()
        local rewardPicked =
            PlayerDataCenter:GetTotalBattleTimes(self.chapterId) > 0
        local rwdCount = 0
        for k, v in pairs(self.fstRewardItemData) do
            if k ~= nil and v ~= nil then
                local itemCfg = (ConfigData.item)[k]
                if itemCfg == nil then
                    error("can not find item,id =" .. tostring(k))
                else
                    local rwdItem = (self.fstRewardPool):GetOne()
                    rwdItem:InitBaseItem(itemCfg, nil);
                    ((rwdItem.ui).obj_isPicked):SetActive(rewardPicked) -- DECOMPILER ERROR at PC53: Confused about usage of register: R10 in 'UnsetPending'
                    ;
                    ((rwdItem.ui).tex_Count).text = tostring(v)
                    rwdCount = rwdCount + 1
                end
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
        for k, v in ipairs(self.mbDropIdList) do
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
    -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

UIHeroChapterItem.OnHide = function(self)
    -- function num : 0_7
    self.onClickAction = nil
    self.fstRewardItemData = {}
    self.mbDropIdList = nil
    self.costItemData = {}
    self.costStrengthNum = 0
    self.state = nil
    self.dailyLimit = 0
    self.usedLimit = 0
end

UIHeroChapterItem.OnDelete = function(self)
    -- function num : 0_8 , upvalues : base
    (base.OnDelete)(self)
end

return UIHeroChapterItem

