local DormFntBottomEntity = class("DormFntBottomEntity")
local DormEnum = require("Game.Dorm.DormEnum")
DormFntBottomEntity.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.wallAngle = (Vector3.New)(90, 0, 0)
end

DormFntBottomEntity.InitFntBottomGo = function(self, go)
  -- function num : 0_1 , upvalues : _ENV
  self.gameObject = go
  self.transform = go.transform
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.bind)
end

DormFntBottomEntity.InitFntBottom = function(self, scale, fntType, parent, pos)
  -- function num : 0_2 , upvalues : _ENV, DormEnum
  (self.transform):SetParent(parent, false)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  if not pos then
    (self.transform).localPosition = Vector3.zero
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.transform).localScale = scale
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

    if fntType == (DormEnum.eDormFntType).WallDecoration or fntType == (DormEnum.eDormFntType).Door then
      (self.transform).localEulerAngles = self.wallAngle
    else
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.transform).localEulerAngles = Vector3.zero
    end
  end
end

DormFntBottomEntity.ShowOverlap = function(self, overlap)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not overlap or not (self.bind).redMat then
    ((self.bind).meshRender).sharedMaterial = (self.bind).greenMat
  end
end

return DormFntBottomEntity

