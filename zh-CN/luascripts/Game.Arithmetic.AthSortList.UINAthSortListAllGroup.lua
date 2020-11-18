-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSortListAllGroup = class("UINAthSortListAllGroup", UIBaseNode)
local base = UIBaseNode
UINAthSortListAllGroup.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthSortListAllGroup.InitAthSortListAllGroup = function(self)
  -- function num : 0_1
end

UINAthSortListAllGroup.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthSortListAllGroup

