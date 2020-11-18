-- params : ...
-- function num : 0 , upvalues : _ENV
local DynEpMapColType = class("DynEpMapColType")
DynEpMapColType.ctor = function(self, mapData, x, trackType, maxRoomCount)
  -- function num : 0_0
  self.x = x
  self.trackType = trackType
  self.maxRoomCount = maxRoomCount
  self.isMaxWidthCol = mapData.width == maxRoomCount
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return DynEpMapColType

