local UIResetRoomChip = class("UIResetRoomChip", UIBaseNode)
local base = UIBaseNode
local UINChipItemWithName = require("Game.CommonUI.Item.UINChipItemWithName")
UIResetRoomChip.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipItemWithName
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Item, self, self.OnButtonClick)
  self.ChipItem = (UINChipItemWithName.New)()
  ;
  (self.ChipItem):Init((self.ui).chipItem)
  ;
  ((self.ui).onSelect):SetActive(false)
end

UIResetRoomChip.InitChipItem = function(self, chipData, chipCount, clickAction)
  -- function num : 0_1
  self.chipData = chipData
  self.dataId = chipData.dataId
  self.count = chipData:GetCount()
  self.clickAction = clickAction
  self.selectCount = 0
  ;
  (self.ChipItem):InitChipItem(chipData, chipCount, nil)
  ;
  (self.ChipItem):UpdateChipItem()
  ;
  (((self.ui).onSelect).transform):SetAsLastSibling()
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).btn_Item).enabled = true
  self:UpdateCountUI(0)
end

UIResetRoomChip.UpdateCountUI = function(self, selectCount)
  -- function num : 0_2 , upvalues : _ENV
  if selectCount > 0 then
    self:OnSelectUI(true)
    ;
    (((self.ui).tex_ChipCount).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_ChipCount).text = tostring(selectCount)
    self.selectCount = selectCount + 1
  else
    self:OnSelectUI(false)
  end
end

UIResetRoomChip.OnSelectUI = function(self, active)
  -- function num : 0_3
  ((self.ui).onSelect):SetActive(active)
  ;
  (((self.ui).tex_ChipCount).gameObject):SetActive(not active)
end

UIResetRoomChip.CanSelect = function(self)
  -- function num : 0_4
  do return self.selectCount <= self.count end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIResetRoomChip.OnButtonClick = function(self)
  -- function num : 0_5
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

UIResetRoomChip.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UIResetRoomChip

