local UINQuickPurchaseFixedCountGood = class("UINQuickPurchaseFixedCountGood", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINQuickPurchaseFixedCountGood.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnClickBuyFixedCountGood)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CantBuy, self, self._OnClickCantBuy)
end

UINQuickPurchaseFixedCountGood.SetBuyFixedCount = function(self, count)
  -- function num : 0_1
  self.fixedCount = count
end

UINQuickPurchaseFixedCountGood.InitWithDataForFixedCountGood = function(self, goodData, buyEvent, ableToBuy)
  -- function num : 0_2
  self.buyEvent = buyEvent
  self.ableToBuyEvent = ableToBuy
  self:__RefreshGoodUI(goodData)
  self:CheckCouldBuyGood(true, goodData)
end

UINQuickPurchaseFixedCountGood.__RefreshTotalMoney = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.buyNum == 0 then
    (((self.ui).btn_Buy).gameObject):SetActive(false)
    ;
    ((self.ui).obj_cantBuy):SetActive(true)
  else
    ;
    (((self.ui).btn_Buy).gameObject):SetActive(true)
    ;
    ((self.ui).obj_cantBuy):SetActive(false)
  end
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_buyCount).text = tostring(self.buyNum)
  local totalMoney = self.buyNum * (self.goodData).newCurrencyNum
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_totalcurrPrice).text = tostring(totalMoney)
end

UINQuickPurchaseFixedCountGood.__RefreshGoodUI = function(self, goodData)
  -- function num : 0_4 , upvalues : UINBaseItemWithCount, _ENV
  self.itemWithCount = (UINBaseItemWithCount.New)()
  ;
  (self.itemWithCount):Init((self.ui).uINBaseItemWithCount)
  ;
  (self.itemWithCount):SetNotNeedAnyJump(true)
  ;
  (self.itemWithCount):InitItemWithCount(goodData.itemCfg, goodData.itemNum, nil)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((goodData.itemCfg).name)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Detail).text = (LanguageUtil.GetLocaleText)((goodData.itemCfg).describe)
  local currencyItemCfg = (ConfigData.item)[goodData.currencyId]
  local smallIcon = currencyItemCfg.small_icon
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_currencyIcon).sprite = CRH:GetSprite(smallIcon)
end

UINQuickPurchaseFixedCountGood.__refreshPriceAndDiscount = function(self, goodData)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_currPrice).text = goodData.newCurrencyNum
  self:__refreshDiscountUIData(goodData)
end

UINQuickPurchaseFixedCountGood.__refreshDiscountUIData = function(self, goodData)
  -- function num : 0_6
  if goodData.discount == 100 then
    (((self.ui).tex_oldPrice).gameObject):SetActive(false)
  else
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_oldPrice).text = goodData.oldCurrencyNum
    ;
    (((self.ui).tex_oldPrice).gameObject):SetActive(true)
  end
end

UINQuickPurchaseFixedCountGood.OnClickBuyFixedCountGood = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.buyEvent ~= nil then
    (self.buyEvent)(self.fixedCount, BindCallback(self, self.CheckCouldBuyGood, false))
  end
end

UINQuickPurchaseFixedCountGood._OnClickCantBuy = function(self)
  -- function num : 0_8
  if self.ableToBuyEvent ~= nil then
    (self.ableToBuyEvent)(self.fixedCount, false)
  end
end

UINQuickPurchaseFixedCountGood.CheckCouldBuyGood = function(self, ignoreMsgTip, goodData)
  -- function num : 0_9 , upvalues : _ENV
  local quickBuyWindow = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
  quickBuyWindow.buyNum = 0
  self:__refreshPriceAndDiscount(goodData)
  if not ignoreMsgTip then
    do
      local couldBuy = (self.ableToBuyEvent)(self.fixedCount, self.ableToBuyEvent == nil or false)
      ;
      ((self.ui).soldOut):SetActive(not couldBuy)
      ;
      (((self.ui).btn_Buy).gameObject):SetActive(couldBuy)
      do return  end
      ;
      ((self.ui).soldOut):SetActive(true)
      ;
      (((self.ui).btn_Buy).gameObject):SetActive(false)
    end
  end
end

UINQuickPurchaseFixedCountGood.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (self.itemWithCount):OnDelete()
  ;
  (base.OnDelete)(self)
end

return UINQuickPurchaseFixedCountGood

