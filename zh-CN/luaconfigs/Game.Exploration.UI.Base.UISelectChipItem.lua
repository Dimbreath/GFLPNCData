-- params : ...
-- function num : 0 , upvalues : _ENV
local UISelectChipItem = class("UISelectChipItem", UIBaseNode)
local base = UIBaseNode
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")
UISelectChipItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Lock, self, self.OnLockClick)
  self.panel = (UINChipDetailPanel.New)()
  ;
  (self.panel):Init((self.ui).uINChipItemDetail)
  self.lockState = false
end

UISelectChipItem.InitSelectChipItem = function(self, idx, chipData, dynPlayer, resloader, __onToggleChipItemClick, __onlockClickAction, showLockBtn, showBuyPrice)
  -- function num : 0_1
  (self.panel):InitEpChipDetail(idx, chipData, dynPlayer, resloader, __onToggleChipItemClick, nil, nil, nil, showBuyPrice)
  self.idx = idx
  self.__onlockClickAction = __onlockClickAction
  self.chipId = chipData.dataId
  self:ShowSelectChipItemLockBtn(showLockBtn)
end

UISelectChipItem.ShowSelectChipItemLockBtn = function(self, showLockBtn)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  (((self.ui).img_btn_Lock).image).enabled = showLockBtn
end

UISelectChipItem.OnLockClick = function(self)
  -- function num : 0_3
  if self.__onlockClickAction ~= nil then
    (self.__onlockClickAction)(self)
  end
end

UISelectChipItem.SetSelectChipItemLock = function(self, lock)
  -- function num : 0_4
  self.lockState = lock
  self:ChangelockUi()
end

UISelectChipItem.ChangelockUi = function(self)
  -- function num : 0_5
  if self.lockState then
    ((self.ui).img_btn_Lock):SetIndex(1)
  else
    ;
    ((self.ui).img_btn_Lock):SetIndex(0)
  end
end

UISelectChipItem.GetChipDetailPanel = function(self)
  -- function num : 0_6
  return self.panel
end

UISelectChipItem.GetChipItemData = function(self)
  -- function num : 0_7
  if self.panel ~= nil then
    return (self.panel):GetChipDetailPanelData()
  end
  return nil
end

UISelectChipItem.SetObjNewTagActive = function(self, active, showState)
  -- function num : 0_8
  (self.panel):SetObjNewTagActive(active, showState)
end

UISelectChipItem.SetTRModifier = function(self, uiModifier)
  -- function num : 0_9
  (self.panel):SetUIModifier(uiModifier)
end

UISelectChipItem.SetSelectChipItemSold = function(self, sold, soldGoPrefab)
  -- function num : 0_10 , upvalues : _ENV
  if sold and self._soldGo == nil then
    self._soldGo = soldGoPrefab:Instantiate((self.panel).transform)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._soldGo).transform).anchoredPosition = Vector2.zero
  end
  ;
  (self.panel):EnableChipDetailPanelClick(not sold)
  if sold then
    (self._soldGo):SetActive(true)
  else
    if not IsNull(self._soldGo) then
      (self._soldGo):SetActive(false)
    end
  end
end

UISelectChipItem.OnDelete = function(self)
  -- function num : 0_11
  (self.panel):OnDelete()
end

return UISelectChipItem

