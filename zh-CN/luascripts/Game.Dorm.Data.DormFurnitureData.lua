-- params : ...
-- function num : 0 , upvalues : _ENV
local DormFurnitureData = class("DormFurnitureData")
local DormUtil = require("Game.Dorm.DormUtil")
local DormInterPointData = require("Game.Dorm.Data.DormInterPointData")
DormFurnitureData.ctor = function(self)
  -- function num : 0_0
end

DormFurnitureData.InitFntData = function(self, id, roomData, fntData)
  -- function num : 0_1 , upvalues : _ENV, DormInterPointData
  self.id = id
  self.roomData = roomData
  self:UpdateFntData(fntData)
  local fntCfg = (ConfigData.dorm_furniture)[self.id]
  if fntCfg == nil then
    error("Can\'t find dorm_furniture cfg, id = " .. tostring(self.id))
    return 
  end
  self.fntCfg = fntCfg
  local itemCfg = (ConfigData.item)[self.id]
  if itemCfg == nil then
    error("Can\'t find item cfg, id = " .. tostring(self.id))
    return 
  end
  self.itemCfg = itemCfg
  self.interpoint = {}
  for index,interId in ipairs(fntCfg.interact_point) do
    local interCfg = (ConfigData.dorm_interpoint)[interId]
    if interCfg == nil then
      error("dorm interpoint cfg is null,id:" .. tostring(interId))
    else
      local point = (DormInterPointData.New)()
      point:InitInterPoint(interCfg, (fntCfg.interact_point_coord)[index], (fntCfg.logic_point)[index], self)
      ;
      (table.insert)(self.interpoint, point)
    end
  end
end

DormFurnitureData.UpdateFntData = function(self, fntData)
  -- function num : 0_2 , upvalues : _ENV, DormUtil
  if fntData == nil then
    self.pos = 0
    self.r = proto_object_FT_R.R_0
    self.param = 0
  else
    self.pos = fntData.pos
    self.r = fntData.r
    self.param = fntData.param
  end
  self.x = (DormUtil.FntCoord2XY)(self.pos)
end

DormFurnitureData.GetFntRoom = function(self)
  -- function num : 0_3
  return self.roomData
end

DormFurnitureData.GetName = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.fntCfg).name)
end

DormFurnitureData.GetIntro = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.fntCfg).intro)
end

DormFurnitureData.GetFntType = function(self)
  -- function num : 0_6
  return (self.fntCfg).type
end

DormFurnitureData.GetFntSize = function(self)
  -- function num : 0_7
  return ((self.fntCfg).size)[1], ((self.fntCfg).size)[2]
end

DormFurnitureData.GetFntPrefab = function(self)
  -- function num : 0_8
  return (self.fntCfg).prefab
end

DormFurnitureData.GetFntIcon = function(self)
  -- function num : 0_9
  return (self.itemCfg).icon
end

DormFurnitureData.GetFntComfort = function(self)
  -- function num : 0_10
  return (self.fntCfg).comfort
end

DormFurnitureData.SetFntPos = function(self, x, y)
  -- function num : 0_11 , upvalues : DormUtil
  self.x = x
  self.y = y
  self.pos = (DormUtil.XYCoord2Fnt)(x, y)
end

DormFurnitureData.SetFntParam = function(self, param)
  -- function num : 0_12
  if param == nil then
    param = 0
  end
  self.param = param
end

DormFurnitureData.GetFntParam = function(self)
  -- function num : 0_13
  return self.param
end

DormFurnitureData.CanBindRole = function(self)
  -- function num : 0_14
  return (self.fntCfg).can_binding
end

DormFurnitureData.RotateFnt = function(self)
  -- function num : 0_15
  self.r = (self.r + 90) % 360
  return self.r
end

DormFurnitureData.CheckOutMap = function(self)
  -- function num : 0_16 , upvalues : DormUtil
  local oldX = self.x
  local oldY = self.y
  local sizeX, sizeY = self:GetFntSize()
  local outX, outY, newX, newY = (DormUtil.FntAreaOutMap)(oldX, oldY, sizeX, sizeY, self.r, self:GetFntType())
  if outX or outY then
    self:SetFntPos(newX, newY)
    return true
  end
  return false
end

return DormFurnitureData

