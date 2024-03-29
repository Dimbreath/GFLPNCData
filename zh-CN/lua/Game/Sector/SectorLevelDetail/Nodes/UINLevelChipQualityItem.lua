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

UINLevelChipQualityItem.InitChipQualityItem = function(self, quality, chipDataList, OnChipClickCallback, isInitChip)
  -- function num : 0_1 , upvalues : _ENV
  self.OnChipClickCallback = OnChipClickCallback
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

  if isInitChip then
    ((self.ui).img_tileLine).color = ItemQualityColor[quality]
    ;
    ((self.ui).texInfo_Quailty):SetIndex(quality)
    ;
    (self.chipItemPool):HideAll()
  else
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_tileLine).color = ItemQualityColor[quality]
    ;
    ((self.ui).texInfo_Quailty):SetIndex(quality - 1)
    ;
    (self.chipItemPool):HideAll()
  end
  for _,chipData in ipairs(chipDataList) do
    local chipItem = (self.chipItemPool):GetOne()
    chipItem:InitChipItem(chipData, false, self._OnChipClick)
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (chipItem.ui).img_lock = ((chipItem.transform):FindComponent("Img_isLock", eUnityComponentID.Image)).gameObject
    ;
    ((chipItem.ui).img_lock):SetActive(chipData.isLock)
  end
end

UINLevelChipQualityItem.OnChipClick = function(self, chipData, chipItem)
  -- function num : 0_2 , upvalues : _ENV
  if chipData.isLock then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.exploration_Level_Chip_Unlock))
    ;
    (self.OnChipClickCallback)()
    return 
  end
  if self.OnChipClickCallback ~= nil then
    (self.OnChipClickCallback)(chipData, chipItem)
  end
end

UINLevelChipQualityItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINLevelChipQualityItem

