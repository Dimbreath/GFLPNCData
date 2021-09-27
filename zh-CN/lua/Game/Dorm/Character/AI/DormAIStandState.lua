local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIStandState = class("DormAIStandState", DormAIStateBase)
DormAIStandState.ctor = function(self, aiCtrl, actionCfg, exitAction)
  -- function num : 0_0
  self.time = 0
end

DormAIStandState.GetStateName = function(self)
  -- function num : 0_1
  return "stand"
end

DormAIStandState.StartState = function(self)
  -- function num : 0_2 , upvalues : DormAIStateBase
  ((self.charEntity):GetCharAStarComp()):SetNavMeshCutEnabled(true)
  self.exeState = (DormAIStateBase.AIExecuteState).Runnig
  ;
  (self.charEntity):AnimatorCrossFade((self.actionCfg).action_name, (self.actionCfg).trans_time)
end

DormAIStandState.OnUpdate = function(self)
  -- function num : 0_3 , upvalues : DormAIStateBase, _ENV
  if self.exeState == (DormAIStateBase.AIExecuteState).End then
    return 
  end
  self.time = self.time + Time.deltaTime
  if self.duration <= self.time then
    self:OnExit()
  end
end

DormAIStandState.InterruptState = function(self, gotoNext)
  -- function num : 0_4
  if gotoNext then
    self:OnExit()
    return 
  end
end

DormAIStandState.StartExitWait = function(self, action)
  -- function num : 0_5
  self:OnExit(action)
end

DormAIStandState.OnExit = function(self, action)
  -- function num : 0_6 , upvalues : DormAIStateBase
  (DormAIStateBase.OnExit)(self)
  self:ExitByWaitAction(action)
end

return DormAIStandState

