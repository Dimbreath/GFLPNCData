local UINSkadaInfoItem = class("UINSkadaInfoItem", UIBaseNode)
local base = UIBaseNode
UINSkadaInfoItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINSkadaInfoItem.InitSkadaInfoItem = function(self, color, name, count, value, progress)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R6 in 'UnsetPending'

  ((self.ui).img_Cube).color = color
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_bar).color = color
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_name).text = name
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = count and tostring(count) or ""
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Value).text = tostring(value)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Percent).text = (string.format)("%.f%%", progress * 100)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_bar).fillAmount = progress
end

UINSkadaInfoItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINSkadaInfoItem

