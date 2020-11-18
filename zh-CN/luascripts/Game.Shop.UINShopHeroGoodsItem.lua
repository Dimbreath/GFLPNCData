-- params : ...
-- function num : 0 , upvalues : _ENV
local UINShopHeroGoodsItem = class("UINShopHeroGoodsItem", UIBaseNode)
local base = UIBaseNode
local cs_ResLoader = CS.ResLoader
local ShopEnum = require("Game.Shop.ShopEnum")
UINShopHeroGoodsItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_shopItem, self, self.OnClick)
  self._RefreshGoods = BindCallback(self, self.RefreshGoods)
  self._RefreshFrgNum = BindCallback(self, self.RefreshFrgNum)
  self.texItemList = {[1] = (self.ui).tex_HeroName, [2] = (self.ui).tex_currPrice}
end

UINShopHeroGoodsItem.InitItem = function(self, resloader)
  -- function num : 0_1
  self.resloader = resloader
end

UINShopHeroGoodsItem.InitNormalGoodsItem = function(self, goodData)
  -- function num : 0_2 , upvalues : _ENV
  self.goodData = goodData
  local heroCfg = (ConfigData.hero_data)[(goodData.goodCfg).hero]
  if heroCfg == nil then
    error("heroCfg null,id:" .. tostring((goodData.goodCfg).hero))
    return 
  end
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_HeroName).text = (LanguageUtil.GetLocaleText)(heroCfg.name)
  local resCfg = (ConfigData.resource_model)[heroCfg.src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    return 
  end
  local campCfg = (ConfigData.camp)[heroCfg.camp]
  if campCfg == nil then
    error("campCfg is null,id:" .. tostring(heroCfg.camp))
    return 
  end
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCharacterPicPath(resCfg.res_Name), function(texture)
    -- function num : 0_2_0 , upvalues : _ENV, self
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Hero).texture = texture
  end
)
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath((LanguageUtil.GetLocaleText)(campCfg.icon)), function(texture)
    -- function num : 0_2_1 , upvalues : _ENV, self
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Camp).texture = texture
  end
)
  self:RefreshCurrencyUI(goodData)
  self:RefreshLimitUI(goodData)
  for i = 1, #self.texItemList do
    ((self.texItemList)[i]):StartScrambleTypeWriter()
  end
end

UINShopHeroGoodsItem.RefreshCurrencyUI = function(self, goodData)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_currPrice).text = goodData.newCurrencyNum
  local currencyItemCfg = (ConfigData.item)[goodData.currencyId]
  local smallIcon = currencyItemCfg.small_icon
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_priceIcon).sprite = CRH:GetSprite(smallIcon)
  if goodData.discount == 100 then
    (((self.ui).tex_oldPrice).gameObject):SetActive(false)
  else
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_oldPrice).text = goodData.oldCurrencyNum
    ;
    (((self.ui).tex_oldPrice).gameObject):SetActive(true)
  end
end

UINShopHeroGoodsItem.RefreshLimitUI = function(self, goodData)
  -- function num : 0_4 , upvalues : _ENV
  local fragItemNum = PlayerDataCenter:GetItemCount(goodData.itemId)
  ;
  ((self.ui).tex_HaseCount):SetIndex(0, tostring(fragItemNum))
  if goodData.isLimit then
    ((self.ui).obj_cantBuy):SetActive(goodData.isSoldOut)
  else
    ;
    ((self.ui).obj_cantBuy):SetActive(false)
  end
end

UINShopHeroGoodsItem.OnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (self.goodData).isLimit and (self.goodData).isSoldOut then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
    -- function num : 0_5_0 , upvalues : _ENV, self
    if win == nil then
      error("can\'t open QuickBuy win")
      return 
    end
    win:SlideIn()
    win:SetRoot((self.ui).quickPurchaseRoot)
    win:InitBuyTarget(self.goodData, self._RefreshGoods)
    win:OnClickAdd()
  end
)
end

UINShopHeroGoodsItem.RefreshGoods = function(self)
  -- function num : 0_6 , upvalues : _ENV
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._RefreshFrgNum)
  self:RefreshCurrencyUI(self.goodData)
  self:RefreshLimitUI(self.goodData)
end

UINShopHeroGoodsItem.RefreshFrgNum = function(self, itemUpdate)
  -- function num : 0_7 , upvalues : _ENV
  if itemUpdate[(self.goodData).itemId] ~= nil then
    self:RefreshLimitUI(self.goodData)
    MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._RefreshFrgNum)
  end
end

UINShopHeroGoodsItem.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UINShopHeroGoodsItem

