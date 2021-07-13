-- params : ...
-- function num : 0 , upvalues : _ENV
local UINChipDisplaceItem = class("UINChipDisplaceItem", UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
UINChipDisplaceItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.chipItem = (UINChipItem.New)()
  ;
  (self.chipItem):Init((self.ui).chipItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_chipItem, self, self.OnClickItem)
end

UINChipDisplaceItem.InitItem = function(self, chipData, onClickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.chipData = chipData
  self.onClickEvent = onClickEvent
  ;
  (self.chipItem):InitChipItem(self.chipData, true)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_QuailtyColor).color = (self.chipData):GetColor()
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (self.chipData):GetName()
  ;
  ((self.ui).tex_ChipLevel):SetIndex(0, tostring((self.chipData):GetCount()))
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_ChipTypeIcon).sprite = CRH:GetSprite(eChipCornerSprite[chipData:GetMarkIconIndex()], CommonAtlasType.ExplorationIcon)
end

UINChipDisplaceItem.OnClickItem = function(self)
  -- function num : 0_2
  if self.onClickEvent ~= nil then
    (self.onClickEvent)(self.chipData)
  end
end

UINChipDisplaceItem.SetSelectState = function(self, isSelect)
  -- function num : 0_3
  ((self.ui).img_OnSelect):SetActive(isSelect)
end

return UINChipDisplaceItem

