-- params : ...
-- function num : 0 , upvalues : _ENV
local UIMessageCommon = class("UIMessageCommon", UIBaseWindow)
local base = UIBaseWindow
local UINMsgCommonItem = require("Game.CommonUI.MessageCommon.UINMsgCommonItem")
UIMessageCommon.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__permanent = true
  ;
  (UIUtil.AddButtonListener)((self.ui).btnClose, self, self._OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).buttonConfirm, self, self._OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).buttonNo, self, self._OnClickNo)
  ;
  (UIUtil.AddButtonListener)((self.ui).buttonYes, self, self._OnClickYes)
end

UIMessageCommon._Reset = function(self)
  -- function num : 0_1
  ((self.ui).textNode):SetActive(false)
  ;
  ((self.ui).itemNode):SetActive(false)
  ;
  ((self.ui).yesNoNode):SetActive(false)
  ;
  (((self.ui).btnClose).gameObject):SetActive(false)
  ;
  (((self.ui).buttonConfirm).gameObject):SetActive(false)
  ;
  ((self.ui).textRemind):SetActive(false)
end

UIMessageCommon._ShowItemCostInternal = function(self, msg, itemId, costNum)
  -- function num : 0_2 , upvalues : _ENV
  ((self.ui).textNode):SetActive(false)
  ;
  ((self.ui).itemNode):SetActive(true)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemContent).text = msg
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    error("Cant get itemCfg, id = " .. tostring(itemId))
    return 
  end
  local itemA = self:_GetItemA()
  itemA:InitMsgCommonItem(itemCfg, costNum)
end

UIMessageCommon.ShowItemCostConfirm = function(self, msg, itemId, costNum, confirmFunc)
  -- function num : 0_3
  self:_Reset()
  self:_ShowItemCostInternal(msg, itemId, costNum)
  ;
  (((self.ui).buttonConfirm).gameObject):SetActive(true)
  self.confirmFunc = confirmFunc
end

UIMessageCommon.ShowItemCost = function(self, msg, itemId, costNum, yesFunc, noFunc)
  -- function num : 0_4
  self:_Reset()
  self:_ShowItemCostInternal(msg, itemId, costNum)
  ;
  ((self.ui).yesNoNode):SetActive(true)
  self.yesFunc = yesFunc
  self.noFunc = noFunc
end

UIMessageCommon.ShowItemConvert = function(self, msg, itemId1, cost1Num, itemId2, item2Num, yesFunc, noFunc)
  -- function num : 0_5 , upvalues : _ENV
  self:_Reset()
  self:_ShowItemCostInternal(msg, itemId1, cost1Num)
  local itemCfg = (ConfigData.item)[itemId2]
  if itemCfg == nil then
    error("Cant get itemCfg, id = " .. tostring(itemId2))
    return 
  end
  local itemB = self:_GetItemB()
  itemB:InitMsgCommonItem(itemCfg, nil, item2Num)
  ;
  ((self.ui).obj_Arrow):SetActive(true)
  ;
  ((self.ui).yesNoNode):SetActive(true)
  self.yesFunc = yesFunc
  self.noFunc = noFunc
end

UIMessageCommon.ShowItemCost2Confirm = function(self, msg, itemId1, costNum1, itemId2, costNum2, confirmFunc)
  -- function num : 0_6 , upvalues : _ENV
  self:_Reset()
  self:_ShowItemCostInternal(msg, itemId1, costNum1)
  local itemCfg = (ConfigData.item)[itemId2]
  if itemCfg == nil then
    error("Cant get itemCfg, id = " .. tostring(itemId2))
    return 
  end
  local itemB = self:_GetItemB()
  itemB:InitMsgCommonItem(itemCfg, costNum2)
  ;
  (((self.ui).buttonConfirm).gameObject):SetActive(true)
  self.confirmFunc = confirmFunc
end

UIMessageCommon.ShowTextBox = function(self, msg)
  -- function num : 0_7
  self:_Reset()
  local hasMsg = msg ~= nil
  ;
  ((self.ui).itemNode):SetActive(not hasMsg)
  ;
  ((self.ui).textNode):SetActive(hasMsg)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Content).text = msg
  ;
  ((self.ui).yesNoNode):SetActive(false)
  ;
  (((self.ui).buttonConfirm).gameObject):SetActive(false)
  ;
  (((self.ui).btnClose).gameObject):SetActive(false)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIMessageCommon.ShowTextBoxWithConfirm = function(self, msg, comfirmFunc)
  -- function num : 0_8
  self:_Reset()
  self:ShowTextBox(msg)
  if comfirmFunc ~= nil then
    (((self.ui).buttonConfirm).gameObject):SetActive(true)
    self.confirmFunc = comfirmFunc
  end
end

UIMessageCommon.ShowTextBoxWithClose = function(self, msg, closeFunc)
  -- function num : 0_9
  self:_Reset()
  self:ShowTextBox(msg)
  if closeFunc ~= nil then
    (((self.ui).btnClose).gameObject):SetActive(true)
    self.closeFunc = closeFunc
  end
end

UIMessageCommon.ShowTextBoxWithYesAndNo = function(self, msg, yesFunc, noFunc)
  -- function num : 0_10
  self:_Reset()
  self:ShowTextBox(msg)
  ;
  ((self.ui).yesNoNode):SetActive(true)
  self.yesFunc = yesFunc
  self.noFunc = noFunc
end

UIMessageCommon.ShowDontRemindTog = function(self, callback, isOn)
  -- function num : 0_11
  self.dontRemindFunc = callback
  ;
  ((self.ui).textRemind):SetActive(true)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tog_RemindSwitch).isOn = isOn or false
end

UIMessageCommon._OnClickClose = function(self)
  -- function num : 0_12
  self:Hide()
  if self.closeFunc ~= nil then
    local func = self.closeFunc
    self.closeFunc = nil
    func()
  end
end

UIMessageCommon._OnClickConfirm = function(self)
  -- function num : 0_13
  self:Hide()
  do
    if self.confirmFunc ~= nil then
      local func = self.confirmFunc
      self.confirmFunc = nil
      func()
    end
    if self.dontRemindFunc ~= nil then
      local func = self.dontRemindFunc
      self.dontRemindFunc = nil
      func(((self.ui).tog_RemindSwitch).isOn)
    end
  end
end

UIMessageCommon._OnClickNo = function(self)
  -- function num : 0_14
  self:Hide()
  if self.noFunc ~= nil then
    local func = self.noFunc
    self.noFunc = nil
    self.yesFunc = nil
    func()
  end
end

UIMessageCommon._OnClickYes = function(self)
  -- function num : 0_15
  self:Hide()
  do
    if self.yesFunc ~= nil then
      local func = self.yesFunc
      self.yesFunc = nil
      self.noFunc = nil
      func()
    end
    if self.dontRemindFunc ~= nil then
      local func = self.dontRemindFunc
      self.dontRemindFunc = nil
      func(((self.ui).tog_RemindSwitch).isOn)
    end
  end
end

UIMessageCommon._GetItemA = function(self)
  -- function num : 0_16 , upvalues : UINMsgCommonItem
  if self.itemA == nil then
    self.itemA = (UINMsgCommonItem.New)()
    ;
    (self.itemA):Init((self.ui).extrItemA)
    ;
    ((self.itemA).gameObject):SetActive(true)
  end
  return self.itemA
end

UIMessageCommon._GetItemB = function(self)
  -- function num : 0_17 , upvalues : UINMsgCommonItem
  if self.itemB == nil then
    self.itemB = (UINMsgCommonItem.New)()
    ;
    (self.itemB):Init((self.ui).extrItemB)
    ;
    ((self.itemB).gameObject):SetActive(true)
  end
  return self.itemB
end

UIMessageCommon.OnDelete = function(self)
  -- function num : 0_18 , upvalues : base
  (base.OnDelete)(self)
end

return UIMessageCommon

