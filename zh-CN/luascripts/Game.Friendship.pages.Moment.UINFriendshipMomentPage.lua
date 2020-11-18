-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipMomentPage = class("UINFriendshipMomentPage", UIBaseNode)
local base = UIBaseNode
UINFriendshipMomentPage.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFriendshipMomentPage.LaterInit = function(self, resloader)
  -- function num : 0_1
  self.resloader = resloader
end

UINFriendshipMomentPage.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINFriendshipMomentPage

