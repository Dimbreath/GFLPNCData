-- params : ...
-- function num : 0 , upvalues : _ENV
local UIPieText = class("UIPieText", UIBaseNode)
local base = UIBaseNode
UIPieText.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIPieText.InitPieText = function(self, proportion, position)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tex_Rate):SetIndex(0, (string.format)("%.1f", proportion * 100))
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).position = position
end

UIPieText.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UIPieText

