local UINShopHeroGoodsItem = class("UINShopHeroGoodsItem", UIBaseNode)
local base = UIBaseNode
local cs_ResLoader = CS.ResLoader
local ShopEnum = require("Game.Shop.ShopEnum")
local UINHeroSkinTag = require("Game.Skin.UI.UINHeroSkinTag")
UINShopHeroGoodsItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroSkinTag
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_shopItem, self, self.OnClick)
  self._RefreshGoods = BindCallback(self, self.RefreshGoods)
  self.texItemList = {[1] = (self.ui).tex_HeroName, [2] = (self.ui).tex_currPrice, [3] = (self.ui).text_subIntro}
  self.skinTagPool = (UIItemPool.New)(UINHeroSkinTag, (self.ui).tagItem)
  ;
  ((self.ui).tagItem):SetActive(false)
end

UINShopHeroGoodsItem.InitItem = function(self, resloader)
  -- function num : 0_1
  self.resloader = resloader
end

UINShopHeroGoodsItem.InitNormalGoodsItem = function(self, goodData, parentNode, purchaseRoot)
  -- function num : 0_2 , upvalues : _ENV
  self.goodData = goodData
  self.parentNode = parentNode
  self.purchaseRoot = purchaseRoot
  local itemCfg = (ConfigData.item)[(self.goodData).itemId]
  if itemCfg.type == eItemType.Skin then
    self:ShowSkinGoods()
  else
    self:ShowChipGoods()
  end
  self:RefreshCurrencyUI()
  self:RefreshLimitUI()
  for i = 1, #self.texItemList do
    ((self.texItemList)[i]):StartScrambleTypeWriter()
  end
end

UINShopHeroGoodsItem.ShowChipGoods = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).chipNode):SetActive(true)
  ;
  ((self.ui).skinNode):SetActive(false)
  local heroCfg = (ConfigData.hero_data)[((self.goodData).goodCfg).hero]
  if heroCfg == nil then
    error("heroCfg null,id:" .. tostring(((self.goodData).goodCfg).hero))
    return 
  end
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_HeroName).text = (LanguageUtil.GetLocaleText)(heroCfg.name)
  ;
  ((self.ui).text_subIntroInfo):SetIndex(0)
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
  self._finialPicName = resCfg.res_Name
  local tempPicName = resCfg.res_Name
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCharacterPicPath(tempPicName), function(texture)
    -- function num : 0_3_0 , upvalues : _ENV, self, tempPicName
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    if tempPicName == self._finialPicName then
      ((self.ui).img_Hero).texture = texture
    end
  end
)
  self._fininalCampName = campCfg.icon
  local tempCampName = campCfg.icon
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath(tempCampName), function(texture)
    -- function num : 0_3_1 , upvalues : _ENV, self, tempCampName
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    if tempCampName == self._fininalCampName then
      ((self.ui).img_Camp).texture = texture
    end
  end
)
end

UINShopHeroGoodsItem.ShowSkinGoods = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((self.ui).chipNode):SetActive(false)
  ;
  ((self.ui).skinNode):SetActive(true)
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local heroId = skinCtr:GetHeroId((self.goodData).itemId)
  local modelRes = skinCtr:GetResModel(heroId, (self.goodData).itemId)
  if modelRes == nil then
    self:Hide()
    return 
  end
  local heroCfg = (ConfigData.hero_data)[heroId]
  if heroCfg == nil then
    error("heroCfg null,id:" .. tostring(heroId))
    return 
  end
  local campCfg = (ConfigData.camp)[heroCfg.camp]
  if campCfg == nil then
    error("campCfg null,id:" .. tostring(heroCfg.camp))
    return 
  end
  self._finialPicName = modelRes.src_id_pic
  local tempPicName = modelRes.src_id_pic
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCharacterPicPath(tempPicName), function(texture)
    -- function num : 0_4_0 , upvalues : _ENV, self, tempPicName
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    if tempPicName == self._finialPicName then
      ((self.ui).img_Hero).texture = texture
    end
  end
)
  self._fininalCampName = campCfg.icon
  local tempCampName = campCfg.icon
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath(tempCampName), function(texture)
    -- function num : 0_4_1 , upvalues : _ENV, self, tempCampName
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    if tempCampName == self._fininalCampName then
      ((self.ui).img_Camp).texture = texture
    end
  end
)
  local skinCfg = (ConfigData.skin)[(self.goodData).itemId]
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_HeroName).text = (LanguageUtil.GetLocaleText)(skinCfg.name)
  local skinThem = (ConfigData.skinTheme)[skinCfg.theme]
  if skinThem ~= nil then
    ((self.ui).text_subIntroInfo):SetIndex(1, (LanguageUtil.GetLocaleText)(skinThem.name))
  else
    ;
    ((self.ui).text_subIntroInfo):SetIndex(1, "")
  end
  ;
  (self.skinTagPool):HideAll()
  do
    if skinCfg.src_id_model ~= nil and #skinCfg.src_id_model > 0 then
      local item = (self.skinTagPool):GetOne(true)
      item:InitTag(0)
      ;
      (item.gameObject):SetActive(true)
      ;
      (item.transform):SetParent(((self.ui).skinNode).transform)
    end
    local resPath = PathConsts:GetCharacterLive2DPath(skinCfg.src_id_pic)
    local haveLive2D = ((CS.ResManager).Instance):ContainsAsset(resPath)
    if haveLive2D then
      local item = (self.skinTagPool):GetOne(true)
      item:InitTag(1)
      ;
      (item.gameObject):SetActive(true)
      ;
      (item.transform):SetParent(((self.ui).skinNode).transform)
    end
  end
end

UINShopHeroGoodsItem.RefreshCurrencyUI = function(self)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_currPrice).text = (self.goodData).newCurrencyNum
  local currencyItemCfg = (ConfigData.item)[(self.goodData).currencyId]
  local smallIcon = currencyItemCfg.small_icon
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_priceIcon).sprite = CRH:GetSprite(smallIcon)
  if (self.goodData).discount == 100 then
    (((self.ui).tex_oldPrice).gameObject):SetActive(false)
  else
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_oldPrice).text = (self.goodData).oldCurrencyNum
    ;
    (((self.ui).tex_oldPrice).gameObject):SetActive(true)
  end
end

UINShopHeroGoodsItem.RefreshLimitUI = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local fragItemNum = PlayerDataCenter:GetItemCount((self.goodData).itemId)
  ;
  ((self.ui).tex_HaseCount):SetIndex(0, tostring(fragItemNum))
  ;
  ((self.ui).obj_cantBuy):SetActive((self.goodData).isSoldOut)
end

UINShopHeroGoodsItem.OnClick = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if (self.goodData).isSoldOut then
    return 
  end
  local itemCfg = (ConfigData.item)[(self.goodData).itemId]
  if itemCfg.type == eItemType.Skin then
    if (UIUtil.CheckIsHaveSpecialMarker)(UIWindowTypeID.HeroSkin) then
      (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.HeroSkin, false)
      local heroSkinUI = UIManager:GetWindow(UIWindowTypeID.HeroSkin)
      local skinId = (self.goodData).itemId
      local skinIds = {}
      for i,v in ipairs((self.parentNode).dataList) do
        (table.insert)(skinIds, v.itemId)
      end
      heroSkinUI:InitSkinBySkinList(skinId, skinIds, true, nil, heroSkinUI.closeCallback)
      return 
    end
    do
      UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkin, function(win)
    -- function num : 0_7_0 , upvalues : self, _ENV
    if win == nil then
      return 
    end
    local skinId = (self.goodData).itemId
    local skinIds = {}
    for i,v in ipairs((self.parentNode).dataList) do
      (table.insert)(skinIds, v.itemId)
    end
    win:InitSkinBySkinList(skinId, skinIds, true, nil, function()
      -- function num : 0_7_0_0 , upvalues : _ENV
      local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
      if shopWin ~= nil then
        shopWin:Show()
      end
    end
)
    local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
    if shopWin ~= nil then
      shopWin:Hide()
    end
  end
)
      UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
    -- function num : 0_7_1 , upvalues : _ENV, self
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
end

UINShopHeroGoodsItem.RefreshGoods = function(self)
  -- function num : 0_8
  self:RefreshCurrencyUI()
  self:RefreshLimitUI()
end

UINShopHeroGoodsItem.RefreshFrgNum = function(self)
  -- function num : 0_9
  self:RefreshLimitUI()
end

UINShopHeroGoodsItem.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnDelete)(self)
end

return UINShopHeroGoodsItem

