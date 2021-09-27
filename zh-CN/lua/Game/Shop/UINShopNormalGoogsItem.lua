local UINShopNormalGoogsItem = class("UINShopNormalGoogsItem", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINShopNormalGoogsItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_shopItem, self, self.OnClick)
  self._RefreshGoods = BindCallback(self, self.RefreshGoods)
  self.itemWithCount = (UINBaseItemWithCount.New)()
  ;
  (self.itemWithCount):Init((self.ui).obj_itemWithCount)
  ;
  (self.itemWithCount):EnableButton(false)
  self._RefreshGoodsRecharge = BindCallback(self, self.OnGoodsShopRechargeSuccess)
  MsgCenter:AddListener(eMsgEventId.ShopRechargeComplete, self._RefreshGoodsRecharge)
  self.texItemList = {[1] = (self.ui).tex_oldPrice, [2] = (self.ui).tex_currPrice, [3] = (self.ui).tex_Name}
end

UINShopNormalGoogsItem.InitNormalGoodsItem = function(self, goodData, purchaseRoot)
  -- function num : 0_1 , upvalues : ShopEnum, _ENV
  self.goodData = goodData
  self.purchaseRoot = purchaseRoot
  self.isRecharge = goodData.shopType == (ShopEnum.eShopType).Recharge
  if self.isRecharge then
    (((self.ui).img_CustomPic).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_CustomPic).sprite = CRH:GetSprite((goodData.goodCfg).icon)
    ;
    (self.itemWithCount):Hide()
    ;
    (((self.ui).tex_Extra).gameObject):SetActive(true)
    self.payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((goodData.goodCfg).name)
    ;
    (((self.ui).img_Quality).gameObject):SetActive(false)
  else
    (((self.ui).img_CustomPic).gameObject):SetActive(false)
    ;
    (self.itemWithCount):Show()
    ;
    (((self.ui).tex_Extra).gameObject):SetActive(false)
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((goodData.itemCfg).name)
    ;
    (self.itemWithCount):InitItemWithCount(goodData.itemCfg, goodData.itemNum)
    -- DECOMPILER ERROR at PC92: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Quality).color = ItemQualityColor[(goodData.itemCfg).quality]
  end
  self:RefreshCurrencyUI(goodData)
  self:RefreshLimitUI(goodData)
  for i = 1, #self.texItemList do
    ((self.texItemList)[i]):StartScrambleTypeWriter()
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINShopNormalGoogsItem.RefreshCurrencyUI = function(self, goodData)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if self.isRecharge then
    ((self.ui).tex_currPrice).text = (self.payCtrl):GetPayPriceShow(((self.goodData).goodCfg).pay_id)
    ;
    (((self.ui).img_priceIcon).gameObject):SetActive(false)
    local itemIdList, itemNumList = (self.payCtrl):GetPayRewards(((self.goodData).goodCfg).pay_id, (self.goodData).hasDouble)
    local content = nil
    for i = 2, #itemIdList do
      local id = itemIdList[i]
      local num = itemNumList[i]
      local itemCfg = (ConfigData.item)[id]
      if itemCfg == nil then
        error("itemCfg is nill id:" .. tostring(id))
      else
        local name = (LanguageUtil.GetLocaleText)(itemCfg.name)
        if (string.IsNullOrEmpty)(content) then
          content = ((self.ui).tex_Extra):GetIndex(0, name, tostring(num))
        else
          content = content .. "\n" .. ((self.ui).tex_Extra):GetIndex(0, name, tostring(num))
        end
      end
    end
    -- DECOMPILER ERROR at PC83: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (((self.ui).tex_Extra).text).text = content
  else
    do
      -- DECOMPILER ERROR at PC88: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).tex_currPrice).text = goodData.newCurrencyNum
      local currencyItemCfg = (ConfigData.item)[goodData.currencyId]
      do
        local smallIcon = currencyItemCfg.small_icon
        ;
        (((self.ui).img_priceIcon).gameObject):SetActive(true)
        -- DECOMPILER ERROR at PC106: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((self.ui).img_priceIcon).sprite = CRH:GetSprite(smallIcon)
        if goodData.discount == 100 then
          ((self.ui).obj_discount):SetActive(false)
          ;
          (((self.ui).tex_oldPrice).gameObject):SetActive(false)
        else
          ;
          ((self.ui).tex_Discount):SetIndex(0, tostring(100 - goodData.discount))
          -- DECOMPILER ERROR at PC134: Confused about usage of register: R2 in 'UnsetPending'

          ;
          ((self.ui).tex_oldPrice).text = goodData.oldCurrencyNum
          ;
          ((self.ui).obj_discount):SetActive(true)
          ;
          (((self.ui).tex_oldPrice).gameObject):SetActive(true)
        end
      end
    end
  end
end

UINShopNormalGoogsItem.RefreshLimitUI = function(self, goodData)
  -- function num : 0_3 , upvalues : ShopEnum, _ENV
  ((self.ui).obj_Times):SetActive(false)
  ;
  ((self.ui).obj_soldOut):SetActive(false)
  if goodData.shopType == (ShopEnum.eShopType).Charcter then
    ((self.ui).obj_soldOut):SetActive(goodData.isSoldOut)
  else
    if goodData.isLimit then
      if goodData.shopType ~= (ShopEnum.eShopType).Random then
        ((self.ui).obj_Times):SetActive(true)
        if goodData.shopType ~= (ShopEnum.eShopType).ResourceRefresh or not 0 then
          local timesTypeIndex = goodData.limitType
        end
        ;
        ((self.ui).tex_Times_type):SetIndex(timesTypeIndex)
        if goodData.totallimitTime == nil or not goodData.totallimitTime then
          local limitCount = goodData.limitTime
        end
        -- DECOMPILER ERROR at PC66: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((self.ui).tex_Times).text = tostring(limitCount - goodData.purchases) .. "/" .. tostring(limitCount)
      end
      do
        ;
        ((self.ui).obj_soldOut):SetActive(goodData.isSoldOut)
      end
    end
  end
end

UINShopNormalGoogsItem.OnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self.goodData).isSoldOut then
    return 
  end
  if self.isRecharge then
    (ControllerManager:GetController(ControllerTypeId.Shop, true)):ReqShopRecharge(((self.goodData).goodCfg).pay_id)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
    -- function num : 0_4_0 , upvalues : _ENV, self
    if win == nil then
      error("can\'t open QuickBuy win")
      return 
    end
    local resIds = {}
    ;
    (table.insert)(resIds, (self.goodData).currencyId)
    if (self.goodData).currencyId == ConstGlobalItem.PaidSubItem and not (table.contain)(resIds, ConstGlobalItem.PaidItem) then
      (table.insert)(resIds, 1, ConstGlobalItem.PaidItem)
    end
    win:SlideIn()
    win:InitBuyTarget(self.goodData, self._RefreshGoods, true, resIds)
    win:OnClickAdd(true)
  end
)
  end
end

UINShopNormalGoogsItem.OnGoodsShopRechargeSuccess = function(self, shopId)
  -- function num : 0_5
  if (self.goodData).shopId == shopId then
    (self.RefreshGoods)()
  end
end

UINShopNormalGoogsItem.RefreshGoods = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if IsNull(self.gameObject) then
    return 
  end
  self:RefreshCurrencyUI(self.goodData)
  self:RefreshLimitUI(self.goodData)
end

UINShopNormalGoogsItem.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINShopNormalGoogsItem

