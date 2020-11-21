-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHudTextItem = class("UINHudTextItem", UIBaseNode)
local base = UIBaseNode
UINHudTextItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINHudTextItem.RefreshHudTextItem = function(self, num)
    -- function num : 0_1 , upvalues : _ENV
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).tex_Left).text = tostring(num) -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_Right).text = tostring(num)
end

UINHudTextItem.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINHudTextItem

