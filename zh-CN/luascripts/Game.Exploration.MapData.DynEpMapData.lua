-- params : ...
-- function num : 0 , upvalues : _ENV
local DynEpMapData = class("DynMapData")
local DynEpMapColType = require("Game.Exploration.MapData.DynEpMapColType")
local DynEpRoomData = require("Game.Exploration.MapData.DynEpRoomData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DynEpMapData.ctor = function(self, sectorId)
  -- function num : 0_0
  self.sectorId = sectorId
end

DynEpMapData.InitMapData = function(self, mapdata, nextMapBrief, opDetail)
  -- function num : 0_1 , upvalues : _ENV, DynEpMapColType, ExplorationEnum, DynEpRoomData
  self.dungeonId = mapdata.dungeonId
  self.floorIdx = mapdata.floorIdx
  self.exploraionId = mapdata.floorId
  if self.exploraionId == nil then
    error("Can\'t get exploraionId,floorIdx:" .. tostring(self.floorIdx))
    return 
  end
  self.epCfg = (ConfigData.exploration)[self.exploraionId]
  if self.epCfg == nil then
    error("exploraion cfg is null,id:" .. tostring(self.exploraionId))
    return 
  end
  self.width = mapdata.width
  self.depth = mapdata.depth
  self.lineDepth = (table.count)(mapdata.lineData)
  self.floor = mapdata.floor
  self.nextMapBrief = nextMapBrief
  local oddColNum = self.width // 2 * 2
  local evenColNum = self.width * 2 - 1 - oddColNum
  self.maxWidthIsOdd = self.width == self.oddColNum
  self.centerPosY = (self.width + 1) / 2 - 1
  self.roomMap = {}
  self.mapColTypeList = {}
  self.maxMapColNumber = self.depth + self.lineDepth
  for i = 0, self.maxMapColNumber do
    -- DECOMPILER ERROR at PC78: Confused about usage of register: R10 in 'UnsetPending'

    (self.roomMap)[i] = {}
  end
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.mapColTypeList)[0] = (DynEpMapColType.New)(self, 0, (ExplorationEnum.eTrackLineType).NormalETrack, 1)
  for i = 1, self.depth do
    local maxColRoomCount = i % 2 == 0 and evenColNum or oddColNum
    if i ~= self.depth or not (ExplorationEnum.eTrackLineType).ReverseETrack then
      local trackLineType = (ExplorationEnum.eTrackLineType).NormalYTrack
    end
    -- DECOMPILER ERROR at PC115: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (self.mapColTypeList)[i] = (DynEpMapColType.New)(self, i, trackLineType, maxColRoomCount)
  end
  for i = self.depth + 1, self.maxMapColNumber - 1 do
    -- DECOMPILER ERROR at PC131: Confused about usage of register: R10 in 'UnsetPending'

    (self.mapColTypeList)[i] = (DynEpMapColType.New)(self, i, (ExplorationEnum.eTrackLineType).SingleTrack, 1)
  end
  -- DECOMPILER ERROR at PC142: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.mapColTypeList)[self.maxMapColNumber] = (DynEpMapColType.New)(self, self.maxMapColNumber, (ExplorationEnum.eTrackLineType).EndTrack, 1)
  local deployRoom = (DynEpRoomData.New)(0, 0, (ExplorationEnum.eRoomType).deploy)
  deployRoom:SetMapData(self)
  self.deployRoom = deployRoom
  local startRoom = (DynEpRoomData.New)(0, 0, (ExplorationEnum.eRoomType).start)
  startRoom:SetMapData(self)
  self:SetMapOneRoom(startRoom.x, startRoom.y, startRoom)
  self.__startRoom = startRoom
  for k,v in pairs(mapdata.data) do
    local isHidden = (mapdata.hidden)[k] ~= nil
    local x, y = (ExplorationManager.Coordination2Pos)(k)
    local room = (DynEpRoomData.New)(x, y, v, k, isHidden)
    room:SetMapData(self)
    room:SetVisible(not isHidden)
    self:SetMapOneRoom(x, y, room)
  end
  local lastIsHidden = false
  self.__hasOverBossRoom = false
  local sortPosList = {}
  for k,v in pairs(mapdata.lineData) do
    (table.insert)(sortPosList, k)
  end
  ;
  (table.sort)(sortPosList)
  for _,k in pairs(sortPosList) do
    local v = (mapdata.lineData)[k]
    lastIsHidden = lastIsHidden or v.mode == 2 or v.mode == 4
    local x, y = (ExplorationManager.Coordination2Pos)(k)
    local room = (DynEpRoomData.New)(x, y, v.cat, k, lastIsHidden)
    room:SetMapData(self)
    room:SetVisible(not lastIsHidden)
    self:SetMapOneRoom(x, y, room)
    if v.mode == 3 or v.mode == 4 then
      self.__realBossRoom = room
      if x < self.maxMapColNumber then
        self.__hasOverBossRoom = true
      end
    end
  end
  if self.__realBossRoom == nil then
    error("探索地图错误：没有真实Boss房间，请检查配置")
    return 
  end
  for k,pos in ipairs(opDetail.path) do
    local x, y = (ExplorationManager.Coordination2Pos)(pos)
    local roomData = self:GetRoomByXY(x, y)
    roomData:SetVisible(true)
    local nextRoomList = roomData:GetNextRoom()
    for _,nextRoom in ipairs(nextRoomList) do
      nextRoom:SetVisible(true)
    end
  end
  -- DECOMPILER ERROR: 15 unprocessed JMP targets
end

DynEpMapData.HasOverBossRoom = function(self)
  -- function num : 0_2
  return self.__hasOverBossRoom
end

DynEpMapData.GetMapColType = function(self, x)
  -- function num : 0_3
  return (self.mapColTypeList)[x]
end

DynEpMapData.GetMapColTrackType = function(self, x)
  -- function num : 0_4
  return ((self.mapColTypeList)[x]).trackType
end

DynEpMapData.GetStartRoom = function(self)
  -- function num : 0_5
  return self.__startRoom
end

DynEpMapData.GetRealBossRoom = function(self)
  -- function num : 0_6
  return self.__realBossRoom
end

DynEpMapData.GetDeployRoom = function(self)
  -- function num : 0_7
  return self.deployRoom
end

DynEpMapData.SetMapOneRoom = function(self, x, y, roomData)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

  ((self.roomMap)[x])[y] = roomData
end

DynEpMapData.GetRoomByCoord = function(self, coord)
  -- function num : 0_9 , upvalues : _ENV
  local x, y = (ExplorationManager.Coordination2Pos)(coord)
  if (self.roomMap)[x] == nil or ((self.roomMap)[x])[y] == nil then
    warn("Cant\'t find DynEpRoomData, pos = " .. tostring(x) .. "," .. tostring(y))
    return nil
  end
  return ((self.roomMap)[x])[y]
end

DynEpMapData.GetRoomByXY = function(self, x, y)
  -- function num : 0_10
  return ((self.roomMap)[x])[y]
end

DynEpMapData.GetOneRoomByX = function(self, x)
  -- function num : 0_11 , upvalues : _ENV
  for k,room in pairs((self.roomMap)[x]) do
    if room ~= nil then
      return room
    end
  end
  return nil
end

DynEpMapData.GetFirstAbleRoomData = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if (self.roomMap)[1] == nil then
    return nil
  end
  for k,roomData in pairs((self.roomMap)[1]) do
    if roomData ~= nil then
      return roomData
    end
  end
  return nil
end

DynEpMapData.GetNextMapBrief = function(self)
  -- function num : 0_13
  return self.nextMapBrief
end

DynEpMapData.GetEpSceneCfg = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local sceneCfg = (ConfigData.scene)[(self.epCfg).scene_id]
  if sceneCfg == nil then
    error("scene cfg is null,id:" .. tostring((self.epCfg).scene_id))
  end
  return sceneCfg
end

DynEpMapData.GetEpSceneSectorId = function(self)
  -- function num : 0_15
  return self.sectorId
end

return DynEpMapData

