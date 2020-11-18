-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisBuildingCanvasProgressItem = class("UIOasisBuildingCanvasProgressItem", UIBaseNode)
local base = UIBaseNode
UIOasisBuildingCanvasProgressItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIOasisBuildingCanvasProgressItem.InitCanvasProcessItem = function(self, id, position, process, text)
  -- function num : 0_1 , upvalues : _ENV
  self.id = id
  self:UpdateProcessPos(position)
  self:UpdateProcess(process, text)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.transform).localScale = Vector3.one
end

UIOasisBuildingCanvasProgressItem.Split = function(self, bgRoot, fillRoot, textRoot)
  -- function num : 0_2
  ((self.ui).bg):SetParent(bgRoot)
  ;
  (((self.ui).fill).transform):SetParent(fillRoot)
  ;
  (((self.ui).text).transform):SetParent(textRoot)
end

UIOasisBuildingCanvasProgressItem.UpdateProcess = function(self, process, text)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).text).text = text
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).fill).fillAmount = process
end

UIOasisBuildingCanvasProgressItem.UpdateProcessPos = function(self, position)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).position = position
end

UIOasisBuildingCanvasProgressItem.OnRecycle = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self.id = nil
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).localScale = Vector3.zero
end

UIOasisBuildingCanvasProgressItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  ((self.ui).bg):SetParent(self.transform)
  ;
  (((self.ui).fill).transform):SetParent(self.transform)
  ;
  (((self.ui).text).transform):SetParent(self.transform)
  ;
  (base.OnDelete)(self)
end

return UIOasisBuildingCanvasProgressItem

