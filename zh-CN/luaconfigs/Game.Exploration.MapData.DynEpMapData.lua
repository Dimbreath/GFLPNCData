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
  local sceneCfg = (ConfigData.scene)[(self.epCfg).scene_id]
  if sceneCfg == nil then
    error("scene cfg is null,id:" .. tostring((self.epCfg).scene_id))
    return 
  end
  self.sceneCfg = sceneCfg
  self.epMapLogic = mapdata.logic
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
    -- DECOMPILER ERROR at PC97: Confused about usage of register: R11 in 'UnsetPending'

    (self.roomMap)[i] = {}
  end
  -- DECOMPILER ERROR at PC107: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.mapColTypeList)[0] = (DynEpMapColType.New)(self, 0, (ExplorationEnum.eTrackLineType).NormalETrack, 1)
  for i = 1, self.depth do
    local maxColRoomCount = i % 2 == 0 and evenColNum or oddColNum
    if i ~= self.depth or not (ExplorationEnum.eTrackLineType).ReverseETrack then
      local trackLineType = (ExplorationEnum.eTrackLineType).NormalYTrack
    end
    -- DECOMPILER ERROR at PC134: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.mapColTypeList)[i] = (DynEpMapColType.New)(self, i, trackLineType, maxColRoomCount)
  end
  for i = self.depth + 1, self.maxMapColNumber - 1 do
    -- DECOMPILER ERROR at PC150: Confused about usage of register: R11 in 'UnsetPending'

    (self.mapColTypeList)[i] = (DynEpMapColType.New)(self, i, (ExplorationEnum.eTrackLineType).SingleTrack, 1)
  end
  -- DECOMPILER ERROR at PC161: Confused about usage of register: R7 in 'UnsetPending'

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
    local isCross = (mapdata.crossroad)[k]
    local x, y = (ExplorationManager.Coordination2Pos)(k)
    local room = (DynEpRoomData.New)(x, y, v, k, isHidden, isCross)
    room:SetMapData(self, opDetail)
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
    local room = (DynEpRoomData.New)(x, y, v.cat, k, lastIsHidden, nil, v.mode)
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
  if (self.epCfg).view_range > 0 then
    self.mapViewRange = {}
    local x = 0
    do
      if #opDetail.path > 0 then
        local coord = (opDetail.path)[#opDetail.path]
        x = (ExplorationManager.Coordination2Pos)(coord)
      end
      for i = x, (math.min)(self.maxMapColNumber, x + (self.epCfg).view_range) do
        -- DECOMPILER ERROR at PC334: Confused about usage of register: R16 in 'UnsetPending'

        (self.mapViewRange)[i] = true
      end
      for i = x + (self.epCfg).view_range + 1, self.maxMapColNumber do
        local colRooms = (self.roomMap)[i]
        for y,roomData in pairs(colRooms) do
          roomData:SetVisible(false)
        end
      end
      for pos,_ in pairs(opDetail.epFloorWalked) do
        local x, y = (ExplorationManager.Coordination2Pos)(pos)
        local roomData = self:GetRoomByXY(x, y)
        roomData:SetVisible(true)
        local nextRoomList = roomData:GetNextRoom()
        for _,nextRoom in ipairs(nextRoomList) do
          nextRoom:SetVisible(true)
        end
      end
      -- DECOMPILER ERROR: 18 unprocessed JMP targets
    end
  end
end

DynEpMapData.EpHasViewRange = function(self)
  -- function num : 0_2
  do return self.mapViewRange ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynEpMapData.GetEpViewRange = function(self)
  -- function num : 0_3
  return (self.epCfg).view_range
end

DynEpMapData.RefreshViewRrange = function(self, x, refreshRoomAction)
  -- function num : 0_4 , upvalues : _ENV
  for i = x, (math.min)(self.maxMapColNumber, x + (self.epCfg).view_range) do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

    if not (self.mapViewRange)[i] then
      (self.mapViewRange)[i] = true
      local colRooms = (self.roomMap)[i]
      if colRooms ~= nil then
        for y,roomData in pairs(colRooms) do
          if not roomData:IsHiddenRoom() and not roomData:GetVisible() then
            roomData:SetVisible(true)
            refreshRoomAction(roomData)
          end
        end
      end
    end
  end
end

DynEpMapData.HasOverBossRoom = function(self)
  -- function num : 0_5
  return self.__hasOverBossRoom
end

DynEpMapData.HasWeeklyChallengeBigBossRoom = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if ExplorationManager:GetIsInWeeklyChallenge() then
    return self:HasOverBossRoom()
  end
end

DynEpMapData.GetMapColType = function(self, x)
  -- function num : 0_7
  return (self.mapColTypeList)[x]
end

DynEpMapData.GetMapColTrackType = function(self, x)
  -- function num : 0_8
  return ((self.mapColTypeList)[x]).trackType
end

DynEpMapData.GetStartRoom = function(self)
  -- function num : 0_9
  return self.__startRoom
end

DynEpMapData.GetRealBossRoom = function(self)
  -- function num : 0_10
  return self.__realBossRoom
end

DynEpMapData.GetDeployRoom = function(self)
  -- function num : 0_11
  return self.deployRoom
end

DynEpMapData.SetMapOneRoom = function(self, x, y, roomData)
  -- function num : 0_12
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

  ((self.roomMap)[x])[y] = roomData
end

DynEpMapData.GetRoomByCoord = function(self, coord)
  -- function num : 0_13 , upvalues : _ENV
  if coord == proto_object_EplSpecialPosition.EplSpecialPositionInit then
    return self:GetEpSpecialRoomData()
  end
  local x, y = (ExplorationManager.Coordination2Pos)(coord)
  if (self.roomMap)[x] == nil or ((self.roomMap)[x])[y] == nil then
    warn("Cant\'t find DynEpRoomData, pos = " .. tostring(x) .. "," .. tostring(y))
    return nil
  end
  return ((self.roomMap)[x])[y]
end

DynEpMapData.GetEpSpecialRoomData = function(self)
  -- function num : 0_14 , upvalues : _ENV, DynEpRoomData
  if self.epSpecialRoom == nil then
    local position = proto_object_EplSpecialPosition.EplSpecialPositionInit
    local x, y = (ExplorationManager.Coordination2Pos)(position)
    local room = (DynEpRoomData.New)(x, y, nil, position)
    room:SetMapData(self)
    local roomType = ((ExplorationManager.dynPlayer):GetOperatorDetail()).specialCat
    room:SetEpSpecialRoomType(roomType)
    self.epSpecialRoom = room
  end
  do
    return self.epSpecialRoom
  end
end

DynEpMapData.GetRoomByXY = function(self, x, y)
  -- function num : 0_15
  return ((self.roomMap)[x])[y]
end

DynEpMapData.GetOneRoomByX = function(self, x)
  -- function num : 0_16 , upvalues : _ENV
  for k,room in pairs((self.roomMap)[x]) do
    if room ~= nil then
      return room
    end
  end
  return nil
end

DynEpMapData.GetRoomsByX = function(self, x)
  -- function num : 0_17
  return (self.roomMap)[x]
end

DynEpMapData.GetFirstAbleRoomData = function(self)
  -- function num : 0_18 , upvalues : _ENV
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
  -- function num : 0_19
  return self.nextMapBrief
end

DynEpMapData.GetEpSceneCfg = function(self)
  -- function num : 0_20
  return self.sceneCfg
end

DynEpMapData.GetBattleFieldSize = function(self)
  -- function num : 0_21
  local sceneCfg = self:GetEpSceneCfg()
  return sceneCfg.size_row, sceneCfg.size_col, sceneCfg.deploy_rows
end

DynEpMapData.GetEpSceneSectorId = function(self)
  -- function num : 0_22
  return self.sectorId
end

DynEpMapData.ClearPassedRoomData = function(self, opDetail, curRoomData)
  -- function num : 0_23 , upvalues : _ENV
  if opDetail.state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Secleted then
    return 
  end
  local curRow = curRoomData.x - 1
  local lastRowRoomDic = (self.roomMap)[curRow]
  if lastRowRoomDic == nil then
    return 
  end
  for k,roomData in pairs(lastRowRoomDic) do
    roomData:ClearEpRoomData()
  end
end

DynEpMapData.IsEpTD = function(self)
  -- function num : 0_24 , upvalues : ExplorationEnum
  do return self.epMapLogic == (ExplorationEnum.eMapLogic).TowerDefence end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return DynEpMapData

