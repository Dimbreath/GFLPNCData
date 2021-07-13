-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDisplayTogItem = class("UINDisplayTogItem", UIBaseNode)
UINDisplayTogItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  (self.ui).togItem = (self.transform):FindComponent(eUnityComponentID.ExToggle)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).textName = (self.transform):FindComponent("Tex_QuailtyName", eUnityComponentID.ExText)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).togItem, self, self.OnDisplayTogChanged)
end

UINDisplayTogItem.InitDisplayTogItem = function(self, index, isOn, togGroup, name, valueEvent)
  -- function num : 0_1
  self.index = index
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).togItem).group = togGroup
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).togItem).isOn = isOn
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).textName).text = name
  self.valueEvent = valueEvent
end

UINDisplayTogItem.OnDisplayTogChanged = function(self, value)
  -- function num : 0_2
  if self.valueEvent ~= nil then
    (self.valueEvent)(value, self)
  end
end

return UINDisplayTogItem

