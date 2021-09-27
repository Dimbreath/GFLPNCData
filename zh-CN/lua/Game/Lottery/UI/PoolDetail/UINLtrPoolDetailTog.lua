local UINLtrPoolDetailTog = class("UINLtrPoolDetailTog", UIBaseNode)
local base = UIBaseNode
UINLtrPoolDetailTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLtrPoolDetailTog.ChangeLtrPoolDetailTogState = function(self, isOn)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not isOn or not Color.black then
    ((self.ui).tex_Name).color = Color.gray
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_Buttom).enabled = isOn
  end
end

UINLtrPoolDetailTog.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINLtrPoolDetailTog

