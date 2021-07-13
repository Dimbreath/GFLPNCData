-- params : ...
-- function num : 0 , upvalues : _ENV
local UINShopLeftPage = class("UINShopLeftPage", UIBaseNode)
local base = UIBaseNode
UINShopLeftPage.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Page, self, self.OnClickPage)
end

UINShopLeftPage.InitPage = function(self, id, clickShopFunc, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.leftPageCfg = (ConfigData.shop_classification)[id]
  self.clickShopFunc = clickShopFunc
  ;
  ((self.ui).obj_RedDot):SetActive(false)
  ;
  ((self.ui).img_Buttom):SetIndex(0)
  local shopId = ((self.leftPageCfg).sub_ids)[1]
  self.shopCfg = (ConfigData.shop)[shopId]
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((self.shopCfg).name)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_NameEn).text = (LanguageUtil.GetLocaleText)((self.shopCfg).name_en)
  self:RefreshRedDotState()
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = (AtlasUtil.GetSpriteFromAtlas)("UI_Shop", (self.leftPageCfg).icon, resloader)
end

UINShopLeftPage.OnClickPage = function(self)
  -- function num : 0_2
  if self.shopCfg ~= nil and self.clickShopFunc ~= nil then
    (self.clickShopFunc)((self.shopCfg).id)
  end
end

UINShopLeftPage.ContainShopId = function(self, shopId)
  -- function num : 0_3
  do return (self.shopCfg).id == shopId end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINShopLeftPage.RefreshState = function(self, selectShopId)
  -- function num : 0_4
  local selected = selectShopId == (self.shopCfg).id
  if selected then
    ((self.ui).img_Buttom):SetIndex(1)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).color_selectedText
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_NameEn).color = (self.ui).color_selectedText
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).color = (self.ui).color_selectedText
  else
    ((self.ui).img_Buttom):SetIndex(0)
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).color_unSelectText
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_NameEn).color = (self.ui).color_unSelectText
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).color = (self.ui).color_unSelectText
  end
  do return selected end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINShopLeftPage.RefreshRedDotState = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((self.ui).obj_RedDot):SetActive(false)
  ;
  ((self.ui).blueDot):SetActive(false)
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, (self.shopCfg).id)
  if ok and shopNode:GetRedDotCount() > 0 then
    local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop)
    if shopCtrl:IsShopBlueReddot((self.shopCfg).id) then
      ((self.ui).blueDot):SetActive(true)
    else
      ;
      ((self.ui).obj_RedDot):SetActive(true)
    end
  end
end

UINShopLeftPage.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINShopLeftPage

