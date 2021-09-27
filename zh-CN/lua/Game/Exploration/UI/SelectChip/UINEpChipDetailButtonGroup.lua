local UINEpChipDetailButtonGroup = class("UINEpChipDetailButtonGroup", UIBaseNode)
local base = UIBaseNode
UINEpChipDetailButtonGroup.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Lock, self, self._OnLockClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Select, self, self._OnSelectClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SelByCost, self, self._OnSelByCostClick)
  self:SetLockState(false)
  self:SetLockGoActive(false)
end

UINEpChipDetailButtonGroup.InitChipDetailButtonGroup = function(self, panel)
  -- function num : 0_1
  self.panel = panel
  self:SetDefaultState()
end

UINEpChipDetailButtonGroup.SetDefaultState = function(self)
  -- function num : 0_2
  (((self.ui).btn_Select).gameObject):SetActive(false)
  ;
  (((self.ui).btn_SelByCost).gameObject):SetActive(false)
  ;
  ((self.ui).obj_tips):SetActive(false)
end

UINEpChipDetailButtonGroup.SetLockGoActive = function(self, active)
  -- function num : 0_3
  (((self.ui).btn_Lock).gameObject):SetActive(active)
end

UINEpChipDetailButtonGroup.SetLockState = function(self, lockState)
  -- function num : 0_4
  self.lock = lockState
  self:_RefreshLockUi()
end

UINEpChipDetailButtonGroup._RefreshLockUi = function(self)
  -- function num : 0_5
  if self.lock then
    ((self.ui).img_Lock):SetIndex(1)
  else
    ;
    ((self.ui).img_Lock):SetIndex(0)
  end
end

UINEpChipDetailButtonGroup.SetLockCallback = function(self, callback)
  -- function num : 0_6
  self._onLockCallback = callback
end

UINEpChipDetailButtonGroup._OnLockClick = function(self)
  -- function num : 0_7
  if self._onLockCallback ~= nil then
    (self._onLockCallback)()
  end
end

UINEpChipDetailButtonGroup.InitBtnSelect = function(self, selectCallback)
  -- function num : 0_8
  self:SetBtnSelectActive(true)
  self:RefreshBtnSelectUI()
  self._onSelectCallback = selectCallback
end

UINEpChipDetailButtonGroup.RefreshBtnSelectUI = function(self, index)
  -- function num : 0_9
  do
    if not (self.panel)._isOwnData then
      local _isOwnData = index ~= nil or false
    end
    index = _isOwnData and 1 or 0
    ;
    ((self.ui).tex_Select):SetIndex(index)
  end
end

UINEpChipDetailButtonGroup.SetBtnSelectActive = function(self, active)
  -- function num : 0_10
  if active and not (((self.ui).btn_Select).gameObject).activeSelf then
    self:SetDefaultState()
  end
  ;
  (((self.ui).btn_Select).gameObject):SetActive(active)
end

UINEpChipDetailButtonGroup._OnSelectClick = function(self)
  -- function num : 0_11
  if self._onSelectCallback ~= nil then
    (self._onSelectCallback)()
  end
end

UINEpChipDetailButtonGroup.InitBtnSelByCost = function(self, isBuy, cost, selectCallback, sprite)
  -- function num : 0_12
  self._onSelByCostCallback = selectCallback
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  if sprite ~= nil then
    ((self.ui).img_SelByCostIcon).sprite = sprite
  end
  self:SetBtnSelByCostActive(true)
  self:_RefreshBtnSelByCostUI(isBuy, cost)
end

UINEpChipDetailButtonGroup._RefreshBtnSelByCostUI = function(self, isBuy, cost)
  -- function num : 0_13 , upvalues : _ENV
  if cost == nil then
    cost = ((self.panel)._chipData):GetChipBuyPrice(ExplorationManager:GetEpModuleId())
  end
  local index = isBuy and 1 or 0
  local str = isBuy and "-" or "+"
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).btn_SelByCost).interactable = true
  if isBuy then
    local currMoney = (ExplorationManager:GetDynPlayer()):GetMoneyCount()
    local couldLoanMoney = ((ExplorationManager.epCtrl).campFetterCtrl):GetCouldLeonMoney()
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R7 in 'UnsetPending'

    if currMoney + couldLoanMoney < cost then
      ((self.ui).btn_SelByCost).interactable = false
      ;
      ((self.ui).tex_SelByCostName):SetIndex(2)
    else
      ;
      ((self.ui).tex_SelByCostName):SetIndex(1)
    end
    ;
    ((self.ui).img_SelByCostBg):SetIndex(1)
  else
    do
      ;
      ((self.ui).tex_SelByCostName):SetIndex(0)
      ;
      ((self.ui).img_SelByCostBg):SetIndex(0)
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_Cost).text = str .. tostring(cost)
    end
  end
end

UINEpChipDetailButtonGroup.SetBtnSelByCostActive = function(self, active)
  -- function num : 0_14
  if active and not (((self.ui).btn_SelByCost).gameObject).activeSelf then
    self:SetDefaultState()
  end
  ;
  (((self.ui).btn_SelByCost).gameObject):SetActive(active)
end

UINEpChipDetailButtonGroup._OnSelByCostClick = function(self)
  -- function num : 0_15
  if self._onSelByCostCallback ~= nil then
    (self._onSelByCostCallback)()
  end
end

UINEpChipDetailButtonGroup.ShowIsLevelMaxTips = function(self)
  -- function num : 0_16
  if not ((self.ui).obj_tips).activeSelf then
    self:SetDefaultState()
  end
  ;
  ((self.ui).obj_tips):SetActive(true)
end

UINEpChipDetailButtonGroup.OnDelete = function(self)
  -- function num : 0_17 , upvalues : base
  (base.OnDelete)(self)
end

return UINEpChipDetailButtonGroup

