-- params : ...
-- function num : 0 , upvalues : _ENV
local UILogicPreviewNodeBase = require("Game.CommonUI.LogicPreviewNode.UILogicPreviewNodeBase")
local UINQuickPurchaseLogicPreview = class("UINQuickPurchaseLogicPreview", UILogicPreviewNodeBase)
local base = UILogicPreviewNodeBase
local UINQuickPurchaseLogicLvRowItem = require("Game.QuickPurchaseBox.UINQuickPurchaseLogicLvRowItem")
UINQuickPurchaseLogicPreview.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, UINQuickPurchaseLogicLvRowItem
  (base.OnInit)(self)
  ;
  (base.InitWithClass)(self, nil, UINQuickPurchaseLogicLvRowItem)
end

UINQuickPurchaseLogicPreview.InitBuyFragPreview = function(self, intervalList, priceList, curIndex)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self._Close)
  ;
  ((self.ui).tex_SkillName):SetIndex(1)
  ;
  (((self.ui).obj_Current).gameObject):SetActive(true)
  ;
  (self.headAttrPool):HideAll()
  ;
  (self.rowItemPool):HideAll()
  local str = (string.split)(ConfigData:GetTipContent(TipContent.Shop_fragPriceDes), "|")
  local intervaTitleItem = (self.headAttrPool):GetOne()
  intervaTitleItem:InitAttrItem(str[1])
  local priceTitleItem = (self.headAttrPool):GetOne()
  priceTitleItem:InitAttrItem(str[2])
  for index = 1, #intervalList do
    local isCur = curIndex == index
    local rowItem = (self.rowItemPool):GetOne()
    rowItem:InitWithClass()
    local str = nil
    if (intervalList[index]).y == -1 then
      str = (intervalList[index]).x .. "~"
    else
      str = (intervalList[index]).x .. "~" .. (intervalList[index]).y
    end
    rowItem:InitShopItemPriveInterval(isCur, str, priceList[index])
    if isCur then
      ((self.ui).obj_Current):SetParent(rowItem.transform)
      -- DECOMPILER ERROR at PC88: Confused about usage of register: R14 in 'UnsetPending'

      ;
      ((self.ui).obj_Current).anchoredPosition = Vector2.zero
      ;
      ((self.ui).obj_Current):SetAsFirstSibling()
    end
  end
  -- DECOMPILER ERROR at PC101: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).verticalNormalizedPosition = 1 - (curIndex - 1) / (#intervalList - 1)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINQuickPurchaseLogicPreview.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINQuickPurchaseLogicPreview

