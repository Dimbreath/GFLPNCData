-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonBattleBaseCtrl = require("Game.Common.CommonGameCtrl.DungeonBattleBaseCtrl")
local ExplorationBattleCtrl = class("ExplorationBattleCtrl", DungeonBattleBaseCtrl)
local CS_BattleManager_Ins = (CS.BattleManager).Instance
local CS_eBattleState = CS.eBattleState
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
  self.funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  self.isRandomBeforeBattleUnlock = false
  self.canShowNewEnemyDetail = true
end

ExplorationBattleCtrl.IsBattleState = function(self, state)
  -- function num : 0_1
  do return self.__curStateId == state end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ExplorationBattleCtrl.OnEnterBattleScene = function(self, roomData)
  -- function num : 0_2
  self.needShowEpBuff = false
  if not roomData:IsDeployRoom() then
    self.needShowEpBuff = true
  end
end

ExplorationBattleCtrl.SetCanShowNewEnemyDetail = function(self, bool)
  -- function num : 0_3
  self.canShowNewEnemyDetail = bool
end

ExplorationBattleCtrl.AutoShowNewEnemyDetail = function(self)
  -- function num : 0_4 , upvalues : _ENV
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
  -- function num : 0_5 , upvalues : _ENV
  if self:AutoShowNewEnemyDetail() then
    self.hasNewEnemyDetail = true
  end
  if GuideManager:TryTriggerGuide(eGuideCondition.InNewMonsterDetail) then
  end
end

ExplorationBattleCtrl.OnBattleStateChange = function(self, battleCtrl, stateId, isDeployRoom)
  -- function num : 0_6 , upvalues : _ENV
  self.battleCtrl = battleCtrl
  self.__curStateId = stateId
  self.isDeployRoom = isDeployRoom
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  if stateId == eBattleState.Init and ((self.epCtrl).autoCtrl):IsAutoModeRunning() and not isDeployRoom then
    (BattleUtil.battleSetting).autoBattle = true
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (BattleUtil.battleSetting).battleSpeed = 2
  end
  if stateId == eBattleState.Deploy then
    self:ShowRandomBeforeRandomUI(isDeployRoom)
    if GuideManager:TryTriggerGuide(eGuideCondition.InBattleDeploy) then
      GuideManager:SetEndAction(function()
    -- function num : 0_6_0 , upvalues : self
    self:__TryAutoShowNewEnemyDetail()
  end
)
    else
      self:__TryAutoShowNewEnemyDetail()
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

ExplorationBattleCtrl.OnBattleObjectLoadComplete = function(self, battleController)
  -- function num : 0_7 , upvalues : _ENV
  self.__loadedBattleObj = true
  if self.__curStateId == eBattleState.Deploy then
    MsgCenter:Broadcast(eMsgEventId.OnBattleReady)
  end
end

ExplorationBattleCtrl.EnterEpBattleRunning = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if not self.__loadedBattleObj or self.__curStateId ~= eBattleState.Deploy or self.battleCtrl == nil then
    return 
  end
  ;
  (((self.battleCtrl).fsm).currentState):StartBattle()
end

ExplorationBattleCtrl.ShowRandomBeforeRandomUI = function(self, isDeployRoom)
  -- function num : 0_9 , upvalues : _ENV
  self.isRandomBeforeBattleUnlock = (self.funcUnLockCrtl):ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Random)
  local roomData = (self.epCtrl):GetCurrentRoomData()
  local dynPlayer = ExplorationManager.dynPlayer
  if not isDeployRoom and self.isRandomBeforeBattleUnlock then
    UIManager:ShowWindowAsync(UIWindowTypeID.BattleRandomBeforeBattle, function(win)
    -- function num : 0_9_0 , upvalues : roomData, dynPlayer
    win:InitData(roomData, dynPlayer.focusLimit, dynPlayer.focusItemNum)
    local ambushData, stealthData = roomData:GetAmbushAndSneakData()
    win:UpdateData(ambushData, stealthData, roomData.position)
  end
)
  end
end

ExplorationBattleCtrl.GetEffectPoolCtrl = function(self)
  -- function num : 0_10
  return ((self.epCtrl).sceneCtrl).effectPoolCtrl
end

ExplorationBattleCtrl.GetRoleAppearEffect = function(self)
  -- function num : 0_11
  return ((self.epCtrl).sceneCtrl):GetRoleAppearEffect()
end

ExplorationBattleCtrl.GetRoleDisappearEffect = function(self)
  -- function num : 0_12
  return ((self.epCtrl).sceneCtrl):GetRoleDisappearEffect()
end

ExplorationBattleCtrl.SetAmbush = function(self, bool)
  -- function num : 0_13 , upvalues : _ENV, startBattleType
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
  -- function num : 0_14 , upvalues : CS_eBattleState, CS_BattleManager_Ins, _ENV
  ((self.battleCtrl).fsm):ChangeState(CS_eBattleState.End)
  CS_BattleManager_Ins:ForceExitBattle()
  ;
  (ExplorationManager.epCtrl):__EnterExplorationScene(2)
end

ExplorationBattleCtrl.GetHeroObjectDic = function(self)
  -- function num : 0_15
  return ((self.epCtrl).sceneCtrl).heroObjectDic
end

ExplorationBattleCtrl.BattleLoadReady = function(self, battleController)
  -- function num : 0_16
  if self.needShowEpBuff then
    self:__ShowEpBuff(battleController.BattleRoomData)
    self.needShowEpBuff = false
  end
end

ExplorationBattleCtrl.__ShowEpBuff = function(self, roomData)
  -- function num : 0_17 , upvalues : _ENV
  local epBuffCfgList = roomData:GetEpBuffEffective((self.epCtrl).dynPlayer)
  if epBuffCfgList ~= nil and #epBuffCfgList > 0 then
    UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffShow, function(window)
    -- function num : 0_17_0 , upvalues : epBuffCfgList
    if window == nil then
      return 
    end
    window:InitEpBuffShow(epBuffCfgList)
  end
)
  end
end

ExplorationBattleCtrl.OnBattleEnd = function(self, battleEndState, evenId, dealBattleEndEvent)
  -- function num : 0_18 , upvalues : DungeonBattleBaseCtrl, _ENV
  if evenId == (DungeonBattleBaseCtrl.eBattleEndType).Failure then
    ((self.epCtrl).autoCtrl):BreakAutoModeForce()
    ;
    ((CS.MessageCommon).ShowMessageBox)(ConfigData:GetTipContent(286), function()
    -- function num : 0_18_0 , upvalues : battleEndState
    battleEndState:RestartBattle()
  end
, function()
    -- function num : 0_18_1 , upvalues : dealBattleEndEvent, evenId
    dealBattleEndEvent(evenId)
  end
)
  else
    if evenId == (DungeonBattleBaseCtrl.eBattleEndType).Restart then
      ((self.epCtrl).autoCtrl):BreakAutoModeForce()
    end
    dealBattleEndEvent(evenId)
  end
end

ExplorationBattleCtrl.ReqStartBattle = function(self, battleRoomData, originRoleList, battleAction)
  -- function num : 0_19 , upvalues : _ENV, startBattleType
  UIManager:DeleteWindow(UIWindowTypeID.BattleRandomBeforeBattle)
  battleRoomData:InitEpBuffEffective(nil)
  local position = battleRoomData.position
  local roleCount = originRoleList.Count
  local sendMsg = {}
  sendMsg.position = position
  sendMsg.data = {}
  for i = 0, roleCount - 1 do
    local role = originRoleList[i]
    local heroId = role.roleDataId
    local pos = (BattleUtil.XYCoord2Pos)(role.x, role.y)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (sendMsg.data)[heroId] = pos
  end
  if self.startBattleType == startBattleType.normal then
    ((self.epCtrl).epNetwork):CS_EXPLORATION_BATTLE_Start(sendMsg, function(dataList)
    -- function num : 0_19_0 , upvalues : battleAction, _ENV
    if battleAction ~= nil then
      battleAction()
    end
    MsgCenter:Broadcast(eMsgEventId.OnEnterBattle)
  end
)
  else
    if self.startBattleType == startBattleType.ambush then
      ((self.epCtrl).epNetwork):CS_EXPLORATION_BATTLE_Ambush(sendMsg, function(dataList)
    -- function num : 0_19_1 , upvalues : battleAction, self, startBattleType
    if battleAction ~= nil then
      battleAction()
    end
    self.startBattleType = startBattleType.normal
  end
)
    end
  end
end

ExplorationBattleCtrl.ReqBattleSettle = function(self, battleEndState, playerRoleSettle, monsterRoleSettle)
  -- function num : 0_20 , upvalues : _ENV, cs_BattleStatistics
  ((self.epCtrl).autoCtrl):OnAutoStageOver()
  local battleController = battleEndState.battleController
  local position = (battleController.BattleRoomData).position
  local dynPlayer = battleController.PlayerData
  local sendMsg = {}
  local win = battleEndState.win
  sendMsg.position = position
  sendMsg.mp = dynPlayer.playerSkillMp
  sendMsg.hmp = dynPlayer.playerUltSkillMp
  sendMsg.win = win
  sendMsg.charHpPer = {}
  sendMsg.monsterHpPer = {}
  self.__waitSettleResult = true
  ;
  (ExplorationManager.epMvpData):AddBattleStatisticsData()
  for k,v in pairs(playerRoleSettle) do
    local elem = {per = v.hpPer, dead = v.dead}
    elem.injury = cs_BattleStatistics:GetHeroInjury(v.role)
    elem.damage = cs_BattleStatistics:GetHeroDamage(v.role)
    elem.record = (ExplorationManager.epMvpData):GetSaveData(k)
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (sendMsg.charHpPer)[k] = elem
  end
  for k,v in pairs(monsterRoleSettle) do
    local elem = {per = v.hpPer, dead = v.dead}
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (sendMsg.monsterHpPer)[k] = elem
  end
  if win == false and (((self.epCtrl).dynPlayer):GetOperatorDetail()).canFloorOver then
    (self.epCtrl):StartCompleteExploration(function()
    -- function num : 0_20_0 , upvalues : battleEndState, _ENV
    battleEndState:ResetPlayerCharacter(true)
    battleEndState:EndBattleAndClear()
    MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
  end
)
    return 
  end
  ;
  ((self.epCtrl).epNetwork):CS_EXPLORATION_BATTLE_Settle(sendMsg, function(dataList)
    -- function num : 0_20_1 , upvalues : _ENV, win, self, battleEndState
    if dataList.Count == 0 then
      return 
    end
    local recvSettle = dataList[0]
    PlayerDataCenter:CleanTempOldEnemy()
    if win then
      self.__waitSettleResult = false
      return 
    end
    if recvSettle.over then
      UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
      -- function num : 0_20_1_0 , upvalues : _ENV, self, battleEndState, recvSettle
      if window == nil then
        return 
      end
      local clearAction = BindCallback(self, function()
        -- function num : 0_20_1_0_0 , upvalues : battleEndState
        battleEndState:EndBattleAndClear()
      end
)
      ;
      ((self.epCtrl).autoCtrl):CloseAutoMode()
      window:FailExploration(clearAction, recvSettle.rewardsRecord, recvSettle.back)
    end
)
    else
      ;
      ((CS.MessageCommon).ShowMessageBoxConfirm)(ConfigData:GetTipContent(1009), function()
      -- function num : 0_20_1_1 , upvalues : battleEndState, _ENV
      battleEndState:ResetPlayerCharacter(true)
      battleEndState:EndBattleAndClear()
      ;
      (ExplorationManager.epCtrl):ContinueExploration()
      AudioManager:PlayAudioById(1026)
    end
)
    end
    MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
  end
)
end

ExplorationBattleCtrl.VictoryBattleEndCoroutine = function(self, battleEndState, resultData)
  -- function num : 0_21 , upvalues : _ENV, util
  local battleController = battleEndState.battleController
  local propDropController = battleController.PropDropController
  local CS_CameraController_Ins = (CS.CameraController).Instance
  self.__waitSelectChip = true
  self.__settleTimelinePause = false
  self.__startSelectChip = false
  self.__showResultUI = false
  local mvpGrade = (BattleUtil.GenMvp)(resultData.playerRoleList)
  local battleEndCoroutine = function()
    -- function num : 0_21_0 , upvalues : CS_CameraController_Ins, battleController, mvpGrade, self, _ENV, resultData, battleEndState
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
    UIManager:ShowWindowAsync(UIWindowTypeID.BattleResult, function(window)
      -- function num : 0_21_0_0 , upvalues : resultData, mvpGrade, self
      if window == nil then
        return 
      end
      window:InitBattleResultData(resultData, mvpGrade)
      window:SetContinueCallback(function()
        -- function num : 0_21_0_0_0 , upvalues : self
        self.__startSelectChip = true
      end
)
    end
)
    while 1 do
      if not CS_CameraController_Ins.settleTimlinePlayEnd or UIManager:GetWindow(UIWindowTypeID.BattleResult) == nil then
        (coroutine.yield)()
        -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out IF_STMT

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
    CS_CameraController_Ins:PlayBattleResult()
    local haveChipSelect = (self.epCtrl):CheckChipSelect(function()
      -- function num : 0_21_0_1 , upvalues : self
      self.__waitSelectChip = false
    end
, true)
    if haveChipSelect then
      ((self.epCtrl).autoCtrl):OnEpBattleSelectChip()
    end
    while self.__waitSelectChip do
      (coroutine.yield)()
    end
    if haveChipSelect then
      ((self.epCtrl).autoCtrl):OnAutoStageOver()
      ;
      (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)((ConfigData.game_config).getChipMoveTime + (ConfigData.game_config).getChipEffectTime))
    end
    UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    avgPlayCtrl:TryPlayTaskAvg(1, function()
      -- function num : 0_21_0_2 , upvalues : CS_CameraController_Ins, _ENV
      CS_CameraController_Ins:OnBattleExit()
      ;
      (ExplorationManager.epCtrl):ContinueExploration()
    end
)
    battleEndState:EndBattleAndClear()
    MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
  end

  return (util.cs_generator)(battleEndCoroutine)
end

ExplorationBattleCtrl.OnTimelineNoticeOpenResultUI = function(self)
  -- function num : 0_22 , upvalues : _ENV
  self.__showResultUI = true
  if self.__waitSettleResult then
    ((CS.CameraController).Instance):PauseSettlementCut(true)
    self.__settleTimelinePause = true
  end
end

ExplorationBattleCtrl.ReqBattleFreshFormation = function(self, battleController)
  -- function num : 0_23 , upvalues : _ENV
  local originRoleList = (battleController.PlayerTeamController).battleOriginRoleList
  local roleCount = originRoleList.Count
  local posDic = {}
  for i = 0, roleCount - 1 do
    local role = originRoleList[i]
    local heroId = role.roleDataId
    local pos = (BattleUtil.XYCoord2Pos)(role.x, role.y)
    posDic[heroId] = pos
  end
  ;
  ((self.epCtrl).epNetwork):CS_EXPLORATION_FreshFromation(posDic)
  ;
  ((self.epCtrl).dynPlayer):RefreshCacheFightPower()
end

ExplorationBattleCtrl.ReqGiveUpBattle = function(self, battleController)
  -- function num : 0_24 , upvalues : _ENV
  local returnStamina = (ExplorationManager:GetReturnStamina())
  -- DECOMPILER ERROR at PC3: Overwrote pending register: R3 in 'AssignReg'

  local msg = .end
  if returnStamina == 0 then
    msg = ConfigData:GetTipContent(1006)
  else
    msg = (string.format)(ConfigData:GetTipContent(1007), tostring(returnStamina))
  end
  ;
  ((CS.MessageCommon).ShowMessageBox)(msg, function()
    -- function num : 0_24_0 , upvalues : battleController, _ENV
    (battleController.fsm):ChangeState((CS.eBattleState).End)
    ;
    ((battleController.fsm).currentState):EndBattleAndClear()
    ExplorationManager:SendSettle(function()
      -- function num : 0_24_0_0 , upvalues : _ENV
      ExplorationManager:ExitExploration()
    end
)
  end
, nil)
end

ExplorationBattleCtrl.OnDelete = function(self)
  -- function num : 0_25 , upvalues : _ENV, DungeonBattleBaseCtrl
  MsgCenter:RemoveListener(eMsgEventId.OnTimelineNoticeCreateResultUI, self.__OnTimelineNoticeOpenResultUI)
  ;
  (DungeonBattleBaseCtrl.OnDelete)(self)
end

return ExplorationBattleCtrl

