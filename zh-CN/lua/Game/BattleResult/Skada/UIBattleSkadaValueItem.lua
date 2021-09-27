local UIBattleSkadaValueItem = class("UIBattleSkadaValueItem", UIBaseNode)
local base = UIBaseNode
UIBattleSkadaValueItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIBattleSkadaValueItem.InitSkadaValueItem = function(self, color)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_Color).color = color
end

UIBattleSkadaValueItem.SetSkadaValue = function(self, progress, value)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).slider).value = progress
  ;
  ((self.ui).tex_Value):SetIndex(0, (string.format)("%.1f", progress * 100), tostring(value))
end

UIBattleSkadaValueItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIBattleSkadaValueItem

