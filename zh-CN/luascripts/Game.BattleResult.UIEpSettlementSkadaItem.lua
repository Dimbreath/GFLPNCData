-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpSettlementSkadaItem = class("UIEpSettlementSkadaItem", UIBaseNode)
local base = UIBaseNode
UIEpSettlementSkadaItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIEpSettlementSkadaItem.InitSettlementSkadaItem =
    function(self, heroInfo, process, resloader)
        -- function num : 0_1 , upvalues : _ENV
        -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

        ((self.ui).img_Pic).texture = resloader:LoadABAsset(
                                          PathConsts:GetCharacterPicPath(
                                              heroInfo:GetResName())) -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).tex_Damage).text = tostring(heroInfo.totalDamage) -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).slider).value = process
    end

UIEpSettlementSkadaItem.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UIEpSettlementSkadaItem

