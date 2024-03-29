local DormHouseData = class("DormHouseData")
local DormRoomData = require("Game.Dorm.Data.DormRoomData")
local DormUtil = require("Game.Dorm.DormUtil")
DormHouseData.ctor = function(self)
  -- function num : 0_0
end

DormHouseData.CreateNewHouse = function(id)
  -- function num : 0_1 , upvalues : DormHouseData
  local housedata = {id = id}
  local dorm = (DormHouseData.New)()
  dorm:InitHouseData(housedata)
  return dorm
end

DormHouseData.InitHouseData = function(self, housedata)
  -- function num : 0_2 , upvalues : _ENV, DormRoomData
  self.id = housedata.id
  self.roomList = {}
  self.roomDic = {}
  self.HasBindHeroCount = 0
  if housedata.data ~= nil then
    for spos,room in pairs(housedata.data) do
      local roomData = (DormRoomData.New)()
      roomData:InitRoomData(spos, room, self.id)
      ;
      (table.insert)(self.roomList, roomData)
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.roomDic)[spos] = roomData
    end
  end
  do
    ;
    (table.sort)(self.roomList, function(x1, x2)
    -- function num : 0_2_0
    do return x1.spos < x2.spos end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    self.houseCfg = (ConfigData.dorm_house)[self.id]
    if self.houseCfg == nil then
      error("dorm house cfg is null,id:" .. tostring(self.id))
      return 
    end
  end
end

DormHouseData.GetRoomDataByRoomIndex = function(self, RoomIndex)
  -- function num : 0_3 , upvalues : _ENV, DormUtil
  for k,v in pairs(self.roomDic) do
    local x, y = (DormUtil.RoomCoordToXY)(k)
    local Index = (DormUtil.GetRoomIndexByRoomposToxy)(x, y)
    if Index == RoomIndex then
      return v
    end
  end
end

DormHouseData.RemoveHouseRoom = function(self, spos)
  -- function num : 0_4 , upvalues : _ENV
  local oldRoom = (self.roomDic)[spos]
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if oldRoom ~= nil then
    (self.roomDic)[spos] = nil
    ;
    (table.removebyvalue)(self.roomList, oldRoom)
  end
end

DormHouseData.AddHouseRoom = function(self, roomData)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self.roomDic)[roomData.spos] = roomData
  ;
  (table.insert)(self.roomList, roomData)
end

DormHouseData.GetName = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.houseCfg).name)
end

DormHouseData.GetRoomCount = function(self)
  -- function num : 0_7
  return #self.roomList
end

DormHouseData.GetRoomHexRange = function(self)
  -- function num : 0_8
  return (self.houseCfg).type
end

DormHouseData.GetComfortLimit = function(self)
  -- function num : 0_9
  return (self.houseCfg).comfort_limit
end

DormHouseData.GetComfort = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local comfort = 0
  for k,v in pairs(self.roomDic) do
    comfort = comfort + v:GetComfort()
  end
  comfort = (math.clamp)(comfort, 0, self:GetComfortLimit())
  return comfort
end

DormHouseData.GetHouseBindCount = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local count = 0
  for k,v in pairs(self.roomDic) do
    count = count + v:GetRoomBindCount()
  end
  return count
end

DormHouseData.GetHouseBindFntCount = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local count = 0
  for k,v in pairs(self.roomDic) do
    count = count + v:GetRoomBindFntCount()
  end
  return count
end

DormHouseData.IsHeroBindOnElseRoom = function(self, HeroId, CurRoomData)
  -- function num : 0_13 , upvalues : _ENV
  for k,v in pairs(self.roomDic) do
    if v.spos ~= CurRoomData.spos and v:IsHeroBindOnRoom(HeroId) then
      return true
    end
  end
  return false
end

DormHouseData.GetHeroOnElseRoomData = function(self, HeroId, CurRoomData)
  -- function num : 0_14 , upvalues : _ENV
  for k,v in pairs(self.roomDic) do
    if v.spos ~= CurRoomData.spos and v:IsHeroBindOnRoom(HeroId) then
      return v
    end
  end
end

DormHouseData.GetHouseCanBindCount = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local count = 0
  for k,v in pairs(self.roomDic) do
    count = count + #v:GetRoomCanBindList()
  end
  return count
end

DormHouseData.GetHouseCanBindFntCount = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local count = 0
  for k,v in pairs(self.roomDic) do
    count = count + v:GetRoomCanBindFntCount()
  end
  return count
end

DormHouseData.GetHouseCanBindFntData = function(self)
  -- function num : 0_17 , upvalues : _ENV
  for k,v in pairs(self.roomDic) do
    local fntData = v:GetCanBindFntData()
    if fntData ~= nil then
      return fntData
    end
  end
end

DormHouseData.SwapHousePos = function(self, spos1, spos2)
  -- function num : 0_18
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  (self.roomDic)[spos1] = (self.roomDic)[spos2]
end

DormHouseData.GetHouseBindFntDataList = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local bindList = {}
  local count = 0
  for k,v in pairs(self.roomDic) do
    for k2,ftnData in pairs(v:GetRoomCanBindList()) do
      count = count + 1
      ;
      (table.insert)(bindList, ftnData)
    end
  end
  ;
  (table.sort)(bindList, function(a, b)
    -- function num : 0_19_0
    local aBind = a:GetFntParam() ~= 0
    local bBind = b:GetFntParam() ~= 0
    if a.id >= b.id then
      do return aBind ~= bBind end
      do return aBind end
      -- DECOMPILER ERROR: 5 unprocessed JMP targets
    end
  end
)
  local list = {}
  for k,v in ipairs(bindList) do
    (table.insert)(list, v)
  end
  return list
end

return DormHouseData

