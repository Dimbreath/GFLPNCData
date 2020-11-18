-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelChipQualityItem = class("UINLevelChipQualityItem", UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
UINLevelChipQualityItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.chipItemPool = (UIItemPool.New)(UINChipItem, (self.ui).uINChipItem)
  ;
  ((self.ui).uINChipItem):SetActive(false)
  self._OnChipClick = BindCallback(self, self.OnChipClick)
end

UINLevelChipQualityItem.InitChipQualityItem = function(self, quality, chipDataList, OnChipClickCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.OnChipClickCallback = OnChipClickCallback
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_tileLine).color = ItemQualityColor[quality]
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Quailty).color = ItemQualityColor[quality]
  ;
  ((self.ui).texInfo_Quailty):SetIndex(quality - 1)
  ;
  (self.chipItemPool):HideAll()
  for _,chipData in ipairs(chipDataList) do
    local chipItem = (self.chipItemPool):GetOne()
    chipItem:InitChipItem(chipData, false, self._OnChipClick)
  end
end

UINLevelChipQualityItem.OnChipClick = function(self, chipData, chipItem)
  -- function num : 0_2
  if self.OnChipClickCallback ~= nil then
    (self.OnChipClickCallback)(chipData, chipItem)
  end
end

UINLevelChipQualityItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINLevelChipQualityItem

