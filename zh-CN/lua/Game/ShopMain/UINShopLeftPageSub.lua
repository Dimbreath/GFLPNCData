local UINShopLeftPageSub = class("UINShopLeftPageSub", UIBaseNode)
local base = UIBaseNode
UINShopLeftPageSub.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sub, self, self.OnClickPage)
end

UINShopLeftPageSub.InitPageSub = function(self, shopId, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.shopCfg = (ConfigData.shop)[shopId]
  self.clickFunc = clickFunc
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((self.shopCfg).name)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Buttom).color = (self.ui).color_unSelectImg
  ;
  ((self.ui).obj_RedDot):SetActive(false)
  self:RefreshPageSubRedDotState()
end

UINShopLeftPageSub.OnClickPage = function(self)
  -- function num : 0_2
  if self.clickFunc ~= nil then
    (self.clickFunc)((self.shopCfg).id)
  end
end

UINShopLeftPageSub.RefreshState = function(self, selectShopId)
  -- function num : 0_3
  local selected = selectShopId == (self.shopCfg).id
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  if selected then
    ((self.ui).img_Buttom).color = (self.ui).color_selectImg
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).color_selectedText
  else
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

    ((self.ui).img_Buttom).color = (self.ui).color_unSelectImg
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).color_unSelectText
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINShopLeftPageSub.RefreshPageSubRedDotState = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((self.ui).obj_RedDot):SetActive(false)
  ;
  ((self.ui).blueDot):SetActive(false)
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, (self.shopCfg).id)
  local flag = not ok or shopNode:GetRedDotCount() > 0
  local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop)
  local isBlue = shopCtrl:IsShopBlueReddot((self.shopCfg).id)
  do
    if flag then
      if not isBlue or not (self.ui).blueDot then
        local reddotObj = (self.ui).obj_RedDot
      end
      reddotObj:SetActive(true)
    end
    do return flag, isBlue end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

UINShopLeftPageSub.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINShopLeftPageSub

