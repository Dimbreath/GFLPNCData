local base = require("Game.Exploration.Ctrl.ExplorationBattleCtrl")
local ExplorationTDBattleCtrl = class("ExplorationTDBattleCtrl", base)
local util = require("XLua.Common.xlua_util")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
ExplorationTDBattleCtrl.ReqBattleSettle = function(self, battleEndState, requestData)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.ReqBattleSettle)(self, battleEndState, requestData)
  local tdWindow = UIManager:GetWindow(UIWindowTypeID.TDBattle)
  if tdWindow ~= nil then
    tdWindow:OnBattleEnd()
  end
end

ExplorationTDBattleCtrl.VictoryBattleEndCoroutine = function(self, battleEndState, resultData)
  -- function num : 0_1 , upvalues : _ENV, ExplorationEnum, util
  local battleController = battleEndState.battleController
  local CS_CameraController_Ins = (CS.CameraController).Instance
  local playerRoleList = (battleController.PlayerTeamController).battleOriginRoleList
  local enemyRoleList = (battleController.EnemyTeamController).battleOriginRoleList
  local mvpGrade = (BattleUtil.GenMvp)(playerRoleList)
  if mvpGrade == nil then
    mvpGrade = {}
    mvpGrade.role = ((battleController.PlayerTeamController).dungeonRoleList)[0]
    mvpGrade.MVPNum = 1
    mvpGrade.MvpType = (BattleUtil.mvpType).default
  end
  local battleEndCoroutine = function()
    -- function num : 0_1_0 , upvalues : CS_CameraController_Ins, battleController, mvpGrade, self, _ENV, playerRoleList, enemyRoleList, battleEndState, ExplorationEnum
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
    self:PlayWinEffect(mvpGrade.role)
    for key,role in pairs(playerRoleList) do
      local roleActionComponent = role:GetActionComponent()
      if roleActionComponent then
        roleActionComponent:OnWin()
      end
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.BattleResult, function(window)
      -- function num : 0_1_0_0 , upvalues : playerRoleList, enemyRoleList, mvpGrade, self
      if window == nil then
        return 
      end
      window:InitBattleResultData(playerRoleList, enemyRoleList, mvpGrade)
      window:SetContinueCallback(function()
        -- function num : 0_1_0_0_0 , upvalues : self
        self.__startSelectChip = true
      end
)
    end
)
    while 1 do
      if not CS_CameraController_Ins.settleTimlinePlayEnd or UIManager:GetWindow(UIWindowTypeID.BattleResult) == nil then
        (coroutine.yield)()
        -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    ;
    ((self.epCtrl).autoCtrl):OnEpBattleResultShow()
    while not self.__startSelectChip do
      (coroutine.yield)()
    end
    self.__startSelectChip = false
    ;
    ((self.epCtrl).autoCtrl):OnAutoStageOver()
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    avgPlayCtrl:TryPlayTaskAvg(1, function()
      -- function num : 0_1_0_1 , upvalues : battleEndState, _ENV, ExplorationEnum
      battleEndState:EndBattleAndClear()
      local dungeonStateInfo = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
      if dungeonStateInfo ~= nil then
        dungeonStateInfo:Show()
        dungeonStateInfo:SetMoneyActive(true)
      end
      MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
      MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).BattleToEp)
      ;
      (ExplorationManager.epCtrl):ContinueExploration()
    end
)
  end

  return (util.cs_generator)(battleEndCoroutine)
end

return ExplorationTDBattleCtrl

