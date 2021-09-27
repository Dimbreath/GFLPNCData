local UINDormRoomStateItem = class("UINDormRoomStateItem", UIBaseNode)
local base = UIBaseNode
UINDormRoomStateItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINDormRoomStateItem.InitDmRoomStateItem = function(self, anchorPos)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).anchoredPosition = anchorPos
end

UINDormRoomStateItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINDormRoomStateItem

