-- params : ...
-- function num : 0 , upvalues : _ENV
local UINStarUpPromoteItem = class("UINStarUpPromoteItem", UIBaseNode)
local base = UIBaseNode
UINStarUpPromoteItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINStarUpPromoteItem.InitPromoteItem = function(self, type, new, old)
  -- function num : 0_1 , upvalues : _ENV
  (((self.ui).tex_Name).gameObject):SetActive(true)
  ;
  (((self.ui).tex_Count).gameObject):SetActive(true)
  new = tostring(new)
  old = tostring(old)
  if type == 4 then
    ((self.ui).tex_Name):SetIndex(type - 1, new)
  else
    ;
    ((self.ui).tex_Name):SetIndex(type - 1)
  end
  if type ~= 4 then
    ((self.ui).tex_Count):SetIndex(0, old, new)
  else
    ;
    (((self.ui).tex_Count).gameObject):SetActive(false)
  end
end

UINStarUpPromoteItem.OnHide = function(self)
  -- function num : 0_2
  (((self.ui).tex_Name).gameObject):SetActive(false)
  ;
  (((self.ui).tex_Count).gameObject):SetActive(false)
end

UINStarUpPromoteItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINStarUpPromoteItem

