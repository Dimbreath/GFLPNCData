-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpUpgradeRoomItem = class("UIEpUpgradeRoomItem", UIBaseNode)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
UIEpUpgradeRoomItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_chipItem, self, self.__OnChipItemClicked)
end

UIEpUpgradeRoomItem.InitUpgradeRoomItem = function(self, roomId, moneyIconId, price, chipData, clickAction)
  -- function num : 0_1 , upvalues : UINChipItem, _ENV
  self.upgradeRoomId = roomId
  self.chipData = chipData
  self.index = chipData.idx
  self.clickAction = clickAction
  local chipItem = (UINChipItem.New)()
  chipItem:Init((self.ui).chipItem)
  chipItem:InitChipItem(self.chipData)
  self.chipItem = chipItem
  self.upgradePrice = price
  self:__ShowPrice(self.upgradePrice, moneyIconId)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (self.chipData):GetName()
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_QuailtyColor).color = (self.chipData):GetColor()
  ;
  ((self.ui).tex_ChipLevel):SetIndex(0, tostring((self.chipData):GetCount()))
end

UIEpUpgradeRoomItem.__ShowPrice = function(self, price, MoneyIconId)
  -- function num : 0_2 , upvalues : _ENV
  ((self.ui).originalPrice):SetActive(false)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Money).text = tostring(price)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Money).sprite = CRH:GetSprite(MoneyIconId)
end

UIEpUpgradeRoomItem.SetChipItemSelect = function(self, selected)
  -- function num : 0_3
  ((self.ui).img_OnSelect):SetActive(selected)
end

UIEpUpgradeRoomItem.__OnChipItemClicked = function(self)
  -- function num : 0_4
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

UIEpUpgradeRoomItem.GetChipItemName = function(self)
  -- function num : 0_5
  return (self.chipData):GetName()
end

UIEpUpgradeRoomItem.GetChipItem = function(self)
  -- function num : 0_6
  return self.chipItem
end

return UIEpUpgradeRoomItem

