-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipSortKindItem = class("UINFriendshipSortKindItem", UIBaseNode)
local base = UIBaseNode
UINFriendshipSortKindItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_sortKindItem, self, self.onItemValueChange)
end

UINFriendshipSortKindItem.InitSortItem = function(self, name, callBack)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_KindName).text = name
  self.callBack = callBack
end

UINFriendshipSortKindItem.onItemValueChange = function(self, bool)
  -- function num : 0_2
  if self.callBack ~= nil then
    (self.callBack)(bool)
  end
end

UINFriendshipSortKindItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINFriendshipSortKindItem

