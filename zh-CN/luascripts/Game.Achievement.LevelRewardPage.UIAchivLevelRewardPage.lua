-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAchivLevelRewardPage = class("UIAchivLevelRewardPage", UIBaseNode)
local base = UIBaseNode
local UIAchivLevelRewardItem = require("Game.Achievement.LevelRewardPage.UIAchivLevelRewardItem")
local eLevelState = {UnCompleted = 1, Completed = 2, Picked = 3}
UIAchivLevelRewardPage.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).background, self, self.OnClickClose)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.scrollRectIndex = 0
  self.__onGetLevelRewardComplete = BindCallback(self, self.GetLevelRewardComplete)
  self.__onUpdatePlayerLevel = BindCallback(self, self.RefreshAchivLevelReward)
  self.__onUpdatePickedRewardLevel = BindCallback(self, self.RefreshAchivLevelReward)
  MsgCenter:AddListener(eMsgEventId.GetAchivLevelRewardComplete, self.__onGetLevelRewardComplete)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self.__onUpdatePlayerLevel)
  MsgCenter:AddListener(eMsgEventId.UpdatePickedRewardLevel, self.__onUpdatePickedRewardLevel)
  self.achivLevelNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.AchivLevel)
  self.levelRewardItem = {}
end

UIAchivLevelRewardPage.InitAchivLevelRewardPage = function(self, resLoader)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).scrollRect).verticalNormalizedPosition = 1
  self.resLoader = resLoader
  self:RefreshAchivLevelReward(true)
end

UIAchivLevelRewardPage.RefreshAchivLevelReward = function(self, isInit)
  -- function num : 0_2 , upvalues : _ENV, eLevelState
  local maxLevel = (ConfigData.game_config).playerMaxLevel
  local curLevel = (PlayerDataCenter.playerLevel).level
  ;
  ((self.ui).tex_level):SetIndex(0, tostring(curLevel))
  if maxLevel <= curLevel then
    ((self.ui).tex_Process):SetIndex(1)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).exp_Fill).fillAmount = 1
  else
    local exp = (PlayerDataCenter.playerLevel).exp
    local expCeiling = (PlayerDataCenter.playerLevel):GetNextLevelExp()
    ;
    ((self.ui).tex_Process):SetIndex(0, tostring(exp), tostring(expCeiling))
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).exp_Fill).fillAmount = exp / expCeiling
  end
  do
    local levelCfg = (ConfigData.achievement_level)[curLevel]
    if levelCfg == nil then
      error("Can\'t find achievement_level, level = " .. tostring(curLevel))
    else
      local path = PathConsts:GetAchivLevelIconPath(levelCfg.icon)
      local icon = (self.resLoader):LoadABAsset(path)
      -- DECOMPILER ERROR at PC70: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).level_Icon).texture = icon
    end
    do
      self.curLevelList = {}
      for i = 2, maxLevel do
        local levelData = {}
        levelData.level = i
        levelData.state = nil
        if (PlayerDataCenter.playerLevel).level < i then
          levelData.state = eLevelState.UnCompleted
        else
          if ((PlayerDataCenter.achivLevelData).pickedRewardLevels)[i] == nil then
            levelData.state = eLevelState.Completed
          else
            levelData.state = eLevelState.Picked
          end
        end
        ;
        (table.insert)(self.curLevelList, levelData)
      end
      self:__SortLevelItem()
      -- DECOMPILER ERROR at PC111: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).scrollRect).totalCount = #self.curLevelList
      if isInit then
        ((self.ui).scrollRect):RefillCells()
      else
        ;
        ((self.ui).scrollRect):RefreshCells()
      end
    end
  end
end

UIAchivLevelRewardPage.__SortLevelItem = function(self)
  -- function num : 0_3 , upvalues : _ENV, eLevelState
  (table.sort)(self.curLevelList, function(a, b)
    -- function num : 0_3_0 , upvalues : eLevelState
    if a.level >= b.level then
      do return a.state ~= b.state end
      if a.state == eLevelState.Completed then
        return true
      elseif b.state == eLevelState.Completed then
        return false
      elseif a.state == eLevelState.UnCompleted then
        return true
      elseif b.state == eLevelState.UnCompleted then
        return false
      end
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
)
end

UIAchivLevelRewardPage.__GetReward = function(self, level)
  -- function num : 0_4
  (self.achivLevelNetworkCtrl):Send_ACHIEVEMENT_LevelReward(level)
end

UIAchivLevelRewardPage.GetLevelRewardComplete = function(self, rewards)
  -- function num : 0_5 , upvalues : _ENV
  local rewardIds = {}
  local rewardNums = {}
  for k,v in pairs(rewards) do
    (table.insert)(rewardIds, k)
    ;
    (table.insert)(rewardNums, v)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_5_0 , upvalues : rewardIds, rewardNums
    if window == nil then
      return 
    end
    window:InitRewardsItem(rewardIds, rewardNums)
  end
)
end

UIAchivLevelRewardPage.OnClickClose = function(self)
  -- function num : 0_6
  self:Hide()
end

UIAchivLevelRewardPage.__OnNewItem = function(self, go)
  -- function num : 0_7 , upvalues : UIAchivLevelRewardItem
  local item = (UIAchivLevelRewardItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.levelRewardItem)[go] = item
end

UIAchivLevelRewardPage.__OnChangeItem = function(self, go, index)
  -- function num : 0_8 , upvalues : _ENV, eLevelState
  self.scrollRectIndex = index
  local levelItem = (self.levelRewardItem)[go]
  if levelItem == nil then
    error("Can\'t find levelItem by gameObject")
    return 
  end
  local levelData = (self.curLevelList)[index + 1]
  if levelData == nil then
    error("Can\'t find levelData by index, index = " .. tonumber(index))
  end
  local picked = levelData.state == eLevelState.Picked
  levelItem:RefreshLevelRewardItem(levelData.level, picked, BindCallback(self, self.__GetReward))
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIAchivLevelRewardPage.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.GetAchivLevelRewardComplete, self.__onGetLevelRewardComplete)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self.__onUpdatePlayerLevel)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePickedRewardLevel, self.__onUpdatePickedRewardLevel)
  ;
  (base.OnDelete)(self)
end

return UIAchivLevelRewardPage

