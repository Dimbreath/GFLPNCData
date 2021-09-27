local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local AttackKnockOutState = class("AttackKnockOutState", DormFightCharacterStateBase)
AttackKnockOutState.ctor = function(self)
  -- function num : 0_0
  self._timer = 0
  self._duration = 0
end

AttackKnockOutState.OnInit = function(self)
  -- function num : 0_1 , upvalues : DormFightConst
  self._duration = DormFightConst.KnockOutShieldInterval
  local propertyCtrl = (self._owner):GetFeature((DormFightConst.FeatureEnum).PropertyController)
  if propertyCtrl ~= nil then
    self._duration = self._duration + propertyCtrl:GetProperty((DormFightConst.PropertyEnum).KnockOutLieDownInterval)
    self._duration = self._duration + propertyCtrl:GetProperty((DormFightConst.PropertyEnum).KnockOutGetUpInterval)
  end
end

AttackKnockOutState.OnEnter = function(self, prevState)
  -- function num : 0_2
  self._timer = 0
end

AttackKnockOutState.OnUpdate = function(self, deltaTime)
  -- function num : 0_3 , upvalues : DormFightConst
  self._timer = self._timer + deltaTime
  if self._duration <= self._timer then
    self:TransferTo((DormFightConst.StateEnum).AttackLayer_Idle)
  end
end

return AttackKnockOutState

