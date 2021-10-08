local UINEpChipDiscardItem = class("UINEpChipDiscardItem", UIBaseNode)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UINEpChipDiscardItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_storeItem, self, self.__OnStoreItemClicked)
end

UINEpChipDiscardItem.InitDiscardChipItem = function(self, discardId, chipData, clickAction, dynPlayer)
  -- function num : 0_1 , upvalues : _ENV, UINChipItem
  self.chipData = chipData
  self.clickAction = clickAction
  self.discardCfg = (ConfigData.exploration_discard)[discardId]
  self.dynPlayer = dynPlayer
  self.price = ConfigData:CalculateEpChipDiscardSalePrice(discardId, ((self.chipData).chipBattleData).level, (self.chipData):GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId()), self.dynPlayer)
  self:__showSellPrice(((ConfigData.item)[(self.discardCfg).discard_scaleId]).icon)
  self.chipItem = (UINChipItem.New)()
  ;
  (self.chipItem):Init((self.ui).chipItem)
  ;
  (self.chipItem):InitChipItem(self.chipData, true)
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (self.chipData):GetName()
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_QuailtyColor).color = (self.chipData):GetColor()
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_ChipTypeIcon).sprite = CRH:GetSprite(chipData:GetChipMarkIcon(), CommonAtlasType.ExplorationIcon)
end

UINEpChipDiscardItem.__showSellPrice = function(self, MoneyIconId)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Money).text = tostring(self.price)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Money).sprite = CRH:GetSprite(MoneyIconId)
end

UINEpChipDiscardItem.SetItemSelect = function(self, selected)
  -- function num : 0_3
  ((self.ui).img_OnSelect):SetActive(selected)
end

UINEpChipDiscardItem.__OnStoreItemClicked = function(self)
  -- function num : 0_4
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

UINEpChipDiscardItem.GetEpChipDiscardItemMoneyIconSpriteNum = function(self)
  -- function num : 0_5
  return ((self.ui).img_Money).sprite, ((self.ui).tex_Money).text
end

return UINEpChipDiscardItem

