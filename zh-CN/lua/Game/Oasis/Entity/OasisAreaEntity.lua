local OasisAreaEntity = class("OasisAreaEntity")
OasisAreaEntity.ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : _ENV
  self.gameObject = gameObject
  self.transform = gameObject.transform
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)(gameObject, self.bind)
end

OasisAreaEntity.InitOasisAreaEntity = function(self, areaId)
  -- function num : 0_1
  self.areaId = areaId
end

OasisAreaEntity.GetOasisAreaEntityId = function(self)
  -- function num : 0_2
  return self.areaId
end

OasisAreaEntity.OnDelete = function(self)
  -- function num : 0_3 , upvalues : _ENV
  DestroyUnityObject(self.gameObject)
end

return OasisAreaEntity

