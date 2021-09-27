local DormInterPointEntity = class("DormInterPointEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local cs_RenderManager = CS.RenderManager
DormInterPointEntity.ctor = function(self)
  -- function num : 0_0
end

DormInterPointEntity.InitInterPointEntity = function(self, interPoint, interStartPos, interEndPos, fntEntity)
  -- function num : 0_1
  self.__interPoint = interPoint
  self:RefreshInterPointEntity(interStartPos, interEndPos, fntEntity)
end

DormInterPointEntity.RefreshInterPointEntity = function(self, interStartPos, interEndPos, fntEntity)
  -- function num : 0_2
  self.__interStartPos = interStartPos
  self.__interEndPos = interEndPos
  self.__fntEntity = fntEntity
end

DormInterPointEntity.GetInterPointData = function(self)
  -- function num : 0_3
  return self.__interPoint
end

DormInterPointEntity.GetPointStartPos = function(self)
  -- function num : 0_4
  return self.__interStartPos
end

DormInterPointEntity.GetPointEndPos = function(self)
  -- function num : 0_5
  return self.__interEndPos
end

DormInterPointEntity.GetPointFromFntEntity = function(self)
  -- function num : 0_6
  return self.__fntEntity
end

DormInterPointEntity.ClearPointEntityData = function(self)
  -- function num : 0_7
  self.__fntEntity = nil
end

DormInterPointEntity.AddPointFntHighlight = function(self)
  -- function num : 0_8 , upvalues : DormUtil
  (DormUtil.AddHighLightTarget)((self.__fntEntity).gameObject)
end

DormInterPointEntity.RemovePointFntHighlight = function(self)
  -- function num : 0_9 , upvalues : DormUtil
  (DormUtil.RemovePointFntHighlight)((self.__fntEntity).gameObject)
end

DormInterPointEntity.GetSqrDistanceToScreenTouch = function(self, screenPos)
  -- function num : 0_10 , upvalues : _ENV, cs_RenderManager
  local pos = (UIManager:GetMainCamera()):WorldToScreenPoint(self.__interEndPos) / cs_RenderManager.SceneCameraResolutionRatio
  return (Vector2.Distance)(pos, screenPos)
end

return DormInterPointEntity

