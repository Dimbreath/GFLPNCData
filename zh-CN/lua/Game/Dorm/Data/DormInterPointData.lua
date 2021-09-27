local DormInterPointData = class("DormInterPointData")
DormInterPointData.ctor = function(self)
  -- function num : 0_0
end

DormInterPointData.InitInterPoint = function(self, interCfg, coord, start_coord, fntData)
  -- function num : 0_1
  self.id = interCfg.id
  self.interCfg = interCfg
  self.coord = coord
  self.start_coord = start_coord
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

DormInterPointData.GetInterOffsetCoord = function(self)
  -- function num : 0_8 , upvalues : _ENV
  return (Vector3.New)((self.coord)[1], (self.coord)[2], (self.coord)[3])
end

DormInterPointData.GetInterStartCoord = function(self)
  -- function num : 0_9 , upvalues : _ENV
  return (Vector3.New)((self.start_coord)[1], 0, (self.start_coord)[2])
end

DormInterPointData.GetInterMoveCurveId = function(self)
  -- function num : 0_10
  return (self.interCfg).move_curve
end

DormInterPointData.GetInterExitCurveId = function(self)
  -- function num : 0_11
  return (self.interCfg).exit_curve
end

DormInterPointData.GetInteractName = function(self)
  -- function num : 0_12 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.interCfg).interact_name)
end

DormInterPointData.GetFntCfg = function(self)
  -- function num : 0_13
  return (self.fntData).fntCfg
end

return DormInterPointData

