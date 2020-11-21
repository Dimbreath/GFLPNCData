-- params : ...
-- function num : 0 , upvalues : _ENV
local UINShopShelfTog = class("UINShopShelfTog", UIBaseNode)
local base = UIBaseNode
UINShopShelfTog.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddValueChangedListener)((self.ui).tog_ShelfType, self,
                                     self.OnValueChage)
end

UINShopShelfTog.InitShelfTog = function(self, shopData, pageId,
                                        refreshGoodsCallback)
    -- function num : 0_1 , upvalues : _ENV
    self.shopData = shopData
    self.pageId = pageId
    self.refreshGoodsCallback = refreshGoodsCallback -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(
                                    ((shopData.shopPagesDic)[pageId]).name)
end

UINShopShelfTog.OnValueChage = function(self, bool)
    -- function num : 0_2
    if bool then
        if self.refreshGoodsCallback ~= nil then
            (self.refreshGoodsCallback)(self.shopData, self.pageId)
        end
        ((self.ui).img_Button):SetIndex(1)
    else

        ((self.ui).img_Button):SetIndex(0)
    end
end

UINShopShelfTog.SetSelected = function(self, bool)
    -- function num : 0_3
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).tog_ShelfType).isOn = bool
end

UINShopShelfTog.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UINShopShelfTog

