-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOverclockChipItem = class("UINOverclockChipItem", UIBaseNode)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local base = UIBaseNode
UINOverclockChipItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipItem
  self.clickCallback = nil
  self.isSelected = false
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_chipItem, self, self.OnChipItemClick)
  self.chipItem = (UINChipItem.New)()
  ;
  (self.chipItem):Init((self.ui).chipItem)
end

UINOverclockChipItem.InitOverclockChipItem = function(self, index, chipData, clickCallback)
  -- function num : 0_1
  self.index = index
  self.chipData = chipData
  ;
  (self.chipItem):InitChipItem(self.chipData)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (self.chipData):GetName()
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_QuailtyColor).color = (self.chipData):GetColor()
  local isUnlock = chipData.isUnlock
  if isUnlock then
    self.clickCallback = clickCallback
  end
  self:SetUnlockUI(isUnlock)
  self:SetSelectUI(false)
  self:Show()
end

UINOverclockChipItem.OnChipItemClick = function(self)
  -- function num : 0_2
  if not self.unlock then
    return 
  end
  if self.clickCallback ~= nil then
    (self.clickCallback)(self)
  end
end

UINOverclockChipItem.GetName = function(self)
  -- function num : 0_3
  return (self.data):GetName()
end

UINOverclockChipItem.SetSelectUI = function(self, isSelect)
  -- function num : 0_4
  self.isSelect = isSelect
  ;
  ((self.ui).obj_OnSelect):SetActive(isSelect)
end

UINOverclockChipItem.SetUnlockUI = function(self, isUnlock)
  -- function num : 0_5
  self.unlock = isUnlock
  ;
  ((self.ui).obj_Lock):SetActive(not isUnlock)
end

UINOverclockChipItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINOverclockChipItem

