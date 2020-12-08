-- params : ...
-- function num : 0 , upvalues : _ENV
local UIResultSettlement = class("UIResultSettlement", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UICharacterItem = require("Game.BattleResult.UIBattleResultCharacterItem")
local UINResultSettlementHeroItem = require("Game.BattleResult.UINResultSettlementHeroItem")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
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
  self:RefreshEpTeam(backRewards.exp or 0, resultSettlementData.oldHeroLevelDic, resultSettlementData.oldHeroExpDic)
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
    end
  end
end

UIResultSettlement.RefreshCommanderSkillTreeExp = function(self, addCSTExp, oldCSTLevel, oldCSTExp)
  -- function num : 0_4 , upvalues : _ENV
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  local isCSUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
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
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_CommanderAddSkillExp).text = "+" .. tostring(addCSTExp)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_CommanderSkillName).text = treeData:GetName()
  local level, exp, expLimit = treeData:TryAddExp(0)
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R12 in 'UnsetPending'

  ;
  ((self.ui).tex_CommanderSkillLevel).text = level
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R12 in 'UnsetPending'

  ;
  ((self.ui).img_CommanderSkillExp).fillAmount = exp / expLimit
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIResultSettlement.RefreshEpTeam = function(self, addExp, oldHeroLevelDic, oldHeroExpDic)
  -- function num : 0_5 , upvalues : _ENV
  local heroList = ((ExplorationManager.epCtrl).dynPlayer).heroList
  ;
  (self.heroItemPool):HideAll()
  for _,dynHeroData in ipairs(heroList) do
    local heroItem = (self.heroItemPool):GetOne()
    local heroId = dynHeroData.dataId
    heroItem:InitCharacterItem(dynHeroData, self.resloader, nil)
    heroItem:RefershExpData(oldHeroLevelDic[heroId], oldHeroExpDic[heroId], addExp)
  end
  self.playExpAnime = true
end

UIResultSettlement.RefreshEpItemReward = function(self, rewardList)
  -- function num : 0_6 , upvalues : _ENV
  (self.rewardItemPool):HideAll()
  for _,v in pairs(rewardList) do
    local item = (self.rewardItemPool):GetOne()
    item:InitItemWithCount(v.itemCfg, v.num, nil)
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
  ;
  (base.OnDelete)(self)
end

return UIResultSettlement

