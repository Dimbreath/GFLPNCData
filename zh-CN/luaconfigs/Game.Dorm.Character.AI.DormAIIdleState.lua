-- params : ...
-- function num : 0 , upvalues : _ENV
local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIIdleState = class("DormAIIdleState", DormAIStateBase)
DormAIIdleState.ctor = function(self, aiCtrl, actionCfg, exitAction)
  -- function num : 0_0 , upvalues : _ENV
  self.aiCtrl = aiCtrl
  self.actionCfg = actionCfg
  self.charEntity = aiCtrl.charEntity
  self.roomCtrl = (self.charEntity).roomCharCtrl
  self.exitAction = exitAction
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
  self:StartNewMove()
end

DormAIIdleState.StartNewMove = function(self)
  -- function num : 0_3 , upvalues : DormAIStateBase
  if self.duration <= self.time then
    self:OnExit()
    return 
  end
  local ok, pos = ((self.charEntity).astarCharcter):RandomBFSPoint(1)
  if not ok then
    (self.charEntity):AnimatorStand()
    self.exeState = (DormAIStateBase.AIExecuteState).Fail
    return 
  end
  local success = (self.charEntity):DoMoveAStar(pos, self.__onCompleteOneMove)
  if success then
    (self.charEntity):AnimatorCrossFade((self.actionCfg).action_name, (self.actionCfg).trans_time)
  end
end

DormAIIdleState.CompleteOneMove = function(self)
  -- function num : 0_4
  self:StartNewMove()
end

DormAIIdleState.OnUpdate = function(self)
  -- function num : 0_5 , upvalues : DormAIStateBase, _ENV
  if self.exeState == (DormAIStateBase.AIExecuteState).End then
    return 
  end
  self.time = self.time + Time.deltaTime
  if self.duration <= self.time and self.exeState == (DormAIStateBase.AIExecuteState).Fail then
    self:OnExit()
  end
end

DormAIIdleState.InterruptState = function(self)
  -- function num : 0_6
end

DormAIIdleState.OnExit = function(self)
  -- function num : 0_7 , upvalues : DormAIStateBase
  (DormAIStateBase.OnExit)(self)
  if self.exitAction ~= nil then
    (self.exitAction)(self)
  end
end

return DormAIIdleState

