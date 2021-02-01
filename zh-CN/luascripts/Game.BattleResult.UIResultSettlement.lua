-- params : ...
-- function num : 0 , upvalues : _ENV
local UIResultSettlement = class("UIResultSettlement", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINResultSettlementHeroItem = require("Game.BattleResult.UINResultSettlementHeroItem")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local cs_DoTween = ((CS.DG).Tweening).DOTween
UIResultSettlement.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINResultSettlementHeroItem, UINBaseItemWithCount, cs_ResLoader
  self.playExpAnime = false
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnClickBack)
  self.heroItemPool = (UIItemPool.New)(UINResultSettlementHeroItem, (self.ui).obj_heroHeadItem)
  ;
  ((self.ui).obj_heroHeadItem):SetActive(false)
  self.rewardItemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).obj_baseItemWithCount)
  ;
  ((self.ui).obj_baseItemWithCount):SetActive(false)
  ;
  ((self.ui).obj_CommanderLvUp):SetActive(false)
  self.resloader = (cs_ResLoader.Create)()
  self.__updateHandle = BindCallback(self, self.Update)
  UpdateManager:AddUpdate(self.__updateHandle)
end

UIResultSettlement.InitResultSettlement = function(self, isWin, backRewards, rewardList, resultSettlementData)
  -- function num : 0_1 , upvalues : _ENV
  self.isWin = isWin
  if resultSettlementData == nil or backRewards == nil then
    error("UIResultSettlement: can\'t read data backRewards" .. tostring(backRewards) .. "oldData" .. tostring(resultSettlementData))
    self:OnClickBack()
  end
  self:m_ChnageBgColor(isWin)
  self:RefreshLevelName()
  self:RefreshCommanderSkillTreeExp(backRewards.cstExp or 0, resultSettlementData.oldCSTLevel, resultSettlementData.oldCSTExp)
  self:RefreshEpItemReward(rewardList)
  self:RefreshEpTeam(backRewards, resultSettlementData)
end

UIResultSettlement.m_ChnageBgColor = function(self, isWin)
  -- function num : 0_2
  local resultBG_Material = ((self.ui).img_ResultBG).material
  if isWin then
    resultBG_Material:SetFloat("_Decoloration", 0)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_ResultBG).color = (self.ui).col_Success
  else
    resultBG_Material:SetFloat("_Decoloration", 1)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_ResultBG).color = (self.ui).col_Over
  end
end

UIResultSettlement.RefreshLevelName = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local moduleId = ExplorationManager:GetEpModuleId()
  local stageCfg = ExplorationManager:GetSectorStageCfg()
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    ((self.ui).tex_LevelName):SetIndex(0, tostring(stageCfg.sector) .. "-" .. tostring(stageCfg.num))
  else
    if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
      local endlessCfg = stageCfg.endlessCfg
      ;
      ((self.ui).tex_LevelName):SetIndex(1, tostring(endlessCfg.index * 10))
    else
      do
        if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
          ((self.ui).tex_LevelName):SetIndex(2)
        end
      end
    end
  end
end

UIResultSettlement.RefreshCommanderSkillTreeExp = function(self, addCSTExp, oldCSTLevel, oldCSTExp)
  -- function num : 0_4 , upvalues : _ENV, cs_DoTween
  local isCSUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
  local CSTId = ((ExplorationManager.epCtrl).dynPlayer):GetCSTId()
  local couldShowCSTExp = not isCSUnlock or CSTId ~= nil
  ;
  ((self.ui).obj_unlocked):SetActive(couldShowCSTExp)
  ;
  ((self.ui).obj_locked):SetActive(not couldShowCSTExp)
  if not couldShowCSTExp then
    return 
  end
  local treeData = ((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic)[CSTId]
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_CommanderAddSkillExp).text = "+" .. tostring(addCSTExp)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_CommanderSkillName).text = treeData:GetName()
  local level, addLevel, exp, expLimit = treeData:TryAddExp(0)
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R12 in 'UnsetPending'

  ;
  ((self.ui).tex_CommanderSkillLevel).text = level
  if addLevel > 0 then
    ((self.ui).obj_CommanderLvUp):SetActive(true)
  end
  local lastDiff = (PlayerDataCenter.CommanderSkillModualData):GetCSLastDiff()
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R13 in 'UnsetPending'

  if lastDiff == nil or (table.count)(lastDiff) == 0 then
    ((self.ui).img_CommanderSkillExp).fillAmount = exp / expLimit
    return 
  end
  local oldCfg = (ConfigData.commander_skill_level)[lastDiff.oldTreelevel]
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R14 in 'UnsetPending'

  if oldCfg == nil then
    ((self.ui).img_CommanderSkillExp).fillAmount = 0
  else
    -- DECOMPILER ERROR at PC91: Confused about usage of register: R14 in 'UnsetPending'

    ((self.ui).img_CommanderSkillExp).fillAmount = lastDiff.oldTreeExp / oldCfg.exp
  end
  if self.skillSequence ~= nil then
    (self.skillSequence):Kill()
  end
  self.skillSequence = (cs_DoTween.Sequence)()
  for i = 1, addLevel do
    ((self.skillSequence):Append(((self.ui).img_CommanderSkillExp):DOFillAmount(1, 0.3))):AppendCallback(function()
    -- function num : 0_4_0 , upvalues : self
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((self.ui).img_CommanderSkillExp).fillAmount = 0
  end
)
  end
  ;
  (self.skillSequence):Append(((self.ui).img_CommanderSkillExp):DOFillAmount(exp / expLimit, 0.3))
  ;
  (self.skillSequence):Play()
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

UIResultSettlement.RefreshEpTeam = function(self, backRewards, resultSettlementData)
  -- function num : 0_5 , upvalues : _ENV
  local oldHeroLevelDic = resultSettlementData.oldHeroLevelDic
  local oldHeroExpDic = resultSettlementData.oldHeroExpDic
  local heroList = ((ExplorationManager.epCtrl).dynPlayer).heroList
  ;
  (self.heroItemPool):HideAll()
  for _,dynHeroData in ipairs(heroList) do
    local heroItem = (self.heroItemPool):GetOne()
    local heroId = dynHeroData.dataId
    heroItem:InitCharacterItem(dynHeroData, self.resloader, nil)
    heroItem:RefershExpData(oldHeroLevelDic[heroId], oldHeroExpDic[heroId], backRewards.exp or 0)
    heroItem:RefreshFriendShipData(backRewards.intimacy or 0)
  end
  self.playExpAnime = true
end

UIResultSettlement.RefreshEpItemReward = function(self, rewardList)
  -- function num : 0_6 , upvalues : _ENV
  ExplorationManager:RewardSort(rewardList)
  ;
  (self.rewardItemPool):HideAll()
  for i,v in pairs(rewardList) do
    do
      local item = (self.rewardItemPool):GetOne()
      item:InitItemWithCount(v.itemCfg, v.num, function()
    -- function num : 0_6_0 , upvalues : _ENV, rewardList, i
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      -- function num : 0_6_0_0 , upvalues : rewardList, i
      if win ~= nil then
        win:InitListDetail(rewardList, i)
      end
    end
)
  end
)
    end
  end
end

UIResultSettlement.m_isRandomAth = function(self, rewardId)
  -- function num : 0_7
  if rewardId >= 8000 and rewardId < 9000 then
    return true
  end
  return false
end

UIResultSettlement.Update = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.playExpAnime then
    local hasnotFinish = false
    for _,heroItem in ipairs((self.heroItemPool).listItem) do
      local isFinish = heroItem:UpdateExp()
      if not isFinish then
        hasnotFinish = true
      end
    end
    if not hasnotFinish then
      self.playExpAnime = false
    end
  end
end

UIResultSettlement.OnClickBack = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.isWin then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    avgPlayCtrl:TryPlayTaskAvg(2, function()
    -- function num : 0_9_0 , upvalues : self, _ENV
    self:Delete()
    ExplorationManager:ExitExploration()
  end
)
  else
    do
      self:Delete()
      ExplorationManager:ExitExploration()
    end
  end
end

UIResultSettlement.OnDelete = function(self)
  -- function num : 0_10 , upvalues : _ENV, base
  UpdateManager:RemoveUpdate(self.__updateHandle)
  if self.resloaders ~= nil then
    (self.resloaders):Put2Pool()
    self.resloaders = nil
  end
  if self.skillSequence ~= nil then
    (self.skillSequence):Kill()
    self.skillSequence = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIResultSettlement

