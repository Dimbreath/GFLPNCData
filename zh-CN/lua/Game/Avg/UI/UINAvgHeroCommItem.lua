local UINAvgHeroCommItem = class("UINAvgHeroCommItem", UIBaseNode)
local base = UIBaseNode
UINAvgHeroCommItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAvgHeroCommItem.InitAvgHeroCommItem = function(self, localPos, heroTransform)
  -- function num : 0_1
  (self.transform):SetParent(heroTransform.parent, true)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).localPosition = localPos
  heroTransform:SetParent((self.ui).mask)
end

UINAvgHeroCommItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAvgHeroCommItem

