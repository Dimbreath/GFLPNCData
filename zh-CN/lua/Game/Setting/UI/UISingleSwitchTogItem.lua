local UISingleSwitchTogItem = class("UISingleSwitchTogItem", UIBaseNode)
local UINDisplayTogItem = require("Game.Setting.UI.UINDisplayTogItem")
UISingleSwitchTogItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).toggleGroup = (self.transform):FindComponent(eUnityComponentID.ToggleGroup)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).backGroundImage = (self.transform):FindComponent(eUnityComponentID.Image)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).togItemList = {}
end

UISingleSwitchTogItem.InitSingleSwitchTogItem = function(self, currentValueeEvent, nameList, singleValueEvent, eventSelf)
  -- function num : 0_1 , upvalues : _ENV, UINDisplayTogItem
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  ((((self.ui).backGroundImage).rectTransform).rect).width = ((((self.ui).backGroundImage).rectTransform).rect).width * 2
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.ui).togItemList = {}
  if type(currentValueeEvent) == "function" then
    self.currentValueeEvent = currentValueeEvent
  else
    self.currentValueeEvent = function()
    -- function num : 0_1_0 , upvalues : currentValueeEvent
    return currentValueeEvent
  end

  end
  local isOn = (self.currentValueeEvent)()
  for i = 1, 2 do
    local dTogItem = (UINDisplayTogItem.New)()
    local index = i - 1
    dTogItem:Init((self.transform):GetChild(index))
    dTogItem:InitDisplayTogItem(i, i == 2 == isOn, (self.ui).toggleGroup, ((LanguageUtil.GetLocaleText)(nameList[i])), nil, self.ui)
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.ui).togItemList)[i] = dTogItem
    ;
    (UIUtil.AddValueChangedListener)(((((self.ui).togItemList)[i]).ui).togItem, self, self.OnSwitchTogChanged, i)
  end
  self.isOn = isOn
  self.SingleValueEvent = singleValueEvent
  self.eventSelf = eventSelf
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UISingleSwitchTogItem.OnSwitchTogChanged = function(self, index, value)
  -- function num : 0_2
  if self.SingleValueEvent ~= nil then
    if index == 1 and value then
      self.isOn = false
      ;
      (self.SingleValueEvent)(self.eventSelf, self.isOn, self)
    end
    if index == 2 and value then
      self.isOn = true
      ;
      (self.SingleValueEvent)(self.eventSelf, self.isOn, self)
    end
  end
end

UISingleSwitchTogItem.SelectCurrentValue = function(self)
  -- function num : 0_3
  if self.currentValueeEvent ~= nil then
    local currentValue = (self.currentValueeEvent)()
    self.isOn = currentValue
    local togItem = ((self.ui).togItemList)[self.isOn and 2 or 1]
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

    if togItem ~= nil and self.ui ~= nil and (self.ui).toggleGroup ~= nil then
      ((togItem.ui).togItem).isOn = true
      ;
      ((self.ui).toggleGroup):NotifyToggleOn((togItem.ui).togItem)
      ;
      (self.SingleValueEvent)(self.eventSelf, self.isOn, self)
    end
  end
end

return UISingleSwitchTogItem

