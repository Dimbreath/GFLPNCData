-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAchievementLevelNode = class("UINAchievementLevelNode", UIBaseNode)
local base = UIBaseNode
local UINAchievementLevelItem = require("Game.Achievement.UI.AchieveLevelUI.UINAchievementLevelItem")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_DoTween = ((CS.DG).Tweening).DOTween
local eLevelState = {UnCompleted = 1, Completed = 2, Picked = 3}
UINAchievementLevelNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  self.achivLevelNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.AchivLevel)
  self.levelItemDic = {}
  self.levelDataList = {}
  self.isOpenDetail = false
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Detail, self, self.OnClickDetail)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnClickDetail)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopList_playerLevelList).onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopList_playerLevelList).onChangeItem = BindCallback(self, self.m_OnChangeItem)
  ;
  (((self.ui).tween_tileSliderNode).onRewind):AddListener(BindCallback(self, self.OnSwitchTweenRewind))
  self.__RefreshPlayerLevel = BindCallback(self, self.RefreshPlayerLevel)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self.__RefreshPlayerLevel)
  MsgCenter:AddListener(eMsgEventId.UpdatePickedRewardLevel, self.__RefreshPlayerLevel)
  self.__onGetLevelRewardComplete = BindCallback(self, self.GetLevelRewardComplete)
  MsgCenter:AddListener(eMsgEventId.GetAchivLevelRewardComplete, self.__onGetLevelRewardComplete)
  self._GetReward = BindCallback(self, self.GetReward)
  self.levelRewardItemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).obj_rewardItem)
  ;
  (((self.ui).obj_rewardItem).gameObject):SetActive(false)
  -- DECOMPILER ERROR at PC103: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).col_ExpBar = ((self.ui).Img_ExpBar).color
  self:RegistAndUpdateRedDot()
end

UINAchievementLevelNode.RegistAndUpdateRedDot = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelReward)
  ;
  ((self.ui).obj_RedDot):SetActive(not ok or node:GetRedDotCount() > 0)
  self.redDotFunc = function(node)
    -- function num : 0_1_0 , upvalues : self
    ((self.ui).obj_RedDot):SetActive(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  RedDotController:AddListener(node.nodePath, self.redDotFunc)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINAchievementLevelNode.OnClickDetail = function(self)
  -- function num : 0_2
  (((self.ui).btn_Return).gameObject):SetActive(not self.isOpenDetail)
  ;
  (((self.ui).btn_Detail).gameObject):SetActive(self.isOpenDetail)
  ;
  ((self.ui).img_isSlideOn):SetActive(not self.isOpenDetail)
  if self.isOpenDetail then
    ((self.ui).tween_tileSliderNode):DOComplete()
    ;
    ((self.ui).tween_tileSliderNode):DOPlayBackwards()
    self.isOpenDetail = false
  else
    ;
    ((self.ui).obj_levelAddition):SetActive(true)
    ;
    ((self.ui).obj_levelList):SetActive(true)
    ;
    ((self.ui).tween_tileSliderNode):DORestart()
    self.isOpenDetail = true
    self:RefreshPlayerLevel(true)
  end
end

UINAchievementLevelNode.OnSwitchTweenRewind = function(self)
  -- function num : 0_3
  ((self.ui).obj_levelAddition):SetActive(false)
  ;
  ((self.ui).obj_levelList):SetActive(false)
end

UINAchievementLevelNode.RefreshPlayerLevel = function(self, isOpen, playTween)
  -- function num : 0_4 , upvalues : _ENV
  local maxLevel = (ConfigData.game_config).playerMaxLevel
  local curLevel = (PlayerDataCenter.playerLevel).level
  if curLevel < 10 then
    ((self.ui).tex_CurPlayerLevel):SetIndex(0, "0", tostring(curLevel))
  else
    ;
    ((self.ui).tex_CurPlayerLevel):SetIndex(0, "", tostring(curLevel))
  end
  if maxLevel <= curLevel then
    if self.processSeq ~= nil then
      (self.processSeq):Kill()
      self.processSeq = nil
    end
    ;
    ((self.ui).tex_Progress):SetIndex(1)
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).Img_ExpBar).color = (self.ui).col_ExpBar
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).Img_ExpBar).fillAmount = 1
  else
    local exp = (PlayerDataCenter.playerLevel).exp
    local expCeiling = (PlayerDataCenter.playerLevel):GetNextLevelExp()
    ;
    ((self.ui).tex_Progress):SetIndex(0, tostring(exp), tostring(expCeiling))
    if not isOpen and playTween then
      self:SetProcessTween(exp / expCeiling, 0.8)
    else
      -- DECOMPILER ERROR at PC81: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).Img_ExpBar).color = (self.ui).col_ExpBar
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).Img_ExpBar).fillAmount = exp / expCeiling
    end
  end
  do
    self:m_RefreshNextLevelInfo(curLevel, maxLevel <= curLevel)
    if self.isOpenDetail then
      self:RefreshLevelList(maxLevel, curLevel, isOpen)
      self:RefreshTotalLogic()
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UINAchievementLevelNode.m_RefreshNextLevelInfo = function(self, curLevel, isMax)
  -- function num : 0_5 , upvalues : _ENV, CommonLogicUtil
  if isMax then
    ((self.ui).obj_levelReward):SetActive(false)
    ;
    ((self.ui).obj_itemList):SetActive(false)
    return 
  else
    ;
    ((self.ui).obj_levelReward):SetActive(true)
    ;
    ((self.ui).obj_itemList):SetActive(true)
  end
  ;
  (self.levelRewardItemPool):HideAll()
  local nextLevel = curLevel + 1
  local nextLevelCfg = (ConfigData.achievement_level)[nextLevel]
  if nextLevelCfg ~= nil then
    for k,id in ipairs(nextLevelCfg.rewardIds) do
      local num = (nextLevelCfg.rewardNums)[k]
      local itemCfg = (ConfigData.item)[id]
      local rewardItem = (self.levelRewardItemPool):GetOne()
      rewardItem:InitItemWithCount(itemCfg, num)
    end
    local logic, para1, para2, para3 = (PlayerDataCenter.achivLevelData):GetLevelLogics(nextLevel)
    local des = ""
    for index,logic in pairs(logic) do
      local para1 = para1[index]
      local para2 = para2[index]
      local para3 = para3[index]
      if (string.IsNullOrEmpty)(des) then
        des = (CommonLogicUtil.GetDesString)(logic, para1, para2, para3)
      else
        des = des .. "\n" .. (CommonLogicUtil.GetDesString)(logic, para1, para2, para3)
      end
    end
    -- DECOMPILER ERROR at PC91: Confused about usage of register: R10 in 'UnsetPending'

    ;
    ((self.ui).tex_LevelBuff).text = des
    ;
    ((self.ui).tex_Level):SetIndex(0, tostring(nextLevel))
  end
end

UINAchievementLevelNode.RefreshAchFinishedNum = function(self, cur, total)
  -- function num : 0_6 , upvalues : _ENV
  ;
  ((self.ui).tex_CompleteNum):SetIndex(0, tostring(cur or 0), tostring(total or 0))
end

UINAchievementLevelNode.RefreshLevelList = function(self, maxLevel, curLevel, isOpen)
  -- function num : 0_7 , upvalues : _ENV, eLevelState
  self.levelDataList = {}
  for i = 2, maxLevel do
    local levelData = {level = i, levelCfg = (ConfigData.achievement_level)[i], state = nil}
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
    (table.insert)(self.levelDataList, levelData)
  end
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

  if ((self.ui).loopList_playerLevelList).totalCount ~= #self.levelDataList then
    ((self.ui).loopList_playerLevelList).totalCount = #self.levelDataList
    ;
    ((self.ui).loopList_playerLevelList):RefillCells()
  else
    ;
    ((self.ui).loopList_playerLevelList):RefreshCells()
  end
  if isOpen then
    local rollIndex = 1
    for index,levelData in ipairs(self.levelDataList) do
      if levelData.state == eLevelState.Completed then
        rollIndex = index
        break
      end
      if levelData.level == curLevel then
        rollIndex = index
        break
      end
    end
    do
      ;
      ((self.ui).loopList_playerLevelList):SrollToCell(rollIndex - 1, 5000)
    end
  end
end

UINAchievementLevelNode.RefreshTotalLogic = function(self)
  -- function num : 0_8 , upvalues : _ENV, CommonLogicUtil
  local des = ""
  local cfg = (ConfigData.achievement_level)[(PlayerDataCenter.playerLevel).level]
  for index,logic in ipairs(cfg.logic) do
    if (string.IsNullOrEmpty)(des) then
      des = (CommonLogicUtil.GetDesString)(logic, (cfg.para1)[index], (cfg.para2)[index], (cfg.para3)[index])
    else
      des = des .. "\n" .. (CommonLogicUtil.GetDesString)(logic, (cfg.para1)[index], (cfg.para2)[index], (cfg.para3)[index])
    end
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Addition).text = des
end

UINAchievementLevelNode.m_OnNewItem = function(self, go)
  -- function num : 0_9 , upvalues : UINAchievementLevelItem, eLevelState
  local levelItem = (UINAchievementLevelItem.New)()
  levelItem:Init(go)
  levelItem:InitLevelItem(eLevelState, self._GetReward)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.levelItemDic)[go] = levelItem
end

UINAchievementLevelNode.m_OnChangeItem = function(self, go, index)
  -- function num : 0_10 , upvalues : _ENV
  local levelItem = (self.levelItemDic)[go]
  if levelItem == nil then
    error("Can\'t find levelItem by gameObject")
    return 
  end
  local levelData = (self.levelDataList)[index + 1]
  if levelData == nil then
    error("Can\'t find levelData by index, index = " .. tonumber(index))
  end
  levelItem:RefreshLevelItem(levelData)
end

UINAchievementLevelNode.GetReward = function(self, level)
  -- function num : 0_11 , upvalues : _ENV
  self._heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
  ;
  (self.achivLevelNetworkCtrl):Send_ACHIEVEMENT_LevelReward(level)
end

UINAchievementLevelNode.GetLevelRewardComplete = function(self, rewards)
  -- function num : 0_12 , upvalues : _ENV
  local rewardIds = {}
  local rewardNums = {}
  for k,v in pairs(rewards) do
    (table.insert)(rewardIds, k)
    ;
    (table.insert)(rewardNums, v)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_12_0 , upvalues : rewardIds, rewardNums, self
    if window == nil then
      return 
    end
    window:InitRewardsItem(rewardIds, rewardNums, self._heroIdSnapShoot)
  end
)
end

UINAchievementLevelNode.SetProcessTween = function(self, setValue, duration)
  -- function num : 0_13 , upvalues : _ENV, cs_DoTween
  if setValue < 0 then
    return 
  end
  if self.processSeq ~= nil then
    (self.processSeq):Kill()
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).Img_ExpBar).color = Color.white
  self.processSeq = (cs_DoTween.Sequence)()
  ;
  (self.processSeq):Append(((self.ui).Img_ExpBar):DOFillAmount(setValue, duration))
  ;
  (self.processSeq):Join((((self.ui).Img_ExpBar):DOColor((self.ui).col_ExpBar, 0.2)):SetLoops(5))
  ;
  (self.processSeq):SetAutoKill(false)
end

UINAchievementLevelNode.OnDelete = function(self)
  -- function num : 0_14 , upvalues : _ENV, base
  if self.processSeq ~= nil then
    (self.processSeq):Kill()
    self.processSeq = nil
  end
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelReward)
  RedDotController:RemoveListener(node.nodePath, self.redDotFunc)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self.__RefreshPlayerLevel)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePickedRewardLevel, self.__RefreshPlayerLevel)
  MsgCenter:RemoveListener(eMsgEventId.GetAchivLevelRewardComplete, self.__onGetLevelRewardComplete)
  ;
  (base.OnDelete)(self)
end

return UINAchievementLevelNode

