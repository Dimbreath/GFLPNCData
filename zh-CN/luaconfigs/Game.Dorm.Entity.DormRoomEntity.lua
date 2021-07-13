-- params : ...
-- function num : 0 , upvalues : _ENV
local DormRoomEntity = class("DormRoomEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local eDormFntType = require("Game.Dorm.Enum.eDormFntType")
local DormFurnitureEntity = require("Game.Dorm.Entity.DormFurnitureEntity")
local CS_EventTrigger = CS.EventTriggerListener
local CS_GameObject = (CS.UnityEngine).GameObject
DormRoomEntity.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__onRoomClicked = BindCallback(self, self.OnRoomClicked)
end

DormRoomEntity.InitHouseData = function(self, x, y, spos, roomData)
  -- function num : 0_1
  self.x = x
  self.y = y
  self.spos = spos
  self.roomData = roomData
end

DormRoomEntity.IsEmptyRoom = function(self)
  -- function num : 0_2
  do return self.roomData == nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormRoomEntity.InitHouseObject = function(self, object, clickAction, resloader)
  -- function num : 0_3 , upvalues : DormUtil, CS_EventTrigger
  self.gameObject = object
  self.transform = object.transform
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.transform).position = (DormUtil.HexToUnityCoord)(self.x, self.y)
  self.resloader = resloader
  local eventTrigger = (CS_EventTrigger.Get)(self.gameObject)
  eventTrigger:onClick("+", self.__onRoomClicked)
  self.clickAction = clickAction
  if self:IsEmptyRoom() then
    return 
  end
  self:InitRoomHolder()
  self:InitAllFntEntity()
end

DormRoomEntity.InitAllFntEntity = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.fntObjDic = {}
  self.fntEntityDic = {}
  if self.roomData ~= nil then
    for k,fntData in ipairs((self.roomData).fntDataList) do
      self:CreateFntEntity(fntData, false)
    end
  end
end

DormRoomEntity.InitRoomHolder = function(self)
  -- function num : 0_5 , upvalues : _ENV, CS_GameObject
  local offset = (ConfigData.game_config).HouseGridWidth / 2
  local groundX = (ConfigData.game_config).HouseGridCount * (ConfigData.game_config).HouseGridWidth / 2 - offset
  local wallY = (ConfigData.game_config).HouseHeightCount * (ConfigData.game_config).HouseGridWidth - offset
  local floorPos = (Vector3.New)(-groundX, 0, -groundX)
  self.characterHolder = (self.transform):FindComponent("Character", eUnityComponentID.Transform)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.characterHolder).localPosition = floorPos
  self.fntHolder = (self.transform):FindComponent("Furniture", eUnityComponentID.Transform)
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.fntHolder).localPosition = floorPos
  self.floorHolder = (self.transform):FindComponent("FloorHolder", eUnityComponentID.Transform)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.floorHolder).localPosition = floorPos
  self.wallHolder = {}
  for i = 1, 4 do
    local wall = (self.transform):FindComponent("Wall/" .. tostring(i), eUnityComponentID.Transform)
    local wallLocalPos = ((Quaternion.Euler)(0, (i - 1) * 90, 0)):MulVec3((Vector3.New)(groundX, wallY, -groundX - offset))
    local holder = (CS_GameObject("WallHolder" .. tostring(i))).transform
    -- DECOMPILER ERROR at PC95: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (self.wallHolder)[i] = holder
    holder:SetParent(wall, false)
    holder.position = (self.transform).position + wallLocalPos
  end
end

DormRoomEntity.InitFntMapData = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local groundX = (ConfigData.game_config).HouseGridCount
  local wallY = (ConfigData.game_config).HouseHeightCount
  self.mapData = {}
  local wallMapList = {}
  for i = 1, 4 do
    local wallMap = {}
    wallMapList[i] = wallMap
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.mapData).wallMapList = wallMapList
  local fntMap = {}
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.mapData).fntMap = fntMap
  local groundMap = {}
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.mapData).groundMap = groundMap
  for k,fntEntity in pairs(self.fntObjDic) do
    self:UpdateFntMap(fntEntity, true)
  end
end

DormRoomEntity.ClearFntMapData = function(self)
  -- function num : 0_7
  self.mapData = nil
end

DormRoomEntity.__GetFntMap = function(self, fntType, param)
  -- function num : 0_8 , upvalues : eDormFntType, _ENV
  local map = nil
  if fntType == eDormFntType.Floor then
    map = (self.mapData).groundMap
  else
    if fntType == eDormFntType.Wall then
      map = ((self.mapData).wallMapList)[param]
    else
      if fntType == eDormFntType.Furniture then
        map = (self.mapData).fntMap
      end
    end
  end
  if map == nil then
    error("fnt map is nil, fntType = " .. tostring(fntType) .. ", param = " .. tostring(param))
    return 
  end
  return map
end

DormRoomEntity.UpdateFntMap = function(self, fntEntity, isAdd, areaList)
  -- function num : 0_9 , upvalues : _ENV, DormUtil
  local fntType = (fntEntity.fntData):GetFntType()
  local param = (fntEntity.fntData):GetFntParam()
  local map = self:__GetFntMap(fntType, param)
  if areaList == nil then
    areaList = fntEntity:GetFntAreaList()
  end
  local overlapEntityDic = {}
  local overlap = false
  for k,pos in pairs(areaList) do
    if isAdd and (DormUtil.FntPosOutMap)(pos.x, pos.y, fntType) then
      overlap = true
    else
      if map[pos.x] == nil then
        map[pos.x] = {}
      end
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R14 in 'UnsetPending'

      if (map[pos.x])[pos.y] == nil then
        (map[pos.x])[pos.y] = {}
      end
      local grid = (map[pos.x])[pos.y]
      if isAdd then
        grid[fntEntity] = true
        for entity,_ in pairs(grid) do
          overlapEntityDic[entity] = true
        end
      else
        do
          grid[fntEntity] = nil
          for entity,_ in pairs(grid) do
            overlapEntityDic[entity] = true
          end
          do
            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  overlap = overlap or (table.count)(overlapEntityDic) > 1
  for entity,_ in pairs(overlapEntityDic) do
    entity:SetFntOverlap(overlap)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

DormRoomEntity.FntMapOverlap = function(self)
  -- function num : 0_10 , upvalues : _ENV
  for k,v in pairs(self.fntObjDic) do
    if v:IsOverlap() then
      return true
    end
  end
  return false
end

DormRoomEntity.OnRoomClicked = function(self, go, eventData)
  -- function num : 0_11
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

DormRoomEntity.GetFntHolder = function(self, fntType, wallId)
  -- function num : 0_12 , upvalues : eDormFntType, _ENV
  if fntType == eDormFntType.Wall then
    return (self.wallHolder)[wallId]
  else
    if fntType == eDormFntType.Furniture then
      return self.fntHolder
    else
      if fntType == eDormFntType.Floor then
        return self.floorHolder
      else
        error("Furniture type error, id = " .. tostring(fntType))
      end
    end
  end
end

DormRoomEntity.CreateFntEntity = function(self, fntData, isNew, callback)
  -- function num : 0_13 , upvalues : _ENV, DormFurnitureEntity
  local path = PathConsts:GetDormFntPath(fntData:GetFntPrefab())
  ;
  (self.resloader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_13_0 , upvalues : _ENV, self, fntData, DormFurnitureEntity, isNew, callback
    if IsNull(self.gameObject) then
      return 
    end
    local parent = self:GetFntHolder(fntData:GetFntType(), fntData.param)
    local go = prefab:Instantiate(parent)
    local entity = (DormFurnitureEntity.New)()
    entity:InitFntEntity(go, fntData)
    self:AddFntEntity(entity, isNew)
    if callback ~= nil then
      callback(entity)
    end
  end
)
end

DormRoomEntity.AddFntEntity = function(self, fntEntity, isNew)
  -- function num : 0_14
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  (self.fntObjDic)[fntEntity.gameObject] = fntEntity
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.fntEntityDic)[fntEntity.fntData] = fntEntity
  if isNew then
    (self.roomData):AddFntData(fntEntity.fntData)
    self:UpdateFntMap(fntEntity, true)
  end
end

DormRoomEntity.RemoveFntEntity = function(self, fntEntity)
  -- function num : 0_15
  self:UpdateFntMap(fntEntity, false)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.fntObjDic)[fntEntity.gameObject] = nil
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.fntEntityDic)[fntEntity.fntData] = nil
  ;
  (self.roomData):RemoveFntData(fntEntity.fntData)
end

DormRoomEntity.GetFntByGo = function(self, go)
  -- function num : 0_16 , upvalues : _ENV
  local entity = (self.fntObjDic)[go]
  if entity == nil then
    error("Can\'t get fnt entity by go, go = " .. tostring(go))
  end
  return entity
end

DormRoomEntity.GetFntByData = function(self, fntData)
  -- function num : 0_17
  return (self.fntEntityDic)[fntData]
end

DormRoomEntity.GetFntObjDic = function(self)
  -- function num : 0_18
  return self.fntObjDic
end

DormRoomEntity.GetFntCount = function(self)
  -- function num : 0_19
  return #(self.roomData).fntDataList
end

DormRoomEntity.EnterRoomEditMode = function(self, floorGo, wallGoDic, roomCtrl)
  -- function num : 0_20 , upvalues : _ENV
  (floorGo.transform):SetParent(self.transform, false)
  floorGo:SetActive(false)
  for k,go in pairs(wallGoDic) do
    (go.transform):SetParent(((self.wallHolder)[k]).parent, false)
    go:SetActive(false)
  end
  self:InitFntMapData()
  for k,fntEntity in pairs(self.fntObjDic) do
    local fntBottomItem = roomCtrl:GetFntBottomItem()
    fntEntity:AddFntBottom(fntBottomItem)
  end
end

DormRoomEntity.ExitRoomEditMode = function(self, roomCtrl)
  -- function num : 0_21 , upvalues : _ENV
  self:ClearFntMapData()
  for k,fntEntity in pairs(self.fntObjDic) do
    local fntBottomItem = fntEntity:RemoveFntBottom()
    if fntBottomItem ~= nil then
      roomCtrl:RecycleFntBottomItem(fntBottomItem)
    end
  end
end

DormRoomEntity.OnDelete = function(self)
  -- function num : 0_22
end

return DormRoomEntity

