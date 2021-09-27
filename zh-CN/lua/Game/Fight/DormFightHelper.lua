local DormFightConst = require("Game.Fight.DormFightConst")
local CS_PlayerPrefs = (CS.UnityEngine).PlayerPrefs
local PropertyType2AttrName = {}
PropertyType2AttrName[(DormFightConst.PropertyEnum).MoveSpeed] = "MoveSpeed"
PropertyType2AttrName[(DormFightConst.PropertyEnum).RunSpeed] = "RunSpeed"
PropertyType2AttrName[(DormFightConst.PropertyEnum).AcceleratedVelocity] = "AcceleratedVelocity"
PropertyType2AttrName[(DormFightConst.PropertyEnum).NegativeAcceleratedVelocity] = "NegativeAcceleratedVelocity"
PropertyType2AttrName[(DormFightConst.PropertyEnum).HitShieldTime] = "HitShieldTime"
PropertyType2AttrName[(DormFightConst.PropertyEnum).MaxVitality] = "MaxVitality"
PropertyType2AttrName[(DormFightConst.PropertyEnum).InitialVitality] = "InitialVitality"
PropertyType2AttrName[(DormFightConst.PropertyEnum).IdleVitalityResumeRate] = "IdleVitalityResumeRate"
PropertyType2AttrName[(DormFightConst.PropertyEnum).WalkVitalityResumeRate] = "WalkVitalityResumeRate"
PropertyType2AttrName[(DormFightConst.PropertyEnum).RunVitalityResumeRate] = "RunVitalityResumeRate"
PropertyType2AttrName[(DormFightConst.PropertyEnum).AttackVitalityResumeRate] = "AttackVitalityResumeRate"
PropertyType2AttrName[(DormFightConst.PropertyEnum).HitVitalityResumeRate] = "HitVitalityResumeRate"
PropertyType2AttrName[(DormFightConst.PropertyEnum).KnockOutVitalityResumeRate] = "KnockOutVitalityResumeRate"
PropertyType2AttrName[(DormFightConst.PropertyEnum).AttackedVitalityLoss] = "AttackedVitalityLoss"
PropertyType2AttrName[(DormFightConst.PropertyEnum).HitWallVitalityLoss] = "HitWallVitalityLoss"
PropertyType2AttrName[(DormFightConst.PropertyEnum).KnockOutVitalityRate] = "KnockOutVitalityRate"
PropertyType2AttrName[(DormFightConst.PropertyEnum).KnockOutBasicRatio] = "KnockOutBasicRatio"
PropertyType2AttrName[(DormFightConst.PropertyEnum).KnockOutRatioUpRate] = "RatioUpRate"
PropertyType2AttrName[(DormFightConst.PropertyEnum).HitForceStrength] = "HitForceStrength"
PropertyType2AttrName[(DormFightConst.PropertyEnum).KnockOutForceStrength] = "KnockOutForceStrength"
PropertyType2AttrName[(DormFightConst.PropertyEnum).KnockOutLieDownInterval] = "KnockOutLieDownInterval"
PropertyType2AttrName[(DormFightConst.PropertyEnum).RotateRatio] = "RotateRatio"
PropertyType2AttrName[(DormFightConst.PropertyEnum).AttackShieldInterval] = "AttackShieldInterval"
PropertyType2AttrName[(DormFightConst.PropertyEnum).AttackAutoAdjustSqrDistance] = "AttackAutoAdjustSqrDistance"
PropertyType2AttrName[(DormFightConst.PropertyEnum).KnockOutGetUpInterval] = "KnockOutGetUpInterval"
local DormFightHelper = {}
local _propertyValue = {}
DormFightHelper.GetPropertyValue = function(propertyType)
  -- function num : 0_0 , upvalues : _propertyValue, _ENV, PropertyType2AttrName, CS_PlayerPrefs
  if _propertyValue[propertyType] == nil then
    local cfg = (ConfigData.dorm_fight)[0]
    local attrName = PropertyType2AttrName[propertyType]
    local defaultValue = cfg ~= nil and attrName ~= nil and cfg[attrName] or 0
    if isGameDev then
      _propertyValue[propertyType] = (CS_PlayerPrefs.GetFloat)("DFP_" .. propertyType, defaultValue)
    else
      _propertyValue[propertyType] = defaultValue
    end
  end
  do
    return _propertyValue[propertyType]
  end
end

DormFightHelper.SetPropertyValue = function(propertyType, value)
  -- function num : 0_1 , upvalues : _propertyValue, _ENV
  if _propertyValue[propertyType] ~= nil and (math.abs)(_propertyValue[propertyType] - value) < 0.0001 then
    return 
  end
  _propertyValue[propertyType] = value
end

DormFightHelper.SavePropertyValue = function()
  -- function num : 0_2 , upvalues : _ENV, _propertyValue, CS_PlayerPrefs
  for k,v in pairs(_propertyValue) do
    (CS_PlayerPrefs.SetFloat)("DFP_" .. k, v)
  end
  ;
  (CS_PlayerPrefs.Save)()
end

return DormFightHelper

