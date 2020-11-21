-- params : ...
-- function num : 0 , upvalues : _ENV
local UINShopNormalGoogsItem = class("UINShopNormalGoogsItem", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINShopNormalGoogsItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_shopItem, self, self.OnClick)
    self._RefreshGoods = BindCallback(self, self.RefreshGoods)
    self._OnClick = BindCallback(self, self.OnClick)
    self.itemWithCount = (UINBaseItemWithCount.New)();
    (self.itemWithCount):Init((self.ui).obj_itemWithCount)
    self.texItemList = {
        [1] = (self.ui).tex_oldPrice,
        [2] = (self.ui).tex_currPrice,
        [3] = (self.ui).tex_Name
    }
end

UINShopNormalGoogsItem.InitNormalGoodsItem =
    function(self, goodData)
        -- function num : 0_1 , upvalues : _ENV
        self.goodData = goodData -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(
                                        (goodData.itemCfg).name);
        (self.itemWithCount):InitItemWithCount(goodData.itemCfg,
                                               goodData.itemNum, self._OnClick) -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).img_Quality).color =
            ItemQualityColor[(goodData.itemCfg).quality]
        self:RefreshCurrencyUI(goodData)
        self:RefreshLimitUI(goodData)
        for i = 1, #self.texItemList do
            ((self.texItemList)[i]):StartScrambleTypeWriter()
        end
    end

UINShopNormalGoogsItem.RefreshCurrencyUI =
    function(self, goodData)
        -- function num : 0_2 , upvalues : _ENV
        -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

        ((self.ui).tex_currPrice).text = goodData.newCurrencyNum
        local currencyItemCfg = (ConfigData.item)[goodData.currencyId]
        local smallIcon = currencyItemCfg.small_icon -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).img_priceIcon).sprite = CRH:GetSprite(smallIcon)
        if goodData.discount == 100 then
            ((self.ui).obj_discount):SetActive(false);
            (((self.ui).tex_oldPrice).gameObject):SetActive(false)
        else

            ((self.ui).tex_Discount):SetIndex(0,
                                              tostring(100 - goodData.discount)) -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((self.ui).tex_oldPrice).text = goodData.oldCurrencyNum;
            ((self.ui).obj_discount):SetActive(true);
            (((self.ui).tex_oldPrice).gameObject):SetActive(true)
        end
    end

UINShopNormalGoogsItem.RefreshLimitUI = function(self, goodData)
    -- function num : 0_3 , upvalues : ShopEnum, _ENV
    if goodData.isLimit then
        if goodData.shopType == (ShopEnum.eShopType).Random then
            ((self.ui).obj_limit):SetActive(false)
        else

            ((self.ui).obj_limit):SetActive(true)
        end
        ((self.ui).tex_LimitType):SetIndex(goodData.limitType - 1)
        if goodData.totallimitTime ~= nil then
            ((self.ui).tex_LimitCount):SetIndex(0, tostring(goodData.purchases),
                                                tostring(goodData.totallimitTime))
        else

            ((self.ui).tex_LimitCount):SetIndex(0, tostring(goodData.purchases),
                                                tostring(goodData.limitTime))
        end
        ((self.ui).obj_soldOut):SetActive(goodData.isSoldOut)
    else

        ((self.ui).obj_soldOut):SetActive(false);
        ((self.ui).obj_limit):SetActive(false)
    end
end

UINShopNormalGoogsItem.OnClick = function(self)
    -- function num : 0_4 , upvalues : _ENV
    if (self.goodData).isLimit and (self.goodData).isSoldOut then return end
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
        -- function num : 0_4_0 , upvalues : _ENV, self
        if win == nil then
            error("can\'t open QuickBuy win")
            return
        end
        win:SlideIn()
        win:SetRoot((self.ui).quickPurchaseRoot)
        win:InitBuyTarget(self.goodData, self._RefreshGoods)
        win:OnClickAdd()
    end)
end

UINShopNormalGoogsItem.RefreshGoods = function(self)
    -- function num : 0_5
    self:RefreshCurrencyUI(self.goodData)
    self:RefreshLimitUI(self.goodData)
end

UINShopNormalGoogsItem.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)(self)
end

return UINShopNormalGoogsItem

