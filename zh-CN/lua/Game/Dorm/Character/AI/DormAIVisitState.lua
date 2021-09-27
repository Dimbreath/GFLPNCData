local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIVisitState = class("DormAIVisitState", DormAIStateBase)
local DormUtil = require("Game.Dorm.DormUtil")
DormAIVisitState.ctor = function(self, aiCtrl, actionCfg, exitAction)
  -- function num : 0_0
  self.time = 0
  self.isFail = false
end

DormAIVisitState.GetStateName = function(self)
  -- function num : 0_1
  return "visit"
end

DormAIVisitState.BindVisitAction = function(self, action)
  -- function num : 0_2
  self.__visitExitAction = action
end

DormAIVisitState.StartState = function(self)
  -- function num : 0_3 , upvalues : DormAIStateBase, DormUtil, _ENV
  self.exeState = (DormAIStateBase.AIExecuteState).Runnig
  local wallId, worldPos, startPos = ((self.charEntity):GetBelongRoomEntity()):GetRoomDoorPos()
  local success = (self.charEntity):DoMoveAStar(startPos, function()
    -- function num : 0_3_0 , upvalues : DormUtil, wallId, self, startPos, _ENV
    local rot = (DormUtil.GetDormWallRot)(wallId, true)
    ;
    (self.charEntity):StartSmoothRotate(rot, function()
      -- function num : 0_3_0_0 , upvalues : self, startPos, _ENV
      (self.charEntity):DoMoveUnityPos(startPos, BindCallback(self, self.VisitOtherDormRoom))
    end
)
  end
)
  if success then
    (self.charEntity):AnimatorCrossFade((self.actionCfg).action_name, (self.actionCfg).trans_time)
  else
    ;
    (self.charEntity):AnimatorStand()
    self.exeState = (DormAIStateBase.AIExecuteState).Fail
  end
end

DormAIVisitState.DirectExitRoom = function(self, action)
  -- function num : 0_4 , upvalues : DormUtil, _ENV
  local wallId, worldPos, startPos = ((self.charEntity):GetBelongRoomEntity()):GetRoomDoorPos()
  local rot = (DormUtil.GetDormWallRot)(wallId, true)
  ;
  (self.charEntity):StartSmoothRotate(rot, function()
    -- function num : 0_4_0 , upvalues : self, worldPos, _ENV, action
    (self.charEntity):DoMoveUnityPos(worldPos, BindCallback(self, self.VisitOtherDormRoom))
    if action then
      action()
    end
  end
)
end

DormAIVisitState.VisitOtherDormRoom = function(self)
  -- function num : 0_5
  (self.charEntity):SetMoveAniSpeed(0)
  self:OnExit(self.__visitExitAction)
end

DormAIVisitState.OnUpdate = function(self)
  -- function num : 0_6 , upvalues : DormAIStateBase, _ENV
  if self.exeState == (DormAIStateBase.AIExecuteState).End then
    return 
  end
  self.time = self.time + Time.deltaTime
  if self.duration <= self.time and self.exeState == (DormAIStateBase.AIExecuteState).Fail then
    self:OnExit()
  end
end

DormAIVisitState.InterruptState = function(self, gotoNext)
  -- function num : 0_7
  (self.charEntity):DormForceStopMove()
  if gotoNext then
    self:OnExit()
    return 
  end
end

DormAIVisitState.StartExitWait = function(self, action)
  -- function num : 0_8
  (self.charEntity):DormForceStopMove()
  self:OnExit(action)
end

DormAIVisitState.OnExit = function(self, action)
  -- function num : 0_9 , upvalues : DormAIStateBase
  (self.charEntity):AnimatorStand()
  ;
  (DormAIStateBase.OnExit)(self)
  self:ExitByWaitAction(action)
end

return DormAIVisitState

