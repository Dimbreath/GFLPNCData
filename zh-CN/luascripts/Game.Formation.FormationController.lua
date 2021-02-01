-- params : ...
-- function num : 0 , upvalues : _ENV
local FormationController = class("FormationController", ControllerBase)
local base = ControllerBase
local FormationSceneCtrl = require("Game.Formation.Ctrl.FormationSceneCtrl")
local eFmtFromModule = require("Game.Formation.Enum.eFmtFromModule")
local util = require("XLua.Common.xlua_util")
local RecommeFormationData = require("Game.Formation.Data.RecommeFormationData")
local CS_ResLoader = CS.ResLoader
local CS_Camera = (CS.UnityEngine).Camera
local CS_GameObject = (CS.UnityEngine).GameObject
local CS_MessageCommon = CS.MessageCommon
FormationController.ctor = function(self)
  -- function num : 0_0 , upvalues : FormationSceneCtrl
  self.ctrls = {}
  self.fmtSceneCtrl = (FormationSceneCtrl.New)(self)
end

FormationController.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, CS_ResLoader, CS_Camera, CS_GameObject
  self.heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  self.resloader = (CS_ResLoader.Create)()
  self.__camMain = CS_Camera.main
  self.__lightMain = (CS_GameObject.FindWithTag)(TagConsts.MainLight)
  self.isOpenedOverClock = false
  self.isOpenedCampInfluence = false
  self.isRecommeSortForCount = false
  self.__OnExitFormation = BindCallback(self, self.OnExitFormation)
end

FormationController.InitFromationCtrl = function(self, fromModule, stageId, enterFunc, exitFunc, startBattleFunc, staminaCost, fmtId, specificHeroDataRuler)
  -- function num : 0_2 , upvalues : eFmtFromModule, _ENV, util
  self.enterFunc = enterFunc
  self.exitFunc = exitFunc
  self.startBattleFunc = startBattleFunc
  self.staminaCost = staminaCost
  self.defaultFmtId = fmtId or 1
  self.fromModule = fromModule
  self.stageId = stageId
  self.specificHeroDataRuler = specificHeroDataRuler
  if fromModule == eFmtFromModule.SectorLevel or fromModule == eFmtFromModule.Infinity or fromModule == eFmtFromModule.PeriodicChallenge then
    self.isOpenedOverClock = true
    self.isOpenedCampInfluence = true
    self.isOpenFmtEvaluation = true
  end
  self.__initCoroutine = (GR.StartCoroutine)((util.cs_generator)(BindCallback(self, self.LoadFormation)))
end

FormationController.GetFormatioFromModule = function(self)
  -- function num : 0_3
  return self.fromModule, self.stageId
end

FormationController.LoadFormation = function(self)
  -- function num : 0_4 , upvalues : _ENV
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
    -- function num : 0_4_0 , upvalues : self
    window:OpenCampInfluence(self.isOpenedCampInfluence)
    window:OpenOverClock(self.isOpenedOverClock)
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
  end
end

FormationController.RefreshFomation = function(self, fmtId)
  -- function num : 0_5 , upvalues : _ENV
  self.curSelectFormationId = fmtId
  local formationData = (PlayerDataCenter.formationDic)[fmtId]
  self.curFormation = nil
  if formationData ~= nil then
    self.curFormation = formationData
  else
    self.curFormation = PlayerDataCenter:CreateFormation(fmtId)
  end
  ;
  (self.fmtSceneCtrl):RefreshFmtScene(self.curFormation, true)
end

FormationController.ShowFmtHeroDetail = function(self)
  -- function num : 0_6 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.FmtHeroDetail, function(window)
    -- function num : 0_6_0 , upvalues : self
    window:InitFmtHeroDetail(self.curSelectFormationId, self)
  end
)
end

FormationController.ExitFmtHeroDetail = function(self)
  -- function num : 0_7 , upvalues : _ENV
  UIManager:DeleteWindow(UIWindowTypeID.FmtHeroDetail)
  ;
  (self.fmtSceneCtrl):RefreshFmtScene(self.curFormation)
end

FormationController.ShowCommanderSkillDetail = function(self)
  -- function num : 0_8 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.CommanderSkill, function(window)
    -- function num : 0_8_0 , upvalues : _ENV, self
    if window == nil then
      error("Open Commander Skill UI error")
      return 
    end
    window:InitCommanderSkillWin(self.curSelectFormationId)
  end
)
end

FormationController.ModifyFormation = function(self, newHeroDic)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.curFormation).data = newHeroDic
  ;
  (self.heroNetwork):SendFormationFresh(self.curSelectFormationId, newHeroDic)
end

FormationController.ShowQuickFormation = function(self, heroData)
  -- function num : 0_10 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.FormationQuick, function(window)
    -- function num : 0_10_0 , upvalues : self, _ENV, heroData
    if window ~= nil then
      (self.fmtSceneCtrl):SetFormationCameraActive(false)
      UIManager:HideWindow(UIWindowTypeID.Formation)
      window:OpenFQCampInfluence(self.isOpenedCampInfluence)
      window:InitQuickFmt(self.curSelectFormationId, self, heroData, self.specificHeroDataRuler)
    end
  end
)
end

FormationController.ExitQuickFormation = function(self, isFmtChanged)
  -- function num : 0_11 , upvalues : _ENV
  UIManager:DeleteWindow(UIWindowTypeID.FormationQuick)
  local detailWindow = UIManager:GetWindow(UIWindowTypeID.FmtHeroDetail)
  if detailWindow ~= nil then
    detailWindow:InitFmtHeroDetail(self.curSelectFormationId, self)
  end
  ;
  (self.fmtSceneCtrl):RefreshFmtScene(self.curFormation)
  ;
  (self.fmtSceneCtrl):SetFormationCameraActive(true)
  local formationWindow = UIManager:ShowWindow(UIWindowTypeID.Formation)
  if isFmtChanged and formationWindow ~= nil then
    formationWindow:CallEvaluationAnalysisFormation(self.curSelectFormationId)
  end
end

FormationController.EnableMainCamAndLight = function(self, enable)
  -- function num : 0_12 , upvalues : _ENV
  if not IsNull(self.__camMain) then
    ((self.__camMain).gameObject):SetActive(enable)
  end
  if not IsNull(self.__lightMain) then
    (self.__lightMain):SetActive(enable)
  end
end

FormationController.FmtStartBattle = function(self)
  -- function num : 0_13 , upvalues : _ENV, CS_MessageCommon
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
    (CS_MessageCommon.ShowMessageTips)((string.format)(ConfigData:GetTipContent(TipContent.Sector_HeroNumInsufficient), tostring((ConfigData.game_config).min_stage_hero)))
    return 
  end
  local voHeroId = heroIdList[(math.random)(#heroIdList)]
  local voiceId = ConfigData:GetVoicePointRandom(4)
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  cvCtr:PlayCv(voHeroId, voiceId)
  if self.startBattleFunc ~= nil then
    (self.startBattleFunc)(self.curSelectFormationId, self.__OnExitFormation)
  end
end

FormationController.OnExitFormation = function(self)
  -- function num : 0_14
  self:Delete()
end

FormationController.BenchUnlock = function(benchId, GetUnlockDescription)
  -- function num : 0_15 , upvalues : _ENV
  local sysFuncId = proto_csmsg_SystemFunctionID["SystemFunctionID_bench" .. tostring(benchId)]
  local unlock = (FunctionUnlockMgr:ValidateUnlock(sysFuncId))
  -- DECOMPILER ERROR at PC11: Overwrote pending register: R4 in 'AssignReg'

  local lockStr, stageCfg = .end, nil
  if not unlock and GetUnlockDescription then
    stageCfg = FunctionUnlockMgr:GetFuncUnlockStageCfg(sysFuncId)
  end
  if stageCfg ~= nil then
    lockStr = (string.format)(ConfigData:GetTipContent(161), tostring(stageCfg.sector), tostring(stageCfg.num))
  else
    lockStr = ""
  end
  return unlock, lockStr
end

FormationController.IsCanReqRecomme = function(self, stageId, isShowTip)
  -- function num : 0_16 , upvalues : _ENV, CS_MessageCommon
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Recommend) then
    if isShowTip then
      (CS_MessageCommon.ShowMessageTips)(FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Recommend))
    end
    return false
  end
  local unlockCfg = (ConfigData.system_open)[proto_csmsg_SystemFunctionID.SystemFunctionID_Recommend]
  if stageId <= (unlockCfg.pre_para1)[1] then
    if isShowTip then
      (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Recomme_Forbid))
    end
    return false
  end
  return true
end

FormationController.ReqRecommeFormation = function(self, stageId, isOpenFormationCopy)
  -- function num : 0_17 , upvalues : _ENV
  if not self:IsCanReqRecomme(stageId, true) then
    return 
  end
  self.isOpenFormationCopy = isOpenFormationCopy or false
  self.reqRecordStageId = stageId
  if self.recommeFormationCache ~= nil and (self.recommeFormationCache).stageId == stageId and PlayerDataCenter.timestamp < (self.recommeFormationCache).refreshTime then
    UIManager:ShowWindowAsync(UIWindowTypeID.RecommeFormation, function(window)
    -- function num : 0_17_0 , upvalues : self
    window:InitRecommeFormation(self.isOpenFormationCopy, self.recommeFormationCache, self)
  end
)
  else
    ;
    (self.heroNetwork):CS_RECOMMANDFORMATION_Detail(self.reqRecordStageId)
  end
end

FormationController.ReceiveRecommeFormation = function(self, msg)
  -- function num : 0_18 , upvalues : RecommeFormationData, CS_MessageCommon, _ENV
  self.recommeFormationCache = (RecommeFormationData.CreateData)(self.reqRecordStageId, msg)
  if #(self.recommeFormationCache).list == 0 then
    (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Recomme_Empty))
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.RecommeFormation, function(window)
    -- function num : 0_18_0 , upvalues : self
    window:InitRecommeFormation(self.isOpenFormationCopy, self.recommeFormationCache, self)
  end
)
end

FormationController.ExitRecommeFormation = function(self, singleData)
  -- function num : 0_19 , upvalues : _ENV, CS_MessageCommon
  if singleData == nil then
    return 
  end
  local isChange = false
  local newHeroDic = singleData:CopyFormation()
  local oldHeroDic = ((PlayerDataCenter.formationDic)[self.curSelectFormationId]).data
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
        local detailWindow = UIManager:GetWindow(UIWindowTypeID.FmtHeroDetail)
        if detailWindow ~= nil then
          detailWindow:InitFmtHeroDetail(self.curSelectFormationId, self)
        end
        ;
        (self.fmtSceneCtrl):RefreshFmtScene(self.curFormation)
        if (table.count)(newHeroDic) == singleData:GetHaveCount() then
          (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Recomme_SuccessAll))
        else
          ;
          (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Recomme_SuccessPart))
        end
      else
        do
          ;
          (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Recomme_Sample))
        end
      end
    end
  end
end

FormationController.ExitFormation = function(self)
  -- function num : 0_20
  self:EnableMainCamAndLight(true)
  if self.exitFunc ~= nil then
    (self.exitFunc)()
  end
  self:Delete()
end

FormationController.OnDelete = function(self)
  -- function num : 0_21 , upvalues : _ENV, base
  if self.__initCoroutine ~= nil then
    (GR.StopCoroutine)(self.__initCoroutine)
  end
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

