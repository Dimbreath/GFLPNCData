-- params : ...
-- function num : 0 , upvalues : _ENV
local DormRoomData = class("DormRoomData")
local DormUtil = require("Game.Dorm.DormUtil")
local DormFurnitureData = require("Game.Dorm.Data.DormFurnitureData")
DormRoomData.ctor = function(self)
  -- function num : 0_0
end

DormRoomData.CreateNewRoom = function(spos, roomId)
  -- function num : 0_1 , upvalues : DormRoomData
  local roomdata = {id = roomId}
  local room = (DormRoomData.New)()
  room:InitRoomData(spos, roomdata)
  return room
end

DormRoomData.InitRoomData = function(self, spos, roomdata)
  -- function num : 0_2 , upvalues : DormUtil
  local x, y = (DormUtil.RoomCoordToXY)(spos)
  self.x = x
  self.y = y
  self.spos = spos
  self:__InitDormRoomData(roomdata)
end

DormRoomData.InitPrefabRoom = function(self, uid, roomdata)
  -- function num : 0_3
  self.uid = uid
  self:__InitDormRoomData(roomdata)
end

DormRoomData.__InitDormRoomData = function(self, roomdata)
  -- function num : 0_4 , upvalues : _ENV
  self.id = roomdata.id
  self.isPrefab = self.uid ~= nil
  self:UpdateRoomFntData(roomdata.data, true)
  self.roomCfg = (ConfigData.dorm_room)[self.id]
  if self.roomCfg == nil then
    error("dorm room cfg is null,id:" .. tostring(self.id))
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DormRoomData.UpdateRoomFntData = function(self, data, createFntData)
  -- function num : 0_5 , upvalues : _ENV, DormFurnitureData
  self.data = data
  if createFntData then
    self.canBindfntDataList = {}
    self.fntDataList = {}
    if self.data ~= nil then
      for k,v in ipairs(self.data) do
        local fntData = (DormFurnitureData.New)()
        fntData:InitFntData(v.id, self, v)
        -- DECOMPILER ERROR at PC22: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self.fntDataList)[k] = fntData
        if fntData:CanBindRole() then
          (table.insert)(self.canBindfntDataList, fntData)
        end
      end
    end
  end
  do
    self.interpoint = {}
    for k,v in ipairs(self.fntDataList) do
      for _,pointData in pairs(v.interpoint) do
        pointData:UnBindInterPoint()
        ;
        (table.insert)(self.interpoint, pointData)
      end
    end
  end
end

DormRoomData.__UpdateRoomInterPoint = function(self)
  -- function num : 0_6
end

DormRoomData.ChangePos = function(self, spos)
  -- function num : 0_7 , upvalues : DormUtil
  if self.isPrefab then
    self.isPrefab = false
    self.uid = nil
  end
  local x, y = (DormUtil.RoomCoordToXY)(spos)
  self.x = x
  self.y = y
  self.spos = spos
end

DormRoomData.GetName = function(self)
  -- function num : 0_8 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.roomCfg).name)
end

DormRoomData.GetComfort = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local comfort = (self.roomCfg).comfort
  for k,v in pairs(self.fntDataList) do
    comfort = comfort + v:GetFntComfort()
  end
  return comfort
end

DormRoomData.AddFntData = function(self, fntData)
  -- function num : 0_10 , upvalues : _ENV
  if fntData ~= nil then
    (table.insert)(self.fntDataList, fntData)
    if fntData:CanBindRole() then
      (table.insert)(self.canBindfntDataList, fntData)
    end
  end
end

DormRoomData.RemoveFntData = function(self, fntData)
  -- function num : 0_11 , upvalues : _ENV
  (table.removebyvalue)(self.fntDataList, fntData)
  if fntData:CanBindRole() then
    (table.removebyvalue)(self.canBindfntDataList, fntData)
  end
end

DormRoomData.GetFntDatas = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local dataList = {}
  for k,fntData in ipairs(self.fntDataList) do
    local data = {id = fntData.id, pos = fntData.pos, r = fntData.r, param = fntData:GetFntParam()}
    dataList[k] = data
  end
  return dataList
end

DormRoomData.GetRoomBindCount = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local count = 0
  for k,fntData in pairs(self.canBindfntDataList) do
    local param = fntData:GetFntParam()
    if param ~= 0 then
      count = count + 1
    end
  end
  count = (math.min)(count, (ConfigData.game_config).DormRoomRoleMaxCount)
  return count
end

DormRoomData.GetRoomCanBindList = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if #self.canBindfntDataList <= (ConfigData.game_config).DormRoomRoleMaxCount then
    return self.canBindfntDataList
  end
  ;
  (table.sort)(self.canBindfntDataList, function(a, b)
    -- function num : 0_14_0
    local aBind = a:GetFntParam() ~= 0
    local bBind = b:GetFntParam() ~= 0
    if a.id >= b.id then
      do return aBind ~= bBind end
      do return aBind end
      -- DECOMPILER ERROR: 5 unprocessed JMP targets
    end
  end
)
  local count = 0
  local list = {}
  for k,fntData in ipairs(self.canBindfntDataList) do
    count = count + 1
    if count <= (ConfigData.game_config).DormRoomRoleMaxCount then
      (table.insert)(list, fntData)
    else
      break
    end
  end
  do
    return list
  end
end

DormRoomData.GetCanBindFntData = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local count = 0
  local canBindfntData = nil
  for k,fntData in ipairs(self.canBindfntDataList) do
    local param = fntData:GetFntParam()
    if param == 0 then
      canBindfntData = fntData
    else
      count = count + 1
    end
  end
  if count < (ConfigData.game_config).DormRoomRoleMaxCount then
    return canBindfntData
  end
end

DormRoomData.GetFntDataIndex = function(self, fntData)
  -- function num : 0_16 , upvalues : _ENV
  for index,v in ipairs(self.fntDataList) do
    if fntData == v then
      return index
    end
  end
  error("Can\'t get FntData index")
end

DormRoomData.GetDoorCoord = function(self)
  -- function num : 0_17
  return ((self.roomCfg).door)[1], ((self.roomCfg).door)[2]
end

return DormRoomData

-- params : ...
-- function num : 0 , upvalues : _ENV
local DormRoomData = class("DormRoomData")
local DormUtil = require("Game.Dorm.DormUtil")
local DormFurnitureData = require("Game.Dorm.Data.DormFurnitureData")
DormRoomData.ctor = function(self)
    -- function num : 0_0
end

DormRoomData.CreateNewRoom = function(spos, roomId)
    -- function num : 0_1 , upvalues : DormRoomData
    local roomdata = {id = roomId}
    local room = (DormRoomData.New)()
    room:InitRoomData(spos, roomdata)
    return room
end

DormRoomData.InitRoomData = function(self, spos, roomdata)
    -- function num : 0_2 , upvalues : DormUtil
    local x, y = (DormUtil.RoomCoordToXY)(spos)
    self.x = x
    self.y = y
    self.spos = spos
    self:__InitDormRoomData(roomdata)
end

DormRoomData.InitPrefabRoom = function(self, uid, roomdata)
    -- function num : 0_3
    self.uid = uid
    self:__InitDormRoomData(roomdata)
end

DormRoomData.__InitDormRoomData = function(self, roomdata)
    -- function num : 0_4 , upvalues : _ENV
    self.id = roomdata.id
    self.isPrefab = self.uid ~= nil
    self:UpdateRoomFntData(roomdata.data, true)
    self.roomCfg = (ConfigData.dorm_room)[self.id]
    if self.roomCfg == nil then
        error("dorm room cfg is null,id:" .. tostring(self.id))
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DormRoomData.UpdateRoomFntData = function(self, data, createFntData)
    -- function num : 0_5 , upvalues : _ENV, DormFurnitureData
    self.data = data
    if createFntData then
        self.canBindfntDataList = {}
        self.fntDataList = {}
        if self.data ~= nil then
            for k, v in ipairs(self.data) do
                local fntData = (DormFurnitureData.New)()
                fntData:InitFntData(v.id, self, v) -- DECOMPILER ERROR at PC22: Confused about usage of register: R9 in 'UnsetPending'
                ;
                (self.fntDataList)[k] = fntData
                if fntData:CanBindRole() then
                    (table.insert)(self.canBindfntDataList, fntData)
                end
            end
        end
    end
    do
        self.interpoint = {}
        for k, v in ipairs(self.fntDataList) do
            for _, pointData in pairs(v.interpoint) do
                pointData:UnBindInterPoint();
                (table.insert)(self.interpoint, pointData)
            end
        end
    end
end

DormRoomData.__UpdateRoomInterPoint = function(self)
    -- function num : 0_6
end

DormRoomData.ChangePos = function(self, spos)
    -- function num : 0_7 , upvalues : DormUtil
    if self.isPrefab then
        self.isPrefab = false
        self.uid = nil
    end
    local x, y = (DormUtil.RoomCoordToXY)(spos)
    self.x = x
    self.y = y
    self.spos = spos
end

DormRoomData.GetName = function(self)
    -- function num : 0_8 , upvalues : _ENV
    return (LanguageUtil.GetLocaleText)((self.roomCfg).name)
end

DormRoomData.GetComfort = function(self)
    -- function num : 0_9 , upvalues : _ENV
    local comfort = (self.roomCfg).comfort
    for k, v in pairs(self.fntDataList) do
        comfort = comfort + v:GetFntComfort()
    end
    return comfort
end

DormRoomData.AddFntData = function(self, fntData)
    -- function num : 0_10 , upvalues : _ENV
    if fntData ~= nil then
        (table.insert)(self.fntDataList, fntData)
        if fntData:CanBindRole() then
            (table.insert)(self.canBindfntDataList, fntData)
        end
    end
end

DormRoomData.RemoveFntData = function(self, fntData)
    -- function num : 0_11 , upvalues : _ENV
    (table.removebyvalue)(self.fntDataList, fntData)
    if fntData:CanBindRole() then
        (table.removebyvalue)(self.canBindfntDataList, fntData)
    end
end

DormRoomData.GetFntDatas = function(self)
    -- function num : 0_12 , upvalues : _ENV
    local dataList = {}
    for k, fntData in ipairs(self.fntDataList) do
        local data = {
            id = fntData.id,
            pos = fntData.pos,
            r = fntData.r,
            param = fntData:GetFntParam()
        }
        dataList[k] = data
    end
    return dataList
end

DormRoomData.GetRoomBindCount = function(self)
    -- function num : 0_13 , upvalues : _ENV
    local count = 0
    for k, fntData in pairs(self.canBindfntDataList) do
        local param = fntData:GetFntParam()
        if param ~= 0 then count = count + 1 end
    end
    count = (math.min)(count, (ConfigData.game_config).DormRoomRoleMaxCount)
    return count
end

DormRoomData.GetRoomCanBindList = function(self)
    -- function num : 0_14 , upvalues : _ENV
    if #self.canBindfntDataList <= (ConfigData.game_config).DormRoomRoleMaxCount then
        return self.canBindfntDataList
    end
    (table.sort)(self.canBindfntDataList, function(a, b)
        -- function num : 0_14_0
        local aBind = a:GetFntParam() ~= 0
        local bBind = b:GetFntParam() ~= 0
        if a.id >= b.id then
            do return aBind ~= bBind end
            do return aBind end
            -- DECOMPILER ERROR: 5 unprocessed JMP targets
        end
    end)
    local count = 0
    local list = {}
    for k, fntData in ipairs(self.canBindfntDataList) do
        count = count + 1
        if count <= (ConfigData.game_config).DormRoomRoleMaxCount then
            (table.insert)(list, fntData)
        else
            break
        end
    end
    do return list end
end

DormRoomData.GetCanBindFntData = function(self)
    -- function num : 0_15 , upvalues : _ENV
    local count = 0
    local canBindfntData = nil
    for k, fntData in ipairs(self.canBindfntDataList) do
        local param = fntData:GetFntParam()
        if param == 0 then
            canBindfntData = fntData
        else
            count = count + 1
        end
    end
    if count < (ConfigData.game_config).DormRoomRoleMaxCount then
        return canBindfntData
    end
end

DormRoomData.GetFntDataIndex = function(self, fntData)
    -- function num : 0_16 , upvalues : _ENV
    for index, v in ipairs(self.fntDataList) do
        if fntData == v then return index end
    end
    error("Can\'t get FntData index")
end

DormRoomData.GetDoorCoord = function(self)
    -- function num : 0_17
    return ((self.roomCfg).door)[1], ((self.roomCfg).door)[2]
end

return DormRoomData

