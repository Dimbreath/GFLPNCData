local DormRoomEntity = class("DormRoomEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local DormFurnitureEntity = require("Game.Dorm.Entity.DormFurnitureEntity")
local CS_EventTrigger = CS.EventTriggerListener
local CS_GameObject = (CS.UnityEngine).GameObject
local CS_ResLoader = CS.ResLoader
DormRoomEntity.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__onRoomClicked = BindCallback(self, self.OnRoomClicked)
  self._AddFntEntityGoFunc = BindCallback(self, self.AddFntEntityGo)
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

DormRoomEntity.ChangeDormRoomPos = function(self, spos)
  -- function num : 0_3 , upvalues : DormUtil, _ENV
  self.spos = spos
  local x, y = (DormUtil.RoomCoordToXY)(spos)
  self.x = x
  self.y = y
  ;
  (self.roomData):ChangePos(spos)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  if not IsNull(self.gameObject) then
    (self.transform).position = (DormUtil.HexToUnityCoord)(self.x, self.y)
  end
  self:__RefreshDormDoorPos()
end

DormRoomEntity.GetDormRoomCenterPos = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local pos = (self.transform).position
  pos.y = pos.y + ((ConfigData.game_config).HouseHeightCount * (ConfigData.game_config).HouseGridWidth - (ConfigData.game_config).HouseFloorHeight) / 2
  local resultPos = UIManager:World2UIPosition(pos)
  return (Vector3.New)(resultPos.x, resultPos.y, 0)
end

DormRoomEntity.LoadRoomEntity = function(self, dormHolder, comResDic, clickAction)
  -- function num : 0_5 , upvalues : _ENV, DormUtil, CS_EventTrigger
  self._comResDic = comResDic
  if not self:IsEmptyRoom() or not comResDic.lockRoomPrefab then
    local prefab = comResDic.roomPrefab
  end
  local go = prefab:Instantiate(dormHolder)
  go.name = (string.format)("%d_%d", self.x, self.y)
  self.gameObject = go
  self.transform = go.transform
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.transform).position = (DormUtil.HexToUnityCoord)(self.x, self.y)
  local eventTrigger = (CS_EventTrigger.Get)(self.gameObject)
  eventTrigger:onClick("+", self.__onRoomClicked)
  self.clickAction = clickAction
  if self:IsEmptyRoom() then
    return 
  end
  self:InitRoomHolder()
  self:ChangeDmRoomFloor((self.roomData).floorId)
  self:ChangeDmRoomWall((self.roomData).wallId)
  self:InitAllFntEntity()
  self:__RefreshDormDoorPos()
end

DormRoomEntity._InstantiateFloor = function(self, prefab)
  -- function num : 0_6 , upvalues : _ENV
  DestroyUnityObject(self.__floorObject)
  local go = prefab:Instantiate(self.floorObjHolder)
  go.name = prefab.name
  self.__floorObject = go
end

DormRoomEntity._InstantiateWall = function(self, prefab)
  -- function num : 0_7 , upvalues : _ENV
  if not self.__wallObjectList then
    self.__wallObjectList = {}
    local wallsGo = prefab:Instantiate()
    for k,holder in ipairs(self.wallHolder) do
      DestroyUnityObject((self.__wallObjectList)[k])
      local wall = (wallsGo.transform):Find(tostring(k))
      if IsNull(wall) then
        error((string.format)("Cant find dorm wall, prefab name : %s, wall index : %s", prefab.name, k))
      else
        wall:SetParent(holder.parent, false)
        wall.localEulerAngles = Vector3.zero
        wall:SetAsFirstSibling()
        -- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (wall.gameObject).name = prefab.name
        -- DECOMPILER ERROR at PC49: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self.__wallObjectList)[k] = wall.gameObject
      end
    end
    DestroyUnityObject(wallsGo)
  end
end

DormRoomEntity._InitWallFntEntityDic = function(self)
  -- function num : 0_8
  self.wallFntEntityDic = {}
  for i = 1, 4 do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

    (self.wallFntEntityDic)[i] = {}
  end
end

DormRoomEntity.InitAllFntEntity = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self.fntObjDic = {}
  self.fntEntityDic = {}
  self:_InitWallFntEntityDic()
  if self.roomData ~= nil then
    for k,fntData in ipairs((self.roomData).fntDataList) do
      self:CreateFntEntity(fntData, false)
    end
  end
  do
    self:CreateFntEntity((self.roomData).dmRoomDoorData, false)
  end
end

DormRoomEntity.ResetDmRoomFntEntity = function(self, fntEntity, withUpdateFntMap)
  -- function num : 0_10
  if withUpdateFntMap then
    self:UpdateFntMap(fntEntity, false)
  end
  local fntData = fntEntity.fntData
  fntData:ResetFntData()
  local holder = self:GetFntHolder(fntData:GetFntType(), fntData:GetFntParam())
  fntEntity:ResetFntEntityByData(holder)
  if withUpdateFntMap then
    self:UpdateFntMap(fntEntity, true)
  end
end

DormRoomEntity.ReinitAllFntEntity = function(self)
  -- function num : 0_11 , upvalues : _ENV
  for fntData,fntEntity in pairs(self.originFntEntityDic) do
    if not fntData:IsDmFntDoor() then
      self:ResetDmRoomFntEntity(fntEntity)
      if (self.fntEntityDic)[fntData] == nil then
        (fntEntity.rootGo):SetActive(true)
        self:AddFntEntityGo(fntEntity)
        self:AddFntEntityData(fntEntity)
      end
    end
  end
end

DormRoomEntity.InitRoomHolder = function(self)
  -- function num : 0_12 , upvalues : _ENV, CS_GameObject
  local offset = (ConfigData.game_config).HouseGridWidth / 2
  local groundX = (ConfigData.game_config).HouseGridCount * (ConfigData.game_config).HouseGridWidth / 2 - offset
  local wallY = (ConfigData.game_config).HouseHeightCount * (ConfigData.game_config).HouseGridWidth - offset
  local floorPos = (Vector3.New)(-groundX, 0, -groundX)
  self.editCollider = (self.transform):FindComponent(eUnityComponentID.Collider)
  self.characterHolder = (self.transform):FindComponent("Character", eUnityComponentID.Transform)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.characterHolder).localPosition = floorPos
  self.fntHolder = (self.transform):FindComponent("Furniture", eUnityComponentID.Transform)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.fntHolder).localPosition = floorPos
  self.floorHolder = (self.transform):FindComponent("FloorHolder", eUnityComponentID.Transform)
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.floorHolder).localPosition = floorPos
  self.floorObjHolder = (self.transform):FindComponent("Floor", eUnityComponentID.Transform)
  self.wallHolder = {}
  self.wallObjDic = {}
  self.wallColliderDic = {}
  for i = 1, 4 do
    local wall = (self.transform):FindComponent("Wall/" .. tostring(i), eUnityComponentID.Transform)
    local wallLocalPos = ((Quaternion.Euler)(0, (i - 1) * 90, 0)):MulVec3((Vector3.New)(groundX, wallY, -groundX - offset))
    local holder = (CS_GameObject("WallHolder" .. tostring(i))).transform
    -- DECOMPILER ERROR at PC112: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (self.wallHolder)[i] = holder
    holder:SetParent(wall, false)
    holder.position = (self.transform).position + wallLocalPos
    -- DECOMPILER ERROR at PC123: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (self.wallObjDic)[i] = wall.gameObject
    local collider = wall:FindComponent(eUnityComponentID.Collider)
    if IsNull(collider) then
      error("wall collider is nil, wallId" .. tostring(i))
    else
      -- DECOMPILER ERROR at PC142: Confused about usage of register: R13 in 'UnsetPending'

      ;
      (self.wallColliderDic)[i] = collider
    end
  end
end

DormRoomEntity.SetEditColliderEnable = function(self, enable)
  -- function num : 0_13
  if self:IsEmptyRoom() then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.editCollider).enabled = enable
end

DormRoomEntity.InitFntMapData = function(self)
  -- function num : 0_14 , upvalues : _ENV
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
  -- function num : 0_15
  self.mapData = nil
end

DormRoomEntity.__GetFntMap = function(self, fntType, param)
  -- function num : 0_16 , upvalues : DormEnum, _ENV
  local map = nil
  if fntType == (DormEnum.eDormFntType).FloorDecoration then
    map = (self.mapData).groundMap
  else
    if fntType == (DormEnum.eDormFntType).WallDecoration or fntType == (DormEnum.eDormFntType).Door then
      map = ((self.mapData).wallMapList)[param]
    else
      if fntType == (DormEnum.eDormFntType).Furniture then
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

DormRoomEntity.UpdateFntMap = function(self, fntEntity, isAdd, areaList, wallIndex, doorFloorAreaList)
  -- function num : 0_17 , upvalues : DormEnum, _ENV
  local fntType = (fntEntity.fntData):GetFntType()
  if not wallIndex then
    local param = (fntEntity.fntData):GetFntParam()
  end
  local map = self:__GetFntMap(fntType, param)
  if areaList == nil then
    areaList = fntEntity:GetFntAreaList()
  end
  local overlapEntityDic = {}
  self:_UpdMapAreaList(areaList, isAdd, map, fntType, fntEntity, overlapEntityDic)
  if fntType == (DormEnum.eDormFntType).Door then
    if doorFloorAreaList == nil then
      doorFloorAreaList = fntEntity:GetFntDoorAreaList()
    end
    local floorMap = self:__GetFntMap((DormEnum.eDormFntType).Furniture)
    self:_UpdMapAreaList(doorFloorAreaList, isAdd, floorMap, (DormEnum.eDormFntType).Furniture, fntEntity, overlapEntityDic)
  end
  do
    for entity,notOnlyOne in pairs(overlapEntityDic) do
      entity:SetFntOverlap(notOnlyOne)
    end
    local wallFntEntityDic = (self.wallFntEntityDic)[param]
    if wallFntEntityDic ~= nil then
      if isAdd then
        wallFntEntityDic[fntEntity.fntData] = fntEntity
      else
        wallFntEntityDic[fntEntity.fntData] = nil
      end
    end
  end
end

DormRoomEntity._UpdMapAreaList = function(self, areaList, isAdd, map, fntType, fntEntity, overlapEntityDic)
  -- function num : 0_18 , upvalues : _ENV, DormUtil
  for k,pos in pairs(areaList) do
    if isAdd and (DormUtil.FntPosOutMap)(pos.x, pos.y, fntType) then
      overlapEntityDic[fntEntity] = true
    else
      if map[pos.x] == nil then
        map[pos.x] = {}
      end
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R12 in 'UnsetPending'

      if (map[pos.x])[pos.y] == nil then
        (map[pos.x])[pos.y] = {}
      end
      local grid = (map[pos.x])[pos.y]
      if isAdd then
        grid[fntEntity] = true
      else
        grid[fntEntity] = nil
      end
      local notOnlyOne = (table.count)(grid) > 1
      for entity,_ in pairs(grid) do
        overlapEntityDic[entity] = overlapEntityDic[entity] or notOnlyOne
      end
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

DormRoomEntity.FntMapOverlap = function(self)
  -- function num : 0_19 , upvalues : _ENV
  for k,v in pairs(self.fntObjDic) do
    if v:IsOverlap() then
      return true
    end
  end
  return false
end

DormRoomEntity.OnRoomClicked = function(self, go, eventData)
  -- function num : 0_20
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

DormRoomEntity.GetFntHolder = function(self, fntType, wallId)
  -- function num : 0_21 , upvalues : DormEnum, _ENV
  if fntType == (DormEnum.eDormFntType).WallDecoration or fntType == (DormEnum.eDormFntType).Door then
    return (self.wallHolder)[wallId]
  else
    if fntType == (DormEnum.eDormFntType).Furniture then
      return self.fntHolder
    else
      if fntType == (DormEnum.eDormFntType).FloorDecoration then
        return self.floorHolder
      else
        error("Furniture type error, id = " .. tostring(fntType))
      end
    end
  end
end

DormRoomEntity.CreateFntEntity = function(self, fntData, isNew)
  -- function num : 0_22 , upvalues : _ENV, DormFurnitureEntity
  local path = PathConsts:GetDormFntPath(fntData:GetFntPrefab())
  local fntType = fntData:GetFntType()
  local entity = (DormFurnitureEntity.New)()
  local parent = self:GetFntHolder(fntType, fntData.param)
  entity:InitFntEntity(fntData, parent)
  self:AddFntEntityData(entity)
  if isNew then
    (self.roomData):AddFntData(fntData)
    self:UpdateFntMap(entity, true)
  end
  entity:LoadFntEntityGo(path, self._AddFntEntityGoFunc)
  return entity
end

DormRoomEntity.ChangeDmRoomDoorGo = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local fntData = (self.roomData).dmRoomDoorData
  local entity = self:GetFntByData(fntData)
  entity:InitFntEntityRoot()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.fntObjDic)[entity.gameObject] = nil
  entity:DestroyDmFntEntityGo()
  entity:ResetFntBottom()
  local path = PathConsts:GetDormFntPath(fntData:GetFntPrefab())
  entity:LoadFntEntityGo(path, self._AddFntEntityGoFunc)
end

DormRoomEntity.AddFntEntityGo = function(self, fntEntity)
  -- function num : 0_24
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self.fntObjDic)[fntEntity.gameObject] = fntEntity
end

DormRoomEntity.AddFntEntityData = function(self, fntEntity)
  -- function num : 0_25
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self.fntEntityDic)[fntEntity.fntData] = fntEntity
  local wallFntEntityDic = (self.wallFntEntityDic)[(fntEntity.fntData):GetFntParam()]
  if wallFntEntityDic ~= nil then
    wallFntEntityDic[fntEntity.fntData] = fntEntity
  end
end

DormRoomEntity.RemoveFntEntity = function(self, fntEntity)
  -- function num : 0_26
  self:UpdateFntMap(fntEntity, false)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.fntObjDic)[fntEntity.gameObject] = nil
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.fntEntityDic)[fntEntity.fntData] = nil
  local wallFntEntityDic = (self.wallFntEntityDic)[(fntEntity.fntData):GetFntParam()]
  if wallFntEntityDic ~= nil then
    wallFntEntityDic[fntEntity.fntData] = nil
  end
  ;
  (self.roomData):RemoveFntData(fntEntity.fntData)
end

DormRoomEntity.GetFntByGo = function(self, go)
  -- function num : 0_27 , upvalues : _ENV
  local entity = (self.fntObjDic)[go]
  if entity == nil then
    error("Can\'t get fnt entity by go, go = " .. tostring(go))
  end
  return entity
end

DormRoomEntity.GetFntByData = function(self, fntData)
  -- function num : 0_28
  return (self.fntEntityDic)[fntData]
end

DormRoomEntity.GetFntObjDic = function(self)
  -- function num : 0_29
  return self.fntObjDic
end

DormRoomEntity.GetFntCount = function(self)
  -- function num : 0_30
  return #(self.roomData).fntDataList
end

DormRoomEntity.IsOriginDmRoomFnt = function(self, fntData)
  -- function num : 0_31
  do return (self.originFntEntityDic)[fntData] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormRoomEntity.EnterRoomEditMode = function(self, floorGo, wallGoDic, roomCtrl)
  -- function num : 0_32 , upvalues : _ENV
  (floorGo.transform):SetParent(self.transform, false)
  floorGo:SetActive(false)
  for k,go in pairs(wallGoDic) do
    (go.transform):SetParent(((self.wallHolder)[k]).parent, false)
    go:SetActive(false)
  end
  self:InitFntMapData()
  local originFntEntityDic = {}
  for k,fntEntity in pairs(self.fntObjDic) do
    local fntBottomItem = roomCtrl:GetFntBottomItem()
    fntEntity:AddFntBottom(fntBottomItem)
    do
      do
        if (fntEntity.fntData):IsDmFntDoor() then
          local bottomItem = roomCtrl:GetFntBottomItem()
          fntEntity:AddFntDoorBottom(bottomItem)
        end
        originFntEntityDic[fntEntity.fntData] = fntEntity
        -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self.originFntEntityDic = originFntEntityDic
  self._dmRoomCtrl = roomCtrl
end

DormRoomEntity.ExitRoomEditMode = function(self, roomCtrl, editSuccess)
  -- function num : 0_33 , upvalues : _ENV
  self:ClearFntMapData()
  for k,fntEntity in pairs(self.fntEntityDic) do
    local fntBottomItem = fntEntity:RemoveFntBottom()
    if fntBottomItem ~= nil then
      roomCtrl:RecycleFntBottomItem(fntBottomItem)
    end
    local bottomItem = fntEntity:RemoveFntDoorBottom()
    if bottomItem ~= nil then
      roomCtrl:RecycleFntBottomItem(bottomItem)
    end
  end
  if editSuccess then
    self:__RefreshDormDoorPos()
  end
  self.originFntEntityDic = nil
  self._dmRoomCtrl = nil
end

DormRoomEntity.StartHideRoom = function(self)
  -- function num : 0_34
  (self.gameObject):SetActive(false)
end

DormRoomEntity.StartShowRoom = function(self)
  -- function num : 0_35
  (self.gameObject):SetActive(true)
end

DormRoomEntity.ResetDormRoomWall = function(self)
  -- function num : 0_36
  self:Show2Hide2DormRoom(1, 2, 3, 4)
end

DormRoomEntity.Show3Hide1DormRoom = function(self, hideIndex)
  -- function num : 0_37
  for i = 1, 4 do
    self:SetDormRoomWallActive(i, hideIndex ~= i)
  end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormRoomEntity.Show2Hide2DormRoom = function(self, index1, index2, index3, index4)
  -- function num : 0_38
  self:SetDormRoomWallActive(index1, true)
  self:SetDormRoomWallActive(index2, true)
  self:SetDormRoomWallActive(index3, false)
  self:SetDormRoomWallActive(index4, false)
end

DormRoomEntity.SetDormRoomWallActive = function(self, index, active)
  -- function num : 0_39 , upvalues : _ENV
  if self.wallColliderDic == nil then
    return 
  end
  local wallCollider = (self.wallColliderDic)[index]
  if wallCollider ~= nil then
    wallCollider.enabled = active
  end
  local wallFntEntityDic = (self.wallFntEntityDic)[index]
  for fntData,fntEntity in pairs(wallFntEntityDic) do
    fntEntity:EnableDmFntCollider(active)
  end
  if self._dmRoomCtrl ~= nil then
    (self._dmRoomCtrl):OnDmRoomWallShow(index, active)
  end
end

DormRoomEntity.ChangeDmRoomFloor = function(self, id)
  -- function num : 0_40 , upvalues : _ENV, CS_ResLoader
  if id == 0 then
    self:_InstantiateFloor((self._comResDic).defaultFloorPrefab)
    return 
  end
  local fntCfg = (ConfigData.dorm_furniture)[id]
  if fntCfg == nil then
    error("Can\'t find dorm_furniture cfg, id = " .. tostring(id))
    return 
  end
  local path = PathConsts:GetDormFntPath(fntCfg.prefab)
  self:_ClearFloorResLoader()
  local resLoader = (CS_ResLoader.Create)()
  resLoader:LoadABAssetAsync(path, function(prefab)
    -- function num : 0_40_0 , upvalues : _ENV, self
    if IsNull(prefab) then
      return 
    end
    self:_InstantiateFloor(prefab)
  end
)
  self._floorResLoader = resLoader
end

DormRoomEntity._ClearFloorResLoader = function(self)
  -- function num : 0_41
  if self._floorResLoader ~= nil then
    (self._floorResLoader):Put2Pool()
    self._floorResLoader = nil
  end
end

DormRoomEntity.ChangeDmRoomWall = function(self, id)
  -- function num : 0_42 , upvalues : _ENV, CS_ResLoader
  if id == 0 then
    self:_InstantiateWall((self._comResDic).defaultWallPrefab)
    return 
  end
  local fntCfg = (ConfigData.dorm_furniture)[id]
  if fntCfg == nil then
    error("Can\'t find dorm_furniture cfg, id = " .. tostring(id))
    return 
  end
  local path = PathConsts:GetDormFntPath(fntCfg.prefab)
  self:_ClearWallResLoader()
  local resLoader = (CS_ResLoader.Create)()
  resLoader:LoadABAssetAsync(path, function(prefab)
    -- function num : 0_42_0 , upvalues : _ENV, self
    if IsNull(prefab) then
      return 
    end
    self:_InstantiateWall(prefab)
  end
)
  self._wallResLoader = resLoader
end

DormRoomEntity._ClearWallResLoader = function(self)
  -- function num : 0_43
  if self._wallResLoader ~= nil then
    (self._wallResLoader):Put2Pool()
    self._wallResLoader = nil
  end
end

DormRoomEntity.IsDmRoomWall = function(self, gameObject)
  -- function num : 0_44 , upvalues : _ENV
  for wallIndex,go in pairs(self.wallObjDic) do
    if go == gameObject then
      return true, wallIndex, (self.wallHolder)[wallIndex]
    end
  end
  return false
end

DormRoomEntity.__RefreshDormDoorPos = function(self)
  -- function num : 0_45 , upvalues : _ENV, DormUtil
  local doorData = (self.roomData).dmRoomDoorData
  local offsetX = (doorData:GetFntSize() - 1) * (ConfigData.game_config).HouseGridWidth / 2
  local wallpos = (DormUtil.FntCoord2Unity)(doorData.x, doorData.y, doorData:GetFntType())
  local wallId = doorData:GetFntParam()
  local holder = (self.wallHolder)[wallId]
  if holder == nil then
    error("dorm holder ")
    return Vector3.zero
  end
  wallpos.x = wallpos.x - offsetX
  wallpos.z = -0.2
  local worldPos = holder:TransformPoint(wallpos)
  local y = ((self.transform).position).y
  worldPos.y = y
  wallpos.z = 0.2
  local doorFrontPos = holder:TransformPoint(wallpos)
  doorFrontPos.y = y
  self.__doorWorldPos = worldPos
  self.__doorFrontPos = doorFrontPos
end

DormRoomEntity.GetRoomDoorPos = function(self)
  -- function num : 0_46
  local wallId = ((self.roomData).dmRoomDoorData):GetFntParam()
  return wallId, self.__doorWorldPos, self.__doorFrontPos
end

DormRoomEntity.IsAnyDmFntEntityInLoading = function(self)
  -- function num : 0_47 , upvalues : _ENV
  for k,fntEntity in pairs(self.fntEntityDic) do
    if fntEntity:IsDmFntEntityInLoading() then
      return true
    end
  end
  return false
end

DormRoomEntity.GetDmRoomDoorWallId = function(self)
  -- function num : 0_48
  if self.roomData == nil then
    return 0
  end
  return ((self.roomData).dmRoomDoorData):GetFntParam()
end

DormRoomEntity.OnDelete = function(self)
  -- function num : 0_49 , upvalues : _ENV
  self:_ClearFloorResLoader()
  self:_ClearWallResLoader()
  self.wallObjDic = nil
  self.wallColliderDic = nil
  if self.fntEntityDic ~= nil then
    for fntData,fntEntity in pairs(self.fntEntityDic) do
      fntEntity:OnDelete()
    end
    self.fntEntityDic = nil
  end
end

return DormRoomEntity

