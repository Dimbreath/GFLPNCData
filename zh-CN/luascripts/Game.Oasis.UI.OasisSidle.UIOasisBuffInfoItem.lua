-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisBuffInfoItem = class("UIOasisDetailInfoItem", UIBaseNode)
local base = UIBaseNode
UIOasisBuffInfoItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIOasisBuffInfoItem.SetInfoItemText = function(self, text)
    -- function num : 0_1
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).tex_Bonus).text = text
end

UIOasisBuffInfoItem.SetInfoItemTextIndex =
    function(self, index, text1, text2)
        -- function num : 0_2
        ((self.ui).tex_Bonus):SetIndex(index, text1, text2)
    end

UIOasisBuffInfoItem.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UIOasisBuffInfoItem

