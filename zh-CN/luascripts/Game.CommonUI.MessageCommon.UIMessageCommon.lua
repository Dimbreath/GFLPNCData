-- params : ...
-- function num : 0 , upvalues : _ENV
local UIMessageCommon = class("UIMessageCommon", UIBaseWindow)
local base = UIBaseWindow
local UINMsgCommonItem = require("Game.CommonUI.MessageCommon.UINMsgCommonItem")
UIMessageCommon.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
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
  (UIUtil.AddButtonListener)((self.ui).buttonConfirm, self, self._OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).buttonNo, self, self._OnClickNo)
  ;
  (UIUtil.AddButtonListener)((self.ui).buttonYes, self, self._OnClickYes)
end

UIMessageCommon._ShowItemCostInternal = function(self, msg, itemId, costNum)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).itemNode):SetActive(true)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

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
  -- function num : 0_2
  self:_ShowItemCostInternal(msg, itemId, costNum)
  ;
  (((self.ui).buttonConfirm).gameObject):SetActive(true)
  self.confirmFunc = confirmFunc
end

UIMessageCommon.ShowItemCost = function(self, msg, itemId, costNum, yesFunc, noFunc)
  -- function num : 0_3
  self:_ShowItemCostInternal(msg, itemId, costNum)
  ;
  ((self.ui).yesNoNode):SetActive(true)
  self.yesFunc = yesFunc
  self.noFunc = noFunc
end

UIMessageCommon.ShowItemConvert = function(self, msg, itemId1, cost1Num, itemId2, item2Num, yesFunc, noFunc)
  -- function num : 0_4 , upvalues : _ENV
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
  -- function num : 0_5 , upvalues : _ENV
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

UIMessageCommon._OnClickConfirm = function(self)
  -- function num : 0_6
  self:Delete()
  if self.confirmFunc ~= nil then
    local func = self.confirmFunc
    self.confirmFunc = nil
    func()
  end
end

UIMessageCommon._OnClickNo = function(self)
  -- function num : 0_7
  self:Delete()
  if self.noFunc ~= nil then
    local func = self.noFunc
    self.noFunc = nil
    func()
  end
end

UIMessageCommon._OnClickYes = function(self)
  -- function num : 0_8
  self:Delete()
  if self.yesFunc ~= nil then
    local func = self.yesFunc
    self.yesFunc = nil
    func()
  end
end

UIMessageCommon._GetItemA = function(self)
  -- function num : 0_9 , upvalues : UINMsgCommonItem
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
  -- function num : 0_10 , upvalues : UINMsgCommonItem
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
  -- function num : 0_11 , upvalues : base
  (base.OnDelete)(self)
end

return UIMessageCommon

