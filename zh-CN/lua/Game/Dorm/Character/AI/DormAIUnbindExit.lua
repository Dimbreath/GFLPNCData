local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIUnbindExit = class("DormAIUnbindExit", DormAIStateBase)
local DormUtil = require("Game.Dorm.DormUtil")
DormAIUnbindExit.ctor = function(self, aiCtrl, actionCfg, exitAction)
  -- function num : 0_0
  self.time = 0
end

DormAIUnbindExit.GetStateName = function(self)
  -- function num : 0_1
  return "unbindExit"
end

DormAIUnbindExit.StartState = function(self)
  -- function num : 0_2 , upvalues : DormUtil
  local wallId, worldPos, startPos = ((self.charEntity):GetBelongRoomEntity()):GetRoomDoorPos()
  local success = (self.charEntity):DoMoveAStar(startPos, function()
    -- function num : 0_2_0 , upvalues : DormUtil, wallId, self, worldPos
    local rot = (DormUtil.GetDormWallRot)(wallId, true)
    ;
    (self.charEntity):StartSmoothRotate(rot, function()
      -- function num : 0_2_0_0 , upvalues : self, worldPos
      (self.charEntity):DoMoveUnityPos(worldPos, function()
        -- function num : 0_2_0_0_0 , upvalues : self
        (self.charEntity):StartExChangeUnBindChar()
      end
)
    end
)
  end
)
  return success
end

DormAIUnbindExit.OnUpdate = function(self)
  -- function num : 0_3 , upvalues : DormAIStateBase
  if self.exeState == (DormAIStateBase.AIExecuteState).End then
    return 
  end
end

DormAIUnbindExit.InterruptState = function(self, gotoNext)
  -- function num : 0_4
  (self.charEntity):DormForceStopMove()
  if gotoNext then
    self:OnExit()
    return 
  end
end

DormAIUnbindExit.StartExitWait = function(self, action)
  -- function num : 0_5
  (self.charEntity):DormForceStopMove()
  self:OnExit(action)
end

DormAIUnbindExit.OnExit = function(self, action)
  -- function num : 0_6 , upvalues : DormAIStateBase
  (self.charEntity):AnimatorStand()
  ;
  (DormAIStateBase.OnExit)(self)
  self:ExitByWaitAction(action)
end

return DormAIUnbindExit

