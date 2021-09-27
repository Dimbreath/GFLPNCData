local UIEpStoreRoomItem = class("UIEpStoreRoomItem", UIBaseNode)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
UIEpStoreRoomItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_storeItem, self, self.__OnStoreItemClicked)
end

UIEpStoreRoomItem.InitStoreRoomItem = function(self, roomId, storeData, MoneyIconId, clickAction, isSell, dynPlayer)
  -- function num : 0_1 , upvalues : _ENV, UINChipItem
  ((self.ui).img_SellOut):SetActive(false)
  self.storeRoomId = roomId
  if isSell then
    self.chipData = storeData
    local buyPrice = (self.chipData):GetChipBuyPrice(ExplorationManager:GetEpModuleId())
    self.epDiscountPriceCfg = (ConfigData.exploration_shop)[self.storeRoomId]
    self.salePrice = ConfigData:CalculateEpChipSalePrice(self.storeRoomId, (self.chipData):GetCount(), buyPrice, dynPlayer)
    self:__showSellPrice(buyPrice, self.salePrice, ((ConfigData.item)[(self.epDiscountPriceCfg).currency]).icon)
    ;
    (((self.ui).itemTitle).gameObject):SetActive(true)
  else
    do
      self.epStoreItemData = storeData
      self.chipData = storeData.chipData
      do
        local buyPrice = (self.chipData):GetChipBuyPrice(ExplorationManager:GetEpModuleId())
        self:__ShowPrice(buyPrice, storeData.discount, MoneyIconId)
        self:__ShowSaledType(storeData.saled)
        ;
        (((self.ui).itemTitle).gameObject):SetActive(not storeData.saled)
        ;
        ((self.ui).itemTitle):SetIndex(isSell and 1 or 0)
        -- DECOMPILER ERROR at PC91: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((self.ui).img_ChipTypeIcon).sprite = CRH:GetSprite((self.chipData):GetChipMarkIcon(), CommonAtlasType.ExplorationIcon)
        self.index = storeData.idx
        self.clickAction = clickAction
        local chipItem = (UINChipItem.New)()
        chipItem:Init((self.ui).chipItem)
        chipItem:InitChipItem(self.chipData, true)
        self.chipItem = chipItem
        if not isSell then
          (self.chipItem):UpdateChipItem(dynPlayer)
        end
        -- DECOMPILER ERROR at PC117: Confused about usage of register: R8 in 'UnsetPending'

        ;
        ((self.ui).tex_ItemName).text = (self.chipData):GetName()
        -- DECOMPILER ERROR at PC123: Confused about usage of register: R8 in 'UnsetPending'

        ;
        ((self.ui).img_QuailtyColor).color = (self.chipData):GetColor()
        self:SetNewTagActive(false)
      end
    end
  end
end

UIEpStoreRoomItem.__ShowSaledType = function(self, isSaled)
  -- function num : 0_2
  ((self.ui).img_SellOut):SetActive(isSaled)
end

UIEpStoreRoomItem.__showSellPrice = function(self, originPrice, price, MoneyIconId)
  -- function num : 0_3 , upvalues : _ENV
  self.price = price
  ;
  ((self.ui).discountNode):SetActive(false)
  ;
  ((self.ui).originalPrice):SetActive(false)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Money).text = tostring(self.price)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Money).sprite = CRH:GetSprite(MoneyIconId)
end

UIEpStoreRoomItem.__ShowPrice = function(self, price, discount, MoneyIconId)
  -- function num : 0_4 , upvalues : _ENV
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

UIEpStoreRoomItem.SetStoreItemSelect = function(self, selected)
  -- function num : 0_5 , upvalues : _ENV
  if selected then
    (((self.ui).img_OnSelect).transform):SetParent(self.transform)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).img_OnSelect).transform).anchoredPosition = Vector2.zero
  end
end

UIEpStoreRoomItem.__OnStoreItemClicked = function(self)
  -- function num : 0_6
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

UIEpStoreRoomItem.GetStoreItemName = function(self)
  -- function num : 0_7
  return (self.chipData):GetName()
end

UIEpStoreRoomItem.GetStoreChipItem = function(self)
  -- function num : 0_8
  return self.chipItem
end

UIEpStoreRoomItem.SetNewTagActive = function(self, active, chipShowState)
  -- function num : 0_9 , upvalues : _ENV, ChipEnum
  if IsNull((self.ui).img_isNew) then
    return 
  end
  ;
  (((self.ui).img_isNew).gameObject):SetActive(active)
  if active then
    if chipShowState == (ChipEnum.eChipShowState).UpState then
      ((self.ui).img_isNew):SetIndex(1)
    else
      if chipShowState == (ChipEnum.eChipShowState).NewState then
        ((self.ui).img_isNew):SetIndex(0)
      else
        ;
        (((self.ui).img_isNew).gameObject):SetActive(false)
      end
    end
  end
end

return UIEpStoreRoomItem

