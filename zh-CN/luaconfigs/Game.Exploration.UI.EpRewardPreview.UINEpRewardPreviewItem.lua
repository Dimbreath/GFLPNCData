-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEpRewardPreviewItem = class("UINEpRewardPreviewItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINEpRewardPreviewItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItemWithCount.New)()
  ;
  (self.baseItem):Init((self.ui).baseItemWithCount)
end

UINEpRewardPreviewItem.InitEpRewardPreviewItem = function(self, index, previewData)
  -- function num : 0_1 , upvalues : _ENV
  self.index = index
  local itemCfg = previewData.itemCfg
  local itemNum = previewData.itemNum
  ;
  (self.baseItem):InitItemWithCount(itemCfg, itemNum)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

  if previewData.moneyIcon ~= nil then
    ((self.ui).img_Money).sprite = previewData.moneyIcon
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Money).text = previewData.priceStr
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_QuailtyColor).color = ItemQualityColor[itemCfg.quality]
end

UINEpRewardPreviewItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (self.baseItem):Delete()
  self.baseItem = nil
  ;
  (base.OnDelete)(self)
end

return UINEpRewardPreviewItem

