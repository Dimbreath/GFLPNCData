-- params : ...
-- function num : 0 , upvalues : _ENV
local UINStOUpItem = class("UINStOUpItem", UIBaseNode)
local base = UIBaseNode
UINStOUpItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINStOUpItem.InitStOUpItem = function(self, curInfo, curValue, nextValue, isMaxLevel)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R5 in 'UnsetPending'

  ((self.ui).tex_Name).text = curInfo
  if isMaxLevel then
    ((self.ui).tex_Value):SetIndex(2, curValue)
  else
    if (string.IsNullOrEmpty)(nextValue) then
      ((self.ui).tex_Value):SetIndex(0, curValue)
    else
      ;
      ((self.ui).tex_Value):SetIndex(1, curValue, nextValue)
    end
  end
end

UINStOUpItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINStOUpItem

