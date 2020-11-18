-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEpChipDiscardItem = class("UINEpChipDiscardItem", UIBaseNode)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
UINEpChipDiscardItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_storeItem, self, self.__OnStoreItemClicked)
end

UINEpChipDiscardItem.InitDiscardChipItem = function(self, discardId, chipData, clickAction)
  -- function num : 0_1 , upvalues : _ENV, UINChipItem
  self.chipData = chipData
  self.clickAction = clickAction
  self.discardCfg = (ConfigData.exploration_discard)[discardId]
  self.price = self:m_CalculateEpChipSalePrice(((self.chipData).chipBattleData).level, ((self.chipData).itemCfg).price)
  self:__showSellPrice(((ConfigData.item)[(self.discardCfg).discard_scaleId]).icon)
  self.chipItem = (UINChipItem.New)()
  ;
  (self.chipItem):Init((self.ui).chipItem)
  ;
  (self.chipItem):InitChipItem(self.chipData)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (self.chipData):GetName()
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_QuailtyColor).color = (self.chipData):GetColor()
  ;
  ((self.ui).tex_ChipLevel):SetIndex(0, tostring((self.chipData):GetCount()))
end

UINEpChipDiscardItem.m_CalculateEpChipSalePrice = function(self, chipLvl, chipPrice)
  -- function num : 0_2
  local levelCfg = (self.discardCfg).discard_level
  local discountCfg = (self.discardCfg).discard_scaleValues
  local levelCount = #levelCfg
  for i = 1, levelCount do
    -- DECOMPILER ERROR at PC18: Unhandled construct in 'MakeBoolean' P1

    if i <= 1 and chipLvl <= levelCfg[1] then
      return chipPrice * discountCfg[1] * chipLvl // 1000
    end
    -- DECOMPILER ERROR at PC30: Unhandled construct in 'MakeBoolean' P1

    if levelCount <= i and levelCfg[i - 1] < chipLvl then
      return chipPrice * discountCfg[i] * chipLvl // 1000
    end
    if levelCfg[i - 1] < chipLvl and chipLvl <= levelCfg[i] then
      return chipPrice * discountCfg[i] * chipLvl // 1000
    end
  end
  return chipPrice
end

UINEpChipDiscardItem.__showSellPrice = function(self, MoneyIconId)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Money).text = tostring(self.price)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Money).sprite = CRH:GetSprite(MoneyIconId)
end

UINEpChipDiscardItem.SetItemSelect = function(self, selected)
  -- function num : 0_4
  ((self.ui).img_OnSelect):SetActive(selected)
end

UINEpChipDiscardItem.__OnStoreItemClicked = function(self)
  -- function num : 0_5
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

return UINEpChipDiscardItem

