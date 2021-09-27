local UIMultiSwitchTogItem = class("UIMultiSwitchTogItem", UIBaseNode)
local UINDisplayTogItem = require("Game.Setting.UI.UINDisplayTogItem")
local UIPerformanceLevelTogItem = require("Game.Setting.UI.UIPerformanceLevelTogItem")
UIMultiSwitchTogItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).toggleGroup = (self.transform):FindComponent(eUnityComponentID.ToggleGroup)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).togItemList = {}
  ;
  (((self.ui).multiTogItem).gameObject):SetActive(false)
end

UIMultiSwitchTogItem.InitUIMultiSwitchTogItem = function(self, currentValueeEvent, nameList, isReverse, multiValueEvent, eventSelf)
  -- function num : 0_1 , upvalues : UINDisplayTogItem, _ENV
  local s = 1
  local e = #nameList
  local a = 1
  if isReverse then
    s = e
    a = -1
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (self.ui).togItemList = {}
  self.currentValueeEvent = currentValueeEvent
  local selectIndex = (self.currentValueeEvent)()
  for i = s, e, a do
    local toggleItemObj = ((self.ui).multiTogItem):Instantiate(self.transform)
    ;
    (toggleItemObj.gameObject):SetActive(true)
    local index = i - 1
    local dTogItem = (UINDisplayTogItem.New)()
    dTogItem:Init(toggleItemObj)
    dTogItem:InitDisplayTogItem(index, index == selectIndex, (self.ui).toggleGroup, ((LanguageUtil.GetLocaleText)(nameList[i])), nil, self.ui)
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R17 in 'UnsetPending'

    ;
    ((self.ui).togItemList)[index] = dTogItem
    ;
    (UIUtil.AddValueChangedListener)(((((self.ui).togItemList)[index]).ui).togItem, self, self.OnSwitchTogChanged, index)
  end
  self.selectIndex = selectIndex
  self.multiValueEvent = multiValueEvent
  self.eventSelf = eventSelf
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIMultiSwitchTogItem.InitUIMultiSwitchPerformanceLevelTogItem = function(self, currentValueeEvent, nameList, recommendIndex, multiValueEvent, eventSelf)
  -- function num : 0_2 , upvalues : UIPerformanceLevelTogItem, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R6 in 'UnsetPending'

  (self.ui).togItemList = {}
  local selectIndex = currentValueeEvent()
  self.currentValueeEvent = currentValueeEvent
  for i = 1, #nameList do
    local toggleItemObj = ((self.ui).multiTogItem):Instantiate(self.transform)
    ;
    (toggleItemObj.gameObject):SetActive(true)
    local index = i
    local PerformanceLevelTogItem = (UIPerformanceLevelTogItem.New)()
    PerformanceLevelTogItem:Init(toggleItemObj)
    PerformanceLevelTogItem:InitDisplayTogItem(index, index == selectIndex, index == recommendIndex, (self.ui).toggleGroup, ((LanguageUtil.GetLocaleText)(nameList[i])), nil, self.ui)
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R14 in 'UnsetPending'

    ;
    ((self.ui).togItemList)[index] = PerformanceLevelTogItem
    if i ~= #nameList then
      (UIUtil.AddValueChangedListener)(((((self.ui).togItemList)[index]).ui).togItem, self, self.OnSwitchTogChanged, index)
    end
  end
  self.selectIndex = selectIndex
  self.multiValueEvent = multiValueEvent
  self.eventSelf = eventSelf
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIMultiSwitchTogItem.OnSwitchTogChanged = function(self, index, value)
  -- function num : 0_3
  if self.multiValueEvent ~= nil then
    (self.multiValueEvent)(value, ((self.ui).togItemList)[index])
  end
end

UIMultiSwitchTogItem.SelectCurrentValue = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.currentValueeEvent ~= nil then
    local currentValue = (self.currentValueeEvent)()
    local togItem = ((self.ui).togItemList)[currentValue]
    if togItem ~= nil and self.ui ~= nil and (self.ui).toggleGroup ~= nil then
      for key,tog in pairs((self.ui).togItemList) do
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

        ((tog.ui).togItem).isOn = currentValue == key
      end
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

return UIMultiSwitchTogItem

