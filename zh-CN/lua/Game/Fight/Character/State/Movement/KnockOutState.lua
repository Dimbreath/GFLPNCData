local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local MovementKnockOutState = class("MovementKnockOutState", DormFightCharacterStateBase)
MovementKnockOutState.ctor = function(self)
  -- function num : 0_0
  self._isLieDown = false
  self._shieldTimer = 0
  self._lieDownTimer = 0
  self._lieDownInterval = 0
  self._isGettingUp = false
  self._getUpTimer = 0
  self._getUpInterval = 0
end

MovementKnockOutState.OnInit = function(self)
  -- function num : 0_1 , upvalues : DormFightConst
  local propertyCtrl = (self._owner):GetFeature((DormFightConst.FeatureEnum).PropertyController)
  if propertyCtrl ~= nil then
    self._lieDownInterval = propertyCtrl:GetProperty((DormFightConst.PropertyEnum).KnockOutLieDownInterval)
    self._getUpInterval = propertyCtrl:GetProperty((DormFightConst.PropertyEnum).KnockOutGetUpInterval)
  end
end

MovementKnockOutState.OnEnter = function(self, prevState)
  -- function num : 0_2
  self._shieldTimer = 0
  self._isLieDown = false
  self._lieDownTimer = 0
  self._isGettingUp = false
  self._getUpTimer = 0
  ;
  (self._owner):SetRogBodyEnabled(true)
  ;
  (self._owner):SetIgnoreWallCollider(false)
end

MovementKnockOutState.OnExit = function(self, nextState)
  -- function num : 0_3
  (self._owner):SetIgnoreWallCollider(true)
end

MovementKnockOutState.OnUpdate = function(self, deltaTime)
  -- function num : 0_4 , upvalues : DormFightConst
  self:FollowRagBodyPosition()
  if self._shieldTimer <= DormFightConst.KnockOutShieldInterval then
    self._shieldTimer = self._shieldTimer + deltaTime
    return 
  end
  if not self._isLieDown and not self:CheckIsGrounded() then
    return 
  end
  self._isLieDown = true
  if self._lieDownTimer <= self._lieDownInterval then
    self._lieDownTimer = self._lieDownTimer + deltaTime
    return 
  end
  if not self._isGettingUp then
    self:GetUp()
  end
  if self._getUpTimer <= self._getUpInterval then
    self._getUpTimer = self._getUpTimer + deltaTime
    return 
  end
  self:TransferTo((DormFightConst.StateEnum).MovementLayer_Idle)
end

MovementKnockOutState.GetUp = function(self)
  -- function num : 0_5 , upvalues : DormFightConst
  self._isGettingUp = true
  ;
  (self._owner):SetRogBodyEnabled(false)
  local animatorCtrl = (self._owner):GetFeature((DormFightConst.FeatureEnum).AnimatorController)
  if animatorCtrl ~= nil then
    animatorCtrl:PlayReviveAnimation()
  end
end

MovementKnockOutState.FollowRagBodyPosition = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local rigidBody = (self._owner).rigidBody
  local ragBody = (self._owner).ragBody
  if not IsNull(rigidBody) and not IsNull(ragBody) and not IsNull(ragBody.RootBoneTr) then
    local revivePos = (ragBody.RootBoneTr).position
    rigidBody.position = Vector3(revivePos.x, (rigidBody.position).y, revivePos.z)
  end
end

return MovementKnockOutState

