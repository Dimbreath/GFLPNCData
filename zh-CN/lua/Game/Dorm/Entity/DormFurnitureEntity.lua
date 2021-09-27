local DormFurnitureEntity = class("DormFurnitureEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local CS_GameObject = (CS.UnityEngine).GameObject
local CS_ResLoader = CS.ResLoader
local CS_Collider = (CS.UnityEngine).Collider
DormFurnitureEntity.ctor = function(self)
  -- function num : 0_0
end

DormFurnitureEntity.InitFntEntity = function(self, fntData, holder)
  -- function num : 0_1 , upvalues : CS_GameObject, _ENV
  self.fntData = fntData
  self.type = (self.fntData):GetFntType()
  self.rootGo = CS_GameObject(tostring((self.fntData).id))
  self.rootTran = (self.rootGo).transform
  ;
  (self.rootTran):SetParent(holder)
  self:InitFntEntityRoot()
end

DormFurnitureEntity.InitFntEntityRoot = function(self)
  -- function num : 0_2 , upvalues : DormUtil
  local sizeX, sizeY = (self.fntData):GetFntSize()
  self._tranformLocalPos = (DormUtil.FntCoord2Unity)(sizeX / 2 - 0.5, sizeY / 2 - 0.5, self.type)
  self:SetFntEntityPos((self.fntData).x, (self.fntData).y)
  self:__SetRotation()
  self._isLoadedGo = false
end

DormFurnitureEntity._ClearResLoader = function(self)
  -- function num : 0_3
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
end

DormFurnitureEntity.LoadFntEntityGo = function(self, path, callback)
  -- function num : 0_4 , upvalues : CS_ResLoader, _ENV
  self:_ClearResLoader()
  self.resLoader = (CS_ResLoader.Create)()
  self._inLoadingModel = true
  ;
  (UIUtil.AddOneCover)(self)
  ;
  (self.resLoader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_4_0 , upvalues : self, _ENV, callback
    self._inLoadingModel = false
    ;
    (UIUtil.CloseOneCover)(self)
    if IsNull(self.rootGo) or IsNull(prefab) then
      return 
    end
    local go = prefab:Instantiate()
    self:SetFntEntityGo(go)
    if callback ~= nil then
      callback(self)
    end
  end
)
end

DormFurnitureEntity.IsDmFntEntityInLoading = function(self)
  -- function num : 0_5
  return self._inLoadingModel
end

DormFurnitureEntity.SetFntEntityGo = function(self, obj)
  -- function num : 0_6 , upvalues : _ENV, CS_Collider
  self.gameObject = obj
  self.transform = obj.transform
  ;
  (self.transform):SetParent(self.rootTran, false)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.transform).localPosition = self._tranformLocalPos
  self._colliders = (self.rootTran):GetComponentsInChildren(typeof(CS_Collider))
  self._isLoadedGo = true
end

DormFurnitureEntity.EnableDmFntCollider = function(self, enable)
  -- function num : 0_7
  if self._colliders == nil then
    return 
  end
  for i = 0, (self._colliders).Length - 1 do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

    ((self._colliders)[i]).enabled = enable
  end
end

DormFurnitureEntity.ResetFntEntityByData = function(self, parent)
  -- function num : 0_8
  (self.rootTran):SetParent(parent)
  self:SetFntEntityPos((self.fntData).x, (self.fntData).y)
  self:__SetRotation()
end

DormFurnitureEntity.SetFntEntityPos = function(self, x, y, tween)
  -- function num : 0_9 , upvalues : DormUtil
  local unityPos = (DormUtil.FntCoord2Unity)(x, y, self.type)
  ;
  (self.fntData):SetFntPos(x, y)
  ;
  (self.rootTran):DOKill()
  if tween then
    ((self.rootTran):DOLocalMove(unityPos, 0.1)):SetLink(self.rootGo)
  else
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.rootTran).localPosition = unityPos
  end
end

DormFurnitureEntity.GetFntEntityLocalPos = function(self)
  -- function num : 0_10
  return (self.rootTran).localPosition
end

DormFurnitureEntity.GetFntEntityCenterTrasform = function(self)
  -- function num : 0_11 , upvalues : CS_GameObject
  if self.rootCenterTran == nil then
    self.rootCenterGo = CS_GameObject("Center")
    self.rootCenterTran = (self.rootCenterGo).transform
    ;
    (self.rootCenterTran):SetParent(self.rootTran)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.rootCenterTran).localPosition = self._tranformLocalPos
  end
  return self.rootCenterTran
end

DormFurnitureEntity.SetFntEntityPosFromUnity = function(self, unityPos, force)
  -- function num : 0_12 , upvalues : DormUtil, DormEnum
  local newX, newY = (DormUtil.UnityCoord2Fnt)(unityPos, self.type)
  local sizeX, sizeY = (self.fntData):GetFntSize()
  if self.type == (DormEnum.eDormFntType).Door then
    newY = (DormUtil.GetFntDoorY)(sizeY)
  end
  local oldX = (self.fntData).x
  local oldY = (self.fntData).y
  local move = newX == oldX and newY == oldY and force
  if move then
    local outX, outY, newX, newY = (DormUtil.FntAreaOutMap)(newX, newY, sizeX, sizeY, (self.fntData).r, self.type)
    if newX == oldX and newY == oldY then
      do
        move = force
        move = move
        if move then
          self:SetFntEntityPos(newX, newY, true)
        end
        do return move, oldX, oldY end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
      end
    end
  end
end

DormFurnitureEntity.RotateFntEntity = function(self)
  -- function num : 0_13 , upvalues : _ENV
  (self.fntData):RotateFnt()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.rootTran).eulerAngles = (Vector3.New)(0, (self.fntData).r, 0)
  if (self.fntData):CheckOutMap() then
    self:SetFntEntityPos((self.fntData).x, (self.fntData).y, true)
  end
end

DormFurnitureEntity.__SetRotation = function(self)
  -- function num : 0_14 , upvalues : _ENV, DormEnum
  local angle = (Vector3.New)()
  if self.type == (DormEnum.eDormFntType).WallDecoration or self.type == (DormEnum.eDormFntType).Door then
    angle.z = (self.fntData).r
  else
    angle.y = (self.fntData).r
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.rootTran).localEulerAngles = angle
end

DormFurnitureEntity.GetFntEntityType = function(self)
  -- function num : 0_15
  return self.type
end

DormFurnitureEntity.GetFntAreaList = function(self, x, y)
  -- function num : 0_16 , upvalues : DormUtil
  if x == nil or y == nil then
    x = (self.fntData).x
    y = (self.fntData).y
  end
  local sizeX, sizeY = (self.fntData):GetFntSize()
  local areaList = (DormUtil.GetFntArea)(x, y, sizeX, sizeY, (self.fntData).r)
  return areaList
end

DormFurnitureEntity.GetFntDoorAreaList = function(self, x, y, wallId)
  -- function num : 0_17 , upvalues : DormUtil
  if x == nil or y == nil then
    x = (self.fntData).x
    y = (self.fntData).y
  end
  if wallId == nil then
    wallId = (self.fntData):GetFntParam()
  end
  x = (DormUtil.GetFntDoorPosByWall)(wallId, x)
  local sizeX, _, sizeY = (self.fntData):GetFntSize()
  local rot = (DormUtil.GetFntDoorR)(wallId)
  local areaList = (DormUtil.GetFntArea)(x, y, sizeX, sizeY, rot)
  return areaList
end

DormFurnitureEntity.SetFntOverlap = function(self, overlap)
  -- function num : 0_18
  self.overlap = overlap
  self:ShowFntOverlap()
end

DormFurnitureEntity.IsOverlap = function(self)
  -- function num : 0_19
  return self.overlap
end

DormFurnitureEntity.ShowFntOverlap = function(self)
  -- function num : 0_20
  if self.fntBottom ~= nil then
    (self.fntBottom):ShowOverlap(self.overlap)
  end
  if self.fntFloorBottom ~= nil then
    (self.fntFloorBottom):ShowOverlap(self.overlap)
  end
end

DormFurnitureEntity.AddFntBottom = function(self, bottom)
  -- function num : 0_21 , upvalues : DormUtil
  local sizeX, sizeY = (self.fntData):GetFntSize()
  local unityScale = (DormUtil.FntSize2Unity)(sizeX, sizeY, self.type)
  bottom:InitFntBottom(unityScale, self.type, self.rootTran, self._tranformLocalPos)
  self.fntBottom = bottom
  self:ShowFntOverlap()
end

DormFurnitureEntity.RemoveFntBottom = function(self)
  -- function num : 0_22
  local bottom = self.fntBottom
  self.fntBottom = nil
  return bottom
end

DormFurnitureEntity.ResetFntBottom = function(self)
  -- function num : 0_23 , upvalues : DormUtil, DormEnum, _ENV
  local sizeX, sizeY, sizeZ = (self.fntData):GetFntSize()
  do
    if self.fntBottom ~= nil then
      local unityScale = (DormUtil.FntSize2Unity)(sizeX, sizeY, self.type)
      ;
      (self.fntBottom):InitFntBottom(unityScale, self.type, self.rootTran, self._tranformLocalPos)
    end
    if self.fntFloorBottom ~= nil then
      local unityScale = (DormUtil.FntSize2Unity)(sizeX, sizeZ, (DormEnum.eDormFntType).Door)
      local wallUnityScale = (DormUtil.FntSize2Unity)(sizeX, sizeY, (DormEnum.eDormFntType).Door)
      local y = -wallUnityScale.z / 2
      local z = unityScale.z / 2
      local pos = (Vector3.New)(0, y, z) + self._tranformLocalPos
      ;
      (self.fntFloorBottom):InitFntBottom(unityScale, (DormEnum.eDormFntType).Furniture, self.rootTran, pos)
    end
  end
end

DormFurnitureEntity.AddFntDoorBottom = function(self, bottom)
  -- function num : 0_24 , upvalues : DormUtil, DormEnum, _ENV
  local sizeX, sizeY, sizeZ = (self.fntData):GetFntSize()
  local unityScale = (DormUtil.FntSize2Unity)(sizeX, sizeZ, (DormEnum.eDormFntType).Door)
  local wallUnityScale = (DormUtil.FntSize2Unity)(sizeX, sizeY, (DormEnum.eDormFntType).Door)
  local y = -wallUnityScale.z / 2
  local z = unityScale.z / 2
  local pos = (Vector3.New)(0, y, z) + self._tranformLocalPos
  bottom:InitFntBottom(unityScale, (DormEnum.eDormFntType).Furniture, self.rootTran, pos)
  self.fntFloorBottom = bottom
  self:ShowFntOverlap()
end

DormFurnitureEntity.RemoveFntDoorBottom = function(self, bottom)
  -- function num : 0_25
  local bottom = self.fntFloorBottom
  self.fntFloorBottom = nil
  return bottom
end

DormFurnitureEntity.ChangeDmFntWall = function(self, wallHolder, wallIndex)
  -- function num : 0_26 , upvalues : _ENV
  (self.fntData):SetFntParam(wallIndex)
  ;
  (self.rootTran):SetParent(wallHolder)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.rootTran).localEulerAngles = Vector3.zero
end

DormFurnitureEntity.DestroyDmFntEntityGo = function(self)
  -- function num : 0_27 , upvalues : _ENV
  DestroyUnityObject(self.gameObject, true)
  self.gameObject = nil
  self.transform = nil
  self._colliders = nil
end

DormFurnitureEntity.OnDelete = function(self)
  -- function num : 0_28 , upvalues : _ENV
  DestroyUnityObject(self.rootGo)
  self:_ClearResLoader()
end

return DormFurnitureEntity

