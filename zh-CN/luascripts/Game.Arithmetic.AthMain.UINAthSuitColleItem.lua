-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSuitColleItem = class("UINAthSuitColleItem", UIBaseNode)
local base = UIBaseNode
UINAthSuitColleItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthSuitColleItem.InitAthSuitColleItem = function(self, num, valid)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tex_Colle):SetIndex(0, tostring(num))
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup).alpha = valid and 1 or 0.5
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

  if not valid or not (self.ui).color_Highlight then
    ((self.ui).img).color = (self.ui).color_Gray
  end
end

UINAthSuitColleItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthSuitColleItem

