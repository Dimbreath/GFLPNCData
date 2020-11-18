-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattleSkadaInfoItem = class("UIBattleSkadaInfoItem", UIBaseNode)
local base = UIBaseNode
UIBattleSkadaInfoItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIBattleSkadaInfoItem.InitSkadaInfoItem = function(self, color, name, count, value, proportion)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R6 in 'UnsetPending'

  ((self.ui).img_Color).color = color
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillName).text = name
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillCount).text = count and tostring(count) or ""
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillHurt).text = tostring(value)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).proportion).text = (string.format)("%.1f", proportion * 100)
end

UIBattleSkadaInfoItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UIBattleSkadaInfoItem

