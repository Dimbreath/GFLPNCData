local FormationController = class("FormationController", ControllerBase)
local base = ControllerBase
local FormationSceneCtrl = require("Game.Formation.Ctrl.FormationSceneCtrl")
local FmtEnum = require("Game.Formation.FmtEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local util = require("XLua.Common.xlua_util")
local VirtualFormationData = require("Game.Formation.Data.VirtualFormationData")
local FriendSupportHeroData = require("Game.Formation.Data.FriendSupportHeroData")
local CheckerTypeId, _ = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local FormationUtil = require("Game.Formation.FormationUtil")
local CS_Input = (CS.UnityEngine).Input
local CS_ResLoader = CS.ResLoader
local CS_Camera = (CS.UnityEngine).Camera
local CS_GameObject = (CS.UnityEngine).GameObject
local CS_MessageCommon = CS.MessageCommon
local BattleUtil = require("Game.Battle.BattleUtil")
FormationController.ctor = function(self)
  -- function num : 0_0 , upvalues : FormationSceneCtrl, _ENV
  self.ctrls = {}
  self.fmtSceneCtrl = (FormationSceneCtrl.New)(self)
  self._OnHeroQuickLvUpFunc = BindCallback(self, self._OnHeroQuickLvUp)
  self._heroChangedIdDic = {}
end

FormationController.OnInit = function(self)
  -- function num : 0_1 , upvalues : CS_Input, _ENV, CS_ResLoader, CS_Camera, CS_GameObject
  self.__multiTouchEnabledBeforeOpen = CS_Input.multiTouchEnabled
  CS_Input.multiTouchEnabled = false
  self.heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  self.resloader = (CS_ResLoader.Create)()
  self.__camMain = CS_Camera.main
  self.__lightMain = (CS_GameObject.FindWithTag)(TagConsts.MainLight)
  self:ResetDefaultParam()
  self.__AfterStartBattleExitFormation = BindCallback(self, self.AfterStartBattleExitFormation)
  self.__TryFixFormatoionCST = BindCallback(self, self.TryFixFormatoionCST)
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__TryFixFormatoionCST)
  self.__UpdateHeroForFmtInfo = BindCallback(self, self._OnUpdateHero)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__UpdateHeroForFmtInfo)
  self._OnHeroAthChangeFunc = BindCallback(self, self._OnHeroAthChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroAthChange, self._OnHeroAthChangeFunc)
  self._TryUpdateSupporeDatas = BindCallback(self, self.TryUpdateSupporeDatas)
  MsgCenter:AddListener(eMsgEventId.OnSupportHoreNeedFresh, self._TryUpdateSupporeDatas)
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
  self.isStaminaShow = true
  self.isFriendSupport = false
  self.isFriendSupportTimeLimitted = false
  self.isFriendSupportHaveTimeLimit = false
  self.forbidSupport = false
end

FormationController.InitFromationCtrl = function(self, fromModule, stageId, enterFunc, exitFunc, startBattleFunc, staminaCost, fmtId, specificHeroDataRuler, chipDataList, forbidSupport)
  -- function num : 0_3 , upvalues : _ENV, FmtEnum, VirtualFormationData, util
  self:ResetDefaultParam()
  self.enterFunc = enterFunc
  self.exitFunc = exitFunc
  self.startBattleFunc = startBattleFunc
  self.staminaCost = staminaCost
  self.defaultFmtId = fmtId or 1
  self.forbidSupport = forbidSupport
  self.fromModule = fromModule
  self.stageId = stageId
  self:_InitFmtFixed()
  self.specificHeroDataRuler = specificHeroDataRuler
  if self.specificHeroDataRuler ~= nil then
    (PlayerDataCenter.specialRuleGenerator):SetSpeicalRuler(self.specificHeroDataRuler)
  end
  self.chipDataList = chipDataList
  if fromModule == (FmtEnum.eFmtFromModule).SectorLevel or fromModule == (FmtEnum.eFmtFromModule).Infinity or fromModule == (FmtEnum.eFmtFromModule).PeriodicChallenge then
    self.isOpenedCampInfluence = true
    self.isOpenTotalPower = not self.isFmtCtrlFixed
  else
    if fromModule == (FmtEnum.eFmtFromModule).WeeklyChallenge then
      local treeId, skillActive = (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):GetLastWeeklySkillList()
      if skillActive ~= nil and #skillActive > 0 then
        self.virtualFormationData = (VirtualFormationData.New)(treeId, skillActive, self.specificHeroDataRuler)
      else
        self.virtualFormationData = (VirtualFormationData.New)(nil, nil, self.specificHeroDataRuler)
      end
      ;
      (self.virtualFormationData):TryRestoreFormation()
      self.isOpenTotalPower = true
      self.isOpenBuffSelect = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyInitBuff)
      self.isExpShow = false
      self.isOpenedCampInfluence = false
      self.isOpenChangeFmt = false
      self.couldShowQuickLevelUp = false
    else
      do
        if fromModule == (FmtEnum.eFmtFromModule).DailyDungeon or fromModule == (FmtEnum.eFmtFromModule).DailyDungeonLevel then
          self.isStaminaShow = false
          self.fmtDailyDungeonDyncData = (PlayerDataCenter.dungeonDyncData):GetDailyDungeonDyncData()
          self.isOpenTotalPower = false
        end
        self.isOpenFmtEvaluation = true
        if (PlayerDataCenter.formationDic)[fmtId] == nil and self.virtualFormationData == nil then
          PlayerDataCenter:CreateFormation(fmtId)
        end
        self:_InitSupport()
        self.__initCoroutine = (GR.StartCoroutine)((util.cs_generator)(BindCallback(self, self.LoadFormation)))
      end
    end
  end
end

FormationController._InitSupport = function(self)
  -- function num : 0_4 , upvalues : FmtEnum, _ENV
  local fromModule = self.fromModule
  if fromModule == (FmtEnum.eFmtFromModule).DailyDungeonLevel then
    fromModule = (FmtEnum.eFmtFromModule).DailyDungeon
  end
  local supportLimitCfg = (ConfigData.support_limit)[fromModule]
  if supportLimitCfg ~= nil then
    self.isFriendSupportHaveTimeLimit = supportLimitCfg.is_limited
    if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Support) then
      local isSupportUnlock = (PlayerDataCenter.friendDataCenter):IsFriendDataCenterInited()
    end
    if supportLimitCfg.is_open and isSupportUnlock then
      self.isFriendSupport = not self.forbidSupport
      if self.isFriendSupportHaveTimeLimit then
        local counterElem = (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterMoudleSupportLimit, 0)
        if PlayerDataCenter.timestamp >= counterElem.nextExpiredTm or self:GetSupportTimeLimit() > counterElem.times then
          do
            self.isFriendSupportTimeLimitted = counterElem == nil
            if fromModule == (FmtEnum.eFmtFromModule).DailyDungeon then
              if isSupportUnlock then
                do
                  self.isFriendSupport = not self.forbidSupport
                  -- DECOMPILER ERROR: 4 unprocessed JMP targets
                end
              end
            end
          end
        end
      end
    end
  end
end

FormationController._InitFmtFixed = function(self)
  -- function num : 0_5 , upvalues : FmtEnum, _ENV, FormationUtil
  self.isFmtCtrlFixed = false
  if self.fromModule ~= (FmtEnum.eFmtFromModule).SectorLevel then
    return 
  end
  local sectorCfg = (ConfigData.sector_stage)[self.stageId]
  if sectorCfg == nil then
    error("cant get sectorCfg, id = " .. tostring(self.stageId))
    return 
  end
  local fixedHeroTeamId = sectorCfg.fixed_hero_team
  if fixedHeroTeamId == 0 then
    return 
  end
  ;
  (FormationUtil.SetFiexdFmt)(self.defaultFmtId, fixedHeroTeamId)
  self.isFmtCtrlFixed = true
end

FormationController.GetFormatioFromModule = function(self)
  -- function num : 0_6
  return self.fromModule, self.stageId
end

FormationController.GetSupportTimeLimit = function(self)
  -- function num : 0_7 , upvalues : _ENV
  return (ConfigData.game_config).supportTimeLimit + (PlayerDataCenter.playerBonus):GetSupportCountAddtion()
end

FormationController.LoadFormation = function(self)
  -- function num : 0_8 , upvalues : _ENV, CS_Camera
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  local path = PathConsts:GetFormationModelPath("Formation")
  local sceneWait = (self.resloader):LoadABAssetAsyncAwait(path)
  ;
  (coroutine.yield)(sceneWait)
  local go = (sceneWait.Result):Instantiate()
  ;
  (self.fmtSceneCtrl):InitFmtSceneCtrl(go)
  self:EnableMainCamAndLight(false)
  local customLight = (CS_Camera.main):GetComponent(typeof(CS.CustomLight))
  if customLight ~= nil then
    customLight:RefreshCharacterShadow()
    customLight:RefreshCharacterOutline()
  end
  if self.enterFunc ~= nil then
    (self.enterFunc)()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Formation, function(window)
    -- function num : 0_8_0 , upvalues : self
    window:OpenCampInfluence(self.isOpenedCampInfluence)
    window:OpenBuffIdSelect(self.isOpenBuffSelect)
    window:OpenTotalPowerShow(self.isOpenTotalPower)
    window:OpenChangeFmtShow(self.isOpenChangeFmt)
    window:SetFmtTopResShow(self.isExpShow, self.isStaminaShow)
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
  for k,heroId in pairs((self.curFormation):GetFormationHeroList(true)) do
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
  -- function num : 0_9 , upvalues : _ENV
  self.curSelectFormationId = fmtId
  if self.virtualFormationData ~= nil then
    self.curFormation = (self.virtualFormationData).formation
  else
    self.curFormation = (PlayerDataCenter.formationDic)[fmtId]
  end
  if self.curFormation == nil then
    self.curFormation = PlayerDataCenter:CreateFormation(fmtId)
  else
    self:CheckAndSyncIllegalCST()
  end
  if self.fmtDailyDungeonDyncData ~= nil then
    (self.curFormation):CleanSupportData()
    ;
    (self.fmtSceneCtrl):RefreshFmtScene(self.curFormation, true)
  end
end

FormationController.TryFixFormatoionCST = function(self, conditionId)
  -- function num : 0_10 , upvalues : CheckerTypeId, _ENV
  if conditionId ~= CheckerTypeId.CompleteStage then
    return 
  end
  if not self:CheckAndSyncIllegalCST() then
    return 
  end
  MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillChande)
  local cstCtrl = ControllerManager:GetController(ControllerTypeId.CommanderSkill)
  if cstCtrl ~= nil then
    cstCtrl:RefreshCmdSkillCtrl((self.curFormation):GetFmtCSTData())
  end
end

FormationController.CheckAndSyncIllegalCST = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if not (self.curFormation):IsIllegalCST(true) then
    return false
  end
  if self.virtualFormationData ~= nil then
    return false
  end
  local cmdSkillData = (self.curFormation):GetFmtCSTData()
  local treeId = cmdSkillData.treeId
  local skills = cmdSkillData:GetUsingCmdSkillList()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)):CS_COMMANDSKILL_SaveFromFormation(self.curSelectFormationId, treeId, skills)
  return true
end

FormationController.ShowFmtHeroDetail = function(self)
  -- function num : 0_12
end

FormationController.ExitFmtHeroDetail = function(self)
  -- function num : 0_13
  (self.fmtSceneCtrl):RefreshFmtScene(self.curFormation)
end

FormationController.GetFixedCstSkills = function(self)
  -- function num : 0_14 , upvalues : FmtEnum, BattleUtil, _ENV
  local gameType = (FmtEnum.GetFmtGameTypeByModuleId)()
  if self.fromModule ~= (FmtEnum.eFmtFromModule).SectorLevel then
    return false
  end
  return (BattleUtil.TryGetFixedCstSkills)(proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, self.stageId)
end

FormationController.ShowCommanderSkillDetail = function(self)
  -- function num : 0_15 , upvalues : CS_MessageCommon, _ENV
  local isFixed, _ = self:GetFixedCstSkills()
  if isFixed then
    (CS_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.CstFixed))
    return 
  end
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
    -- function num : 0_15_0 , upvalues : self, _ENV
    (self.fmtSceneCtrl):SetFormationCameraActive(false)
    UIManager:HideWindow(UIWindowTypeID.Formation)
  end
)
  end
end

FormationController.FormSelectSkillTree = function(self, saveData)
  -- function num : 0_16 , upvalues : _ENV
  if self.virtualFormationData ~= nil then
    (self.virtualFormationData):SetCst(saveData)
    ;
    (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):SetLastWeeklySkillList(saveData.treeId, saveData:GetUsingCmdSkillList())
    PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
    MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillChande)
  else
    local changed = false
    local fmtCSTData = ((PlayerDataCenter.formationDic)[self.curSelectFormationId]):GetFmtCSTData()
    if fmtCSTData.treeId ~= treeId then
      changed = true
    else
      for slot,skillId in ipairs(fmtCSTData:GetUsingCmdSkillList()) do
        if saveData[slot] ~= skillId then
          changed = true
          break
        end
      end
    end
    do
      do
        if changed then
          local netCtr = NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)
          if netCtr ~= nil then
            netCtr:CS_COMMANDSKILL_SaveFromFormation(self.curSelectFormationId, saveData.treeId, saveData:GetUsingCmdSkillList(), function()
    -- function num : 0_16_0 , upvalues : self, saveData
    self._fmtCommanderskillChange = true
    self._fmtCommanderskillNewTreeId = saveData.treeId
    self._fmtIsChange = true
  end
)
          end
        end
        ;
        (self.fmtSceneCtrl):SetFormationCameraActive(true)
        UIManager:ShowWindow(UIWindowTypeID.Formation)
      end
    end
  end
end

FormationController.ModifyFormation = function(self, formationData, newHeroDic)
  -- function num : 0_17 , upvalues : _ENV
  (self.curFormation):ModifyFormationData(formationData, newHeroDic)
  if self.virtualFormationData == nil then
    (self.heroNetwork):SendFormationFresh(self.curSelectFormationId, (self.curFormation):GetFormationHeroList(true))
  else
    local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
    saveUserData:SetLastWeeklyChallengeFmt(((self.virtualFormationData).formation):GetFormationHeroList(true))
    PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
  end
  do
    self._fmtIsChange = true
  end
end

FormationController.ShowQuickFormation = function(self, heroData)
  -- function num : 0_18 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.FormationQuick, function(window)
    -- function num : 0_18_0 , upvalues : self, _ENV, heroData
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
  -- function num : 0_19 , upvalues : _ENV
  if heroData == nil then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroState, function(win)
    -- function num : 0_19_0 , upvalues : heroData, heroDataList
    if win ~= nil then
      win:InitHeroState(heroData, heroDataList)
    end
  end
)
end

FormationController.ExitQuickFormation = function(self, isFmtChanged)
  -- function num : 0_20 , upvalues : _ENV
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
  -- function num : 0_21 , upvalues : _ENV
  if not IsNull(self.__camMain) then
    ((self.__camMain).gameObject):SetActive(enable)
  end
  if not IsNull(self.__lightMain) then
    (self.__lightMain):SetActive(enable)
  end
end

FormationController.FmtStartBattle = function(self)
  -- function num : 0_22 , upvalues : _ENV, CS_MessageCommon
  local count = 0
  local heroIdList = {}
  for i = 1, (ConfigData.game_config).max_stage_hero do
    if ((self.curFormation):GetFormationHeroList())[i] ~= nil and ((self.curFormation):GetFormationHeroList())[i] > 0 then
      count = count + 1
      ;
      (table.insert)(heroIdList, ((self.curFormation):GetFormationHeroList())[i])
    end
  end
  if (self.curFormation):GetIsOnlyHaveSupportHero() then
    (CS_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Formation_OnlyHaveASupportHero))
    return 
  end
  if count < (ConfigData.game_config).min_stage_hero then
    (CS_MessageCommon.ShowMessageTipsWithErrorSound)((string.format)(ConfigData:GetTipContent(TipContent.Sector_HeroNumInsufficient), tostring((ConfigData.game_config).min_stage_hero)))
    return 
  end
  self._voHeroId = heroIdList[(math.random)(#heroIdList)]
  self._voiceId = ConfigData:GetVoicePointRandom(4)
  if self.startBattleFunc ~= nil then
    (self.startBattleFunc)(self.curFormation, self.__AfterStartBattleExitFormation)
  end
  ;
  (PlayerDataCenter.supportHeroData):CleanCachedSupportData()
end

FormationController.__GetFmtReuseHeroResDic = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local heroResDic = {}
  for heroId,heroEntity in pairs((self.fmtSceneCtrl).heroEntityIdDic) do
    local resloader = heroEntity:GetHeroEntityLoadedResloader()
    if resloader ~= nil then
      heroResDic[heroId] = resloader
    end
  end
  return heroResDic
end

FormationController.AfterStartBattleExitFormation = function(self)
  -- function num : 0_24 , upvalues : _ENV, FmtEnum
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  cvCtr:PlayCv(self._voHeroId, self._voiceId)
  if ExplorationManager:IsInTDExp() or BattleDungeonManager:IsInTDDungeon() then
    self:Delete()
    return 
  end
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
  -- function num : 0_25 , upvalues : _ENV
  if self.isInEditor then
    return ((self.fmtSceneCtrl).formationData):GetFormationHeroList()
  else
    return ((PlayerDataCenter.formationDic)[self.curSelectFormationId]):GetFormationHeroList()
  end
end

FormationController.CheckFormationHero = function(self, newHeroDic)
  -- function num : 0_26 , upvalues : _ENV
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
  -- function num : 0_27 , upvalues : _ENV
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
        self:ModifyFormation(nil, newHeroDic)
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
  -- function num : 0_28 , upvalues : FmtEnum, _ENV
  local inDailyDungeon = self.fromModule == (FmtEnum.eFmtFromModule).DailyDungeon
  if inDailyDungeon and (self._fmtIsChange or self.curSelectFormationId ~= self.defaultFmtId) then
    if inDailyDungeon then
      local commandSkillChanged = self._fmtCommanderskillChange
    end
    local heroChangedIdDic = table.emptytable
    if inDailyDungeon then
      heroChangedIdDic = {}
      for index,heroId in pairs((self.curFormation).data) do
        if (self._heroChangedIdDic)[heroId] then
          heroChangedIdDic[heroId] = true
        end
      end
    end
    self._commandSkillChanged = commandSkillChanged
    if not self._OnBattleFmtChangeFunc then
      do
        self._OnBattleFmtChangeFunc = BindCallback(self, self._OnBattleFmtChange)
        ;
        (NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)):CS_BATTLE_FormationFresh(self.curFormation, commandSkillChanged, heroChangedIdDic, self._OnBattleFmtChangeFunc)
        self:_OnExitFormation()
        -- DECOMPILER ERROR: 8 unprocessed JMP targets
      end
    end
  end
end

FormationController._OnBattleFmtChange = function(self, objList)
  -- function num : 0_29 , upvalues : _ENV, BattleUtil
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return 
  end
  local msg = objList[0]
  local curBattleSceneCtrl = (BattleUtil.GetCurSceneCtrl)()
  local dynPlayer = ((BattleUtil.GetCurDynPlayer)())
  local treeId = nil
  if self.curFormation ~= nil and (self.curFormation).cst ~= nil then
    treeId = ((self.curFormation).cst).treeId
  end
  dynPlayer:InitPlayerSkill(msg.commandSkill, treeId)
  local addHeroList, newHeroList, removeHeroList = dynPlayer:ChangeDynPlayerHeroList((msg.roleSync).enter, (msg.roleSync).quit, (msg.roleSync).change)
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  local epWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if epWindow ~= nil then
    epWindow:ReInitDungeonHeroList(dynPlayer)
  end
  curBattleSceneCtrl:ChangeEpHeroModel(removeHeroList, addHeroList, function()
    -- function num : 0_29_0 , upvalues : _ENV, self
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    self:_OnExitFormation()
  end
)
end

FormationController._OnExitFormation = function(self)
  -- function num : 0_30 , upvalues : _ENV
  self:EnableMainCamAndLight(true)
  if self.exitFunc ~= nil then
    (self.exitFunc)(self.curSelectFormationId)
  end
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  self:Delete()
end

FormationController.UpdateBuffSelected = function(self, buffIds)
  -- function num : 0_31
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
  -- function num : 0_32 , upvalues : _ENV
  local totalFtPower = 0
  local totalBenchPower = 0
  local heroPower = 0
  local heroTotalList = {}
  local campCountDic = (table.GetDefaulValueTable)(0)
  for index,heroId in pairs(formationData:GetFormationHeroList()) do
    local heroData = nil
    if self.specificHeroDataRuler ~= nil then
      heroData = (PlayerDataCenter.specialRuleGenerator):GetSpecificHeroData(heroId, self.specificHeroDataRuler)
    else
      heroData = formationData:GetFormationHeroData(index)
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
    -- function num : 0_32_0
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
  -- function num : 0_33 , upvalues : _ENV
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
  -- function num : 0_34 , upvalues : _ENV
  (self.fmtSceneCtrl):ShowHeroQuickLvUpEffect(self._quickLvUpfmtIdx)
  AudioManager:PlayAudioById(1126)
  GuideManager:TryTriggerGuide(eGuideCondition.InFormationSpecial)
end

FormationController.EnterEditMode = function(self)
  -- function num : 0_35 , upvalues : _ENV
  self.isInEditor = true
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  local uiFormation = UIManager:GetWindow(UIWindowTypeID.Formation)
  if uiFormation ~= nil then
    uiFormation:OnEnterEditorMode()
  end
  ;
  (self.fmtSceneCtrl):PlayTimeLine(function()
    -- function num : 0_35_0 , upvalues : _ENV
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end
, function()
    -- function num : 0_35_1 , upvalues : uiFormation, _ENV, self
    if uiFormation ~= nil then
      for index,heroEntity in pairs((self.fmtSceneCtrl).heroEntityDic) do
        uiFormation:UpdateFmtHeroInfo(heroEntity.heroData, heroEntity:__GetInfoPos(), true)
      end
    end
  end
)
end

FormationController.ExitEditMode = function(self)
  -- function num : 0_36 , upvalues : _ENV
  self.isInEditor = false
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  local uiFormation = UIManager:GetWindow(UIWindowTypeID.Formation)
  if uiFormation ~= nil then
    uiFormation:OnExitEditorMode()
  end
  ;
  (self.fmtSceneCtrl):RewindTimeLine(function()
    -- function num : 0_36_0 , upvalues : _ENV
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end
, function()
    -- function num : 0_36_1 , upvalues : uiFormation, _ENV, self
    if uiFormation ~= nil then
      for index,heroEntity in pairs((self.fmtSceneCtrl).heroEntityDic) do
        uiFormation:UpdateFmtHeroInfo(heroEntity.heroData, heroEntity:__GetInfoPos(), true)
      end
    end
  end
)
end

FormationController.IsFmtCtrlFiexd = function(self)
  -- function num : 0_37
  return self.isFmtCtrlFixed
end

FormationController.HasFmtFixedHeroIndex = function(self, fmtIndex)
  -- function num : 0_38 , upvalues : _ENV
  if not self:IsFmtCtrlFiexd() then
    return false
  end
  local formationData = (PlayerDataCenter.formationDic)[self.defaultFmtId]
  if formationData == nil then
    return false
  end
  local heroData = formationData:GetFormationHeroData(fmtIndex)
  do return heroData ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

FormationController._OnUpdateHero = function(self, heroUpdateIdDic)
  -- function num : 0_39 , upvalues : _ENV
  for heroId,v in pairs(heroUpdateIdDic) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

    (self._heroChangedIdDic)[heroId] = true
    self._fmtIsChange = true
  end
end

FormationController._OnHeroAthChange = function(self, heroId)
  -- function num : 0_40
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._heroChangedIdDic)[heroId] = true
  self._fmtIsChange = true
end

FormationController.TryUpdateSupporeDatas = function(self)
  -- function num : 0_41 , upvalues : _ENV
  local supportHeroData = (self.curFormation):GetRealSupportHeroData()
  local fmtSupportHeroData = ((self.fmtSceneCtrl).formationData):GetRealSupportHeroData()
  local uiFormation = UIManager:GetWindow(UIWindowTypeID.Formation)
  local selectedSupportHero = false
  if ((uiFormation.editorNode).supportHero).heroData == nil then
    selectedSupportHero = uiFormation == nil
    if supportHeroData == nil and fmtSupportHeroData == nil and not selectedSupportHero then
      return 
    end
    local fixCfg = (PlayerDataCenter.supportHeroData):GetCurFormationLevelEffectByAllHero(PlayerDataCenter.heroDic)
    if fixCfg ~= self.__caheFixCfg then
      self.__caheFixCfg = fixCfg
      if supportHeroData ~= nil then
        supportHeroData:UseFixCfg2ChangeSupportorAttr(fixCfg)
      end
      if fmtSupportHeroData ~= nil then
        fmtSupportHeroData:UseFixCfg2ChangeSupportorAttr(fixCfg)
      end
      if selectedSupportHero then
        ((uiFormation.editorNode).supportHero):UpdateFixCfg(fixCfg)
      end
    end
    do
      if fmtSupportHeroData ~= nil then
        local supportorIndex = (((self.fmtSceneCtrl).formationData):GetSupportHeroData()).formIdx
        ;
        (self.fmtSceneCtrl):RefreshSupportHeroInfo(supportorIndex)
      end
      -- DECOMPILER ERROR: 7 unprocessed JMP targets
    end
  end
end

FormationController.CacheStrangerSupportHeroDic = function(self, allSupportHeroDataDic, nextRefreshTm, friendsBanData, userInfoDic)
  -- function num : 0_42 , upvalues : _ENV
  (PlayerDataCenter.supportHeroData):SetCachedSupportData(allSupportHeroDataDic, nextRefreshTm, friendsBanData, userInfoDic)
  if self.__selectedSupportHero ~= nil then
    local uid = ((self.__selectedSupportHero):GetUserInfo()):GetUserUID()
    local heroId = (self.__selectedSupportHero).dataId
    if allSupportHeroDataDic[uid] == nil or (allSupportHeroDataDic[uid])[heroId] == nil then
      self:CacheSelectedSupportHero(nil)
      ;
      (self.curFormation):CleanSupportData()
      if self.isInEditor then
        local uiFormation = UIManager:GetWindow(UIWindowTypeID.Formation)
        if uiFormation ~= nil then
          (uiFormation.editorNode):ClearSupportCard()
        end
      end
    end
  end
end

FormationController.GetStrangerSupportHeroDic = function(self)
  -- function num : 0_43 , upvalues : _ENV
  return (PlayerDataCenter.supportHeroData):GetCachedSupportData()
end

FormationController.CacheSelectedSupportHero = function(self, supportHeroData)
  -- function num : 0_44 , upvalues : _ENV
  if self.fmtDailyDungeonDyncData ~= nil then
    (PlayerDataCenter.dungeonDyncData):CacheDailyDgFmtFriendSupportHeroData(supportHeroData)
  end
  self.__selectedSupportHero = supportHeroData
end

FormationController.GetCacheSelectedSupportHero = function(self)
  -- function num : 0_45 , upvalues : _ENV
  if self.fmtDailyDungeonDyncData ~= nil then
    return (PlayerDataCenter.dungeonDyncData):GetDailyDgFmtFriendSupportHeroDataCache()
  end
  return self.__selectedSupportHero
end

FormationController.GetMapLogic = function(self)
  -- function num : 0_46 , upvalues : FmtEnum, _ENV, ExplorationEnum
  if self.fromModule == (FmtEnum.eFmtFromModule).SectorLevel then
    local sectorStageCfg = (ConfigData.sector_stage)[self.stageId]
    if sectorStageCfg == nil then
      error("sectorStageCfg is nil ,id:" .. tostring())
      return nil
    end
    local expFloorList = sectorStageCfg.exploration_list
    local expCfg = (ConfigData.exploration)[expFloorList[1]]
    return expCfg.map_logic
  else
    do
      if self.fromModule == (FmtEnum.eFmtFromModule).Infinity then
        local sectorId = self.stageId // 1000
        local index = self.stageId % 100
        local endless = ((ConfigData.endless)[sectorId])[index]
        if endless == nil then
          error("endless is nil , id:" .. tostring(self.stageId))
          return nil
        end
        local layerCfg = (ConfigData.endless_layer)[(endless.layer)[1]]
        local expCfg = (ConfigData.exploration)[(layerCfg.map_para)[1]]
        return expCfg.map_logic
      else
        do
          if self.fromModule == (FmtEnum.eFmtFromModule).WeeklyChallenge then
            local weeklyData = (PlayerDataCenter.allWeeklyChallengeData):GetWeeklyChallengeDataByDungeonId(self.stageId)
            if weeklyData == nil then
              error(" weeklyChallenge is nil ,id:" .. tostring(self.stageId))
              return nil
            end
            return weeklyData:GetMapLogic()
          else
            do
              if self.fromModule == (FmtEnum.eFmtFromModule).DailyDungeon or self.fromModule == (FmtEnum.eFmtFromModule).DailyDungeonLevel then
                return (ExplorationEnum.eMapLogic).Default
              end
            end
          end
        end
      end
    end
  end
end

FormationController.OnDelete = function(self)
  -- function num : 0_47 , upvalues : _ENV, FormationUtil, CS_Input, base
  if self.__initCoroutine ~= nil then
    (GR.StopCoroutine)(self.__initCoroutine)
  end
  ;
  (PlayerDataCenter.specialRuleGenerator):CancelSpeicalRulerCache()
  if self:IsFmtCtrlFiexd() then
    (FormationUtil.ClearFiexdFmt)(self.defaultFmtId)
  end
  MsgCenter:RemoveListener(eMsgEventId.OnHeroAthChange, self._OnHeroAthChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__UpdateHeroForFmtInfo)
  MsgCenter:RemoveListener(eMsgEventId.OnSupportHoreNeedFresh, self._TryUpdateSupporeDatas)
  UIManager:DeleteWindow(UIWindowTypeID.Formation)
  ;
  (self.resloader):Put2Pool()
  self.resloader = nil
  CS_Input.multiTouchEnabled = self.__multiTouchEnabledBeforeOpen
  for k,v in pairs(self.ctrls) do
    v:OnDelete()
  end
  ;
  (base.OnDelete)(self)
end

return FormationController

