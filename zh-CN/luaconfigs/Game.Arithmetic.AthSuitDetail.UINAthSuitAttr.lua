-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSuitAttr = class("UINAthSuitAttr", UIBaseNode)
local base = UIBaseNode
UINAthSuitAttr.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthSuitAttr.InitAthSuitAttr = function(self, suitCount, info, textIndex)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tex_Content):SetIndex(textIndex, tostring(suitCount), info)
end

UINAthSuitAttr.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthSuitAttr

