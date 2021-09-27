local DormFurnitureData = class("DormFurnitureData")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local DormInterPointData = require("Game.Dorm.Data.DormInterPointData")
DormFurnitureData.ctor = function(self)
  -- function num : 0_0
end

DormFurnitureData.InitFntData = function(self, id, roomData, fntData, isDoor)
  -- function num : 0_1 , upvalues : _ENV
  self.id = id
  self.roomData = roomData
  local fntId = id
  if isDoor and id == 0 then
    fntId = (ConfigData.game_config).DmRoomDoorDefaultId
  end
  self:_InitFntCfg(fntId)
  self:UpdateFntData(fntData)
end

DormFurnitureData._InitFntCfg = function(self, fntId)
  -- function num : 0_2 , upvalues : _ENV, DormInterPointData
  local fntCfg = (ConfigData.dorm_furniture)[fntId]
  if fntCfg == nil then
    error("Can\'t find dorm_furniture cfg, id = " .. tostring(fntId))
    return 
  end
  self.fntCfg = fntCfg
  local itemCfg = (ConfigData.item)[fntId]
  if itemCfg == nil then
    error("Can\'t find item cfg, id = " .. tostring(fntId))
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
      point:InitInterPoint(interCfg, (fntCfg.interact_point_coord)[index], (fntCfg.interact_start_coord)[index], self)
      ;
      (table.insert)(self.interpoint, point)
    end
  end
end

DormFurnitureData.UpdateFntData = function(self, fntData, isReset)
  -- function num : 0_3 , upvalues : _ENV, DormUtil
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
  if self:IsDmFntDoor() then
    local sizeX, sizeY = self:GetFntSize()
    local newY = (DormUtil.GetFntDoorY)(sizeY)
    if self.y ~= newY then
      self.y = newY
      self.pos = (DormUtil.XYToRoomCoord)(self.x, self.y)
    end
  end
  do
    if not isReset then
      self:RecordOriginalFntData()
    end
  end
end

DormFurnitureData.RecordOriginalFntData = function(self)
  -- function num : 0_4
  self.oldFntData = {id = self.id, pos = self.pos, r = self.r, param = self.param}
end

DormFurnitureData.ResetFntData = function(self)
  -- function num : 0_5
  self:UpdateFntData(self.oldFntData, true)
end

DormFurnitureData.GetFntRoom = function(self)
  -- function num : 0_6
  return self.roomData
end

DormFurnitureData.GetName = function(self)
  -- function num : 0_7 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.itemCfg).name)
end

DormFurnitureData.GetFntIntro = function(self)
  -- function num : 0_8 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.itemCfg).describe)
end

DormFurnitureData.GetFntType = function(self)
  -- function num : 0_9
  return (self.fntCfg).type
end

DormFurnitureData.GetFntSize = function(self)
  -- function num : 0_10
  return ((self.fntCfg).size)[1], ((self.fntCfg).size)[2], ((self.fntCfg).size)[3]
end

DormFurnitureData.GetFntPrefab = function(self)
  -- function num : 0_11
  return (self.fntCfg).prefab
end

DormFurnitureData.GetFntIcon = function(self)
  -- function num : 0_12
  return (self.itemCfg).icon
end

DormFurnitureData.GetFntComfort = function(self)
  -- function num : 0_13
  return (self.fntCfg).comfort
end

DormFurnitureData.SetFntPos = function(self, x, y)
  -- function num : 0_14 , upvalues : DormUtil
  self.x = x
  self.y = y
  self.pos = (DormUtil.XYCoord2Fnt)(x, y)
end

DormFurnitureData.SetFntParam = function(self, param)
  -- function num : 0_15
  if param == nil then
    param = 0
  end
  self.param = param
end

DormFurnitureData.GetFntParam = function(self)
  -- function num : 0_16
  return self.param
end

DormFurnitureData.CanBindRole = function(self)
  -- function num : 0_17
  return (self.fntCfg).can_binding
end

DormFurnitureData.RotateFnt = function(self)
  -- function num : 0_18
  self.r = (self.r + 90) % 360
  return self.r
end

DormFurnitureData.CheckOutMap = function(self)
  -- function num : 0_19 , upvalues : DormUtil
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

DormFurnitureData.GetDmFntServerData = function(self)
  -- function num : 0_20
  local id = self.id
  local data = {id = id, pos = self.pos, r = self.r, param = self.param}
  return data
end

DormFurnitureData.IsDmFntDoor = function(self)
  -- function num : 0_21 , upvalues : DormEnum
  do return self:GetFntType() == (DormEnum.eDormFntType).Door end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormFurnitureData.TryFntDoorDataChangeDoor = function(self, fntId)
  -- function num : 0_22 , upvalues : DormUtil
  local id = (DormUtil.IsDmRoomDefaultDoorId)(fntId) and 0 or fntId
  if self.id == id then
    return false
  end
  self.id = id
  self:_InitFntCfg(fntId)
  return true
end

DormFurnitureData.GetFntOldId = function(self)
  -- function num : 0_23
  return (self.oldFntData).id
end

DormFurnitureData.GetFntCategory = function(self)
  -- function num : 0_24
  return (self.fntCfg).category
end

return DormFurnitureData

