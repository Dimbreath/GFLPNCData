local UINLogicPreviewRowBase = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
local UINQuickPurchaseLogicLvRowItem = class("UINQuickPurchaseLogicLvRowItem", UINLogicPreviewRowBase)
local base = UINLogicPreviewRowBase
UINQuickPurchaseLogicLvRowItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : base
  (base.OnInit)(self)
end

UINQuickPurchaseLogicLvRowItem.InitShopItemPriveInterval = function(self, isCur, interval, price)
  -- function num : 0_1 , upvalues : _ENV
  (self.attrPool):HideAll()
  local attrItem = (self.attrPool):GetOne()
  attrItem:InitAttrItem(tostring(interval), isCur)
  local attrItem = (self.attrPool):GetOne()
  attrItem:InitAttrItem(tostring(price), isCur)
end

UINQuickPurchaseLogicLvRowItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINQuickPurchaseLogicLvRowItem

