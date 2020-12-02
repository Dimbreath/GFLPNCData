-- params : ...
-- function num : 0 , upvalues : _ENV
local DormInterPointData = class("DormInterPointData")
DormInterPointData.ctor = function(self)
  -- function num : 0_0
end

DormInterPointData.InitInterPoint = function(self, interCfg, coord, logicpoint, fntData)
  -- function num : 0_1
  self.id = interCfg.id
  self.interCfg = interCfg
  self.coord = coord
  self.logicpoint = logicpoint
  self.fntData = fntData
end

DormInterPointData.BindInterPoint = function(self, charEntity)
  -- function num : 0_2
  self.__active = false
  self.__bindCharacter = charEntity
end

DormInterPointData.UnBindInterPoint = function(self)
  -- function num : 0_3
  self.__active = true
  self.__bindCharacter = nil
end

DormInterPointData.GetPointActive = function(self)
  -- function num : 0_4
  return self.__active
end

DormInterPointData.GetBindCharacter = function(self)
  -- function num : 0_5
  return self.__bindCharacter
end

DormInterPointData.GetInterPointType = function(self)
  -- function num : 0_6
  return (self.interCfg).interact_point_type
end

DormInterPointData.GetInterAngle = function(self)
  -- function num : 0_7
  return (self.interCfg).interact_front * 90
end

DormInterPointData.GetInterHeight = function(self)
  -- function num : 0_8
  return (self.interCfg).interact_height
end

DormInterPointData.GetInterOffsetCoord = function(self)
  -- function num : 0_9 , upvalues : _ENV
  return (Vector3.New)((self.coord)[1], 0, (self.coord)[2])
end

return DormInterPointData

