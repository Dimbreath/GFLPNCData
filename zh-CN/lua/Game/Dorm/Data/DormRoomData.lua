local DormRoomData = class("DormRoomData")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
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

DormRoomData.InitRoomData = function(self, spos, roomdata, houseid)
  -- function num : 0_2 , upvalues : DormUtil
  local x, y = (DormUtil.RoomCoordToXY)(spos)
  self.belongtohouseid = houseid
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
  self.__roomName = roomdata.name
  self.isPrefab = self.uid ~= nil
  self:UpdateRoomFntData(roomdata.data, true)
  self:_InitDmRoomDoorData(roomdata.door)
  self:SetDmRoomFloor(roomdata.floorId)
  self:SetDmRoomWall(roomdata.wallId)
  self:RecordOrnginalDmRoomData(roomdata)
  self.__enableUnbind = roomdata.unbind
  self.roomCfg = (ConfigData.dorm_room)[self.id]
  if self.roomCfg == nil then
    error("dorm room cfg is null,id:" .. tostring(self.id))
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DormRoomData.UpdateRoomFntData = function(self, data, createFntData)
  -- function num : 0_5 , upvalues : _ENV, DormFurnitureData, DormUtil
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
  else
    do
      for k,fntData in ipairs(self.fntDataList) do
        fntData:RecordOriginalFntData()
      end
      do
        self.BindFndDatList = {}
        for i = 1, DormUtil:GetBedCount() do
          local fntdata = (self.canBindfntDataList)[i]
          if fntdata ~= nil then
            if fntdata:CanBindRole() and fntdata:GetFntParam() ~= 0 then
              (table.insert)(self.BindFndDatList, fntdata)
            else
              if fntdata:CanBindRole() and fntdata:GetFntParam() == 0 then
                (table.insert)(self.BindFndDatList, fntdata)
              else
                ;
                (table.insert)(self.BindFndDatList, -1)
              end
            end
          else
            ;
            (table.insert)(self.BindFndDatList, -1)
          end
        end
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
  end
end

DormRoomData.GetEnableUnbind = function(self)
  -- function num : 0_6
  return self.__enableUnbind
end

DormRoomData.SetEnableUnbind = function(self, unbind)
  -- function num : 0_7
  self.__enableUnbind = unbind
end

DormRoomData._InitDmRoomDoorData = function(self, doorData)
  -- function num : 0_8 , upvalues : _ENV, DormFurnitureData
  if doorData == nil then
    error("Door door data from server is nil, roomId = " .. tostring(self.id))
    return 
  end
  local fntData = (DormFurnitureData.New)()
  fntData:InitFntData(doorData.id, self, doorData, true)
  self.dmRoomDoorData = fntData
end

DormRoomData.RecordOrnginalDmRoomData = function(self, roomdata)
  -- function num : 0_9
  self.oldRoomdata = roomdata
end

DormRoomData.ClearDormRoom = function(self)
  -- function num : 0_10 , upvalues : _ENV
  for _,pointData in pairs(self.interpoint) do
    pointData:UnBindInterPoint()
  end
end

DormRoomData.__UpdateRoomInterPoint = function(self)
  -- function num : 0_11
end

DormRoomData.ChangePos = function(self, spos)
  -- function num : 0_12 , upvalues : DormUtil
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
  -- function num : 0_13 , upvalues : _ENV
  if not (string.IsNullOrEmpty)(self.__roomName) then
    return self.__roomName
  end
  return (LanguageUtil.GetLocaleText)((self.roomCfg).name)
end

DormRoomData.SetRoomName = function(self, name)
  -- function num : 0_14
  self.__roomName = name
end

DormRoomData.GetComfort = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local comfort = 0
  for k,v in pairs(self.fntDataList) do
    comfort = comfort + v:GetFntComfort()
  end
  comfort = comfort + (self.dmRoomDoorData):GetFntComfort()
  do
    if self.floorId > 0 then
      local fntCfg = (ConfigData.dorm_furniture)[self.floorId]
      if fntCfg == nil then
        error("Can\'t find dorm_furniture cfg, id = " .. tostring(self.floorId))
        return 
      end
      comfort = comfort + fntCfg.comfort
    end
    do
      if self.wallId > 0 then
        local fntCfg = (ConfigData.dorm_furniture)[self.wallId]
        if fntCfg == nil then
          error("Can\'t find dorm_furniture cfg, id = " .. tostring(self.wallId))
          return 
        end
        comfort = comfort + fntCfg.comfort
      end
      return comfort
    end
  end
end

DormRoomData.AddFntData = function(self, fntData)
  -- function num : 0_16 , upvalues : DormEnum, _ENV
  if fntData == nil then
    return 
  end
  local fntType = fntData:GetFntType()
  if fntData == (DormEnum.eDormFntType).Door then
    return 
  end
  ;
  (table.insert)(self.fntDataList, fntData)
  if fntData:CanBindRole() then
    (table.insert)(self.canBindfntDataList, fntData)
  end
end

DormRoomData.RemoveFntData = function(self, fntData)
  -- function num : 0_17 , upvalues : DormEnum, _ENV
  local fntType = fntData:GetFntType()
  if fntData == (DormEnum.eDormFntType).Door then
    return 
  end
  ;
  (table.removebyvalue)(self.fntDataList, fntData)
  if fntData:CanBindRole() then
    (table.removebyvalue)(self.canBindfntDataList, fntData)
  end
end

DormRoomData.GetFntDatas = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local dataList = {}
  for k,fntData in ipairs(self.fntDataList) do
    local data = fntData:GetDmFntServerData()
    dataList[k] = data
  end
  return dataList
end

DormRoomData.GetRoomBindCount = function(self)
  -- function num : 0_19 , upvalues : _ENV
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

DormRoomData.GetRoomBindFntCount = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local count = 0
  for k,v in pairs(self.BindFndDatList) do
    if v ~= -1 and v.param ~= 0 then
      count = count + 1
    end
  end
  return count
end

DormRoomData.GetRoomBindList = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local list = {}
  for k,fntData in pairs(self.canBindfntDataList) do
    local param = fntData:GetFntParam()
    if param ~= 0 then
      (table.insert)(list, fntData)
    end
  end
  return list
end

DormRoomData.GetRoomCanBindFntCount = function(self)
  -- function num : 0_22 , upvalues : _ENV
  local count = 0
  for k,v in pairs(self.BindFndDatList) do
    if v ~= -1 then
      count = count + 1
    end
  end
  return count
end

DormRoomData.GetRoomCanBindList = function(self)
  -- function num : 0_23 , upvalues : _ENV
  if #self.canBindfntDataList <= (ConfigData.game_config).DormRoomRoleMaxCount then
    return self.canBindfntDataList
  end
  ;
  (table.sort)(self.canBindfntDataList, function(a, b)
    -- function num : 0_23_0
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
    ;
    (table.insert)(list, fntData)
  end
  do
    if (ConfigData.game_config).DormRoomRoleMaxCount > count then
      return list
    end
  end
end

DormRoomData.GetFntDataByBindHeroId = function(self, HeroID)
  -- function num : 0_24 , upvalues : _ENV
  for k,fntData in ipairs(self.canBindfntDataList) do
    local param = fntData:GetFntParam()
    if param == HeroID then
      return fntData
    end
  end
  return nil
end

DormRoomData.GetCanBindFntData = function(self)
  -- function num : 0_25 , upvalues : _ENV
  local canBindfntData = nil
  for k,fntData in ipairs(self.canBindfntDataList) do
    local param = fntData:GetFntParam()
    if param == 0 then
      canBindfntData = fntData
      break
    end
  end
  do
    return canBindfntData
  end
end

DormRoomData.GetFntDataIndex = function(self, fntData)
  -- function num : 0_26 , upvalues : _ENV
  for index,v in ipairs(self.fntDataList) do
    if fntData == v then
      return index - 1
    end
  end
  error("Can\'t get FntData index")
end

DormRoomData.IsHeroBindOnRoom = function(self, HeroID)
  -- function num : 0_27 , upvalues : _ENV
  for k,fntData in pairs(self.canBindfntDataList) do
    local param = fntData:GetFntParam()
    if param == HeroID then
      return true
    end
  end
  return false
end

DormRoomData.SetDmRoomWall = function(self, wallId)
  -- function num : 0_28
  self.wallId = wallId
end

DormRoomData.SetDmRoomFloor = function(self, floorId)
  -- function num : 0_29
  self.floorId = floorId
end

DormRoomData.SaveDmRoomData = function(self)
  -- function num : 0_30
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self.oldRoomdata).data = self.data
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.oldRoomdata).wallId = self.wallId
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.oldRoomdata).floorId = self.floorId
  ;
  (self.dmRoomDoorData):RecordOriginalFntData()
end

DormRoomData.GetDmRoomOldFloor = function(self)
  -- function num : 0_31
  return (self.oldRoomdata).floorId
end

DormRoomData.GetDmRoomOldWall = function(self)
  -- function num : 0_32
  return (self.oldRoomdata).wallId
end

DormRoomData.GetDmRoomOldDoor = function(self)
  -- function num : 0_33
  return (self.dmRoomDoorData):GetFntOldId()
end

DormRoomData.GetDmRoomFntCategoryNum = function(self, categoryId)
  -- function num : 0_34 , upvalues : _ENV
  local num = 0
  for k,fntData in ipairs(self.fntDataList) do
    if fntData:GetFntCategory() == categoryId then
      num = num + 1
    end
  end
  return num
end

return DormRoomData

