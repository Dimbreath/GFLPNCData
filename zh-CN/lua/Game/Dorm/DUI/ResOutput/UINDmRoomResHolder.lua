local UINDmRoomResHolder = class("UINDmRoomResHolder", UIBaseNode)
local base = UIBaseNode
UINDmRoomResHolder.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINDmRoomResHolder.InitDmRoomResHolder = function(self)
  -- function num : 0_1
end

UINDmRoomResHolder.RefreshDmRoomResHolderPos = function(self, position)
  -- function num : 0_2 , upvalues : _ENV
  local anchorPos = UIManager:World2UIPosition(position)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = anchorPos
end

UINDmRoomResHolder.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINDmRoomResHolder

