local UINDisplayTogItem = require("Game.Setting.UI.UINDisplayTogItem")
local UIPerformanceLevelTogItem = class("UIPerformanceLevelTogItem", UINDisplayTogItem)
UIPerformanceLevelTogItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).togItem = (self.transform):FindComponent(eUnityComponentID.ExToggle)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).togItem, self, self.OnDisplayTogChanged)
end

UIPerformanceLevelTogItem.InitDisplayTogItem = function(self, index, isOn, isRecommend, togGroup, name, valueEvent)
  -- function num : 0_1
  self.index = index
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).togItem).group = togGroup
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).togItem).isOn = isOn
  self:SetIsOn(isOn)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).textName).text = name
  self.valueEvent = valueEvent
  ;
  ((self.ui).img_Recommend):SetActive(isRecommend)
end

UIPerformanceLevelTogItem.SetIsOn = function(self, value)
  -- function num : 0_2
  ((self.ui).img_Select):SetActive(value)
  ;
  ((self.ui).imgInfo_Setting):SetIndex(value and 0 or 1)
end

UIPerformanceLevelTogItem.OnDisplayTogChanged = function(self, value)
  -- function num : 0_3 , upvalues : _ENV
  if self.valueEvent ~= nil then
    print(tostring(((self.ui).togItem).isOn))
    ;
    (self.valueEvent)(value, self)
  end
  self:SetIsOn(value)
end

return UIPerformanceLevelTogItem

