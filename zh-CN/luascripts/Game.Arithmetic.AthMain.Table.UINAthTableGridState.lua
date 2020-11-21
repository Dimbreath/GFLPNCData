-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthTableGridState = class("UINAthTableGridState", UIBaseNode)
local base = UIBaseNode
UINAthTableGridState.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthTableGridState.InitAthGridState = function(self, position, stateIndex)
    -- function num : 0_1
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

    (self.transform).anchoredPosition = position;
    ((self.ui).img_State):SetIndex(stateIndex)
end

UINAthTableGridState.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINAthTableGridState

