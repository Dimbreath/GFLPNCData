-- params : ...
-- function num : 0 , upvalues : _ENV
local FormationController = class("FormationController", ControllerBase)
local base = ControllerBase
local FormationSceneCtrl = require("Game.Formation.Ctrl.FormationSceneCtrl")
local FmtEnum = require("Game.Formation.FmtEnum")
local util = require("XLua.Common.xlua_util")
local FormationData = require("Game.PlayerData.FormationData")
local VirtualFormationData = require("Game.Formation.Data.VirtualFormationData")
local CS_ResLoader = CS.ResLoader
local CS_Camera = (CS.UnityEngine).Camera
local CS_GameObject = (CS.UnityEngine).GameObject
local CS_MessageCommon = CS.MessageCommon
FormationController.ctor = function(self)
  -- function num : 0_0 , upvalues : FormationSceneCtrl, _ENV
  self.ctrls = {}
  self.fmtSceneCtrl = (FormationSceneCtrl.New)(self)
  self._OnHeroQuickLvUpFunc = BindCallback(self, self._OnHeroQuickLvUp)
end

FormationController.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, CS_ResLoader, CS_Camera, CS_GameObject
  self.heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  self.resloader = (CS_ResLoader.Create)()
  self.__camMain = CS_Camera.main
  self.__lightMain = (CS_GameObject.FindWithTag)(TagConsts.MainLight)
  self:ResetDefaultParam()
  self.__OnExitFormation = BindCallback(self, self.OnExitFormation)
end

FormationController.ResetDefaultParam = function(self)
  -- function num : 0_2
  self.isOpenedCampInfluence = false
  self.isOpenBuffSelect = false
  self.isOpenTotalPower = true
  self.isOpenChangeFmt = true
  self.virtualFormationData = nil
  self.isInEditor = false
  self.couldShowQuickLevelUp = true
  self.isExpShow = true
end

FormationController.InitFromationCtrl = function(self, fromModule, stageId, enterFunc, exitFunc, startBattleFunc, staminaCost, fmtId, specificHeroDataRuler, chipDataList)
  -- function num : 0_3 , upvalues : _ENV, FmtEnum, VirtualFormationData, util
  self:ResetDefaultParam()
  self.enterFunc = enterFunc
  self.exitFunc = exitFunc
  self.startBattleFunc = startBattleFunc
  self.staminaCost = staminaCost
  self.defaultFmtId = fmtId or 1
  self.fromModule = fromModule
  self.stageId = stageId
  self.specificHeroDataRuler = specificHeroDataRuler
  if self.specificHeroDataRuler ~= nil then
    (PlayerDataCenter.specialRuleGenerator):SetSpeicalRuler(self.specificHeroDataRuler)
  end
  self.chipDataList = chipDataList
  if fromModule == (FmtEnum.eFmtFromModule).SectorLevel or fromModule == (FmtEnum.eFmtFromModule).Infinity or fromModule == (FmtEnum.eFmtFromModule).PeriodicChallenge then
    self.isOpenedCampInfluence = true
  else
    if fromModule == (FmtEnum.eFmtFromModule).WeeklyChallenge then
      local skillActive = (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):GetLastWeeklySkillList()
      if skillActive ~= nil and #skillActive > 0 then
        self.virtualFormationData = (VirtualFormationData.New)(nil, skillActive)
      else
        self.virtualFormationData = (VirtualFormationData.New)(self.defaultFmtId)
      end
      local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
      if not saveUserData:GetLastWeeklyChallengeFmt() then
        local weeklyFmt = {}
      end
      for k,lastHeroid in pairs(weeklyFmt) do
        if not (table.contain)((self.specificHeroDataRuler).heroIds, lastHeroid) then
          weeklyFmt = {}
          break
        end
      end
      do
        do
          -- DECOMPILER ERROR at PC93: Confused about usage of register: R13 in 'UnsetPending'

          ;
          ((self.virtualFormationData).formation).data = weeklyFmt
          self.isOpenTotalPower = true
          self.isOpenBuffSelect = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyInitBuff)
          self.isExpShow = false
          self.isOpenedCampInfluence = false
          self.isOpenChangeFmt = false
          self.couldShowQuickLevelUp = false
          self.isOpenFmtEvaluation = true
          self.__initCoroutine = (GR.StartCoroutine)((util.cs_generator)(BindCallback(self, self.LoadFormation)))
        end
      end
    end
  end
end

FormationController.GetFormatioFromModule = function(self)
  -- function num : 0_4
  return self.fromModule, self.stageId
end

FormationController.LoadFormation = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  local path = PathConsts:GetFormationModelPath("Formation")
  local sceneWait = (self.resloader):LoadABAssetAsyncAwait(path)
  ;
  (coroutine.yield)(sceneWait)
  local go = (sceneWait.Result):Instantiate()
  ;
  (self.fmtSceneCtrl):InitFmtSceneCtrl(go, self.specificHeroDataRuler)
  self:EnableMainCamAndLight(false)
  if self.enterFunc ~= nil then
    (self.enterFunc)()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Formation, function(window)
    -- function num : 0_5_0 , upvalues : self
    window:OpenCampInfluence(self.isOpenedCampInfluence)
    window:OpenBuffIdSelect(self.isOpenBuffSelect)
    window:OpenTotalPowerShow(self.isOpenTotalPower)
    window:OpenChangeFmtShow(self.isOpenChangeFmt)
    window:ShowExpLaber(self.isExpShow)
    window:InitUIFormation(self.defaultFmtId, self, self.stageId, self.fromModule, self.staminaCost)
    self.__fmtWindow = window
  end
)
  local detailWindow = nil
  repeat
    (coroutine.yield)(nil)
    detailWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
  until detailWindow ~= nil
  self:RefreshFomation(self.defaultFmtId)
  local heroIdList = {}
  for k,heroId in pairs((self.curFormation).data) do
    (table.insert)(heroIdList, heroId)
  end
  if #heroIdList > 0 then
    local voHeroId = heroIdList[(math.random)(#heroIdList)]
    local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
    cvCtr:PlayCv(voHeroId, ConfigData:GetVoicePointRandom(3))
  end
  do
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    GuideManager:TryTriggerGuide(eGuideCondition.InFormationSpecial)
  end
end

FormationController.RefreshFomation = function(self, fmtId)
  -- function num : 0_6 , upvalues : _ENV
  self.curSelectFormationId = fmtId
  if self.virtualFormationData ~= nil then
    self.curFormation = (self.virtualFormationData).formation
  else
    self.curFormation = (PlayerDataCenter.formationDic)[fmtId]
  end
  if self.curFormation == nil then
    self.curFormation = PlayerDataCenter:CreateFormation(fmtId)
  end
  ;
  (self.fmtSceneCtrl):RefreshFmtScene(self.curFormation, true)
end

FormationController.ShowFmtHeroDetail = function(self)
  -- function num : 0_7
end

FormationController.ExitFmtHeroDetail = function(self)
  -- function num : 0_8
  (self.fmtSceneCtrl):RefreshFmtScene(self.curFormation)
end

FormationController.ShowCommanderSkillDetail = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if not self._formSelectSkillTreeFunc then
    self._formSelectSkillTreeFunc = BindCallback(self, self.FormSelectSkillTree)
    local cmdSkillData = nil
    if self.virtualFormationData ~= nil then
      cmdSkillData = ((self.virtualFormationData).formation).cst
    else
      cmdSkillData = ((PlayerDataCenter.formationDic)[self.curSelectFormationId]):GetFmtCSTData()
    end
    ;
    (ControllerManager:GetController(ControllerTypeId.CommanderSkill, true)):InitCmdSkillCtrl(cmdSkillData, self._formSelectSkillTreeFunc, function()
    -- function num : 0_9_0 , upvalues : self, _ENV
    (self.fmtSceneCtrl):SetFormationCameraActive(false)
    UIManager:HideWindow(UIWindowTypeID.Formation)
  end
)
  end
end

FormationController.FormSelectSkillTree = function(self, treeId, saveData)
  -- function num : 0_10 , upvalues : _ENV
  if self.virtualFormationData ~= nil then
    (self.virtualFormationData):SetCst(treeId, saveData)
    ;
    (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):SetLastWeeklySkillList(saveData.skillActive)
    PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
    MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillChande)
  else
    local saveData = (PlayerDataCenter.CommanderSkillModualData):CreateSavingData(treeId)
    local fmtCSTData = ((PlayerDataCenter.formationDic)[self.curSelectFormationId]).cst
    local changed = false
    if fmtCSTData.treeId == treeId then
      for index,skillId in pairs((fmtCSTData.saving).skillActive) do
        if (saveData.skillActive)[index] ~= skillId then
          changed = true
        end
      end
      for index,skillId in pairs(saveData.skillActive) do
        if ((fmtCSTData.saving).skillActive)[index] == nil or ((fmtCSTData.saving).skillActive)[index] ~= skillId then
          changed = true
        end
      end
      for id,data in pairs((fmtCSTData.saving).skillProficient) do
        if (saveData.skillProficient)[id] == nil or ((saveData.skillProficient)[id]).level ~= data.level then
          changed = true
        end
      end
      for id,data in pairs(saveData.skillProficient) do
        if ((fmtCSTData.saving).skillProficient)[id] == nil or (((fmtCSTData.saving).skillProficient)[id]).level ~= data.level then
          changed = true
        end
      end
    else
      do
        changed = true
        do
          if changed == true then
            local netCtr = NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)
            if netCtr ~= nil then
              netCtr:CS_COMMANDSKILL_SaveFromFormation(self.curSelectFormationId, treeId, saveData)
            end
          end
          ;
          (self.fmtSceneCtrl):SetFormationCameraActive(true)
          UIManager:ShowWindow(UIWindowTypeID.Formation)
        end
      end
    end
  end
end

FormationController.ModifyFormation = function(self, newHeroDic)
  -- function num : 0_11 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.curFormation).data = newHeroDic
  if self.virtualFormationData == nil then
    (self.heroNetwork):SendFormationFresh(self.curSelectFormationId, newHeroDic)
  else
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.virtualFormationData).formation).data = (self.curFormation).data
    local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
    saveUserData:SetLastWeeklyChallengeFmt(((self.virtualFormationData).formation).data)
    PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
  end
end

FormationController.ShowQuickFormation = function(self, heroData)
  -- function num : 0_12 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.FormationQuick, function(window)
    -- function num : 0_12_0 , upvalues : self, _ENV, heroData
    if window ~= nil then
      (self.fmtSceneCtrl):SetFormationCameraActive(false)
      UIManager:HideWindow(UIWindowTypeID.Formation)
      window:OpenFQCampInfluence(self.isOpenedCampInfluence)
      window:InitQuickFmt(self.curFormation, self, heroData, self.specificHeroDataRuler)
    end
  end
)
end

FormationController.ShowHeroState = function(self, heroData, heroDataList)
  -- function num : 0_13 , upvalues : _ENV
  if heroData == nil then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroState, function(win)
    -- function num : 0_13_0 , upvalues : heroData, heroDataList
    if win ~= nil then
      win:InitHeroState(heroData, heroDataList)
    end
  end
)
end

FormationController.ExitQuickFormation = function(self, isFmtChanged)
  -- function num : 0_14 , upvalues : _ENV
  UIManager:DeleteWindow(UIWindowTypeID.FormationQuick)
  ;
  (self.fmtSceneCtrl):RefreshFmtScene(self.curFormation)
  ;
  (self.fmtSceneCtrl):SetFormationCameraActive(true)
  local formationWindow = UIManager:ShowWindow(UIWindowTypeID.Formation)
  if isFmtChanged and formationWindow ~= nil then
    formationWindow:CallEvaluationAnalysisFormation(self.curFormation)
  end
end

FormationController.EnableMainCamAndLight = function(self, enable)
  -- function num : 0_15 , upvalues : _ENV
  if not IsNull(self.__camMain) then
    ((self.__camMain).gameObject):SetActive(enable)
  end
  if not IsNull(self.__lightMain) then
    (self.__lightMain):SetActive(enable)
  end
end

FormationController.FmtStartBattle = function(self)
  -- function num : 0_16 , upvalues : _ENV, CS_MessageCommon
  local count = 0
  local heroIdList = {}
  for i = 1, (ConfigData.game_config).max_stage_hero do
    if ((self.curFormation).data)[i] ~= nil and ((self.curFormation).data)[i] > 0 then
      count = count + 1
      ;
      (table.insert)(heroIdList, ((self.curFormation).data)[i])
    end
  end
  if count < (ConfigData.game_config).min_stage_hero then
    (CS_MessageCommon.ShowMessageTipsWithErrorSound)((string.format)(ConfigData:GetTipContent(TipContent.Sector_HeroNumInsufficient), tostring((ConfigData.game_config).min_stage_hero)))
    return 
  end
  self._voHeroId = heroIdList[(math.random)(#heroIdList)]
  self._voiceId = ConfigData:GetVoicePointRandom(4)
  if self.startBattleFunc ~= nil then
    (self.startBattleFunc)(self.curSelectFormationId, self.__OnExitFormation)
  end
end

FormationController.__GetFmtReuseHeroResDic = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local heroResDic = {}
  for heroId,heroEntity in pairs((self.fmtSceneCtrl).heroEntityIdDic) do
    local resloader = heroEntity:GetHeroEntityLoadedResloader()
    if resloader ~= nil then
      heroResDic[heroId] = resloader
    end
  end
  return heroResDic
end

FormationController.OnExitFormation = function(self)
  -- function num : 0_18 , upvalues : _ENV, FmtEnum
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  cvCtr:PlayCv(self._voHeroId, self._voiceId)
  local gameType = (FmtEnum.GetFmtGameTypeByModuleId)(self.fromModule)
  do
    if gameType == (FmtEnum.eFmtGamePlayType).Exploration and ExplorationManager:IsInExploration() then
      local heroResDic = self:__GetFmtReuseHeroResDic()
      ;
      ((ExplorationManager.epCtrl).sceneCtrl):SaveReuseHeroResloader(heroResDic)
    end
    do
      if gameType == (FmtEnum.eFmtGamePlayType).Dungeon and BattleDungeonManager:InBattleDungeon() then
        local heroResDic = self:__GetFmtReuseHeroResDic()
        ;
        ((BattleDungeonManager.dungeonCtrl).sceneCtrl):SaveReuseHeroResloader(heroResDic)
      end
      self:Delete()
    end
  end
end

FormationController.GetFormationHeroDic = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if self.isInEditor then
    return ((self.fmtSceneCtrl).formationData).data
  else
    return ((PlayerDataCenter.formationDic)[self.curSelectFormationId]).data
  end
end

FormationController.CheckFormationHero = function(self, newHeroDic)
  -- function num : 0_20 , upvalues : _ENV
  local posMax = ConfigData:GetFormationHeroCount()
  for pos,_ in pairs(newHeroDic) do
    if posMax < pos then
      error("formation error")
      return false
    end
  end
  return true
end

FormationController.UpdateFormationHero = function(self, newHeroDic)
  -- function num : 0_21 , upvalues : _ENV
  if newHeroDic == nil then
    return false
  end
  if not self:CheckFormationHero(newHeroDic) then
    return false
  end
  local isChange = false
  local oldHeroDic = self:GetFormationHeroDic()
  if (table.count)(newHeroDic) == (table.count)(oldHeroDic) then
    for key,value in pairs(newHeroDic) do
      if value ~= oldHeroDic[key] then
        isChange = true
        break
      end
    end
  else
    do
      isChange = true
      if isChange then
        self:ModifyFormation(newHeroDic)
        ;
        (self.fmtSceneCtrl):RefreshFmtScene(self.curFormation)
        if self.isInEditor then
          local uiFormationWin = UIManager:GetWindow(UIWindowTypeID.Formation)
          if uiFormationWin ~= nil then
            uiFormationWin:RefreshFormtionEditor()
          end
        end
      end
      do
        return isChange
      end
    end
  end
end

FormationController.ExitFormation = function(self)
  -- function num : 0_22
  self:EnableMainCamAndLight(true)
  if self.exitFunc ~= nil then
    (self.exitFunc)()
  end
  self:Delete()
end

FormationController.UpdateBuffSelected = function(self, buffIds)
  -- function num : 0_23
  if self.virtualFormationData ~= nil then
    if not buffIds then
      (self.virtualFormationData):SetBuffList({})
      if self.specificHeroDataRuler ~= nil then
        local wcData = (self.specificHeroDataRuler):GetWCData()
        wcData:SetLastDebuff(buffIds)
      end
    end
  end
end

FormationController.CalculatePower = function(self, formationData)
  -- function num : 0_24 , upvalues : _ENV
  local totalFtPower = 0
  local totalBenchPower = 0
  local heroPower = 0
  local heroTotalList = {}
  local campCountDic = (table.GetDefaulValueTable)(0)
  for index,heroId in pairs(formationData.data) do
    local heroData = nil
    if self.specificHeroDataRuler ~= nil then
      heroData = (PlayerDataCenter.specialRuleGenerator):GetSpecificHeroData(heroId, self.specificHeroDataRuler)
    else
      heroData = PlayerDataCenter:GetHeroData(heroId)
    end
    if heroData ~= nil then
      local campId = heroData.camp
      campCountDic[campId] = campCountDic[campId] + 1
      heroPower = heroData:GetFightingPower()
      if heroPower ~= 0 then
        (table.insert)(heroTotalList, heroPower)
      end
      if (ConfigData.game_config).max_stage_hero < index then
        totalBenchPower = heroPower + totalBenchPower
      else
        totalFtPower = heroPower + totalFtPower
      end
    end
  end
  ;
  (table.sort)(heroTotalList, function(a, b)
    -- function num : 0_24_0
    do return b < a end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local top5Total = 0
  for i = 1, #heroTotalList do
    if i <= 5 then
      do
        top5Total = top5Total + heroTotalList[i]
        -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local commanderPowerTab = {power = totalFtPower}
  local dynPlayerFtPower = (ConfigData.GetFormulaValue)(eFormulaType.Commander, commanderPowerTab)
  dynPlayerFtPower = (math.floor)(dynPlayerFtPower)
  totalFtPower = totalFtPower + dynPlayerFtPower
  top5Total = top5Total + dynPlayerFtPower
  return totalFtPower, totalBenchPower, campCountDic, top5Total
end

FormationController.ReqFmtHeroLvUp = function(self, fmtIdx, heroId, targetLevel)
  -- function num : 0_25 , upvalues : _ENV
  self._quickLvUpfmtIdx = fmtIdx
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  if heroData ~= nil then
    local isCanLevelUp = heroData:GenHeroCanQuickLevelUp()
    if isCanLevelUp then
      (self.heroNetwork):CS_HERO_Upgrade(heroId, targetLevel, self._OnHeroQuickLvUpFunc)
    else
      error("道具不足 无法升级")
    end
  end
end

FormationController._OnHeroQuickLvUp = function(self)
  -- function num : 0_26 , upvalues : _ENV
  (self.fmtSceneCtrl):ShowHeroQuickLvUpEffect(self._quickLvUpfmtIdx)
  GuideManager:TryTriggerGuide(eGuideCondition.InFormationSpecial)
end

FormationController.EnterEditMode = function(self)
  -- function num : 0_27 , upvalues : _ENV
  self.isInEditor = true
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  ;
  (self.fmtSceneCtrl):PlayTimeLine(function()
    -- function num : 0_27_0 , upvalues : _ENV
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end
)
  local uiFormation = UIManager:GetWindow(UIWindowTypeID.Formation)
  if uiFormation ~= nil then
    uiFormation:OnEnterEditorMode()
  end
end

FormationController.ExitEditMode = function(self)
  -- function num : 0_28 , upvalues : _ENV
  self.isInEditor = false
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  ;
  (self.fmtSceneCtrl):RewindTimeLine(function()
    -- function num : 0_28_0 , upvalues : _ENV
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end
)
  local uiFormation = UIManager:GetWindow(UIWindowTypeID.Formation)
  if uiFormation ~= nil then
    uiFormation:OnExitEditorMode()
  end
end

FormationController.OnDelete = function(self)
  -- function num : 0_29 , upvalues : _ENV, base
  if self.__initCoroutine ~= nil then
    (GR.StopCoroutine)(self.__initCoroutine)
  end
  ;
  (PlayerDataCenter.specialRuleGenerator):CancelSpeicalRulerCache()
  UIManager:DeleteWindow(UIWindowTypeID.Formation)
  ;
  (self.resloader):Put2Pool()
  self.resloader = nil
  for k,v in pairs(self.ctrls) do
    v:OnDelete()
  end
  ;
  (base.OnDelete)(self)
end

return FormationController

