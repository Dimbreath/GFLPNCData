-- params : ...
-- function num : 0 , upvalues : _ENV
local UITreasureRoomChipItem = class("UITreasureRoomChipItem", UIBaseNode)
local base = UIBaseNode
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINChipDetailPanel")
UITreasureRoomChipItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Lock, self, self.OnLockClick)
  self.panel = (UINChipDetailPanel.New)()
  ;
  (self.panel):Init((self.ui).uINChipItemDetail)
  self.lockState = false
end

UITreasureRoomChipItem.InitTreasureRoomChip = function(self, idx, chipData, dynPlayer, resloader, __onToggleChipItemClick, __onlockClickAction)
  -- function num : 0_1
  (self.panel):InitChipDetailPanel(idx, chipData, dynPlayer, resloader, __onToggleChipItemClick)
  self.idx = idx
  self.__onlockClickAction = __onlockClickAction
  self.chipId = chipData.dataId
end

UITreasureRoomChipItem.OnLockClick = function(self)
  -- function num : 0_2
  if self.__onlockClickAction ~= nil then
    (self.__onlockClickAction)(self)
  end
end

UITreasureRoomChipItem.ChangelockUi = function(self)
  -- function num : 0_3
  if self.lockState then
    ((self.ui).img_btn_Lock):SetIndex(1)
  else
    ;
    ((self.ui).img_btn_Lock):SetIndex(0)
  end
end

UITreasureRoomChipItem.GetChipDetailPanel = function(self)
  -- function num : 0_4
  return self.panel
end

UITreasureRoomChipItem.SetObjNewTagActive = function(self, active)
  -- function num : 0_5
  (self.panel):SetObjNewTagActive(active)
end

UITreasureRoomChipItem.OnDelete = function(self)
  -- function num : 0_6
end

return UITreasureRoomChipItem

