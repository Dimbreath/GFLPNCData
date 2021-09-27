local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local AttackHitState = class("AttackHitState", DormFightCharacterStateBase)
AttackHitState.ctor = function(self)
  -- function num : 0_0
  self._timer = 0
  self._propertyCtrl = nil
end

AttackHitState.OnInit = function(self)
  -- function num : 0_1 , upvalues : DormFightConst
  self._propertyCtrl = (self._owner):GetFeature((DormFightConst.FeatureEnum).PropertyController)
end

AttackHitState.OnEnter = function(self, _)
  -- function num : 0_2
  self._timer = 0
end

AttackHitState.OnUpdate = function(self, deltaTime)
  -- function num : 0_3 , upvalues : DormFightConst
  self._timer = self._timer + deltaTime
  if (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).HitShieldTime) <= self._timer then
    self:TransferTo((DormFightConst.StateEnum).AttackLayer_Idle)
  end
end

return AttackHitState

