-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFactoryLineItem = class("UINFactoryLineItem", UIBaseNode)
UINFactoryLineItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFactoryLineItem.InitLineItem = function(self, itemCfg, itemNum, isProduce,
                                           uiFactory)
    -- function num : 0_1 , upvalues : _ENV
    if not isProduce then isProduce = false end
    self.isProduce = isProduce
    self.itemCfg = itemCfg
    self.itemId = itemCfg.id
    self.itemNum = itemNum
    self.uiFactory = uiFactory -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_Pic).sprite = CRH:GetSprite((self.itemCfg).icon);
    ((self.ui).img_OnSelect):SetActive(false) -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_Quality).color = ItemQualityColor[itemCfg.quality];
    ((self.ui).tex_Count):SetIndex(0, (LanguageUtil.GetLocaleText)(
                                       (self.itemCfg).name),
                                   tostring(self.itemNum))
end

UINFactoryLineItem.SetHightlightActive =
    function(self, active)
        -- function num : 0_2
        ((self.ui).img_OnSelect):SetActive(active)
    end

UINFactoryLineItem.SetSignActive = function(self, active)
    -- function num : 0_3
    (((self.ui).tex_Sign).gameObject):SetActive(active)
end

return UINFactoryLineItem

