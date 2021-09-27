local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local AttackState = class("AttackState", DormFightCharacterStateBase)
AttackState.ctor = function(self)
  -- function num : 0_0
  self._timer = 0
  self._attackShieldInterval = 0
  self._attackAutoAdjustSqrDistance = 0
end

AttackState.OnInit = function(self)
  -- function num : 0_1 , upvalues : DormFightConst
  local propertyCtrl = (self._owner):GetFeature((DormFightConst.FeatureEnum).PropertyController)
  if propertyCtrl ~= nil then
    self._attackShieldInterval = propertyCtrl:GetProperty((DormFightConst.PropertyEnum).AttackShieldInterval)
    self._attackAutoAdjustSqrDistance = propertyCtrl:GetProperty((DormFightConst.PropertyEnum).AttackAutoAdjustSqrDistance)
  end
end

AttackState.OnEnter = function(self, prevState)
  -- function num : 0_2
  self:Attack()
end

AttackState.Attack = function(self)
  -- function num : 0_3 , upvalues : _ENV, DormFightConst
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  local characterCtrl = dormFightCtrl:GetCharacterCtrl()
  local position = (self._owner):GetPosition()
  local nearestEnemyPosition = characterCtrl:GetNearestEnemyPosition((self._owner):GetComp(), position, true)
  if nearestEnemyPosition ~= nil then
    local dx = nearestEnemyPosition.x - position.x
    local dz = nearestEnemyPosition.z - position.z
    local sqrDistance = dx * dx + dz * dz
    local rigidBody = (self._owner).rigidBody
    if sqrDistance <= self._attackAutoAdjustSqrDistance and not IsNull(rigidBody) then
      rigidBody.rotation = (Quaternion.LookRotation)(Vector3(dx, 0, dz), Vector3.up)
    end
  end
  do
    local animationCtrl = (self._owner):GetFeature((DormFightConst.FeatureEnum).AnimatorController)
    if animationCtrl ~= nil then
      animationCtrl:PlayAttackAnimation()
    end
    ;
    (self._owner):SetHandDetectHit(true)
    self._timer = self._attackShieldInterval
  end
end

AttackState.OnExit = function(self, nextState)
  -- function num : 0_4
  (self._owner):SetHandDetectHit(false)
end

AttackState.OnUpdate = function(self, deltaTime)
  -- function num : 0_5 , upvalues : DormFightConst
  self._timer = self._timer - deltaTime
  if self._timer <= 0 then
    self:TransferTo((DormFightConst.StateEnum).AttackLayer_Idle)
  end
end

return AttackState

