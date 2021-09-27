local UISctBuildResItem = class("UISctBuildResItem", UIBaseNode)
local base = UIBaseNode
UISctBuildResItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UISctBuildResItem.InitSctBuildResItem = function(self, index)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_Rate).color = ((self.ui).barColor)[index]
end

UISctBuildResItem.UpdateSctBuildResItem = function(self, name, count, progress)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

  ((self.ui).tex_ResName).text = name
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_ResCount).text = tostring(count)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Rate).fillAmount = progress
end

UISctBuildResItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UISctBuildResItem

