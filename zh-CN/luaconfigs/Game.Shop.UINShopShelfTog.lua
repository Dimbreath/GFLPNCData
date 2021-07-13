-- params : ...
-- function num : 0 , upvalues : _ENV
local UINShopShelfTog = class("UINShopShelfTog", UIBaseNode)
local base = UIBaseNode
UINShopShelfTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_ShelfType, self, self.OnValueChage)
  self.__RedDotEvent = BindCallback(self, self.RefreshShelfTogReddot)
end

UINShopShelfTog.InitShelfTog = function(self, shopData, pageId, shopId, refreshGoodsCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.shopData = shopData
  self.pageId = pageId
  self.shopId = shopId
  self.refreshGoodsCallback = refreshGoodsCallback
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  if self.shopData ~= nil then
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(((shopData.shopPagesDic)[pageId]).name)
  else
    local pageCfg = (ConfigData.shop_page)[self.pageId]
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(pageCfg.page)
  end
  do
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

    if ((self.ui).tog_ShelfType).isOn then
      ((self.ui).tog_ShelfType).isOn = false
    else
      ;
      (((self.ui).img_Select).gameObject):SetActive(false)
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_Name).color = (self.ui).color_unSelect
    end
    self:RefreshShelfTogReddot()
    RedDotController:RemoveListener(RedDotDynPath.ShopPath, self.__RedDotEvent)
    RedDotController:AddListener(RedDotDynPath.ShopPath, self.__RedDotEvent)
  end
end

UINShopShelfTog.OnValueChage = function(self, bool)
  -- function num : 0_2 , upvalues : _ENV
  if bool then
    if self.refreshGoodsCallback ~= nil then
      (self.refreshGoodsCallback)(self.shopData, self.pageId)
    end
    ;
    (((self.ui).img_Select).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).color_selected
    if not self._inSetSelected and (ConfigData.shop_page)[self.pageId] ~= nil then
      local auId = ((ConfigData.shop_page)[self.pageId]).click_audio
      if auId == 0 then
        auId = 1060
      end
      AudioManager:PlayAudioById(auId)
    end
  else
    do
      ;
      (((self.ui).img_Select).gameObject):SetActive(false)
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).tex_Name).color = (self.ui).color_unSelect
    end
  end
end

UINShopShelfTog.SetSelected = function(self, bool)
  -- function num : 0_3
  self._inSetSelected = true
  if ((self.ui).tog_ShelfType).isOn == bool then
    self:OnValueChage(bool)
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tog_ShelfType).isOn = bool
  end
  self._inSetSelected = false
end

UINShopShelfTog.RefreshShelfTogReddot = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, self.shopId, self.pageId)
  ;
  ((self.ui).obj_RedDot):SetActive(not ok or shopNode:GetRedDotCount() > 0)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINShopShelfTog.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  RedDotController:RemoveListener(RedDotDynPath.ShopPath, self.__RedDotEvent)
  ;
  (base.OnDelete)(self)
end

return UINShopShelfTog

