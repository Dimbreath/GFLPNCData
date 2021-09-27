local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local DormFightVitalityController = class("DormFightVitalityController", DormFightCharacterFeatureBase)
local State2ResumeRatePropertyKeyList = {
{state = (DormFightConst.StateEnum).AttackLayer_Attack, key = (DormFightConst.PropertyEnum).AttackVitalityResumeRate}
, 
{state = (DormFightConst.StateEnum).AttackLayer_Hit, key = (DormFightConst.PropertyEnum).HitVitalityResumeRate}
, 
{state = (DormFightConst.StateEnum).MovementLayer_Idle, key = (DormFightConst.PropertyEnum).IdleVitalityResumeRate}
, 
{state = (DormFightConst.StateEnum).MovementLayer_Move, key = (DormFightConst.PropertyEnum).WalkVitalityResumeRate}
, 
{state = (DormFightConst.StateEnum).MovementLayer_Run, key = (DormFightConst.PropertyEnum).RunVitalityResumeRate}
, 
{state = (DormFightConst.StateEnum).MovementLayer_KnockOut, key = (DormFightConst.PropertyEnum).KnockOutVitalityResumeRate}
}
DormFightVitalityController.ctor = function(self)
  -- function num : 0_0
  self._propertyCtrl = nil
  self._modelCtrl = nil
  self._vitality = 0
end

DormFightVitalityController.OnInit = function(self)
  -- function num : 0_1 , upvalues : DormFightConst
  self._modelCtrl = self:GetFeature((DormFightConst.FeatureEnum).ModelController)
  self._propertyCtrl = self:GetFeature((DormFightConst.FeatureEnum).PropertyController)
  self._vitality = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).InitialVitality)
end

DormFightVitalityController.GetVitalityRatio = function(self)
  -- function num : 0_2 , upvalues : DormFightConst
  local maxVitality = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).MaxVitality)
  return self._vitality / maxVitality
end

DormFightVitalityController.OnUpdate = function(self, deltaTime)
  -- function num : 0_3 , upvalues : _ENV, State2ResumeRatePropertyKeyList, DormFightConst
  local resumeValue = 0
  for _,v in ipairs(State2ResumeRatePropertyKeyList) do
    resumeValue = not (self._modelCtrl):IsInState(v.state) or (self._propertyCtrl):GetProperty(v.key) or 0
    do break end
  end
  do
    local maxVitality = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).MaxVitality)
    local value = self._vitality + (math.floor)((resumeValue) * deltaTime)
    self._vitality = (math.clamp)(value, 0, maxVitality)
  end
end

DormFightVitalityController.ShouldKnockOut = function(self)
  -- function num : 0_4 , upvalues : DormFightConst, _ENV
  local maxVitality = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).MaxVitality)
  local knockOutRate = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).KnockOutVitalityRate)
  if maxVitality * knockOutRate < self._vitality then
    return false
  end
  local diff = (math.floor)((knockOutRate - self._vitality / maxVitality) * 100)
  local baseProbability = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).KnockOutBasicRatio)
  local upRate = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).KnockOutRatioUpRate)
  do return (math.random)() < baseProbability + upRate * diff * 0.01 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormFightVitalityController.OnAttacked = function(self)
  -- function num : 0_5 , upvalues : DormFightConst, _ENV
  local lossValue = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).AttackedVitalityLoss)
  local maxVitality = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).MaxVitality)
  local value = self._vitality + lossValue
  self._vitality = (math.clamp)(value, 0, maxVitality)
end

DormFightVitalityController.OnHitWall = function(self)
  -- function num : 0_6 , upvalues : DormFightConst, _ENV
  local lossValue = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).HitWallVitalityLoss)
  local maxVitality = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).MaxVitality)
  local value = self._vitality + lossValue
  self._vitality = (math.clamp)(value, 0, maxVitality)
end

return DormFightVitalityController

