-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Common.CommonGameCtrl.DungeonSceneBaseCtrl")
local ExplorationSceneCtrl = class("ExplorationSceneCtrl", base)
local CS_CameraController = CS.CameraController
local CS_PlayState_Playing = (((CS.UnityEngine).Playables).PlayState).Playing
local CS_BattleManager = (CS.BattleManager).Instance
local CS_RenderMgr = (CS.RenderManager).Instance
local cs_ResLoader = CS.ResLoader
local cs_BattlePosData = CS.BattlePosData
local util = require("XLua.Common.xlua_util")
local Cs_coroutine = require("XLua.Common.cs_coroutine")
local HeroSkillData = require("Game.PlayerData.Skill.HeroSkillData")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local eCamControlState = {None = 0, Exploration = 1, Battle = 2}
ExplorationSceneCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV, ExplorationEnum
  self.epCtrl = epCtrl
  ;
  (table.insert)((self.epCtrl).ctrls, self)
  self.resloader = ((CS.ResLoader).Create)()
  self.__effectPool = {}
  self.__effectInUseDic = {}
  self.__onRecycleEffect = BindCallback(self, self.__RecycleEffect)
  self.__epSceneState = (ExplorationEnum.eEpSceneState).None
  self.__OnEpSceneLoadRole = BindCallback(self, self.OnEpSceneLoadRole)
  MsgCenter:AddListener(eMsgEventId.OnEpSceneLoadRole, self.__OnEpSceneLoadRole)
  self.__onShowRoleHeadBar = BindCallback(self, self.ShowBattleCanvasTween)
  MsgCenter:AddListener(eMsgEventId.OnShowRoleHeadBar, self.__onShowRoleHeadBar)
  self.__onPlayerMoveComplete = BindCallback(self, self.OnPlayerMoveComplete)
  MsgCenter:AddListener(eMsgEventId.OnEpPlayerMoveComplete, self.__onPlayerMoveComplete)
  self.__onShowEpUI = BindCallback(self, self.ShowExplorationUI)
  MsgCenter:AddListener(eMsgEventId.OnShowExplorationUI, self.__onShowEpUI)
  self.__onChangeRoomSelectAudio = BindCallback(self, self.OnChangeRoomSelectAudio)
  MsgCenter:AddListener(eMsgEventId.OnChangeEpRoomSelectAudio, self.__onChangeRoomSelectAudio)
  self.__onSkipTimeline = BindCallback(self, self.OnSkipTimeline)
  self.__onStartTimelineCompleteGeneral = BindCallback(self, self.OnStartTimelineCompleteGeneral)
  self.__onEpToBattleNormalComplete = BindCallback(self, self.OnEpToBattleNormalCompleteGeneral)
  self.__onEpToBattleReconnetedComplete = BindCallback(self, self.OnExpToBatleInReconnectedComplete)
  self.__onBattleToEpComplete = BindCallback(self, self.OnBattleToEpComplete)
  self.__onSceneLoaded = BindCallback(self, self.__OnSceneEnter)
  self._onEnterEpAvgCompleteFunc = BindCallback(self, self._OnEnterEpAvgComplete)
  self.skipEpTimeline = (GR.SkipEpTimeline)()
end

ExplorationSceneCtrl.GetBattleFieldSizeBySceneId = function(self)
  -- function num : 0_1
  return ((self.epCtrl).mapData):GetBattleFieldSize()
end

ExplorationSceneCtrl.ChangeEpSceneState = function(self, state)
  -- function num : 0_2 , upvalues : ExplorationEnum, CS_RenderMgr, _ENV
  if state == self.__epSceneState then
    return 
  end
  local lastSceneState = self.__epSceneState
  self.__epSceneState = state
  if self.__epSceneState == (ExplorationEnum.eEpSceneState).InBattleScene then
    ((self.epCtrl).mapCtrl):HideMapCavas()
    CS_RenderMgr:ResetShaderLODGlobal()
    if ((self.epCtrl):GetCurrentRoomData()):IsRealBossRoom() then
      local moduleId = ExplorationManager:GetEpModuleId()
      if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
        local stageId = (ExplorationManager:GetSectorStageCfg()).id
        local curFloor = ExplorationManager:GetCurLevelIndex() + 1
        ;
        ((ExplorationManager.epCtrl).battleCtrl):SetCanShowNewEnemyDetail(false)
        ;
        (ControllerManager:GetController(ControllerTypeId.AvgPlay, true)):TryPlayAvg(eAvgTriggerType.MainAvgEp, stageId, curFloor, 1, function()
    -- function num : 0_2_0 , upvalues : _ENV
    ((ExplorationManager.epCtrl).battleCtrl):SetCanShowNewEnemyDetail(true)
    ;
    ((ExplorationManager.epCtrl).battleCtrl):AutoShowNewEnemyDetail()
  end
)
      end
    end
    do
      if self.epSceneEntity ~= nil then
        ((self.epSceneEntity):GetEpMapCamera()).enabled = false
      end
      if self.__epSceneState == (ExplorationEnum.eEpSceneState).InEpScene then
        CS_RenderMgr:SetShaderLODGlobal(300)
        GuideManager:TryTriggerGuide(eGuideCondition.InExplorationScene)
      else
        if self.__epSceneState == (ExplorationEnum.eEpSceneState).InTimeline then
          CS_RenderMgr:ResetShaderLODGlobal()
        end
      end
      if lastSceneState == (ExplorationEnum.eEpSceneState).InBattleScene and self.epSceneEntity ~= nil then
        ((self.epSceneEntity):GetEpMapCamera()).enabled = true
      end
      MsgCenter:Broadcast(eMsgEventId.OnEpSceneStateChanged, self.__epSceneState)
    end
  end
end

ExplorationSceneCtrl.InBattleScene = function(self)
  -- function num : 0_3 , upvalues : ExplorationEnum
  do return self.__epSceneState == (ExplorationEnum.eEpSceneState).InBattleScene end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ExplorationSceneCtrl.FirstEnterScene = function(self, enterSceneAction, startTimelineAction)
  -- function num : 0_4 , upvalues : _ENV, util
  self.firstEnterComplelte = false
  self.loadRoleComplete = false
  self.showEpUIComplete = false
  local sceneCfg = ((self.epCtrl).mapData):GetEpSceneCfg()
  self.__enterSceneAction = enterSceneAction
  self.__startTimelineAction = startTimelineAction
  self.heroPrefabs = {}
  self.heroObjectDic = {}
  local preLoadFunc = function()
    -- function num : 0_4_0 , upvalues : self
    self:__InitDungeonSceneEffect()
    self:__PreLoadCharacterAndSkill((self.epCtrl).dynPlayer, self.heroPrefabs, self.heroObjectDic, true)
  end

  local preLoadFunc2 = function()
    -- function num : 0_4_1 , upvalues : self
    (self.epCtrl):GenExplorationMap()
  end

  local sectorId = ((self.epCtrl).mapData):GetEpSceneSectorId()
  self.epSceneEntity = (((EpSceneConfig[sceneCfg.id]).EpSceneClass).New)(sceneCfg.scene_name, self)
  ;
  (self.epSceneEntity):LoadArenaSceneForce(self.__onSceneLoaded, (util.cs_generator)(preLoadFunc), (util.cs_generator)(preLoadFunc2))
end

ExplorationSceneCtrl.__OnSceneEnter = function(self)
  -- function num : 0_5 , upvalues : ExplorationEnum
  if self.__enterSceneAction ~= nil then
    (self.__enterSceneAction)()
    self.__enterSceneAction = nil
  end
  ;
  (self.epSceneEntity):OnSceneLoadedPlay(self.__onStartTimelineCompleteGeneral)
  self:ChangeEpSceneState((ExplorationEnum.eEpSceneState).InTimeline)
  if self.skipEpTimeline then
    (self.epSceneEntity):EndOnSceneLoadedTimeLine()
    if not self.loadRoleComplete then
      self:OnEpSceneLoadRole()
    end
    if not self.showEpUIComplete then
      self:ShowExplorationUI()
    end
  else
    self:ShowSkipWindow(false)
  end
end

ExplorationSceneCtrl.OnChangeRoomSelectAudio = function(self)
  -- function num : 0_6 , upvalues : _ENV
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Sector).name, (eAuSelct.Sector).roomSelect)
end

ExplorationSceneCtrl.OnEpSceneLoadRole = function(self)
  -- function num : 0_7 , upvalues : _ENV, util
  if self.firstEnterComplelte or self.heroPrefabs == nil then
    return 
  end
  self.firstEnterComplelte = true
  local previewAniFunc = function()
    -- function num : 0_7_0 , upvalues : self, _ENV
    local dynPlayer = (self.epCtrl).dynPlayer
    local heroRandList = {}
    for heroId,dynHero in pairs(dynPlayer.heroDic) do
      if dynHero ~= nil then
        local tmp = {id = dynHero.dataId, weight = (math.random)()}
        ;
        (table.insert)(heroRandList, tmp)
      end
    end
    ;
    (table.sort)(heroRandList, function(a, b)
      -- function num : 0_7_0_0
      do return a.weight < b.weight end
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
)
    for k,v in pairs(heroRandList) do
      local heroId = v.id
      local dynHero = (dynPlayer.heroDic)[heroId]
      if dynHero ~= nil then
        local heroGo = (self.heroObjectDic)[dynHero.dataId]
        heroGo:SetActive(true)
        if not self.loadRoleComplete then
          local effect = self:GetRoleAppearEffect()
          effect:Play((heroGo.transform).position)
          ;
          (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(0.1))
        end
      end
    end
    if not self.loadRoleComplete then
      (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(1.5))
    end
    if self.loadRoleComplete then
      self:DeleteSkipWindow()
      self:_TryTriggerStartTimelineEndAction()
    else
      self.loadRoleComplete = true
    end
    self.__loadRoleCoroutine = nil
  end

  self.__loadRoleCoroutine = (GR.StartCoroutine)((util.cs_generator)(previewAniFunc))
end

ExplorationSceneCtrl.OnStartTimelineCompleteGeneral = function(self)
  -- function num : 0_8 , upvalues : _ENV, CS_CameraController, eCamControlState
  MsgCenter:RemoveListener(eMsgEventId.OnEpSceneLoadRole, self.__OnEpSceneLoadRole)
  ;
  (CS_CameraController.Instance):SetControlState(eCamControlState.Exploration)
  local moduleId = ExplorationManager:GetEpModuleId()
  if (self.epCtrl):IsFirstEnterEp() and moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local stageId = (ExplorationManager:GetSectorStageCfg()).id
    local curFloor = ExplorationManager:GetCurLevelIndex() + 1
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
    if avgPlayCtrl:TryPlayAvg(eAvgTriggerType.MainAvgEp, stageId, curFloor, 2, self._onEnterEpAvgCompleteFunc) then
      self._isPlayingEnterEpAvg = true
    end
  end
  do
    if self.loadRoleComplete then
      self:DeleteSkipWindow()
      self:_TryTriggerStartTimelineEndAction()
    else
      self.loadRoleComplete = true
    end
  end
end

ExplorationSceneCtrl._OnEnterEpAvgComplete = function(self)
  -- function num : 0_9
  self._isPlayingEnterEpAvg = false
  if self.loadRoleComplete then
    self:_TryTriggerStartTimelineEndAction()
  end
end

ExplorationSceneCtrl._TryTriggerStartTimelineEndAction = function(self)
  -- function num : 0_10
  if not self._isPlayingEnterEpAvg and self.__startTimelineAction ~= nil then
    (self.__startTimelineAction)()
    self.__startTimelineAction = nil
  end
end

ExplorationSceneCtrl.ExplorationToBattleSceneNormal = function(self, dir, mapRoot, roomPosition, epToBattleAction)
  -- function num : 0_11 , upvalues : CS_CameraController, eCamControlState, ExplorationEnum
  self.__epToBattleAction = epToBattleAction
  ;
  (CS_CameraController.Instance):BattleCameraReset()
  ;
  (CS_CameraController.Instance):SetControlState(eCamControlState.None)
  local tlIndex = (self.epSceneEntity):CalculateExpToBattleNormalTL(dir)
  ;
  (self.epSceneEntity):OnStartBattlePlay(self.__onEpToBattleNormalComplete)
  self:ChangeEpSceneState((ExplorationEnum.eEpSceneState).InTimeline)
  if ((tlIndex == 1 and tlIndex ~= 2)) or self.skipEpTimeline then
    (self.epSceneEntity):EndOnStartBattleTimeLine()
  else
    self:ShowSkipWindow()
    self:TweenRoomToScreenCenter(mapRoot, roomPosition)
  end
end

ExplorationSceneCtrl.OnEpToBattleNormalCompleteGeneral = function(self)
  -- function num : 0_12 , upvalues : ExplorationEnum
  self:DeleteSkipWindow()
  self:ChangeEpSceneState((ExplorationEnum.eEpSceneState).InBattleScene)
  if self.__epToBattleAction ~= nil then
    (self.__epToBattleAction)()
    self.__epToBattleAction = nil
  end
  if self.__resetMapPosAction ~= nil then
    (self.__resetMapPosAction)()
    self.__resetMapPosAction = nil
  end
end

ExplorationSceneCtrl.ExplorationToBattleSceneInReconnected = function(self, epToBattleAction)
  -- function num : 0_13 , upvalues : CS_CameraController, eCamControlState, ExplorationEnum
  self.__epToBattleAction = epToBattleAction
  ;
  (CS_CameraController.Instance):BattleCameraReset()
  ;
  (CS_CameraController.Instance):SetControlState(eCamControlState.None)
  ;
  (self.epSceneEntity):OnReconnectToBattlePlay(self.__onEpToBattleReconnetedComplete)
  self:ChangeEpSceneState((ExplorationEnum.eEpSceneState).InTimeline)
  if self.skipEpTimeline then
    (self.epSceneEntity):EndOnReconnectToBattleTimeLine()
  else
    self:ShowSkipWindow()
  end
end

ExplorationSceneCtrl.OnExpToBatleInReconnectedComplete = function(self)
  -- function num : 0_14 , upvalues : ExplorationEnum
  self:DeleteSkipWindow()
  self:ChangeEpSceneState((ExplorationEnum.eEpSceneState).InBattleScene)
  if self.__epToBattleAction ~= nil then
    (self.__epToBattleAction)()
    self.__epToBattleAction = nil
  end
end

ExplorationSceneCtrl.BattleToExplorationScene = function(self, battleToEpAction)
  -- function num : 0_15 , upvalues : ExplorationEnum
  self.showEpUIComplete = false
  self.__battleToEpAction = battleToEpAction
  ;
  (self.epSceneEntity):EpRoomCoverBattleMap()
  ;
  (self.epSceneEntity):OnExitBattlePlay(self.__onBattleToEpComplete)
  ;
  ((self.epCtrl).mapCtrl):EpMapFadeTweenBack()
  self:ChangeEpSceneState((ExplorationEnum.eEpSceneState).InTimeline)
  if self.skipEpTimeline then
    (self.epSceneEntity):EndOnExitBattleTimeLine()
    if not self.showEpUIComplete then
      self:ShowExplorationUI()
    end
  else
    self:ShowSkipWindow()
  end
end

ExplorationSceneCtrl.OnBattleToEpComplete = function(self)
  -- function num : 0_16 , upvalues : ExplorationEnum, CS_CameraController, eCamControlState, _ENV
  self:DeleteSkipWindow()
  self:ChangeEpSceneState((ExplorationEnum.eEpSceneState).InEpScene)
  ;
  (CS_CameraController.Instance):SetControlState(eCamControlState.Exploration)
  for _,heroObject in pairs(self.heroObjectDic) do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

    (heroObject.transform).localScale = Vector3.one
  end
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).BattleToEp)
end

ExplorationSceneCtrl.ShowSkipWindow = function(self, clickClose)
  -- function num : 0_17 , upvalues : _ENV
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(self.__onSkipTimeline, false, nil, Color.clear, clickClose)
end

ExplorationSceneCtrl.DeleteSkipWindow = function(self)
  -- function num : 0_18 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
end

ExplorationSceneCtrl.OnSkipTimeline = function(self)
  -- function num : 0_19 , upvalues : CS_PlayState_Playing
  self.onLoadCompleteTL = (self.epSceneEntity):GetOnSceneLoadedTL()
  local skipTime = (self.onLoadCompleteTL).duration
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  if (self.onLoadCompleteTL).state == CS_PlayState_Playing and (self.onLoadCompleteTL).time < skipTime then
    (self.onLoadCompleteTL).time = skipTime
    if not self.loadRoleComplete then
      self:OnEpSceneLoadRole()
    end
    if not self.showEpUIComplete then
      self:ShowExplorationUI()
    end
  end
  self.OnExitBattleTL = (self.epSceneEntity):GetOnExitBattleTL()
  skipTime = (self.OnExitBattleTL).duration
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

  if (self.OnExitBattleTL).state == CS_PlayState_Playing and (self.OnExitBattleTL).time < skipTime then
    (self.OnExitBattleTL).time = skipTime
    if not self.showEpUIComplete then
      self:ShowExplorationUI()
    end
  end
  self.onStartBattleTL = (self.epSceneEntity):GetOnStartBattleTL()
  if self.onStartBattleTL ~= nil then
    skipTime = (self.onStartBattleTL).duration
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R2 in 'UnsetPending'

    if (self.onStartBattleTL).state == CS_PlayState_Playing and (self.onStartBattleTL).time < skipTime then
      (self.onStartBattleTL).time = skipTime
      self:ClearEpMapTween()
    end
  end
  self.onReconnectToBattleTL = (self.epSceneEntity):GetOnReconnectToBattleTL()
  skipTime = (self.onReconnectToBattleTL).duration
  -- DECOMPILER ERROR at PC87: Confused about usage of register: R2 in 'UnsetPending'

  if (self.onReconnectToBattleTL).state == CS_PlayState_Playing and (self.onReconnectToBattleTL).time < skipTime then
    (self.onReconnectToBattleTL).time = skipTime
    self:ClearEpMapTween()
  end
end

ExplorationSceneCtrl.ClearEpMapTween = function(self)
  -- function num : 0_20
  ((self.epCtrl).mapCtrl):PauseEpMapTween()
  if self.__resetMapPosAction ~= nil then
    (self.__resetMapPosAction)()
    self.__resetMapPosAction = nil
  end
end

ExplorationSceneCtrl.ShowBattleCanvasTween = function(self)
  -- function num : 0_21 , upvalues : _ENV
  UIManager:PlayDoFade((self.epSceneEntity):GetBattleCanvasGroup(), 0, 1, 0.5)
end

ExplorationSceneCtrl.OnPlayerMoveComplete = function(self, roomData)
  -- function num : 0_22
  self:RefreshBattleToMapLine()
end

ExplorationSceneCtrl.RefreshBattleToMapLine = function(self)
  -- function num : 0_23
  if self.epSceneEntity ~= nil then
    local playerPosItem = ((self.epCtrl).mapCtrl):GetPlayerPosItem()
    ;
    ((self.epSceneEntity):GetBattleToMapLine()).endPoint = playerPosItem.transform
  end
end

ExplorationSceneCtrl.ShowExplorationUI = function(self)
  -- function num : 0_24 , upvalues : _ENV
  if self.showEpUIComplete then
    return 
  end
  local dungeonWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonWindow ~= nil then
    dungeonWindow:Show()
    dungeonWindow:OnlyShowChipList(false)
    dungeonWindow:RefreshHeroListHp()
  end
  ;
  (UIManager:GetWindow(UIWindowTypeID.Exploration)):Show(true)
  ;
  ((self.epCtrl).campFetterCtrl):OnEpBack2Ep()
  if self.__battleToEpAction ~= nil then
    (self.__battleToEpAction)()
    self.__battleToEpAction = nil
  end
  self.showEpUIComplete = true
end

ExplorationSceneCtrl.TweenRoomToScreenCenter = function(self, mapRoot, roomPos)
  -- function num : 0_25
  local mapRootPos = mapRoot.position
  local mapRootRot = mapRoot.rotation
  local mainCamTran = ((self.epSceneEntity):GetMainCam()).transform
  local roomOffset = mainCamTran:InverseTransformVector(mapRootPos - roomPos)
  self.__resetMapPosAction = function()
    -- function num : 0_25_0 , upvalues : mapRoot, mapRootPos, mapRootRot
    mapRoot:SetParent(nil)
    mapRoot:SetPositionAndRotation(mapRootPos, mapRootRot)
  end

  mapRoot:SetParent(mainCamTran)
  local roomPos = mainCamTran:InverseTransformPoint(roomPos)
  local targetPos = roomOffset
  targetPos.z = (mapRoot.localPosition).z
  targetPos.x = targetPos.x - 0.2
  ;
  ((self.epCtrl).mapCtrl):EpMapTween(targetPos, self.__resetMapPosAction)
end

ExplorationSceneCtrl.__RecycleEffect = function(self, effectCommon)
  -- function num : 0_26 , upvalues : _ENV
  local efcName = effectCommon:GetEffectName()
  local poolList = (self.__effectPool)[efcName]
  if poolList == nil then
    error("该特效组被提前销毁，请检查:" .. efcName)
    return 
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__effectInUseDic)[effectCommon] = nil
  ;
  (table.insert)(poolList, effectCommon)
end

ExplorationSceneCtrl.ChangeEpHeroModel = function(self, srcDynHeroList, tarDynHeroList, onFinish)
  -- function num : 0_27 , upvalues : _ENV, cs_BattlePosData, cs_ResLoader, util
  for k,dynHero in ipairs(srcDynHeroList) do
    local srcHeroId = dynHero.dataId
    local srcResLoader = (self.heroResLoaderDic)[srcHeroId]
    if srcResLoader ~= nil then
      local srcObj = (self.heroObjectDic)[srcHeroId]
      DestroyUnityObject(srcObj)
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (self.heroObjectDic)[srcHeroId] = nil
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (self.heroPrefabs)[srcHeroId] = nil
      srcResLoader:Put2Pool()
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (self.heroResLoaderDic)[srcHeroId] = nil
    end
  end
  local loadFunc = function()
    -- function num : 0_27_0 , upvalues : _ENV, cs_BattlePosData, tarDynHeroList, cs_ResLoader, self, onFinish
    local size_row, size_col = ExplorationManager:GetEpSceneBattleFieldSize()
    local battlePos = cs_BattlePosData(size_row, size_col, (ConfigData.game_config).battleMap_bench_count)
    local waitList = {}
    for k,dynHero in ipairs(tarDynHeroList) do
      local heroId = dynHero.dataId
      local modelPath = PathConsts:GetCharacterModelPrefabPath(dynHero:GetResModelName())
      local resLoader = (cs_ResLoader.Create)()
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (self.heroResLoaderDic)[heroId] = resLoader
      local wait = resLoader:LoadABAssetAsyncAwait(modelPath)
      waitList[k] = wait
    end
    for k,dynHero in ipairs(tarDynHeroList) do
      local heroId = dynHero.dataId
      local wait = waitList[k]
      ;
      (coroutine.yield)(wait)
      local heroPrefab = wait.Result
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (self.heroPrefabs)[heroId] = heroPrefab
      local heroGo = (heroPrefab:Instantiate(self.heroModelHolder))
      local logicPos = nil
      if dynHero.onBench then
        logicPos = ((battlePos.benchLogicPosMap)[dynHero.y]):ToVector3()
      else
        logicPos = ((battlePos.boardLogicPosMap):GetValue(dynHero.x, dynHero.y)):ToVector3()
      end
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R14 in 'UnsetPending'

      ;
      (heroGo.transform).position = logicPos
      -- DECOMPILER ERROR at PC70: Confused about usage of register: R14 in 'UnsetPending'

      ;
      (self.heroObjectDic)[dynHero.dataId] = heroGo
      ;
      (coroutine.yield)(nil)
    end
    onFinish()
    self.__changeEpHeroModelCo = nil
  end

  self:_ClearChangeEpHeroModelCo()
  self.__changeEpHeroModelCo = (GR.StartCoroutine)((util.cs_generator)(loadFunc))
end

ExplorationSceneCtrl._ClearChangeEpHeroModelCo = function(self)
  -- function num : 0_28 , upvalues : _ENV
  if self.__changeEpHeroModelCo ~= nil then
    (GR.StopCoroutine)(self.__changeEpHeroModelCo)
    self.__changeEpHeroModelCo = nil
  end
end

ExplorationSceneCtrl.RefreshEpSceneHeroPos = function(self, dynHeroList)
  -- function num : 0_29 , upvalues : _ENV, cs_BattlePosData
  local size_row, size_col = ExplorationManager:GetEpSceneBattleFieldSize()
  local battlePos = cs_BattlePosData(size_row, size_col, (ConfigData.game_config).battleMap_bench_count)
  for k,dynHero in ipairs(dynHeroList) do
    local heroGo = (self.heroObjectDic)[dynHero.dataId]
    if not IsNull(heroGo) then
      local logicPos = nil
      if dynHero.onBench then
        logicPos = ((battlePos.benchLogicPosMap)[dynHero.y]):ToVector3()
      else
        logicPos = ((battlePos.boardLogicPosMap):GetValue(dynHero.x, dynHero.y)):ToVector3()
      end
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (heroGo.transform).position = logicPos
    end
  end
end

ExplorationSceneCtrl.OnDelete = function(self)
  -- function num : 0_30 , upvalues : CS_RenderMgr, base, _ENV
  self:_ClearChangeEpHeroModelCo()
  CS_RenderMgr:ResetShaderLODGlobal()
  base:OnDelete(self)
  self.heroPrefabs = nil
  if self.__loadRoleCoroutine ~= nil then
    (GR.StopCoroutine)(self.__loadRoleCoroutine)
    self.__loadRoleCoroutine = nil
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  self:ClearEpMapTween()
  ;
  (self.epSceneEntity):OnDelete()
  self.epSceneEntity = nil
  MsgCenter:RemoveListener(eMsgEventId.OnShowRoleHeadBar, self.__onShowRoleHeadBar)
  MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerMoveComplete, self.__onPlayerMoveComplete)
  MsgCenter:RemoveListener(eMsgEventId.OnShowExplorationUI, self.__onShowEpUI)
  MsgCenter:RemoveListener(eMsgEventId.OnChangeEpRoomSelectAudio, self.__onChangeRoomSelectAudio)
end

ExplorationSceneCtrl.EditorModelChangeHero = function(self, srcHeroId, tarHeroId, onFinish)
  -- function num : 0_31 , upvalues : _ENV, HeroSkillData, ExplorationEnum, Cs_coroutine
  if (((self.epCtrl).dynPlayer).heroDic)[srcHeroId] == nil then
    return 
  end
  local dynHero = (((self.epCtrl).dynPlayer).heroDic)[srcHeroId]
  local heroCfg = (ConfigData.hero_data)[tarHeroId]
  local heroRankCfg = (ConfigData.hero_rank)[heroCfg.rank]
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

  if heroCfg ~= nil then
    (dynHero.heroData).dataId = tarHeroId
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (dynHero.heroData).heroCfg = heroCfg
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (dynHero.heroData).camp = heroCfg.camp
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (dynHero.heroData).career = heroCfg.career
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (dynHero.heroData).rare = heroRankCfg.rare
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (dynHero.heroData).fragId = heroCfg.fragment
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (dynHero.heroData).resCfg = (ConfigData.resource_model)[heroCfg.src_id]
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (dynHero.heroData).skillDic = {}
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (dynHero.heroData).skillList = {}
    do
      for k,skillId in ipairs(heroCfg.skill_list) do
        local skillData = (HeroSkillData.New)(skillId, dynHero.heroData)
        skillData.level = 1
        -- DECOMPILER ERROR at PC59: Confused about usage of register: R13 in 'UnsetPending'

        ;
        ((dynHero.heroData).skillDic)[skillId] = skillData
        ;
        (table.insert)((dynHero.heroData).skillList, skillData)
      end
    end
    dynHero.dataId = tarHeroId
    dynHero.heroCfg = heroCfg
    dynHero.resCfg = (ConfigData.resource_model)[heroCfg.src_id]
    dynHero.attackRange = heroCfg.range
    dynHero.intensity = heroCfg.intensity
    dynHero.hpPer = ExplorationEnum.eHeroHpPercent
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (((self.epCtrl).dynPlayer).heroDic)[srcHeroId] = nil
    -- DECOMPILER ERROR at PC88: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (((self.epCtrl).dynPlayer).heroDic)[tarHeroId] = dynHero
    local heroResName = PathConsts:GetCharacterModelPrefabPath(dynHero:GetResModelName())
    local wait = (self.resloader):LoadABAssetAsyncAwait(heroResName)
    local size_row, size_col = ExplorationManager:GetEpSceneBattleFieldSize()
    local battlePos = (CS.BattlePosData)(size_row, size_col, (ConfigData.game_config).battleMap_bench_count)
    ;
    (Cs_coroutine.start)(function()
    -- function num : 0_31_0 , upvalues : _ENV, wait, self, tarHeroId, dynHero, battlePos, srcHeroId, onFinish
    (coroutine.yield)(wait)
    local heroPrefab = wait.Result
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.heroPrefabs)[tarHeroId] = heroPrefab
    ;
    (heroPrefab:Instantiate(self.heroModelHolder))
    local heroGo = nil
    local logicPos = nil
    if dynHero.onBench then
      logicPos = ((battlePos.benchLogicPosMap)[dynHero.y]):ToVector3()
    else
      logicPos = ((battlePos.boardLogicPosMap):GetValue(dynHero.x, dynHero.y)):ToVector3()
    end
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (heroGo.transform).position = logicPos
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.heroObjectDic)[srcHeroId] = nil
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.heroObjectDic)[tarHeroId] = heroGo
    onFinish(dynHero, heroGo)
  end
)
  end
end

ExplorationSceneCtrl.EditorModelChangeMonster = function(self, srcId, index, tarId)
  -- function num : 0_32 , upvalues : _ENV, DynBattleSkill, ExplorationEnum
  local currentRoomDta = (self.epCtrl):GetCurrentRoomData()
  local monsterList = (currentRoomDta.battleMap).monsterList
  local tarDynMonster = nil
  for k,v in pairs(monsterList) do
    if v.dataId == srcId and k == index then
      tarDynMonster = v
      break
    end
  end
  do
    if tarDynMonster ~= nil and (ConfigData.monster)[tarId] ~= nil then
      tarDynMonster.dataId = tarId
      tarDynMonster.monsterCfg = (ConfigData.monster)[tarId]
      tarDynMonster.resCfg = (ConfigData.resource_model)[(tarDynMonster.monsterCfg).src_id]
      tarDynMonster.attackRange = (tarDynMonster.monsterCfg).range
      tarDynMonster.intensity = (tarDynMonster.monsterCfg).intensity
      tarDynMonster.originSkillList = {}
      for k,skillId in pairs((tarDynMonster.monsterCfg).enemy_skill) do
        local battleSkill = (DynBattleSkill.New)(skillId, 1, (ExplorationEnum.eBattleSkillType).Original)
        ;
        (table.insert)(tarDynMonster.originSkillList, battleSkill)
      end
    end
    do
      return tarDynMonster
    end
  end
end

return ExplorationSceneCtrl

