local UISelectChipItem = class("UISelectChipItem", UIBaseNode)
local base = UIBaseNode
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")
UISelectChipItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self._onlockClick = BindCallback(self, self._OnlockClick)
  self._onSelectClick = BindCallback(self, self._OnSelectClick)
  self.panel = (UINChipDetailPanel.New)()
  ;
  (self.panel):Init((self.ui).uINChipItemDetail)
  self.lockState = false
end

UISelectChipItem.InitSelectChipItem = function(self, idx, chipData, dynPlayer, resloader, __onChipItemSelectClick, __onlockClickAction, showLockBtn, showBuyPrice)
  -- function num : 0_1
  (self.panel):InitEpChipDetail(idx, chipData, dynPlayer, resloader, nil, nil, nil)
  self.idx = idx
  self.chipId = chipData.dataId
  self._selectFunc = __onChipItemSelectClick
  self.__onlockClickAction = __onlockClickAction
  self.buttonGroup = (self.panel):GetDetailButtonGroup()
  if showBuyPrice then
    (self.buttonGroup):InitBtnSelByCost(true, nil, self._onSelectClick)
  else
    ;
    (self.buttonGroup):InitBtnSelect(self._onSelectClick)
  end
  ;
  (self.buttonGroup):SetLockCallback(self._onlockClick)
  self:ShowSelectChipItemLockBtn(showLockBtn)
end

UISelectChipItem._OnlockClick = function(self)
  -- function num : 0_2
  if self.__onlockClickAction ~= nil then
    (self.__onlockClickAction)(self)
  end
end

UISelectChipItem._OnSelectClick = function(self)
  -- function num : 0_3
  if self._selectFunc ~= nil then
    (self._selectFunc)(self.panel)
  end
end

UISelectChipItem.ShowSelectChipItemLockBtn = function(self, showLockBtn)
  -- function num : 0_4
  (self.buttonGroup):SetLockGoActive(showLockBtn)
end

UISelectChipItem.SetSelectChipItemLock = function(self, lock)
  -- function num : 0_5
  self.lockState = lock
  ;
  (self.buttonGroup):SetLockState(self.lockState)
end

UISelectChipItem.ChangelockUi = function(self)
  -- function num : 0_6
  (self.buttonGroup):SetLockState(self.lockState)
end

UISelectChipItem.GetChipDetailPanel = function(self)
  -- function num : 0_7
  return self.panel
end

UISelectChipItem.GetChipItemData = function(self)
  -- function num : 0_8
  if self.panel ~= nil then
    return (self.panel):GetChipDetailPanelData()
  end
  return nil
end

UISelectChipItem.SetObjNewTagActive = function(self, active, showState)
  -- function num : 0_9
  (self.panel):SetObjNewTagActive(active, showState)
end

UISelectChipItem.SetTRModifier = function(self, uiModifier)
  -- function num : 0_10
  (self.panel):SetUIModifier(uiModifier)
end

UISelectChipItem.SetSelectChipItemSold = function(self, sold, soldGoPrefab)
  -- function num : 0_11 , upvalues : _ENV
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
  -- function num : 0_12
  (self.panel):OnDelete()
end

return UISelectChipItem

