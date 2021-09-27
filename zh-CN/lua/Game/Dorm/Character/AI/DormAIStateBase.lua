local DormAIStateBase = class("DormAIStateBase")
DormAIStateBase.AIExecuteState = {Init = 0, Runnig = 1, Fail = 2, End = 4}
DormAIStateBase.ctor = function(self, aiCtrl, actionCfg, exitAction)
  -- function num : 0_0 , upvalues : DormAIStateBase
  self.duration = 0
  self.exeState = (DormAIStateBase.AIExecuteState).Init
  self.aiCtrl = aiCtrl
  self.actionCfg = actionCfg
  self.charEntity = aiCtrl.charEntity
  self.exitAction = exitAction
  self.roomCtrl = (self.charEntity).roomCharCtrl
end

DormAIStateBase.SetStateDuration = function(self, duration)
  -- function num : 0_1
  self.duration = duration
end

DormAIStateBase.StartState = function(self)
  -- function num : 0_2
end

DormAIStateBase.InterruptState = function(self, gotoNext)
  -- function num : 0_3
end

DormAIStateBase.StartExitWait = function(self, action, ...)
  -- function num : 0_4
end

DormAIStateBase.GetStateName = function(self)
  -- function num : 0_5
  return ""
end

DormAIStateBase.OnExit = function(self)
  -- function num : 0_6 , upvalues : DormAIStateBase
  self.exeState = (DormAIStateBase.AIExecuteState).End
end

DormAIStateBase.ExitByWaitAction = function(self, action)
  -- function num : 0_7
  local autoNext = true
  if action ~= nil then
    autoNext = false
  end
  if self.exitAction ~= nil then
    (self.exitAction)(self, autoNext)
  end
  if action ~= nil then
    action(true)
  end
end

DormAIStateBase.OnUpdate = function(self)
  -- function num : 0_8
end

return DormAIStateBase

