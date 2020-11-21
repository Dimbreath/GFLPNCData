-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFactoryLineEntityMat = class("UINFactoryLineEntityMat", UIBaseNode)
local base = UIBaseNode
UINFactoryLineEntityMat.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFactoryLineEntityMat.InitLineEntityResItem =
    function(self, itemCfg, stockNum)
        -- function num : 0_1 , upvalues : _ENV
        -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

        ((self.ui).tex_Count).text = tostring(stockNum) -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).img_Pic).sprite = CRH:GetSprite(itemCfg.icon) -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name) -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).img_Quality).color = ItemQualityColor[itemCfg.quality]
    end

UINFactoryLineEntityMat.RefreshEntityResItemCount =
    function(self, stockNum)
        -- function num : 0_2 , upvalues : _ENV
        -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

        ((self.ui).tex_Count).text = tostring(stockNum)
    end

UINFactoryLineEntityMat.SetSignActive = function(self, active)
    -- function num : 0_3
    (((self.ui).tex_Sign).gameObject):SetActive(active)
end

return UINFactoryLineEntityMat

