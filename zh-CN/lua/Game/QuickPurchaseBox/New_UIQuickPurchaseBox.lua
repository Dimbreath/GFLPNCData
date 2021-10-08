local New_UIQuickPurchaseBox = class("New_UIQuickPurchaseBox", UIBaseWindow)
local base = UIBaseWindow
local ShopEnum = require("Game.Shop.ShopEnum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINQuickPurchaseLogicPreview = require("Game.QuickPurchaseBox.UINQuickPurchaseLogicPreview")
local UINQuickPurchasePayGift = require("Game.QuickPurchaseBox.UINQuickPurchasePayGift")
local UINQuickPurchaseFixedCountGood = require("Game.QuickPurchaseBox.UINQuickPurchaseFixedCountGood")
local cs_MessageCommon = CS.MessageCommon
local JumpManager = require("Game.Jump.JumpManager")
local CoinAllowExchange = {[ConstGlobalItem.SkinTicket] = (ShopEnum.eQuickBuy).skinTicket}
local QuickPurchaseType = {normal = 1, payGift = 2, fixedCountGoods = 3}
New_UIQuickPurchaseBox.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINResourceGroup, UINBaseItemWithCount, UINQuickPurchaseLogicPreview
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
  if not self.slideInOver then
    if popBackStack then
      (UIUtil.PopFromBackStack)()
    end
    self:OnClickClose()
    return 
  else
    if self.isSlideOuting then
      return 
    end
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
  -- function num : 0_4 , upvalues : _ENV, QuickPurchaseType
  if self.outDataTiemr ~= nil then
    TimerManager:StopTimer(self.outDataTiemr)
    self.outDataTiemr = nil
  end
  self.payGiftInfo = payGiftInfo
  self:ShowChildNodeByType(QuickPurchaseType.payGift)
  ;
  ((self.ui).obj_limit):SetActive(false)
  ;
  ((self.ui).obj_discount):SetActive(false)
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
      ;
      (((self.ui).btn_ExtrInfo).gameObject):SetActive(false)
    end
  end
end

New_UIQuickPurchaseBox.InitBuyTarget = function(self, goodData, BuySuccessCallback, isNeedRes, resIdList, JumpOtherWinCallback)
  -- function num : 0_5 , upvalues : QuickPurchaseType
  self:ShowChildNodeByType(QuickPurchaseType.normal)
  self.goodData = goodData
  self.BuySuccessCallback = BuySuccessCallback
  self.isNeedRes = isNeedRes
  self.resIdList = resIdList
  self.JumpOtherWinCallback = JumpOtherWinCallback
  self:m_RefreshGoodUI(goodData)
  self:m_RefreshTotalMoney()
  self:__refreshResGroup(isNeedRes, resIdList)
  self:__isContainExtrInfo()
end

New_UIQuickPurchaseBox.__isContainExtrInfo = function(self)
  -- function num : 0_6 , upvalues : ShopEnum, _ENV
  if (self.goodData).shopType == (ShopEnum.eShopType).Charcter then
    (((self.ui).btn_ExtrInfo).gameObject):SetActive(true)
  else
    ;
    (((self.ui).btn_ExtrInfo).gameObject):SetActive(false)
  end
  if self.outDataTiemr ~= nil then
    TimerManager:StopTimer(self.outDataTiemr)
    self.outDataTiemr = nil
  end
  local hasTime, inTime = (self.goodData):GetStillTime()
  if hasTime and inTime then
    self.outDataTiemr = TimerManager:StartTimer(1, self.OnTimerOutData, self)
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
  ;
  ((self.ui).comfortLv):SetActive(false)
  if (goodData.itemCfg).type == eItemType.DormFurniture then
    local fntCfg = (ConfigData.dorm_furniture)[(goodData.itemCfg).id]
    if fntCfg ~= nil then
      ((self.ui).comfortLv):SetActive(true)
      -- DECOMPILER ERROR at PC82: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_Comfort).text = tostring(fntCfg.comfort)
    end
  end
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
      ((self.ui).tex_LimitCount):SetIndex(0, tostring(goodData.totallimitTime - goodData.purchases), tostring(goodData.totallimitTime))
    else
      ;
      ((self.ui).tex_LimitCount):SetIndex(0, tostring(goodData.limitTime - goodData.purchases), tostring(goodData.limitTime))
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
    if not (self.goodData).isLimit and (table.contain)((ConfigData.game_config).highValueCurrencyList, (self.goodData).currencyId) then
      AudioManager:PlayAudioById(1065)
      return 
    end
    local maxNum = self:Add2Max(false)
    if maxNum == 0 then
      AudioManager:PlayAudioById(1065)
    else
      AudioManager:PlayAudioById(1064)
    end
    return 
  end
  do
    AudioManager:PlayAudioById(1065)
    self.buyNum = self.buyNum - 1
    self:m_RefreshTotalMoney()
  end
end

New_UIQuickPurchaseBox.OnPressMin = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local pressedTime = ((self.ui).btn_Reduce):GetPressedTime()
  local changeNum = (math.ceil)(pressedTime * pressedTime / 5)
  changeNum = (math.min)(changeNum, 100)
  if self.buyNum - changeNum <= 1 then
    if self.buyNum > 1 then
      AudioManager:PlayAudioById(1065)
    end
    self.buyNum = 1
    self:m_RefreshTotalMoney()
    return 
  end
  AudioManager:PlayAudioById(1065)
  self.buyNum = self.buyNum - changeNum
  self:m_RefreshTotalMoney()
end

New_UIQuickPurchaseBox.m_CouldAdd = function(self, count, isIgnoreTip)
  -- function num : 0_16 , upvalues : cs_MessageCommon, _ENV, CoinAllowExchange
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
  if (self.goodData).currencyId == ConstGlobalItem.PaidSubItem or (self.goodData).currencyId == ConstGlobalItem.PaidItem then
    totalMoney = totalMoney + PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidItem)
    enableBuyOne = self.buyNum + count <= 1
  elseif self.buyNum + count > 1 then
    enableBuyOne = CoinAllowExchange[(self.goodData).currencyId] == nil
    local totalNeedMoney = (self.buyNum + count) * (self.goodData).newCurrencyNum
    if totalMoney < totalNeedMoney and not enableBuyOne then
      if not isIgnoreTip then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Shop_MoneyInsufficient))
      end
      return false
    end
    do return true end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

New_UIQuickPurchaseBox.Add2Max = function(self, maxLimit, getMax)
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
  if not getMax then
    if maxLimit then
      self.buyNum = (math.min)(maxNum, 99)
    else
      self.buyNum = maxNum
    end
    self:m_RefreshTotalMoney()
    return maxNum
  else
    return maxNum
  end
end

New_UIQuickPurchaseBox.OnClickBuy = function(self, buyNum, OnBuyCompleted)
  -- function num : 0_18 , upvalues : _ENV, cs_MessageCommon, CoinAllowExchange
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

  if (self.goodData).currencyId == ConstGlobalItem.PaidSubItem or (self.goodData).currencyId == ConstGlobalItem.PaidItem then
    local totalNeedMoney = self.buyNum * (self.goodData).newCurrencyNum
    do
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
        do
          local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
          payCtrl:TryConvertPayItem((self.goodData).currencyId, totalNeedMoney - ownMoney, beforeJumpCallback, nil, buyFunc, directShowShop)
          do return  end
          -- DECOMPILER ERROR at PC96: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC96: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  elseif CoinAllowExchange[(self.goodData).currencyId] ~= nil then
    local totalNeedMoney = self.buyNum * (self.goodData).newCurrencyNum
    local ownMoney = PlayerDataCenter:GetItemCount((self.goodData).currencyId)
    if ownMoney < totalNeedMoney then
      local coinQuickBuyCfg = CoinAllowExchange[(self.goodData).currencyId]
      local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
      if not shopCtrl:ShopIsUnlock(coinQuickBuyCfg.shopId) then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Shop_MoneyInsufficient))
        return 
      end
      shopCtrl:GetShopData(coinQuickBuyCfg.shopId, function(shopData)
    -- function num : 0_18_2 , upvalues : coinQuickBuyCfg, _ENV, self, totalNeedMoney, ownMoney, shopCtrl, buyFunc
    local exChangeGoodData = (shopData.shopGoodsDic)[coinQuickBuyCfg.shelfId]
    if exChangeGoodData == nil then
      error("Cant get goodData from normalShop, itemId = " .. (self.goodData).currencyId)
      return 
    end
    local needItemNum = (math.ceil)((totalNeedMoney - ownMoney) / exChangeGoodData.itemNum)
    local needCurrencyNum = exChangeGoodData.newCurrencyNum * needItemNum
    self:PaidCoinExecute(exChangeGoodData.currencyId, needCurrencyNum, (self.goodData).currencyId, needItemNum * exChangeGoodData.itemNum, function()
      -- function num : 0_18_2_0 , upvalues : shopCtrl, exChangeGoodData, needItemNum, buyFunc
      shopCtrl:ReqBuyGoods(exChangeGoodData.shopId, exChangeGoodData.shelfId, needItemNum, function()
        -- function num : 0_18_2_0_0 , upvalues : buyFunc
        buyFunc()
      end
)
    end
)
  end
)
      return 
    end
  end
  totalNeedMoney = buyFunc
  totalNeedMoney()
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

New_UIQuickPurchaseBox.PaidCoinExecute = function(self, currencyId, currencyNum, coinId, coinNum, executeFunc)
  -- function num : 0_19 , upvalues : _ENV, cs_MessageCommon, JumpManager, ShopEnum
  local containCurrencyNum = PlayerDataCenter:GetItemCount(currencyId)
  local currencyCfg = (ConfigData.item)[currencyId]
  if currencyCfg == nil then
    error("Item Cfg is null,ID:" .. tostring(currencyId))
    return 
  end
  local currencyName = (LanguageUtil.GetLocaleText)(currencyCfg.name)
  local srcIdList = {}
  local srcNumList = {}
  local needPaidItemNum = 0
  needPaidItemNum = currencyNum - containCurrencyNum
  if currencyId == ConstGlobalItem.PaidSubItem then
    if needPaidItemNum > 0 and (containCurrencyNum == 0 or currencyId == coinId) then
      (table.insert)(srcIdList, ConstGlobalItem.PaidItem)
      ;
      (table.insert)(srcNumList, needPaidItemNum)
      local itemCfg = (ConfigData.item)[ConstGlobalItem.PaidItem]
      currencyName = tostring(needPaidItemNum) .. (LanguageUtil.GetLocaleText)(itemCfg.name)
    else
      do
        if needPaidItemNum > 0 and containCurrencyNum > 0 then
          (table.insert)(srcIdList, ConstGlobalItem.PaidItem)
          ;
          (table.insert)(srcNumList, needPaidItemNum)
          ;
          (table.insert)(srcIdList, ConstGlobalItem.PaidSubItem)
          ;
          (table.insert)(srcNumList, containCurrencyNum)
          local itemCfg = (ConfigData.item)[ConstGlobalItem.PaidItem]
          currencyName = tostring(needPaidItemNum) .. (LanguageUtil.GetLocaleText)(itemCfg.name) .. "+" .. tostring(containCurrencyNum) .. currencyName
        else
          do
            ;
            (table.insert)(srcIdList, ConstGlobalItem.PaidSubItem)
            ;
            (table.insert)(srcNumList, currencyNum)
            currencyName = tostring(currencyNum) .. currencyName
            ;
            (table.insert)(srcIdList, currencyId)
            ;
            (table.insert)(srcNumList, currencyNum)
            currencyName = tostring(currencyNum) .. currencyName
            local needItemName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[coinId]).name)
            local msg = (string.format)(ConfigData:GetTipContent(322), currencyName, tostring(coinNum), needItemName)
            local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
            window:ShowItemConvert(msg, srcIdList, srcNumList, {coinId}, {coinNum}, function()
    -- function num : 0_19_0 , upvalues : needPaidItemNum, executeFunc, cs_MessageCommon, _ENV, self, JumpManager, ShopEnum
    if needPaidItemNum <= 0 then
      executeFunc()
      return 
    end
    ;
    (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(TipContent.PaidItemNotEnoughTip), function()
      -- function num : 0_19_0_0 , upvalues : _ENV, self, JumpManager, ShopEnum
      local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
      local beforeJumpCallback = function(callBack)
        -- function num : 0_19_0_0_0 , upvalues : self
        self:SlideOut(nil, true)
        if self.JumpOtherWinCallback ~= nil then
          (self.JumpOtherWinCallback)()
        end
        if callBack ~= nil then
          callBack()
        end
      end

      local directShowShop = shopWin == nil
      if directShowShop then
        JumpManager:DirectShowShop(beforeJumpCallback, nil, (ShopEnum.ShopId).recharge)
      else
        JumpManager:Jump((JumpManager.eJumpTarget).DynShop, beforeJumpCallback, nil, {(ShopEnum.ShopId).recharge})
      end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
, nil)
  end
)
          end
        end
      end
    end
  end
end

New_UIQuickPurchaseBox.OnSlideInComplete = function(self)
  -- function num : 0_20
  self.slideInOver = true
end

New_UIQuickPurchaseBox.OnClickClose = function(self)
  -- function num : 0_21
  self.isSlideOuting = false
  self:Hide()
  self.buyNum = 0
  if self.goodData ~= nil then
    self:m_RefreshTotalMoney()
  end
  self:SetRoot(self.oldRoot)
end

New_UIQuickPurchaseBox.m_RefreshTotalMoney = function(self)
  -- function num : 0_22 , upvalues : _ENV
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
  -- function num : 0_23
  local intervalList, priceList, curIndex = (self.goodData):GetPriceInterval()
  ;
  (self.buildPreviewNode):InitBuyFragPreview(intervalList, priceList, curIndex)
  ;
  (self.buildPreviewNode):Show()
end

New_UIQuickPurchaseBox.InitBuyFixedCountGood = function(self, fixedCount, goodData, isNeedRes, resIdList, buySuccessCallback)
  -- function num : 0_24 , upvalues : QuickPurchaseType, _ENV
  self.fixedCount = fixedCount
  self.goodData = goodData
  self.isNeedRes = isNeedRes
  self.resIdList = resIdList
  self.BuySuccessCallback = buySuccessCallback
  self:ShowChildNodeByType(QuickPurchaseType.fixedCountGoods)
  self:__refreshLimitUIData(goodData)
  self:__refreshDiscountTipUI(goodData.discount)
  self:__refreshResGroup(isNeedRes, resIdList)
  self:__isContainExtrInfo()
  ;
  (self.quickPurchaseFixedCountGood):InitWithDataForFixedCountGood(goodData, BindCallback(self, self.OnClickBuy), BindCallback(self, self.m_CouldAdd))
  ;
  (self.quickPurchaseFixedCountGood):SetBuyFixedCount(fixedCount)
  self.buyNum = 0
end

New_UIQuickPurchaseBox.ShowChildNodeByType = function(self, purchaseType)
  -- function num : 0_25 , upvalues : QuickPurchaseType, UINQuickPurchasePayGift, UINQuickPurchaseFixedCountGood
  self.__purchaseType = purchaseType
  ;
  ((self.ui).itemPage):SetActive(purchaseType == QuickPurchaseType.normal)
  if self.quickPurchasePayGift ~= nil then
    if purchaseType == QuickPurchaseType.payGift then
      (self.quickPurchasePayGift):Show()
    else
      (self.quickPurchasePayGift):Hide()
    end
  elseif purchaseType == QuickPurchaseType.payGift then
    ((self.ui).giftBagPage):SetActive(true)
    self.quickPurchasePayGift = (UINQuickPurchasePayGift.New)()
    ;
    (self.quickPurchasePayGift):Init((self.ui).giftBagPage)
  else
    ((self.ui).giftBagPage):SetActive(false)
  end
  if self.quickPurchaseFixedCountGood ~= nil then
    if purchaseType == QuickPurchaseType.fixedCountGoods then
      (self.quickPurchaseFixedCountGood):Show()
    else
      (self.quickPurchaseFixedCountGood):Hide()
    end
  elseif purchaseType == QuickPurchaseType.fixedCountGoods then
    ((self.ui).singleBuyPage):SetActive(true)
    self.quickPurchaseFixedCountGood = (UINQuickPurchaseFixedCountGood.New)()
    ;
    (self.quickPurchaseFixedCountGood):Init((self.ui).singleBuyPage)
  else
    ((self.ui).singleBuyPage):SetActive(false)
  end
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

New_UIQuickPurchaseBox.OnTimerOutData = function(self)
  -- function num : 0_26 , upvalues : _ENV
  local _, inTime, _, _ = (self.goodData):GetStillTime()
  if inTime then
    return 
  end
  if self.outDataTiemr ~= nil then
    TimerManager:StopTimer(self.outDataTiemr)
    self.outDataTiemr = nil
  end
  self:OnClickClose()
end

New_UIQuickPurchaseBox.GenCoverJumpReturnCallback = function(self)
  -- function num : 0_27 , upvalues : _ENV, QuickPurchaseType
  local dataTable = {}
  for key,value in pairs(self) do
    dataTable[key] = value
  end
  self:SlideOut(nil, true)
  return function()
    -- function num : 0_27_0 , upvalues : _ENV, dataTable, self, QuickPurchaseType
    for key,value in pairs(dataTable) do
      self[key] = value
    end
    if self.__purchaseType == QuickPurchaseType.payGift then
      self:SlideIn()
      self:InitBuyPayGift(self.payGiftInfo)
      return 
    end
    local ShopController = ControllerManager:GetController(ControllerTypeId.Shop, true)
    ShopController:GetShopData((self.goodData).shopId, function(shopData)
      -- function num : 0_27_0_0 , upvalues : self, QuickPurchaseType
      if shopData == nil then
        return true
      end
      self.goodData = (shopData.shopGoodsDic)[(self.goodData).shelfId]
      self:SlideIn()
      if self.__purchaseType == QuickPurchaseType.normal then
        local maxNum = self:Add2Max(nil, true)
        if maxNum < self.buyNum then
          self.buyNum = maxNum
        end
        self:InitBuyTarget(self.goodData, self.BuySuccessCallback, self.isNeedRes, self.resIdList, self.JumpOtherWinCallback)
      else
        do
          if self.__purchaseType == QuickPurchaseType.fixedCountGoods then
            self:InitBuyFixedCountGood(self.fixedCount, self.goodData, self.isNeedRes, self.resIdList)
          end
        end
      end
    end
)
  end

end

New_UIQuickPurchaseBox.OnHide = function(self)
  -- function num : 0_28 , upvalues : base
  if (self.buildPreviewNode).active then
    (self.buildPreviewNode):_OnClickClose()
  end
  ;
  (base.OnHide)(self)
end

New_UIQuickPurchaseBox.OnDelete = function(self)
  -- function num : 0_29 , upvalues : _ENV, base
  ((self.ui).tween_side):DOKill()
  ;
  (self.resourceGroup):Delete()
  ;
  (self.itemWithCount):Delete()
  ;
  (self.buildPreviewNode):Delete()
  if self.quickPurchaseFixedCountGood ~= nil then
    (self.quickPurchaseFixedCountGood):Delete()
    self.quickPurchaseFixedCountGood = nil
  end
  if self.quickPurchasePayGift ~= nil then
    (self.quickPurchasePayGift):Delete()
    self.quickPurchasePayGift = nil
  end
  if self.outDataTiemr ~= nil then
    TimerManager:StopTimer(self.outDataTiemr)
    self.outDataTiemr = nil
  end
  ;
  (base.OnDelete)(self)
end

return New_UIQuickPurchaseBox

