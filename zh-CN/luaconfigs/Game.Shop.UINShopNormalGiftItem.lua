-- params : ...
-- function num : 0 , upvalues : _ENV
local UINShopNormalGiftItem = class("UINShopNormalGiftItem", UIBaseNode)
local base = UIBaseNode
local CS_ClientConsts = CS.ClientConsts
local ShopEnum = require("Game.Shop.ShopEnum")
UINShopNormalGiftItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CNY, self, self.OnClickGiftBuy)
end

UINShopNormalGiftItem.InitGiftItem = function(self, data, purchaseRoot, resloader, refreshFunc)
  -- function num : 0_1 , upvalues : _ENV, CS_ClientConsts, ShopEnum
  self.data = data
  self.purchaseRoot = purchaseRoot
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(((self.data).groupCfg).name)
  self.refreshFunc = refreshFunc
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
  if (self.data):IsUseItemPay() then
    (((self.ui).tex_CNY).gameObject):SetActive(false)
    ;
    ((self.ui).obj_img_QuartzGift):SetActive(true)
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring(((self.data).defaultCfg).costCount)
    if ((self.data).defaultCfg).costId ~= ConstGlobalItem.PaidItem or self.__loadedOther then
      local itemCfg = (ConfigData.item)[((self.data).defaultCfg).costId]
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).imgIcon).sprite = CRH:GetSprite(itemCfg.small_icon)
      if ((self.data).defaultCfg).costId == ConstGlobalItem.PaidItem then
        self.__loadedOther = false
      else
        self.__loadedOther = true
      end
    end
  else
    do
      ;
      (((self.ui).tex_CNY).gameObject):SetActive(true)
      ;
      ((self.ui).obj_img_QuartzGift):SetActive(false)
      local payId = ((self.data).defaultCfg).payId
      do
        local priceStr, priceNum = payCtrl:GetPayPriceShow(payId)
        if priceNum == 0 then
          ((self.ui).tex_CNY):SetIndex(0)
        else
          ;
          ((self.ui).tex_CNY):SetIndex(1, priceStr)
        end
        self._finimalGiftIcon = ((self.data).groupCfg).icon
        local textureName = ((self.data).groupCfg).icon
        ;
        (((self.ui).img_GiftBag).gameObject):SetActive(false)
        resloader:LoadABAssetAsync(PathConsts:GetShopGiftBgPath(textureName), function(texture)
    -- function num : 0_1_0 , upvalues : _ENV, textureName, self
    if not IsNull(texture) and textureName == self._finimalGiftIcon then
      (((self.ui).img_GiftBag).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((self.ui).img_GiftBag).texture = texture
    end
  end
)
        ;
        (((self.ui).obj_Discount).gameObject):SetActive(false)
        ;
        (((self.ui).img_tag).gameObject):SetActive(false)
        do
          if not CS_ClientConsts.IsAudit and not (ConfigData.game_config).payGiftdiscountHide and ((self.data).groupCfg).tagType > 0 then
            local groupCfg = (self.data).groupCfg
            if groupCfg.tagType == (ShopEnum.ePayGiftTag).Discount then
              (((self.ui).obj_Discount).gameObject):SetActive(true)
              -- DECOMPILER ERROR at PC172: Confused about usage of register: R8 in 'UnsetPending'

              ;
              ((self.ui).tex_Discount).text = tostring(groupCfg.tagValue) .. "%"
            else
              ;
              (((self.ui).img_tag).gameObject):SetActive(true)
              ;
              ((self.ui).img_tag):SetIndex(groupCfg.tagValue - 1)
              ;
              ((self.ui).tex_Tag):SetIndex(groupCfg.tagType - 2)
            end
          end
          self:RefreshGiftItem()
        end
      end
    end
  end
end

UINShopNormalGiftItem.RefreshGiftItem = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local isSoldOut = (self.data):IsSoldOut()
  local isLimit, times, limitTimes = (self.data):GetLimitBuyCount()
  ;
  (((self.ui).obj_SoldOut).gameObject):SetActive(isSoldOut)
  ;
  ((self.ui).obj_limit):SetActive(isLimit)
  do
    if not (self.data).needRefresh or not 1 then
      local index = not isLimit or 0
    end
    ;
    ((self.ui).text_limit):SetIndex(index, tostring(limitTimes - times))
    self.lastRefreshTime = (math.floor)((self.data):GetPayGiftNextTime())
    if (self.data).needRefresh then
      ((self.ui).obj_time):SetActive(true)
      if self.timer == nil then
        self.timer = TimerManager:GetTimer(1, self.ShowGiftCutDown, self, false, false, false)
      else
        ;
        (self.timer):Stop()
        ;
        (self.timer):Init(1, self.ShowGiftCutDown, self, false, false, false)
      end
      self:ShowGiftCutDown()
      ;
      (self.timer):Start()
    else
      ;
      ((self.ui).obj_time):SetActive(false)
      if self.timer ~= nil then
        (self.timer):Stop()
        self.timer = nil
      end
    end
  end
end

UINShopNormalGiftItem.ShowGiftCutDown = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local time = self.lastRefreshTime - PlayerDataCenter.timestamp
  if time < 0 then
    if self.refreshFunc ~= nil then
      (self.refreshFunc)()
    end
    return 
  end
  local d, h, m, s = TimestampToTimeInter(time, false, true)
  if d > 0 then
    ((self.ui).text_time):SetIndex(0, tostring(d), tostring(h))
  else
    if h > 0 then
      ((self.ui).text_time):SetIndex(1, tostring(h), tostring(m))
    else
      if m > 0 then
        ((self.ui).text_time):SetIndex(2, tostring(m))
      else
        ;
        ((self.ui).text_time):SetIndex(2, tostring(1))
      end
    end
  end
end

UINShopNormalGiftItem.OnClickGiftBuy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(window)
    -- function num : 0_4_0 , upvalues : self
    window:SlideIn()
    window:InitBuyPayGift(self.data)
  end
)
end

UINShopNormalGiftItem.SetGiftItemReddot = function(self, flag)
  -- function num : 0_5
  ((self.ui).redDot):SetActive(flag)
end

UINShopNormalGiftItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINShopNormalGiftItem

