local UIGuideSettingGraphTogItem = class("UIGuideSettingGraphTogItem", UIBaseNode)
UIGuideSettingGraphTogItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).togItem = (self.transform):FindComponent(eUnityComponentID.ExToggle)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).togItem, self, self.OnSwitchTogChanged)
end

UIGuideSettingGraphTogItem.InitGuideSettingGraphTogItem = function(self, index, isOn, isRecommend, isHigh, name, image, togGroup, onValueChangeEvent)
  -- function num : 0_1
  self.index = index
  ;
  ((self.ui).obj_Recommend):SetActive(isRecommend)
  ;
  (((self.ui).tex_ConsumePower).gameObject):SetActive(isHigh)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).togItem).group = togGroup
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_SettingName).text = name
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).img_SettingImage).texture = image
  self.onValueChangeEvent = onValueChangeEvent
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).togItem).isOn = isOn
end

UIGuideSettingGraphTogItem.OnSwitchTogChanged = function(self, value)
  -- function num : 0_2
  if self.onValueChangeEvent ~= nil then
    (self.onValueChangeEvent)(value, self)
  end
end

return UIGuideSettingGraphTogItem

