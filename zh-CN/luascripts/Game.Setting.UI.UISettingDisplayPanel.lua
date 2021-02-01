-- params : ...
-- function num : 0 , upvalues : _ENV
local UISettingDisplayPanel = class("UISettingDisplayPanel", UIBaseNode)
local UINDisplayTogItem = require("Game.Setting.UI.UINDisplayTogItem")
UISettingDisplayPanel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).multiTogItem):SetActive(false)
end

UISettingDisplayPanel.InitDisplayPanel = function(self, ctrl)
  -- function num : 0_1 , upvalues : _ENV
  self.ctrl = ctrl
  local systemSaveData = (self.ctrl):GetSystemSaveData()
  self.resolutionItemList = {}
  local resolution = systemSaveData:GetDisplaySettingValue("resolution")
  local resolutionCallback = BindCallback(self, self.OnResolutionChanged)
  local resolutionOptionName = (ConfigData:GetPerformanceTypeinfoByName("resolution")).option_group_name
  self:InitMultiDisplayItem(resolution, resolutionOptionName, self.resolutionItemList, (self.ui).resolutionItem, resolutionCallback, true)
  self.textureLimitItemList = {}
  local textureLimit = systemSaveData:GetDisplaySettingValue("texture_limit")
  local textureLimitCallback = BindCallback(self, self.OnTextureLimitChanged)
  local textureLimitOptionName = (ConfigData:GetPerformanceTypeinfoByName("texture_limit")).option_group_name
  self:InitMultiDisplayItem(textureLimit, textureLimitOptionName, self.textureLimitItemList, (self.ui).textureLimitItem, textureLimitCallback, true)
  self.effectQualityItemList = {}
  local effectQuality = systemSaveData:GetDisplaySettingValue("effect_quality")
  local effectQualityCallback = BindCallback(self, self.OnEffectQualityChanged)
  local effectQualityOptionName = (ConfigData:GetPerformanceTypeinfoByName("effect_quality")).option_group_name
  self:InitMultiDisplayItem(effectQuality, effectQualityOptionName, self.effectQualityItemList, (self.ui).effectQualityItem, effectQualityCallback)
  self.modelQualityItemList = {}
  local modelQuality = systemSaveData:GetDisplaySettingValue("model_quality")
  local modelQualityCallback = BindCallback(self, self.OnModelQualityChanged)
  local modelQualityOptionName = (ConfigData:GetPerformanceTypeinfoByName("model_quality")).option_group_name
  self:InitMultiDisplayItem(modelQuality, modelQualityOptionName, self.modelQualityItemList, (self.ui).modelQualityItem, modelQualityCallback)
  self.posteffectItemList = {}
  local postEffect = systemSaveData:GetDisplaySettingValue("post_effect")
  local postEffectCallback = BindCallback(self, self.OnPostEffectChanged)
  local postEffectOptionName = (ConfigData:GetPerformanceTypeinfoByName("post_effect")).option_group_name
  self:InitMultiDisplayItem(postEffect, postEffectOptionName, self.posteffectItemList, (self.ui).postEffectItem, postEffectCallback)
  self.maxFpsItemList = {}
  local maxFps = systemSaveData:GetDisplaySettingValue("frame_rate")
  local maxFpsCallback = BindCallback(self, self.OnMaxFpsChanged)
  local maxFpsOptionName = (ConfigData:GetPerformanceTypeinfoByName("frame_rate")).option_group_name
  self:InitMultiDisplayItem(maxFps, maxFpsOptionName, self.maxFpsItemList, (self.ui).maxFpsItem, maxFpsCallback)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Shadow, self, self.OnDynShadowChanged)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_aa, self, self.OnAntiAliasingChanged)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Outline, self, self.OnOutlineChanged)
  -- DECOMPILER ERROR at PC168: Confused about usage of register: R21 in 'UnsetPending'

  ;
  ((self.ui).tog_Shadow).isOn = systemSaveData:GetDisplaySettingValue("dyn_shadow") > 0
  -- DECOMPILER ERROR at PC178: Confused about usage of register: R21 in 'UnsetPending'

  ;
  ((self.ui).tog_aa).isOn = systemSaveData:GetDisplaySettingValue("anti_aliasing") > 0
  -- DECOMPILER ERROR at PC188: Confused about usage of register: R21 in 'UnsetPending'

  ;
  ((self.ui).tog_Outline).isOn = systemSaveData:GetDisplaySettingValue("outline") > 0
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UISettingDisplayPanel.InitMultiDisplayItem = function(self, curValue, strList, ItemList, togGroup, bindEvent, isReverse)
  -- function num : 0_2 , upvalues : UINDisplayTogItem, _ENV
  local s = 1
  local e = #strList
  local a = 1
  if isReverse then
    s = e
    a = -1
  end
  for i = s, e, a do
    local itemGo = ((self.ui).multiTogItem):Instantiate(togGroup.transform)
    itemGo:SetActive(true)
    local dTogItem = (UINDisplayTogItem.New)()
    dTogItem:Init(itemGo)
    local index = i - 1
    dTogItem:InitDisplayTogItem(index, curValue == index, togGroup, (LanguageUtil.GetLocaleText)(strList[i]), bindEvent)
    ItemList[i] = dTogItem
  end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UISettingDisplayPanel.OnResolutionChanged = function(self, value, togItem)
  -- function num : 0_3
  if value then
    (self.ctrl):SetResolutionIndex(togItem.index)
  end
end

UISettingDisplayPanel.OnTextureLimitChanged = function(self, value, togItem)
  -- function num : 0_4
  if value then
    (self.ctrl):SetTextureLimit(togItem.index)
  end
end

UISettingDisplayPanel.OnEffectQualityChanged = function(self, value, togItem)
  -- function num : 0_5
  if value then
    (self.ctrl):SetEffectQuality(togItem.index)
  end
end

UISettingDisplayPanel.OnModelQualityChanged = function(self, value, togItem)
  -- function num : 0_6
  if value then
    (self.ctrl):SetModelQuality(togItem.index)
  end
end

UISettingDisplayPanel.OnPostEffectChanged = function(self, value, togItem)
  -- function num : 0_7
  if value then
    (self.ctrl):SetPostEffect(togItem.index)
  end
end

UISettingDisplayPanel.OnMaxFpsChanged = function(self, value, togItem)
  -- function num : 0_8
  if value then
    (self.ctrl):SetFrameRateIndex(togItem.index)
  end
end

UISettingDisplayPanel.OnDynShadowChanged = function(self, value)
  -- function num : 0_9
  ;
  (self.ctrl):SetDynShadowIndex(value == true and 1 or 0)
end

UISettingDisplayPanel.OnAntiAliasingChanged = function(self, value)
  -- function num : 0_10
  ;
  (self.ctrl):SetAntiAliasingIndex(value == true and 1 or 0)
end

UISettingDisplayPanel.OnOutlineChanged = function(self, value)
  -- function num : 0_11
  ;
  (self.ctrl):SetOutlineIndex(value == true and 1 or 0)
end

return UISettingDisplayPanel

