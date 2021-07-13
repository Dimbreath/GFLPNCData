-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroTag = class("UINHeroTag", UIBaseNode)
local base = UIBaseNode
UINHeroTag.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINHeroTag.InitTag = function(self, index)
  -- function num : 0_1
  ((self.ui).tex_Tag):SetIndex(index, "")
end

UINHeroTag.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroTag

