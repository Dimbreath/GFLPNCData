-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonBattleBaseCtrl = require("Game.Common.CommonGameCtrl.DungeonBattleBaseCtrl")
local ExplorationBattleCtrl = class("ExplorationBattleCtrl", DungeonBattleBaseCtrl)
local base = DungeonBattleBaseCtrl
local CS_BattleManager_Ins = (CS.BattleManager).Instance
local CS_eBattleState = CS.eBattleState
local cs_MessageCommon = CS.MessageCommon
local cs_UIManager = (CS.UIManager).Instance
local cs_BattleStatistics = (CS.BattleStatistics).Instance
local cs_ExplorationStatistic = (CS.ExplorationStatistic).Instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local util = require("XLua.Common.xlua_util")
local startBattleType = {normal = 1, ambush = 2}
ExplorationBattleCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV, startBattleType
  self.epCtrl = epCtrl
  ;
  (table.insert)((self.epCtrl).ctrls, self)
  self.__OnTimelineNoticeOpenResultUI = BindCallback(self, self.OnTimelineNoticeOpenResultUI)
  MsgCenter:AddListener(eMsgEventId.OnTimelineNoticeCreateResultUI, self.__OnTimelineNoticeOpenResultUI)
  self.startBattleType = startBattleType.normal
  self.__curStateId = -1
  self.__waitSelectChip = nil
  self.__waitSettleResult = nil
  self.__settleTimelinePause = nil
  self.__loadedBattleObj = false
  self.canShowNewEnemyDetail = true
end

ExplorationBattleCtrl.IsBattleState = function(self, state)
  -- function num : 0_1
  do return self.__curStateId == state end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ExplorationBattleCtrl.StartNewEpBattle = function(self, roomData, dynPlayer)
  -- function num : 0_2 , upvalues : CS_BattleManager_Ins
  self:__OnEnterBattleScene(roomData)
  self.__battleCount = 0
  local csbattleCtrl = CS_BattleManager_Ins:StartNewBattle(roomData, dynPlayer, self)
  return csbattleCtrl
end

ExplorationBattleCtrl.__OnEnterBattleScene = function(self, roomData)
  -- function num : 0_3
  self.needShowEpBuff = false
  if not roomData:IsDeployRoom() then
    self.needShowEpBuff = true
  end
end

ExplorationBattleCtrl.SetCanShowNewEnemyDetail = function(self, bool)
  -- function num : 0_4
  self.canShowNewEnemyDetail = bool
end

ExplorationBattleCtrl.AutoShowNewEnemyDetail = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local haveNew = false
  if not self.isDeployRoom and self.canShowNewEnemyDetail then
    local isFirsh = true
    for i = 0, (((self.battleCtrl).EnemyTeamController).battleOriginRoleList).Count - 1 do
      local enemy = (((self.battleCtrl).EnemyTeamController).battleOriginRoleList)[i]
      if PlayerDataCenter:IsNewEnemy(enemy.roleDataId) then
        (enemy.battleRoleView):ShowNewArrow(true)
        PlayerDataCenter:AddOldEnemy(enemy.roleDataId)
        if isFirsh then
          (self.battleCtrl):BroadCaseSelectRole(enemy)
          isFirsh = false
          haveNew = true
        end
      end
    end
  end
  do
    return haveNew
  end
end

ExplorationBattleCtrl.__TryAutoShowNewEnemyDetail = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self:AutoShowNewEnemyDetail() then
    self.hasNewEnemyDetail = true
  end
  if GuideManager:TryTriggerGuide(eGuideCondition.InNewMonsterDetail) then
  end
end

ExplorationBattleCtrl.OnBattleStateChange = function(self, battleCtrl, stateId, isDeployRoom)
  -- function num : 0_7 , upvalues : _ENV
  self.battleCtrl = battleCtrl
  self.__curStateId = stateId
  self.isDeployRoom = isDeployRoom
  if stateId == eBattleState.Init then
    if ((self.epCtrl).autoCtrl):IsAutoModeRunning() and not isDeployRoom then
      (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):SetIsAutoBattle(true)
      ;
      (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):SetBattleSpeed(2)
    end
    self.__battleCount = self.__battleCount + 1
    if self.__battleCount > 1 and ((self.epCtrl).overclockCtrl):IsLevelHasOverclock() then
      local battleWindow = UIManager:GetWindow(UIWindowTypeID.Battle)
      if battleWindow ~= nil then
        battleWindow:SetOverclockHighlight(not ((self.epCtrl).overclockCtrl):IsUseClockLimit())
      end
    end
  else
    do
      if stateId == eBattleState.Deploy then
        self:ShowRandomBeforeRandomUI(isDeployRoom)
        if not ((self.epCtrl).autoCtrl):IsAutoModeRunning() and GuideManager:TryTriggerGuide(eGuideCondition.InBattleDeploy) then
          GuideManager:SetEndAction(function()
    -- function num : 0_7_0 , upvalues : self
    self:__TryAutoShowNewEnemyDetail()
  end
)
        else
          self:__TryAutoShowNewEnemyDetail()
        end
        if not isDeployRoom then
          ((self.epCtrl).campFetterCtrl):OnEpBattleDeploy()
        end
        if self.__loadedBattleObj then
          MsgCenter:Broadcast(eMsgEventId.OnBattleReady)
        end
      else
      end
      if (stateId == eBattleState.Running and stateId ~= eBattleState.End) or stateId == eBattleState.Delete then
        self.__loadedBattleObj = false
        self.__curStateId = -1
        self.hasNewEnemyDetail = false
        self.battleCtrl = nil
      end
    end
  end
end

ExplorationBattleCtrl.OnBattleObjectLoadComplete = function(self, battleController)
  -- function num : 0_8 , upvalues : _ENV
  self.__loadedBattleObj = true
  if self.__curStateId == eBattleState.Deploy then
    MsgCenter:Broadcast(eMsgEventId.OnBattleReady)
  end
end

ExplorationBattleCtrl.EnterEpBattleRunning = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if not self.__loadedBattleObj or self.__curStateId ~= eBattleState.Deploy or self.battleCtrl == nil then
    return 
  end
  local battleWindow = UIManager:GetWindow(UIWindowTypeID.Battle)
  if battleWindow ~= nil then
    battleWindow:RealStartBattle()
    return 
  end
  ;
  (((self.battleCtrl).fsm).currentState):StartBattle()
end

ExplorationBattleCtrl.ShowRandomBeforeRandomUI = function(self, isDeployRoom)
  -- function num : 0_10
  return 
end

ExplorationBattleCtrl.GetEffectPoolCtrl = function(self)
  -- function num : 0_11
  return ((self.epCtrl).sceneCtrl).effectPoolCtrl
end

ExplorationBattleCtrl.GetRoleAppearEffect = function(self)
  -- function num : 0_12
  return ((self.epCtrl).sceneCtrl):GetRoleAppearEffect()
end

ExplorationBattleCtrl.GetRoleDisappearEffect = function(self)
  -- function num : 0_13
  return ((self.epCtrl).sceneCtrl):GetRoleDisappearEffect()
end

ExplorationBattleCtrl.SetAmbush = function(self, bool)
  -- function num : 0_14 , upvalues : _ENV, startBattleType
  if bool then
    local win = UIManager:GetWindow(UIWindowTypeID.Battle)
    win:ChangeStartBattleBtnText(1)
    self.startBattleType = startBattleType.ambush
  else
    do
      local win = UIManager:GetWindow(UIWindowTypeID.Battle)
      win:ChangeStartBattleBtnText(0)
      self.startBattleType = startBattleType.normal
    end
  end
end

ExplorationBattleCtrl.SetSneak = function(self)
  -- function num : 0_15 , upvalues : CS_eBattleState, CS_BattleManager_Ins, _ENV
  ((self.battleCtrl).fsm):ChangeState(CS_eBattleState.End)
  CS_BattleManager_Ins:ForceExitBattle()
  ;
  (ExplorationManager.epCtrl):__EnterExplorationScene(2)
end

ExplorationBattleCtrl.GetHeroObjectDic = function(self)
  -- function num : 0_16
  return ((self.epCtrl).sceneCtrl).heroObjectDic
end

ExplorationBattleCtrl.BattleLoadReady = function(self, battleController)
  -- function num : 0_17
  if self.needShowEpBuff then
    self:__ShowEpBuff(battleController.BattleRoomData)
    self.needShowEpBuff = false
  end
end

ExplorationBattleCtrl.__ShowEpBuff = function(self, roomData)
  -- function num : 0_18 , upvalues : _ENV
  local epBuffCfgList = roomData:GetEpBuffEffective((self.epCtrl).dynPlayer)
  if epBuffCfgList ~= nil and #epBuffCfgList > 0 then
    UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffShow, function(window)
    -- function num : 0_18_0 , upvalues : epBuffCfgList
    if window == nil then
      return 
    end
    window:InitEpBuffShow(epBuffCfgList)
  end
)
  end
end

ExplorationBattleCtrl.OnBattleEnd = function(self, battleEndState, evenId, dealBattleEndEvent)
  -- function num : 0_19 , upvalues : DungeonBattleBaseCtrl, _ENV, cs_MessageCommon, cs_BattleStatistics
  if evenId == (DungeonBattleBaseCtrl.eBattleEndType).Failure then
    ((self.epCtrl).autoCtrl):BreakAutoModeForce()
    if ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
      local contentNum = 286
      if ((self.epCtrl):GetCurrentRoomData()):GetIsInWeeklyChallengeBigBossRoom() then
        contentNum = 907
      end
      ;
      (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(contentNum), function()
    -- function num : 0_19_0 , upvalues : battleEndState
    battleEndState:RestartBattle()
  end
, function()
    -- function num : 0_19_1 , upvalues : dealBattleEndEvent, evenId
    dealBattleEndEvent(evenId)
  end
)
    else
      do
        do
          local lastTime = self:GetEpBattleLastCount()
          if lastTime > 0 then
            UIManager:ShowWindowAsync(UIWindowTypeID.BattleFail, function(win)
    -- function num : 0_19_2 , upvalues : dealBattleEndEvent, evenId, self, battleEndState, _ENV, cs_BattleStatistics
    win:InitBattleFail(function()
      -- function num : 0_19_2_0 , upvalues : dealBattleEndEvent, evenId
      dealBattleEndEvent(evenId)
    end
, function()
      -- function num : 0_19_2_1 , upvalues : self, battleEndState
      ((self.epCtrl).epNetwork):CS_EXPLORATION_BATTLE_Restart(function(dataList)
        -- function num : 0_19_2_1_0 , upvalues : battleEndState
        battleEndState:RestartBattle()
      end
)
    end
, function()
      -- function num : 0_19_2_2 , upvalues : win, _ENV, cs_BattleStatistics, battleEndState
      win:Hide()
      UIManager:ShowWindowAsync(UIWindowTypeID.ResultSkada, function(window)
        -- function num : 0_19_2_2_0 , upvalues : cs_BattleStatistics, battleEndState, win
        if window == nil then
          return 
        end
        window:InitBattleSkada(cs_BattleStatistics, ((battleEndState.battleController).PlayerTeamController).battleOriginRoleList, ((battleEndState.battleController).EnemyTeamController).battleOriginRoleList)
        window:SetSkadaCloseCallback(function()
          -- function num : 0_19_2_2_0_0 , upvalues : win
          win:Show()
        end
)
      end
)
    end
)
  end
)
          else
            dealBattleEndEvent(evenId)
          end
          if evenId == (DungeonBattleBaseCtrl.eBattleEndType).Restart then
            ((self.epCtrl).autoCtrl):BreakAutoModeForce()
            ;
            ((self.epCtrl).autoCtrl):DisableEpAutoMode()
          end
          dealBattleEndEvent(evenId)
        end
      end
    end
  end
end

ExplorationBattleCtrl.ReqStartBattle = function(self, battleRoomData, originRoleList, battleAction)
  -- function num : 0_20 , upvalues : _ENV, startBattleType, base
  battleRoomData:InitEpBuffEffective(nil)
  local position = battleRoomData.position
  local roleCount = originRoleList.Count
  local sendMsg = {}
  sendMsg.position = position
  sendMsg.data = {}
  for i = 0, roleCount - 1 do
    local role = originRoleList[i]
    local heroId = (((self.epCtrl).dynPlayer):GetDynHeroByDataId(role.roleDataId)).uid
    local pos = (BattleUtil.XYCoord2Pos)(role.x, role.y)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (sendMsg.data)[heroId] = pos
  end
  if self.startBattleType == startBattleType.normal then
    ((self.epCtrl).epNetwork):CS_EXPLORATION_BATTLE_Start(sendMsg, function(dataList)
    -- function num : 0_20_0 , upvalues : battleAction, self, base, battleRoomData, originRoleList, _ENV
    if battleAction ~= nil then
      local randomSeed = 0
      do
        do
          if dataList ~= nil and dataList.Count > 0 then
            local msg = dataList[0]
            randomSeed = msg.seed
            self.__restartCount = msg.times
          end
          battleAction(randomSeed)
          ;
          (base.ReqStartBattle)(self, battleRoomData, originRoleList, battleAction)
          MsgCenter:Broadcast(eMsgEventId.OnEnterBattle)
        end
      end
    end
  end
)
  else
    if self.startBattleType == startBattleType.ambush then
      ((self.epCtrl).epNetwork):CS_EXPLORATION_BATTLE_Ambush(sendMsg, function(dataList)
    -- function num : 0_20_1 , upvalues : battleAction, base, self, battleRoomData, originRoleList, startBattleType
    do
      if battleAction ~= nil then
        local randomSeed = 0
        if dataList ~= nil and dataList.Count > 0 then
          randomSeed = dataList[0]
        end
        battleAction(randomSeed)
        ;
        (base.ReqStartBattle)(self, battleRoomData, originRoleList, battleAction)
      end
      self.startBattleType = startBattleType.normal
    end
  end
)
    end
  end
end

ExplorationBattleCtrl.ReqBattleSettle = function(self, battleEndState, requestData)
  -- function num : 0_21 , upvalues : _ENV, cs_BattleStatistics, DungeonBattleBaseCtrl
  ((self.epCtrl).autoCtrl):OnAutoStageOver()
  local playerRoleSettle = requestData.playerRoleSettle
  local monsterRoleSettle = requestData.monsterRoleSettle
  local battleCtrl = battleEndState.battleController
  local battlePlayerController = battleCtrl.PlayerController
  local position = (battleCtrl.BattleRoomData).position
  local dynPlayer = battleCtrl.PlayerData
  local sendMsg = {}
  local win = battleEndState.win
  local isWCLastBoss = (battleCtrl.BattleRoomData):GetIsInWeeklyChallengeBigBossRoom()
  sendMsg.position = position
  sendMsg.mp = dynPlayer.playerSkillMp
  sendMsg.hmp = dynPlayer.playerUltSkillMp
  sendMsg.win = win or isWCLastBoss
  sendMsg.charHpPer = {}
  sendMsg.monsterHpPer = {}
  sendMsg.misc = {}
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R12 in 'UnsetPending'

  ;
  (sendMsg.misc).totalFrame = battleCtrl.frame
  local score = {}
  for k,v in pairs(requestData.gameScore) do
    score[k] = v
  end
  sendMsg.valid = {}
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R13 in 'UnsetPending'

  ;
  (sendMsg.valid).score = score
  self.__waitSettleResult = true
  local isBossRoom = ((self.epCtrl):GetCurrentRoomData()):IsRealBossRoom()
  ;
  (ExplorationManager.epMvpData):AddBattleStatisticsData(isBossRoom)
  for k,v in pairs(playerRoleSettle) do
    local elem = {per = v.hpPer, dead = v.dead}
    elem.injury = cs_BattleStatistics:GetHeroInjury(v.role)
    elem.damage = cs_BattleStatistics:GetHeroDamage(v.role)
    elem.record = (ExplorationManager.epMvpData):GetSaveData((v.role).roleDataId, isBossRoom)
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R20 in 'UnsetPending'

    ;
    (sendMsg.charHpPer)[k] = elem
  end
  for k,v in pairs(monsterRoleSettle) do
    local elem = {per = v.hpPer, dead = v.dead}
    -- DECOMPILER ERROR at PC98: Confused about usage of register: R20 in 'UnsetPending'

    ;
    (sendMsg.monsterHpPer)[k] = elem
  end
  -- DECOMPILER ERROR at PC106: Confused about usage of register: R14 in 'UnsetPending'

  ;
  (sendMsg.misc).inputData = (DungeonBattleBaseCtrl.StoreInputCmdToSettleMsg)(self, battlePlayerController)
  if ExplorationManager:GetIsInWeeklyChallenge() then
    local wcStaticData = ((CS.BattleStatistics).Instance).wcStaticData
    -- DECOMPILER ERROR at PC118: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (sendMsg.valid).weeklyChallengeValid = {}
    if wcStaticData.TotalRecord ~= nil then
      for k,v in pairs(wcStaticData.TotalRecord) do
        -- DECOMPILER ERROR at PC128: Confused about usage of register: R20 in 'UnsetPending'

        ((sendMsg.valid).weeklyChallengeValid)[k] = v
      end
    end
  end
  do
    ;
    ((self.epCtrl).epNetwork):CS_EXPLORATION_BATTLE_Settle(sendMsg, function(dataList)
    -- function num : 0_21_0 , upvalues : _ENV, win, self, isWCLastBoss, battleEndState
    if dataList.Count == 0 then
      return 
    end
    local recvSettle = dataList[0]
    PlayerDataCenter:CleanTempOldEnemy()
    if win then
      self.__waitSettleResult = false
      local curRoomData = (ExplorationManager.epCtrl):GetCurrentRoomData()
      if curRoomData ~= nil then
        curRoomData:InitRoomRewardGroup(recvSettle.showRewards)
      end
      return 
    end
    do
      if recvSettle.over or isWCLastBoss then
        if win == false and (((self.epCtrl).dynPlayer):GetOperatorDetail()).canFloorOver then
          (self.epCtrl):StartCompleteExploration(function()
      -- function num : 0_21_0_0 , upvalues : battleEndState, _ENV
      battleEndState:ResetPlayerCharacter(true)
      battleEndState:EndBattleAndClear()
      MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
    end
)
        else
          ;
          (self.epCtrl):ExplorationFailSettle(function()
      -- function num : 0_21_0_1 , upvalues : battleEndState
      battleEndState:EndBattleAndClear()
    end
)
        end
      else
        ;
        ((CS.MessageCommon).ShowMessageBoxConfirm)(ConfigData:GetTipContent(1009), function()
      -- function num : 0_21_0_2 , upvalues : battleEndState, _ENV
      battleEndState:ResetPlayerCharacter(true)
      battleEndState:EndBattleAndClear()
      ;
      (ExplorationManager.epCtrl):ContinueExploration(true)
      AudioManager:PlayAudioById(1026)
    end
)
      end
      MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
    end
  end
)
  end
end

ExplorationBattleCtrl.VictoryBattleEndCoroutine = function(self, battleEndState, resultData)
  -- function num : 0_22 , upvalues : _ENV, util
  local battleController = battleEndState.battleController
  local propDropController = battleController.PropDropController
  local CS_CameraController_Ins = (CS.CameraController).Instance
  self.__waitSelectChip = true
  self.__settleTimelinePause = false
  self.__startSelectChip = false
  self.__showResultUI = false
  local mvpGrade = (BattleUtil.GenMvp)(resultData.playerRoleList)
  local battleEndCoroutine = function()
    -- function num : 0_22_0 , upvalues : CS_CameraController_Ins, battleController, mvpGrade, self, _ENV, resultData, battleEndState
    CS_CameraController_Ins:PlaySettlementCut(battleController, mvpGrade.role)
    while self.__waitSettleResult do
      (coroutine.yield)()
    end
    ;
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
    if self.__settleTimelinePause then
      CS_CameraController_Ins:PauseSettlementCut(false)
    end
    while not self.__showResultUI do
      (coroutine.yield)()
    end
    local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
    cvCtr:PlayCv((mvpGrade.role).roleDataId, ConfigData:GetVoicePointRandom(5))
    UIManager:ShowWindowAsync(UIWindowTypeID.BattleResult, function(window)
      -- function num : 0_22_0_0 , upvalues : resultData, mvpGrade, self
      if window == nil then
        return 
      end
      window:InitBattleResultData(resultData, mvpGrade)
      window:SetContinueCallback(function()
        -- function num : 0_22_0_0_0 , upvalues : self
        self.__startSelectChip = true
      end
)
    end
)
    while 1 do
      if not CS_CameraController_Ins.settleTimlinePlayEnd or UIManager:GetWindow(UIWindowTypeID.BattleResult) == nil then
        (coroutine.yield)()
        -- DECOMPILER ERROR at PC70: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC70: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    ;
    ((self.epCtrl).autoCtrl):OnEpBattleResultShow()
    while not self.__startSelectChip do
      (coroutine.yield)()
    end
    ;
    ((self.epCtrl).autoCtrl):OnAutoStageOver()
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    avgPlayCtrl:TryPlayTaskAvg(1, function()
      -- function num : 0_22_0_1 , upvalues : _ENV
      (ExplorationManager.epCtrl):ContinueExploration()
    end
)
    ;
    (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(0.7))
    battleEndState:EndBattleAndClear()
    MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
  end

  return (util.cs_generator)(battleEndCoroutine)
end

ExplorationBattleCtrl.OnTimelineNoticeOpenResultUI = function(self)
  -- function num : 0_23 , upvalues : _ENV
  self.__showResultUI = true
  if self.__waitSettleResult then
    ((CS.CameraController).Instance):PauseSettlementCut(true)
    self.__settleTimelinePause = true
  end
end

ExplorationBattleCtrl.ReqBattleFreshFormation = function(self, battleController)
  -- function num : 0_24 , upvalues : _ENV
  local originRoleList = (battleController.PlayerTeamController).battleOriginRoleList
  local roleCount = originRoleList.Count
  local posDic = {}
  for i = 0, roleCount - 1 do
    local role = originRoleList[i]
    local heroId = (((self.epCtrl).dynPlayer):GetDynHeroByDataId(role.roleDataId)).uid
    local pos = (BattleUtil.XYCoord2Pos)(role.x, role.y)
    posDic[heroId] = pos
  end
  ;
  ((self.epCtrl).epNetwork):CS_EXPLORATION_FreshFromation(posDic)
  ;
  ((self.epCtrl).dynPlayer):RefreshCacheFightPower()
end

ExplorationBattleCtrl.ReqGiveUpBattle = function(self, battleController)
  -- function num : 0_25 , upvalues : _ENV, cs_MessageCommon
  if (self.epCtrl):IsCompleteExploration() then
    (self.epCtrl):StartCompleteExploration()
    return 
  end
  if ExplorationManager:HasEpRewardBag() then
    local hasReward = ((((self.epCtrl).dynPlayer).dynRewardBag):HasEpRewardBagData())
    -- DECOMPILER ERROR at PC19: Overwrote pending register: R3 in 'AssignReg'

    local msg = .end
    if hasReward then
      msg = ConfigData:GetTipContent(753)
    else
      msg = ConfigData:GetTipContent(752)
    end
    ;
    (cs_MessageCommon.ShowMessageBox)(msg, function()
    -- function num : 0_25_0 , upvalues : battleController, _ENV, self
    (battleController.fsm):ChangeState((CS.eBattleState).End)
    ;
    ((battleController.fsm).currentState):EndBattleAndClear()
    ;
    (self.epCtrl):ExplorationFailSettle()
  end
, nil)
    return 
  end
  do
    local returnStamina = (ExplorationManager:GetReturnStamina())
    -- DECOMPILER ERROR at PC42: Overwrote pending register: R3 in 'AssignReg'

    local msg = .end
    if returnStamina == 0 then
      msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
    else
      msg = (string.format)(ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpoWithStaminaBack), tostring(returnStamina))
    end
    ;
    (cs_MessageCommon.ShowMessageBox)(msg, function()
    -- function num : 0_25_1 , upvalues : battleController, _ENV
    (battleController.fsm):ChangeState((CS.eBattleState).End)
    ;
    ((battleController.fsm).currentState):EndBattleAndClear()
    ExplorationManager:SendSettle(function()
      -- function num : 0_25_1_0 , upvalues : _ENV
      ExplorationManager:ExitExploration()
    end
, nil, nil, false)
  end
, nil)
  end
end

ExplorationBattleCtrl.ReqRestartBattle = function(self, battleController)
  -- function num : 0_26 , upvalues : DungeonBattleBaseCtrl
  ((self.epCtrl).epNetwork):CS_EXPLORATION_BATTLE_Restart(function(dataList)
    -- function num : 0_26_0 , upvalues : DungeonBattleBaseCtrl, self, battleController
    (DungeonBattleBaseCtrl.ReqRestartBattle)(self, battleController)
  end
)
end

ExplorationBattleCtrl.GetEpBattleLastCount = function(self)
  -- function num : 0_27 , upvalues : _ENV
  return (ConfigData.game_config).epBattleRestartLimit - (math.max)(0, (self.__restartCount or 0) - 1)
end

ExplorationBattleCtrl.OnDelete = function(self)
  -- function num : 0_28 , upvalues : _ENV, DungeonBattleBaseCtrl
  MsgCenter:RemoveListener(eMsgEventId.OnTimelineNoticeCreateResultUI, self.__OnTimelineNoticeOpenResultUI)
  ;
  (DungeonBattleBaseCtrl.OnDelete)(self)
end

return ExplorationBattleCtrl

