-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthHasSuitItem = class("UINAthHasSuitItem", UIBaseNode)
local base = UIBaseNode
local rectAnchorOffsetMax = (Vector2.New)(12, 12)
local rectAnchorOffsetMin = (Vector2.New)(-12, -12)
UINAthHasSuitItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthHasSuitItem.InitAthHasSuitItem = function(self, parent, holder)
  -- function num : 0_1 , upvalues : rectAnchorOffsetMax, rectAnchorOffsetMin
  self.holder = holder
  ;
  (self.transform):SetParent(parent)
  ;
  (self.transform):SetAsFirstSibling()
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).offsetMax = rectAnchorOffsetMax
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).offsetMin = rectAnchorOffsetMin
end

UINAthHasSuitItem.OnHide = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if not IsNull(self.holder) then
    (self.transform):SetParent(self.holder)
  end
end

UINAthHasSuitItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthHasSuitItem

