local UINShopNormalGoogsItem = require("Game.Shop.UINShopNormalGoogsItem")
local base = UINShopNormalGoogsItem
local UINShopFntItem = class("UINShopFntItem", base)
local ShopEnum = require("Game.Shop.ShopEnum")
UINShopFntItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : base
  (base.OnInit)(self)
end

UINShopFntItem.InitNormalGoodsItem = function(self, goodData, purchaseRoot, refreshFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.goodData = goodData
  self.purchaseRoot = purchaseRoot
  self.refreshFunc = refreshFunc
  self.isRecharge = false
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((goodData.itemCfg).name)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite((goodData.itemCfg).icon)
  self:RefreshCurrencyUI(goodData)
  self:RefreshLimitUI(goodData)
  ;
  ((self.ui).soldOut):SetActive((self.goodData).isSoldOut)
  for i = 1, #self.texItemList do
    ((self.texItemList)[i]):StartScrambleTypeWriter()
  end
  self:InitDormFntInfo(goodData)
end

UINShopFntItem.InitDormFntInfo = function(self, goodData)
  -- function num : 0_2 , upvalues : _ENV
  local fntCfg = (ConfigData.dorm_furniture)[(goodData.itemCfg).id]
  if fntCfg == nil then
    error("can\'t not find dorm fnt cfg,id:" .. tostring((goodData.itemCfg).id))
    return 
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Comfort).text = tostring(fntCfg.comfort)
end

UINShopFntItem.RefreshLimitUI = function(self, goodData)
  -- function num : 0_3 , upvalues : ShopEnum, _ENV
  ((self.ui).obj_Times):SetActive(false)
  if goodData.isLimit and goodData.shopType ~= (ShopEnum.eShopType).Random then
    ((self.ui).obj_Times):SetActive(true)
    if goodData.shopType ~= (ShopEnum.eShopType).ResourceRefresh or not 0 then
      local timesTypeIndex = goodData.limitType
    end
    ;
    ((self.ui).tex_Times_type):SetIndex(timesTypeIndex)
    if goodData.totallimitTime == nil or not goodData.totallimitTime then
      local limitCount = goodData.limitTime
    end
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Times).text = tostring(limitCount - goodData.purchases) .. "/" .. tostring(limitCount)
  end
end

UINShopFntItem.RefreshGoods = function(self)
  -- function num : 0_4
  if self.refreshFunc ~= nil then
    (self.refreshFunc)()
  end
end

return UINShopFntItem

