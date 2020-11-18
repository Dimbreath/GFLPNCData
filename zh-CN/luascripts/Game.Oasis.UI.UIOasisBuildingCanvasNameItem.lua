-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisBuildingCanvasNameItem = class("UIOasisBuildingCanvasNameItem", UIBaseNode)
local base = UIBaseNode
UIOasisBuildingCanvasNameItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.nameItemScale = (Vector3.New)(4.6, 4.6, 1)
end

UIOasisBuildingCanvasNameItem.InitCanvasNameItem = function(self, id, UIbulidData, position)
  -- function num : 0_1
  self.id = id
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = UIbulidData.name
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_NameEN).text = UIbulidData.nameEn
  self:UpdateBuildingLevel(UIbulidData.level)
  self:UpdateNamePos(position)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.transform).localScale = self.nameItemScale
end

UIOasisBuildingCanvasNameItem.Split = function(self, bgRoot, textRoot)
  -- function num : 0_2
  ((self.ui).bg):SetParent(bgRoot)
  ;
  (((self.ui).text).transform):SetParent(textRoot)
end

UIOasisBuildingCanvasNameItem.UpdateNamePos = function(self, position)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).position = position
end

UIOasisBuildingCanvasNameItem.UpdateBuildingLevel = function(self, level)
  -- function num : 0_4 , upvalues : _ENV
  local index = level >= 9 and 1 or 0
  ;
  ((self.ui).tex_Level):SetIndex(index, tostring(level))
end

UIOasisBuildingCanvasNameItem.OnRecycle = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self.id = nil
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).localScale = Vector3.zero
end

UIOasisBuildingCanvasNameItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  ((self.ui).bg):SetParent(self.transform)
  ;
  (((self.ui).text).transform):SetParent(self.transform)
  ;
  (base.OnDelete)(self)
end

return UIOasisBuildingCanvasNameItem

