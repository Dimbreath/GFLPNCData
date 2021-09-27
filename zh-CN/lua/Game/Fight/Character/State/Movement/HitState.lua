local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local MovementHitState = class("MovementHitState", DormFightCharacterStateBase)
MovementHitState.ctor = function(self)
  -- function num : 0_0
  self._timer = 0
  self._hasSendHitWallEvent = false
  self._propertyCtrl = nil
end

MovementHitState.OnInit = function(self)
  -- function num : 0_1 , upvalues : DormFightConst
  self._propertyCtrl = (self._owner):GetFeature((DormFightConst.FeatureEnum).PropertyController)
  self._vitalityCtrl = (self._owner):GetFeature((DormFightConst.FeatureEnum).VitalityController)
end

MovementHitState.OnEnter = function(self, _)
  -- function num : 0_2
  self._timer = 0
  self._hasSendHitWallEvent = false
end

MovementHitState.OnUpdate = function(self, deltaTime)
  -- function num : 0_3 , upvalues : DormFightConst
  if not self._hasSendHitWallEvent and self:CheckHitWall() then
    self._hasSendHitWallEvent = true
    if self._vitalityCtrl ~= nil then
      (self._vitalityCtrl):OnHitWall()
    end
  end
  self._timer = self._timer + deltaTime
  if (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).HitShieldTime) <= self._timer then
    self:TransferTo((DormFightConst.StateEnum).MovementLayer_Idle)
  end
end

return MovementHitState

