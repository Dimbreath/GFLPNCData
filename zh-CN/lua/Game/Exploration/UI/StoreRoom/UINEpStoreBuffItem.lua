local UINEpStoreBuffItem = class("UINEpStoreBuffItem", UIBaseNode)
local base = UIBaseNode
UINEpStoreBuffItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
end

UINEpStoreBuffItem.InitEpStoreBuffItem = function(self, storeData, MoneyIconId, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.clickFunc = clickFunc
  self.epStoreItemData = storeData
  local dynBuffData = storeData.epBuffData
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = dynBuffData:GetEpBuffName()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = dynBuffData:GetEpBuffIcon()
  local buyPrice = dynBuffData:GetEpBuffBuyPrice(ExplorationManager:GetEpModuleId())
  local discount = storeData.discount
  self:__ShowPrice(buyPrice, discount, MoneyIconId)
  ;
  ((self.ui).img_SellOut):SetActive(storeData.saled)
end

UINEpStoreBuffItem.__ShowPrice = function(self, price, discount, MoneyIconId)
  -- function num : 0_2 , upvalues : _ENV
  self.price = price
  local hasDiscount = false
  if discount == 100 then
    hasDiscount = true
    ;
    ((self.ui).tex_Discount):SetIndex(0, tostring(100 - discount))
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_originalCost).text = tostring(self.price)
    self.price = (math.ceil)(self.price * discount / 100)
    ;
    ((self.ui).discountNode):SetActive(hasDiscount)
    ;
    ((self.ui).originalPrice):SetActive(hasDiscount)
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_Money).text = tostring(self.price)
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_Money).sprite = CRH:GetSprite(MoneyIconId)
  end
end

UINEpStoreBuffItem.SetStoreBuffItemSelect = function(self, selected)
  -- function num : 0_3 , upvalues : _ENV
  if selected then
    (((self.ui).img_OnSelect).transform):SetParent(self.transform)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).img_OnSelect).transform).anchoredPosition = Vector2.zero
  end
end

UINEpStoreBuffItem._OnClickRoot = function(self)
  -- function num : 0_4
  if self.clickFunc ~= nil then
    (self.clickFunc)(self)
  end
end

UINEpStoreBuffItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINEpStoreBuffItem

