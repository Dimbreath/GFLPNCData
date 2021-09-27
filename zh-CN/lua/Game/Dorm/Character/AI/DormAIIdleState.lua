local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIIdleState = class("DormAIIdleState", DormAIStateBase)
DormAIIdleState.ctor = function(self, aiCtrl, actionCfg, exitAction)
  -- function num : 0_0 , upvalues : _ENV
  self.time = 0
  self.__onCompleteOneMove = BindCallback(self, self.CompleteOneMove)
end

DormAIIdleState.GetStateName = function(self)
  -- function num : 0_1
  return "idle"
end

DormAIIdleState.StartState = function(self)
  -- function num : 0_2 , upvalues : DormAIStateBase
  self.exeState = (DormAIStateBase.AIExecuteState).Runnig
  self.__moveCount = 0
  self:StartNewMove()
end

DormAIIdleState.StartNewMove = function(self)
  -- function num : 0_3 , upvalues : DormAIStateBase, _ENV
  if self.duration <= self.time then
    self:OnExit()
    return 
  end
  local ok, pos = (self.charEntity):GetRandomOnePoint()
  if not ok then
    (self.charEntity):AnimatorStand()
    self.exeState = (DormAIStateBase.AIExecuteState).Fail
    return 
  end
  local success = (self.charEntity):DoMoveAStar(pos, self.__onCompleteOneMove, (ConfigData.buildinConfig).DormMoveFailTimeout, true, true)
  if success then
    if self.__moveCount <= 0 then
      (self.charEntity):AnimatorCrossFade((self.actionCfg).action_name, (self.actionCfg).trans_time)
    end
    self.__moveCount = self.__moveCount + 1
  end
end

DormAIIdleState.CompleteOneMove = function(self, success)
  -- function num : 0_4
  if self.duration <= self.time then
    (self.charEntity):DormForceStopMove()
    self:OnExit()
    return 
  end
  self:StartNewMove()
end

DormAIIdleState.StartRandToRoomOnePoint = function(self)
  -- function num : 0_5 , upvalues : DormAIStateBase, _ENV
  self.exeState = (DormAIStateBase.AIExecuteState).Runnig
  self.__moveCount = 0
  local ok, pos = (self.charEntity):GetRandomOnePoint()
  if not ok then
    self:OnExit()
    return 
  end
  self.duration = 0
  local success = (self.charEntity):DoMoveAStar(pos, self.__onCompleteOneMove, (ConfigData.buildinConfig).DormMoveFailTimeout, true, true)
end

DormAIIdleState.OnUpdate = function(self)
  -- function num : 0_6 , upvalues : DormAIStateBase, _ENV
  if self.exeState == (DormAIStateBase.AIExecuteState).End then
    return 
  end
  self.time = self.time + Time.deltaTime
  if self.exeState == (DormAIStateBase.AIExecuteState).Fail then
    self:OnExit()
  end
end

DormAIIdleState.InterruptState = function(self, gotoNext)
  -- function num : 0_7 , upvalues : _ENV
  TimerManager:StopTimer(self.__nextTimer)
  ;
  (self.charEntity):DormForceStopMove()
  if gotoNext then
    self:OnExit()
    return 
  end
end

DormAIIdleState.StartExitWait = function(self, action)
  -- function num : 0_8
  (self.charEntity):DormForceStopMove()
  self:OnExit(action)
end

DormAIIdleState.OnExit = function(self, action)
  -- function num : 0_9 , upvalues : _ENV, DormAIStateBase
  TimerManager:StopTimer(self.__nextTimer)
  ;
  (self.charEntity):AnimatorStand()
  ;
  (DormAIStateBase.OnExit)(self)
  self:ExitByWaitAction(action)
end

return DormAIIdleState

