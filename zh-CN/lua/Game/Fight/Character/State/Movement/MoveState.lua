local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local MovementMoveState = class("MovementMoveState", DormFightCharacterStateBase)
MovementMoveState.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._targetForward = Quaternion.identity
  self._propertyCtrl = nil
end

MovementMoveState.OnInit = function(self)
  -- function num : 0_1 , upvalues : DormFightConst
  self._propertyCtrl = (self._owner):GetFeature((DormFightConst.FeatureEnum).PropertyController)
end

MovementMoveState.OnEnter = function(self, prevState)
  -- function num : 0_2 , upvalues : DormFightConst
  local moveSpeed = 0
  if self._propertyCtrl ~= nil then
    moveSpeed = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).MoveSpeed)
  end
  ;
  (self._owner):SetTargetVelocity(moveSpeed)
  local animatorCtrl = (self._owner):GetFeature((DormFightConst.FeatureEnum).AnimatorController)
  if animatorCtrl ~= nil then
    animatorCtrl:PlayWalkAnimation()
  end
end

MovementMoveState.OnExit = function(self, nextState)
  -- function num : 0_3
  (self._owner):SetTargetVelocity(0)
end

MovementMoveState.OnUpdate = function(self, deltaTime)
  -- function num : 0_4 , upvalues : _ENV, DormFightConst
  local rigidBody = (self._owner).rigidBody
  if not IsNull(rigidBody) then
    local rotateRatio = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).RotateRatio)
    rigidBody.rotation = (Quaternion.Slerp)(rigidBody.rotation, self._targetForward, rotateRatio)
  end
end

MovementMoveState.OnEvent = function(self, eventType, arg1)
  -- function num : 0_5 , upvalues : DormFightConst, _ENV
  if eventType == (DormFightConst.EventEnum).StopMoving then
    self:TransferTo((DormFightConst.StateEnum).MovementLayer_Idle)
  else
    if eventType == (DormFightConst.EventEnum).Run then
      self:TransferTo((DormFightConst.StateEnum).MovementLayer_Run)
    else
      if eventType == (DormFightConst.EventEnum).Move then
        self._targetForward = (Quaternion.LookRotation)(arg1, Vector3.up)
      else
        if eventType == (DormFightConst.EventEnum).KnockOut then
          self:TransferTo((DormFightConst.StateEnum).MovementLayer_KnockOut)
        end
      end
    end
  end
end

return MovementMoveState

