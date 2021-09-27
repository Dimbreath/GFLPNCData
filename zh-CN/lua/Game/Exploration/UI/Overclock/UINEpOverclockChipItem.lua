local UINEpOverclockChipItem = class("UINEpOverclockChipItem", UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
UINEpOverclockChipItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_chipItem, self, self.OnChipItemClick)
  self.chipItem = (UINChipItem.New)()
  ;
  (self.chipItem):Init((self.ui).chipItem)
end

UINEpOverclockChipItem.InitOverclockChipItem = function(self, index, chipData, clickCallback)
  -- function num : 0_1
  self.index = index
  self.chipData = chipData
  ;
  (self.chipItem):InitChipItem(self.chipData, true)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (self.chipData):GetName()
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_QuailtyColor).color = (self.chipData):GetColor()
  self.clickCallback = clickCallback
  self:SetUnlockUI(true)
  self:SetSelectUI(false)
  self:Show()
end

UINEpOverclockChipItem.OnChipItemClick = function(self)
  -- function num : 0_2
  if not self.unlock then
    return 
  end
  if self.clickCallback ~= nil then
    (self.clickCallback)(self)
  end
end

UINEpOverclockChipItem.SetSelectUI = function(self, isSelect)
  -- function num : 0_3
  self.isSelect = isSelect
  ;
  ((self.ui).obj_OnSelect):SetActive(isSelect)
end

UINEpOverclockChipItem.SetUnlockUI = function(self, isUnlock)
  -- function num : 0_4
  self.unlock = isUnlock
  ;
  ((self.ui).obj_Lock):SetActive(not isUnlock)
end

UINEpOverclockChipItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINEpOverclockChipItem

