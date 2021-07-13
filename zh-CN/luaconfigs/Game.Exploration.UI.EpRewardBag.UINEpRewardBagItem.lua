-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEpRewardBagItem = class("UINEpRewardBagItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local EpRewardBagUtil = require("Game.Exploration.UI.EpRewardBag.EpRewardBagUtil")
UINEpRewardBagItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
  self.baseItem = (UINBaseItemWithCount.New)()
  ;
  (self.baseItem):Init((self.ui).baseItemWithCount)
end

UINEpRewardBagItem.InitEpRewardBagItem = function(self, index, itemCfg, itemNum, price, originalPrice, selectFunc, selectable)
  -- function num : 0_1 , upvalues : EpRewardBagUtil, _ENV
  self.itemCfg = itemCfg
  self.index = index
  self.selectFunc = selectFunc
  self.selectable = selectable
  ;
  (self.baseItem):InitItemWithCount(itemCfg, itemNum)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_originalCost).text = EpRewardBagUtil:GetEpRewardItemPriceStr(originalPrice)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_Money).text = EpRewardBagUtil:GetEpRewardItemPriceStr(price)
  ;
  ((self.ui).originalPrice):SetActive(originalPrice ~= price)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_QuailtyColor).color = ItemQualityColor[itemCfg.quality]
  ;
  ((self.ui).selecttable):SetActive(selectable)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINEpRewardBagItem._OnClickRoot = function(self)
  -- function num : 0_2
  if self.selectable and self.selectFunc ~= nil then
    (self.selectFunc)(self, self.index)
  end
end

UINEpRewardBagItem.SetEpRewardBagItemSelected = function(self, selected)
  -- function num : 0_3
  ((self.ui).img_IsSelect):SetActive(selected)
end

UINEpRewardBagItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (self.baseItem):Delete()
  self.baseItem = nil
  ;
  (base.OnDelete)(self)
end

return UINEpRewardBagItem

