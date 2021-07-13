-- params : ...
-- function num : 0 , upvalues : _ENV
local New_UIQuickPurchaseBox = class("New_UIQuickPurchaseBox", UIBaseWindow)
local base = UIBaseWindow
local ShopEnum = require("Game.Shop.ShopEnum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINQuickPurchaseLogicPreview = require("Game.QuickPurchaseBox.UINQuickPurchaseLogicPreview")
local UINQuickPurchasePayGift = require("Game.QuickPurchaseBox.UINQuickPurchasePayGift")
local UINQuickPurchaseFixedCountGood = require("Game.QuickPurchaseBox.UINQuickPurchaseFixedCountGood")
local cs_MessageCommon = CS.MessageCommon
New_UIQuickPurchaseBox.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINResourceGroup, UINBaseItemWithCount, UINQuickPurchaseLogicPreview, UINQuickPurchasePayGift
  self.oldRoot = (self.transform).parent
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Shop, false)
  self.buyNum = 0
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).gameResourceGroup)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnClickBuy)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_Back, self, self.SlideOut, nil, true)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reduce, self, self.OnClickMin)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.OnClickAdd)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ExtrInfo, self, self.OnClickExtraInfo)
  ;
  (((self.ui).btn_Add).onPress):AddListener(BindCallback(self, self.OnPressAdd))
  ;
  (((self.ui).btn_Reduce).onPress):AddListener(BindCallback(self, self.OnPressMin))
  ;
  (((self.ui).tween_side).onComplete):AddListener(BindCallback(self, self.OnSlideInComplete))
  ;
  (((self.ui).tween_side).onRewind):AddListener(BindCallback(self, self.OnClickClose))
  self.itemWithCount = (UINBaseItemWithCount.New)()
  ;
  (self.itemWithCount):Init((self.ui).itemWithCount)
  ;
  (self.itemWithCount):SetNotNeedAnyJump(true)
  self.buildPreviewNode = (UINQuickPurchaseLogicPreview.New)()
  ;
  (self.buildPreviewNode):Init((self.ui).obj_logicPreviewNode)
  ;
  (self.buildPreviewNode):Hide()
  self.quickPurchasePayGift = (UINQuickPurchasePayGift.New)()
  ;
  (self.quickPurchasePayGift):Init((self.ui).giftBagPage)
end

New_UIQuickPurchaseBox.SetRoot = function(self, transform)
  -- function num : 0_1
  (self.transform):SetParent(transform)
end

New_UIQuickPurchaseBox.SlideIn = function(self, isJumpIn)
  -- function num : 0_2 , upvalues : _ENV
  self.isJumpIn = isJumpIn
  ;
  ((self.ui).tween_side):DOPlayForward()
  AudioManager:PlayAudioById(1070)
  if not self.isJumpIn then
    (UIUtil.SetTopStatus)(self, self.SlideOut, nil, nil, nil, nil)
  else
    local backData = (UIUtil.PeekBackStack)()
    if backData == nil or backData.backAction == nil then
      (UIUtil.SetTopStatus)(nil, nil, nil, nil, nil, nil)
    else
      ;
      (UIUtil.SetTopStatus)(self, self.SlideOut, nil, nil, nil, nil)
    end
  end
  do
    self.slideInOver = false
    self.isSlideOuting = false
  end
end

New_UIQuickPurchaseBox.SlideOut = function(self, isHome, popBackStack)
  -- function num : 0_3 , upvalues : _ENV
  if not self.slideInOver or self.isSlideOuting then
    return 
  end
  self.isSlideOuting = true
  AudioManager:PlayAudioById(1071)
  ;
  ((self.ui).tween_side):DOPlayBackwards()
  if popBackStack then
    if not self.isJumpIn then
      (UIUtil.PopFromBackStack)()
      self.isJumpIn = nil
    else
      ;
      (UIUtil.PopFromBackStack)()
    end
  end
end

New_UIQuickPurchaseBox.InitBuyPayGift = function(self, payGiftInfo)
  -- function num : 0_4 , upvalues : _ENV
  ((self.ui).itemPage):SetActive(false)
  ;
  ((self.ui).singleBuyPage):SetActive(false)
  ;
  ((self.ui).giftBagPage):SetActive(true)
  ;
  ((self.ui).obj_limit):SetActive(false)
  ;
  (self.quickPurchasePayGift):OnInitPayGift(payGiftInfo, self)
  if payGiftInfo:IsUseItemPay() then
    local redIds = {}
    ;
    (table.insert)(redIds, (payGiftInfo.defaultCfg).costId)
    self:__refreshResGroup(true, redIds)
  else
    do
      self:__refreshResGroup(false)
    end
  end
end

New_UIQuickPurchaseBox.InitBuyTarget = function(self, goodData, BuySuccessCallback, isNeedRes, resIdList, JumpOtherWinCallback)
  -- function num : 0_5
  ((self.ui).itemPage):SetActive(true)
  ;
  ((self.ui).giftBagPage):SetActive(false)
  ;
  ((self.ui).singleBuyPage):SetActive(false)
  self.goodData = goodData
  self.BuySuccessCallback = BuySuccessCallback
  self.JumpOtherWinCallback = JumpOtherWinCallback
  self:m_RefreshGoodUI(goodData)
  self:m_RefreshTotalMoney()
  self:__refreshResGroup(isNeedRes, resIdList)
  self:__isContainExtrInfo()
end

New_UIQuickPurchaseBox.__isContainExtrInfo = function(self)
  -- function num : 0_6 , upvalues : ShopEnum
  if (self.goodData).shopType == (ShopEnum.eShopType).Charcter then
    (((self.ui).btn_ExtrInfo).gameObject):SetActive(true)
  else
    ;
    (((self.ui).btn_ExtrInfo).gameObject):SetActive(false)
  end
end

New_UIQuickPurchaseBox.__refreshResGroup = function(self, isNeedRes, resIdList)
  -- function num : 0_7
  if isNeedRes then
    (self.resourceGroup):SetResourceIds(resIdList)
    ;
    (self.resourceGroup):Show()
  else
    ;
    (self.resourceGroup):Hide()
  end
  ;
  (self.transform):SetAsLastSibling()
end

New_UIQuickPurchaseBox.m_RefreshGoodUI = function(self, goodData)
  -- function num : 0_8 , upvalues : _ENV
  self:__refreshLimitUIData(goodData)
  self:__refreshDiscountTipUI(goodData.discount)
  self:__refreshPriceDiscountUIData(goodData)
  ;
  (self.itemWithCount):InitItemWithCount(goodData.itemCfg, goodData.itemNum, nil)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((goodData.itemCfg).name)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Detail).text = (LanguageUtil.GetLocaleText)((goodData.itemCfg).describe)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_currPrice).text = goodData.newCurrencyNum
  local currencyItemCfg = (ConfigData.item)[goodData.currencyId]
  local smallIcon = currencyItemCfg.small_icon
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_currencyIcon).sprite = CRH:GetSprite(smallIcon)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_totalCurrencyIcon).sprite = CRH:GetSprite(smallIcon)
end

New_UIQuickPurchaseBox.__refreshPriceDiscountUIData = function(self, goodData)
  -- function num : 0_9
  if goodData.discount == 100 then
    ((self.ui).obj_discount):SetActive(false)
    ;
    (((self.ui).tex_oldPrice).gameObject):SetActive(false)
  else
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_oldPrice).text = goodData.oldCurrencyNum
    ;
    (((self.ui).tex_oldPrice).gameObject):SetActive(true)
  end
end

New_UIQuickPurchaseBox.__refreshDiscountTipUI = function(self, discountNum)
  -- function num : 0_10 , upvalues : _ENV
  if discountNum == 100 then
    ((self.ui).obj_discount):SetActive(false)
    return 
  end
  ;
  ((self.ui).obj_discount):SetActive(true)
  ;
  ((self.ui).tex_Discount):SetIndex(0, tostring(100 - discountNum))
end

New_UIQuickPurchaseBox.__refreshLimitUIData = function(self, goodData)
  -- function num : 0_11 , upvalues : ShopEnum, _ENV
  if goodData.shopType ~= (ShopEnum.eShopType).Random and goodData.isLimit and goodData.limitType ~= (ShopEnum.eLimitType).None then
    ((self.ui).tex_LimitType):SetIndex(goodData.limitType - 1)
    if goodData.totallimitTime ~= nil then
      ((self.ui).tex_LimitCount):SetIndex(0, tostring(goodData.purchases), tostring(goodData.totallimitTime))
    else
      ;
      ((self.ui).tex_LimitCount):SetIndex(0, tostring(goodData.purchases), tostring(goodData.limitTime))
    end
    ;
    ((self.ui).obj_limit):SetActive(true)
  else
    ;
    ((self.ui).obj_limit):SetActive(false)
  end
end

New_UIQuickPurchaseBox.OnClickAdd = function(self, isIgnoreTip)
  -- function num : 0_12 , upvalues : _ENV
  if self:m_CouldAdd(1, isIgnoreTip) then
    AudioManager:PlayAudioById(1064)
    self.buyNum = self.buyNum + 1
    self:m_RefreshTotalMoney()
  end
end

New_UIQuickPurchaseBox.OnPressAdd = function(self, isIgnoreTip)
  -- function num : 0_13 , upvalues : _ENV
  local pressedTime = ((self.ui).btn_Add):GetPressedTime()
  local changeNum = (math.ceil)(pressedTime * pressedTime / 5)
  changeNum = (math.min)(changeNum, 100)
  if self:m_CouldAdd(changeNum, isIgnoreTip) then
    AudioManager:PlayAudioById(1064)
    self.buyNum = self.buyNum + changeNum
    self:m_RefreshTotalMoney()
  else
    self:Add2Max()
  end
end

New_UIQuickPurchaseBox.OnClickMin = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if self.buyNum <= 1 then
    self:Add2Max(false)
    return 
  end
  AudioManager:PlayAudioById(1065)
  self.buyNum = self.buyNum - 1
  self:m_RefreshTotalMoney()
end

New_UIQuickPurchaseBox.OnPressMin = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local pressedTime = ((self.ui).btn_Reduce):GetPressedTime()
  local changeNum = (math.ceil)(pressedTime * pressedTime / 5)
  changeNum = (math.min)(changeNum, 100)
  if self.buyNum - changeNum <= 1 then
    self:Add2Max(true)
    return 
  end
  AudioManager:PlayAudioById(1065)
  self.buyNum = self.buyNum - changeNum
  self:m_RefreshTotalMoney()
end

New_UIQuickPurchaseBox.m_CouldAdd = function(self, count, isIgnoreTip)
  -- function num : 0_16 , upvalues : cs_MessageCommon, _ENV
  if not count then
    count = 1
  end
  if (self.goodData).isSoldOut then
    if not isIgnoreTip then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Shop_SoldOut))
    end
    return false
  else
    if (self.goodData).fragMaxBuyNum ~= nil and (self.goodData).fragMaxBuyNum < self.buyNum + count then
      if not isIgnoreTip then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Shop_BuyNumLimit))
      end
      return false
    end
  end
  if (self.goodData).isLimit and (self.goodData).limitTime - (self.goodData).purchases < self.buyNum + count then
    if not isIgnoreTip then
      if (self.goodData).totallimitTime ~= nil and self.buyNum + count <= (self.goodData).totallimitTime - (self.goodData).purchases then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Shop_PriceChange))
      else
        ;
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Shop_BuyNumLimit))
      end
    end
    return false
  end
  local wharehouseMaxNum = (self.goodData):GetCouldBuyMaxBuyNum()
  if wharehouseMaxNum >= 0 and wharehouseMaxNum < self.buyNum + count then
    if not isIgnoreTip then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.ResourceOverflow))
    end
    return false
  end
  local totalMoney = PlayerDataCenter:GetItemCount((self.goodData).currencyId)
  local enableBuyOne = false
  if (self.goodData).currencyId == ConstGlobalItem.PaidSubItem then
    totalMoney = totalMoney + PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidItem)
    enableBuyOne = self.buyNum + count <= 1
  end
  local totalNeedMoney = (self.buyNum + count) * (self.goodData).newCurrencyNum
  if totalMoney < totalNeedMoney and not enableBuyOne then
    if not isIgnoreTip then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Shop_MoneyInsufficient))
    end
    return false
  end
  do return true end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

New_UIQuickPurchaseBox.Add2Max = function(self, maxLimit)
  -- function num : 0_17 , upvalues : _ENV
  local maxNum = 0
  local totalMoney = PlayerDataCenter:GetItemCount((self.goodData).currencyId)
  if (self.goodData).currencyId == ConstGlobalItem.PaidSubItem then
    totalMoney = totalMoney + PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidItem)
  end
  local totalNeedMoney = (self.buyNum + 1) * (self.goodData).newCurrencyNum
  maxNum = (math.max)((math.floor)((totalMoney) / (self.goodData).newCurrencyNum), 0)
  if (self.goodData).currencyId == ConstGlobalItem.PaidSubItem then
    maxNum = (math.max)(1, maxNum)
  end
  if (self.goodData).isLimit then
    maxNum = (math.min)((self.goodData).limitTime - (self.goodData).purchases, maxNum)
  end
  if (self.goodData).fragMaxBuyNum ~= nil then
    maxNum = (math.min)((self.goodData).fragMaxBuyNum, maxNum)
  end
  local wharehouseMaxNum = (self.goodData):GetCouldBuyMaxBuyNum()
  if wharehouseMaxNum >= 0 then
    maxNum = (math.min)(maxNum, wharehouseMaxNum)
  end
  if maxLimit then
    self.buyNum = (math.min)(maxNum, 99)
  else
    self.buyNum = maxNum
  end
  self:m_RefreshTotalMoney()
end

New_UIQuickPurchaseBox.OnClickBuy = function(self, buyNum, OnBuyCompleted)
  -- function num : 0_18 , upvalues : _ENV, cs_MessageCommon
  if self.isSlideOuting then
    return 
  end
  if buyNum ~= nil then
    self.buyNum = buyNum
  end
  if self.buyNum <= 0 then
    return 
  end
  local containAth = false
  local itemCfg = (self.goodData).itemCfg
  if itemCfg ~= nil and itemCfg.type == eItemType.Arithmetic then
    containAth = true
  end
  if containAth and (ConfigData.game_config).athMaxNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    return 
  end
  local tatalBuyNum = self.buyNum * (self.goodData).itemNum
  local buyFunc = function()
    -- function num : 0_18_0 , upvalues : self, _ENV, tatalBuyNum
    self._heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
    ;
    (self.ctrl):ReqBuyGoods((self.goodData).shopId, (self.goodData).shelfId, self.buyNum, function()
      -- function num : 0_18_0_0 , upvalues : _ENV, self, tatalBuyNum
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        -- function num : 0_18_0_0_0 , upvalues : self, tatalBuyNum, _ENV
        if window == nil then
          return 
        end
        window:InitRewardsItem({(self.goodData).itemId}, {tatalBuyNum}, self._heroIdSnapShoot)
        self.buyNum = 0
        if UIManager:GetWindow(self:GetUIWindowTypeId()) ~= nil then
          self:m_RefreshTotalMoney()
          self:m_RefreshGoodUI(self.goodData)
        end
        if self.BuySuccessCallback ~= nil then
          (self.BuySuccessCallback)()
        end
      end
)
      if self.isJumpIn then
        self:SlideOut(false, true)
      else
        ;
        (UIUtil.OnClickBack)()
      end
    end
)
  end

  if (self.goodData).currencyId == ConstGlobalItem.PaidSubItem then
    local totalNeedMoney = self.buyNum * (self.goodData).newCurrencyNum
    local ownMoney = PlayerDataCenter:GetItemCount((self.goodData).currencyId)
    if ownMoney < totalNeedMoney then
      local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
      local beforeJumpCallback = function(callBack)
    -- function num : 0_18_1 , upvalues : self
    self:SlideOut(nil, true)
    if self.JumpOtherWinCallback ~= nil then
      (self.JumpOtherWinCallback)()
    end
    if callBack ~= nil then
      callBack()
    end
  end

      local directShowShop = shopWin == nil
      local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
      payCtrl:TryConvertPayItem((self.goodData).currencyId, totalNeedMoney - ownMoney, beforeJumpCallback, nil, buyFunc, directShowShop)
      return 
    end
  end
  buyFunc()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

New_UIQuickPurchaseBox.OnSlideInComplete = function(self)
  -- function num : 0_19
  self.slideInOver = true
end

New_UIQuickPurchaseBox.OnClickClose = function(self)
  -- function num : 0_20
  self.isSlideOuting = false
  self:Hide()
  self.buyNum = 0
  if self.goodData ~= nil then
    self:m_RefreshTotalMoney()
  end
  self:SetRoot(self.oldRoot)
end

New_UIQuickPurchaseBox.m_RefreshTotalMoney = function(self)
  -- function num : 0_21 , upvalues : _ENV
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

New_UIQuickPurchaseBox.OnClickExtraInfo = function(self)
  -- function num : 0_22
  local intervalList, priceList, curIndex = (self.goodData):GetPriceInterval()
  ;
  (self.buildPreviewNode):InitBuyFragPreview(intervalList, priceList, curIndex)
  ;
  (self.buildPreviewNode):Show()
end

New_UIQuickPurchaseBox.InitBuyFixedCountGood = function(self, fixedCount, goodData, isNeedRes, resIdList)
  -- function num : 0_23 , upvalues : UINQuickPurchaseFixedCountGood, _ENV
  if self.quickPurchaseFixedCountGood == nil then
    self.quickPurchaseFixedCountGood = (UINQuickPurchaseFixedCountGood.New)()
    ;
    (self.quickPurchaseFixedCountGood):Init((self.ui).singleBuyPage)
  end
  self.goodData = goodData
  ;
  ((self.ui).itemPage):SetActive(false)
  ;
  ((self.ui).giftBagPage):SetActive(false)
  self:__refreshLimitUIData(goodData)
  self:__refreshDiscountTipUI(goodData.discount)
  self:__refreshResGroup(isNeedRes, resIdList)
  self:__isContainExtrInfo()
  ;
  (self.quickPurchaseFixedCountGood):InitWithDataForFixedCountGood(goodData, BindCallback(self, self.OnClickBuy), BindCallback(self, self.m_CouldAdd))
  ;
  (self.quickPurchaseFixedCountGood):SetBuyFixedCount(fixedCount)
  self.buyNum = 0
  ;
  (self.quickPurchaseFixedCountGood):Show()
end

New_UIQuickPurchaseBox.OnDelete = function(self)
  -- function num : 0_24 , upvalues : base
  ((self.ui).tween_side):DOKill()
  ;
  (self.resourceGroup):Delete()
  ;
  (self.quickPurchasePayGift):Delete()
  ;
  (self.itemWithCount):Delete()
  ;
  (self.buildPreviewNode):Delete()
  if self.quickPurchaseFixedCountGood ~= nil then
    (self.quickPurchaseFixedCountGood):Delete()
    self.quickPurchaseFixedCountGood = nil
  end
  ;
  (base.OnDelete)(self)
end

return New_UIQuickPurchaseBox

