-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthEmptyAffix = class("UINAthEmptyAffix", UIBaseNode)
local base = UIBaseNode
UINAthEmptyAffix.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthEmptyAffix.InitAthEmptyAffix = function(self, parent, ratio)
  -- function num : 0_1 , upvalues : _ENV
  (self.transform):SetParent(parent)
  if ratio == nil then
    ((self.ui).img_Buttom):SetIndex(0)
  else
    ;
    ((self.ui).img_Buttom):SetIndex(1)
    ;
    ((self.ui).tex_Rate):SetIndex(0, GetPreciseDecimalStr(ratio * 100, 1))
  end
  ;
  (((self.ui).tex_Rate).gameObject):SetActive(ratio ~= nil)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINAthEmptyAffix.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthEmptyAffix

