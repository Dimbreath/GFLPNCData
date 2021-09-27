local DormFightCharacterFeatureBase = class("DormFightCharacterFeatureBase")
DormFightCharacterFeatureBase.ctor = function(self)
  -- function num : 0_0
  self._owner = nil
end

DormFightCharacterFeatureBase.GetFeature = function(self, featureType)
  -- function num : 0_1
  if self._owner then
    return (self._owner):GetFeature(featureType)
  end
end

DormFightCharacterFeatureBase.Init = function(self, owner)
  -- function num : 0_2
  self._owner = owner
  self:OnInit()
end

DormFightCharacterFeatureBase.Update = function(self, deltaTime)
  -- function num : 0_3
  self:OnUpdate(deltaTime)
end

DormFightCharacterFeatureBase.Destroy = function(self)
  -- function num : 0_4
  self:OnDestroy()
end

DormFightCharacterFeatureBase.OnInit = function(self)
  -- function num : 0_5
end

DormFightCharacterFeatureBase.OnUpdate = function(self, deltaTime)
  -- function num : 0_6
end

DormFightCharacterFeatureBase.Destroy = function(self)
  -- function num : 0_7
end

return DormFightCharacterFeatureBase

