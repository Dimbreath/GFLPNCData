-- params : ...
-- function num : 0 , upvalues : _ENV
local DormFurnitureEntity = class("DormFurnitureEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local eDormFntType = require("Game.Dorm.Enum.eDormFntType")
local CS_GameObject = (CS.UnityEngine).GameObject
DormFurnitureEntity.ctor = function(self)
  -- function num : 0_0
end

DormFurnitureEntity.InitFntEntity = function(self, obj, fntData)
  -- function num : 0_1 , upvalues : CS_GameObject, DormUtil
  self.gameObject = obj
  self.transform = obj.transform
  self.fntData = fntData
  self.type = (self.fntData):GetFntType()
  self.rootGo = CS_GameObject((self.gameObject).name)
  self.rootTran = (self.rootGo).transform
  ;
  (self.rootTran):SetParent((self.transform).parent)
  ;
  (self.transform):SetParent(self.rootTran, false)
  local sizeX, sizeY = (self.fntData):GetFntSize()
  local posOffset = (DormUtil.FntCoord2Unity)(sizeX / 2 - 0.5, sizeY / 2 - 0.5, self.type)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.transform).localPosition = posOffset
  self:SetFntEntityPos((self.fntData).x, (self.fntData).y)
  self:__SetRotation()
end

DormFurnitureEntity.SetFntEntityPos = function(self, x, y, tween)
  -- function num : 0_2 , upvalues : DormUtil
  local unityPos = (DormUtil.FntCoord2Unity)(x, y, self.type)
  ;
  (self.fntData):SetFntPos(x, y)
  if tween then
    (self.rootTran):DOLocalMove(unityPos, 0.1)
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.rootTran).localPosition = unityPos
  end
end

DormFurnitureEntity.SetFntEntityPosFromUnity = function(self, unityPos)
  -- function num : 0_3 , upvalues : DormUtil
  local newX, newY = (DormUtil.UnityCoord2Fnt)(unityPos, self.type)
  local oldX = (self.fntData).x
  local oldY = (self.fntData).y
  local move = newX ~= oldX or newY ~= oldY
  if move then
    local sizeX, sizeY = (self.fntData):GetFntSize()
    local outX, outY = (DormUtil.FntAreaOutMap)(newX, newY, sizeX, sizeY, (self.fntData).r, self.type)
    if outX then
      newX = oldX
    end
    if outY then
      newY = oldY
    end
    move = newX ~= oldX or newY ~= oldY
    if move then
      self:SetFntEntityPos(newX, newY, true)
    end
  end
  do return move, oldX, oldY end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

DormFurnitureEntity.RotateFntEntity = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self.fntData):RotateFnt()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.rootTran).eulerAngles = (Vector3.New)(0, (self.fntData).r, 0)
  if (self.fntData):CheckOutMap() then
    self:SetFntEntityPos((self.fntData).x, (self.fntData).y, true)
  end
end

DormFurnitureEntity.__SetRotation = function(self)
  -- function num : 0_5 , upvalues : _ENV, eDormFntType
  local angle = (Vector3.New)()
  if self.type == eDormFntType.Wall then
    angle.z = (self.fntData).r
  else
    angle.y = (self.fntData).r
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.rootTran).localEulerAngles = angle
end

DormFurnitureEntity.GetFntEntityType = function(self)
  -- function num : 0_6
  return self.type
end

DormFurnitureEntity.GetFntAreaList = function(self, x, y)
  -- function num : 0_7 , upvalues : DormUtil
  if x == nil or y == nil then
    x = (self.fntData).x
    y = (self.fntData).y
  end
  local sizeX, sizeY = (self.fntData):GetFntSize()
  local areaList = (DormUtil.GetFntArea)(x, y, sizeX, sizeY, (self.fntData).r)
  return areaList
end

DormFurnitureEntity.SetFntOverlap = function(self, overlap)
  -- function num : 0_8
  self.overlap = overlap
  self:ShowFntOverlap()
end

DormFurnitureEntity.IsOverlap = function(self)
  -- function num : 0_9
  return self.overlap
end

DormFurnitureEntity.ShowFntOverlap = function(self)
  -- function num : 0_10
  if self.fntBottom ~= nil then
    (self.fntBottom):ShowOverlap(self.overlap)
  end
end

DormFurnitureEntity.AddFntBottom = function(self, bottom)
  -- function num : 0_11 , upvalues : DormUtil
  local sizeX, sizeY = (self.fntData):GetFntSize()
  local unityScale = (DormUtil.FntSize2Unity)(sizeX, sizeY, self.type)
  bottom:InitFntBottom(unityScale, self.type, self.transform)
  self.fntBottom = bottom
  self:ShowFntOverlap()
end

DormFurnitureEntity.RemoveFntBottom = function(self)
  -- function num : 0_12
  local bottom = self.fntBottom
  self.fntBottom = nil
  return bottom
end

DormFurnitureEntity.GetFntOffset = function(self)
  -- function num : 0_13
  return (self.transform).position - ((self.rootTran).transform).position
end

DormFurnitureEntity.OnDelete = function(self)
  -- function num : 0_14 , upvalues : _ENV
  DestroyUnityObject(self.rootGo)
end

return DormFurnitureEntity

