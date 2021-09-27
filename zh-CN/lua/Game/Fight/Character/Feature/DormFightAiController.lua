local AttackSqrDistance = 0.5
local AttackProbability = 0.1
local EscapeVitalityRatio = 0.5
local StopEscapeVitalityRatio = 1
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local DormFightAiController = class("DormFightAiController", DormFightCharacterFeatureBase)
DormFightAiController.ctor = function(self)
  -- function num : 0_0
  self._modelCtrl = nil
  self._vitalityCtrl = nil
  self._isEscape = false
end

DormFightAiController.OnInit = function(self)
  -- function num : 0_1 , upvalues : DormFightConst
  self._modelCtrl = self:GetFeature((DormFightConst.FeatureEnum).ModelController)
  self._vitalityCtrl = self:GetFeature((DormFightConst.FeatureEnum).VitalityController)
  self._isEscape = false
end

DormFightAiController.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : EscapeVitalityRatio, StopEscapeVitalityRatio, _ENV, DormFightConst, AttackSqrDistance, AttackProbability
  if self._modelCtrl == nil then
    return 
  end
  if self._vitalityCtrl then
    local vitalityRatio = (self._vitalityCtrl):GetVitalityRatio()
  end
  if not self._isEscape and vitalityRatio < EscapeVitalityRatio then
    self._isEscape = true
  else
    if self._isEscape and StopEscapeVitalityRatio - 1e-05 <= vitalityRatio then
      self._isEscape = false
    end
  end
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  local characterCtrl = dormFightCtrl:GetCharacterCtrl()
  local comp = (self._owner):GetComp()
  local position = (self._owner):GetPosition()
  local tPosition = characterCtrl:GetNearestEnemyPosition(comp, position, false)
  if tPosition == nil then
    (self._modelCtrl):PostEvent((DormFightConst.EventEnum).StopMoving)
    return 
  end
  local dx = tPosition.x - position.x
  local dz = tPosition.z - position.z
  local sqrDistance = dx * dx + dz * dz
  if self._isEscape then
    local dir = Vector3(-dx, 0, -dz)
    ;
    (self._modelCtrl):PostEvent((DormFightConst.EventEnum).Move, dir)
  else
    do
      if AttackSqrDistance <= sqrDistance then
        local dir = Vector3(dx, 0, dz)
        ;
        (self._modelCtrl):PostEvent((DormFightConst.EventEnum).Move, dir)
      else
        do
          ;
          (self._modelCtrl):PostEvent((DormFightConst.EventEnum).StopMoving)
          if (math.random)() < AttackProbability then
            (self._modelCtrl):PostEvent((DormFightConst.EventEnum).Attack)
          end
        end
      end
    end
  end
end

return DormFightAiController

