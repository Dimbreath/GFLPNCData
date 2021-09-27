local UINFactoryHeroListCardAccItem = class("UINFactoryHeroListCardAccItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
UINFactoryHeroListCardAccItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFactoryHeroListCardAccItem.SetValue = function(self, index, speed, accRate)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tex_Name):SetIndex(index)
  local value = GetPreciseDecimalStr(speed * accRate * 3600, 1)
  ;
  ((self.ui).tex_Timer):SetIndex(0, tostring(value))
end

UINFactoryHeroListCardAccItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINFactoryHeroListCardAccItem

