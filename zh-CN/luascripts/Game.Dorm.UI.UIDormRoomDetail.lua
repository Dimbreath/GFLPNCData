-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormRoomDetail = class("UIDormRoomDetail", UIBaseWindow)
local base = UIBaseWindow
UIDormRoomDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnBtnReturnClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Exchange, self, self.OnBtnBuyClicked)
end

UIDormRoomDetail.InitRoomDetail = function(self, data, isShop)
  -- function num : 0_1 , upvalues : _ENV
  self.data = data
  self.isShop = isShop or false
  ;
  (((self.ui).btn_Exchange).gameObject):SetActive(isShop)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  if isShop then
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((data.itemCfg).name)
    ;
    ((self.ui).tex_Num):SetIndex(0, tostring(data.itemNum))
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Quality).color = ItemQualityColor[(data.itemCfg).quality]
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_ItemPic).sprite = CRH:GetSprite((data.itemCfg).icon)
    local roomCfg = (ConfigData.dorm_room)[(data.itemCfg).id]
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R4 in 'UnsetPending'

    if roomCfg ~= nil then
      ((self.ui).tex_Description).text = (LanguageUtil.GetLocaleText)(roomCfg.intro)
    else
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Description).text = ""
    end
    local payItemCfg = (ConfigData.item)[data.payType]
    local payItemName = ""
    if payItemCfg ~= nil then
      payItemName = (LanguageUtil.GetLocaleText)(payItemCfg.name)
    end
    ;
    ((self.ui).tex_Price):SetIndex(0, tostring(data.discountPrice), payItemName)
  end
end

UIDormRoomDetail.OnBtnBuyClicked = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if not self.isShop then
    return 
  end
  if (ControllerManager:GetController(ControllerTypeId.Shop, true)):BuyShopItem(self.data, 1) then
    self:Delete()
  end
end

UIDormRoomDetail.OnBtnReturnClicked = function(self)
  -- function num : 0_3
  self:Delete()
end

UIDormRoomDetail.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIDormRoomDetail

