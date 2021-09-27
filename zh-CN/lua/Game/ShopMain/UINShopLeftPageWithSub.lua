local UINShopLeftPageWithSub = class("UINShopLeftPageWithSub", UIBaseNode)
local base = UIBaseNode
local UINShopLeftPageSub = require("Game.ShopMain.UINShopLeftPageSub")
UINShopLeftPageWithSub.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINShopLeftPageSub
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.subPool = (UIItemPool.New)(UINShopLeftPageSub, (self.ui).obj_btn_Sub)
  ;
  ((self.ui).obj_btn_Sub):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Main, self, self.OnClickPage)
end

UINShopLeftPageWithSub.InitPage = function(self, id, clickShopFunc, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.leftPageCfg = (ConfigData.shop_classification)[id]
  self.clickShopFunc = clickShopFunc
  ;
  ((self.ui).obj_RedDot):SetActive(false)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((self.leftPageCfg).name)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_NameEn).text = (LanguageUtil.GetLocaleText)((self.leftPageCfg).name_en)
  ;
  (self.subPool):HideAll()
  local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop)
  for i,v in ipairs((self.leftPageCfg).sub_ids) do
    if shopCtrl:ShopIsUnlock(v) then
      local item = (self.subPool):GetOne(true)
      ;
      (item.gameObject):SetActive(true)
      ;
      (item.transform):SetParent(((self.ui).subList).transform)
      item:InitPageSub(v, self.clickShopFunc)
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (item.gameObject).name = v
    end
  end
  self:RefreshRedDotState()
  -- DECOMPILER ERROR at PC77: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = (AtlasUtil.GetSpriteFromAtlas)("UI_Shop", (self.leftPageCfg).icon, resloader)
  ;
  ((self.ui).img_Buttom):SetIndex(1)
  -- DECOMPILER ERROR at PC87: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).color = (self.ui).color_selectedText
  -- DECOMPILER ERROR at PC92: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_NameEn).color = (self.ui).color_selectedText
  ;
  ((self.ui).subList):SetActive(false)
end

UINShopLeftPageWithSub.InitSpecialPage = function(self, id, clickShopFunc, resloader, markShop)
  -- function num : 0_2 , upvalues : _ENV
  self.leftPageCfg = (ConfigData.shop_classification)[id]
  self.clickShopFunc = clickShopFunc
  ;
  ((self.ui).obj_RedDot):SetActive(false)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((self.leftPageCfg).name)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_NameEn).text = (LanguageUtil.GetLocaleText)((self.leftPageCfg).name_en)
  ;
  (self.subPool):HideAll()
  local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop)
  for i,v in ipairs(markShop) do
    if shopCtrl:ShopIsUnlock(v) then
      local item = (self.subPool):GetOne(true)
      ;
      (item.gameObject):SetActive(true)
      ;
      (item.transform):SetParent(((self.ui).subList).transform)
      item:InitPageSub(v, self.clickShopFunc)
    end
  end
  self:RefreshRedDotState()
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = (AtlasUtil.GetSpriteFromAtlas)("UI_Shop", (self.leftPageCfg).icon, resloader)
  ;
  ((self.ui).img_Buttom):SetIndex(1)
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).color = (self.ui).color_selectedText
  -- DECOMPILER ERROR at PC89: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_NameEn).color = (self.ui).color_selectedText
  ;
  ((self.ui).subList):SetActive(false)
end

UINShopLeftPageWithSub.OnClickPage = function(self)
  -- function num : 0_3
  if ((self.ui).subList).activeSelf then
    ((self.ui).subList):SetActive(false)
  else
    ;
    ((self.ui).subList):SetActive(true)
    ;
    (((self.subPool).listItem)[1]):OnClickPage()
  end
end

UINShopLeftPageWithSub.ContainShopId = function(self, shopId)
  -- function num : 0_4
  for i = 1, #(self.subPool).listItem do
    if ((((self.subPool).listItem)[i]).shopCfg).id == shopId then
      return true
    end
  end
  return false
end

UINShopLeftPageWithSub.RefreshState = function(self, selectShopId)
  -- function num : 0_5
  local seleted = false
  for i = 1, #(self.subPool).listItem do
    (((self.subPool).listItem)[i]):RefreshState(selectShopId)
    if ((((self.subPool).listItem)[i]).shopCfg).id == selectShopId then
      seleted = true
    end
  end
  ;
  ((self.ui).subList):SetActive(seleted)
  if seleted then
    ((self.ui).img_Buttom):SetIndex(1)
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).color_selectedText
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_NameEn).color = (self.ui).color_selectedText
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).color = (self.ui).color_selectedText
  else
    ;
    ((self.ui).img_Buttom):SetIndex(0)
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).color_unSelectText
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_NameEn).color = (self.ui).color_unSelectText
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).color = (self.ui).color_unSelectText
  end
end

UINShopLeftPageWithSub.RefreshRedDotState = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((self.ui).obj_RedDot):SetActive(false)
  ;
  ((self.ui).blueDot):SetActive(false)
  local flag = false
  local isBlue = true
  for i,v in ipairs((self.subPool).listItem) do
    local tempFlag, tempIsBlue = v:RefreshPageSubRedDotState()
    if tempFlag then
      flag = true
      if not tempIsBlue then
        isBlue = false
      end
    end
  end
  do
    if flag then
      if not isBlue or not (self.ui).blueDot then
        local reddotObj = (self.ui).obj_RedDot
      end
      reddotObj:SetActive(true)
    end
  end
end

UINShopLeftPageWithSub.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (self.subPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINShopLeftPageWithSub

