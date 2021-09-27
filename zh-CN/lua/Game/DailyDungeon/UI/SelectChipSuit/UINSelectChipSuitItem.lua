local UINSelectChipSuitItem = class("UINSelectChipSuitItem", UIBaseNode)
local base = UIBaseNode
local UINEpChipSuitItem = require("Game.Exploration.UI.ChipSuit.UINEpChipSuitItem")
UINSelectChipSuitItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEpChipSuitItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.suitItemBase = (UINEpChipSuitItem.New)()
  ;
  (self.suitItemBase):Init((self.ui).uINChipSuitItem)
  self._onSelectChipItemClick = BindCallback(self, self._OnSelectChipItemClick)
end

UINSelectChipSuitItem.InitSelectChipSuitItem = function(self, dynChipSuitData, clickCallback)
  -- function num : 0_1
  self._ClickCallback = clickCallback
  if dynChipSuitData == nil then
    (self.suitItemBase):Hide()
    ;
    ((self.ui).obj_Empty):SetActive(true)
  else
    ;
    ((self.ui).obj_Empty):SetActive(false)
    ;
    (self.suitItemBase):InitEpChipSuitItem(dynChipSuitData, self._onSelectChipItemClick)
    ;
    (self.suitItemBase):Show()
  end
end

UINSelectChipSuitItem.GetEmptyTransform = function(self)
  -- function num : 0_2
  return ((self.ui).obj_Empty).transform
end

UINSelectChipSuitItem.GetSelectChipSuitIcon = function(self)
  -- function num : 0_3
  return ((self.suitItemBase).ui).img_Icon
end

UINSelectChipSuitItem._OnSelectChipItemClick = function(self)
  -- function num : 0_4
  if self._ClickCallback ~= nil then
    (self._ClickCallback)((self.suitItemBase):GetDynChipSuit())
  end
end

UINSelectChipSuitItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.suitItemBase):Delete()
  ;
  (base.OnDelete)(self)
end

return UINSelectChipSuitItem

