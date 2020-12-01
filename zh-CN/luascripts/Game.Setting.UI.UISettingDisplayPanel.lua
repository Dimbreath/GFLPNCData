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
  local displaySetting = (self.ctrl):GetSettingDisplayData()
  self.resolutionItemList = {}
  local resolution = displaySetting.resolution
  local resolutionCallback = BindCallback(self, self.OnResolutionChanged)
  self:InitMultiDisplayItem(resolution, (self.ui).str_Resolution, self.resolutionItemList, (self.ui).resolutionItem, resolutionCallback, true)
  self.textureLimitItemList = {}
  local textureLimit = displaySetting.texture_limit
  local textureLimitCallback = BindCallback(self, self.OnTextureLimitChanged)
  self:InitMultiDisplayItem(textureLimit, (self.ui).str_TextureLimit, self.textureLimitItemList, (self.ui).textureLimitItem, textureLimitCallback, true)
  self.maxFpsItemList = {}
  local maxFps = displaySetting.frame_rate
  local maxFpsCallback = BindCallback(self, self.OnMaxFpsChanged)
  self:InitMultiDisplayItem(maxFps, (self.ui).str_MaxFps, self.maxFpsItemList, (self.ui).maxFpsItem, maxFpsCallback)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Shadow, self, self.OnDynShadowChanged)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_aa, self, self.OnAntiAliasingChanged)
  -- DECOMPILER ERROR at PC75: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tog_Shadow).isOn = displaySetting.dyn_shadow == 1
  -- DECOMPILER ERROR at PC83: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tog_aa).isOn = displaySetting.anti_aliasing == 1
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UISettingDisplayPanel.InitMultiDisplayItem = function(self, curValue, strList, ItemList, togGroup, bindEvent, isReverse)
  -- function num : 0_2 , upvalues : UINDisplayTogItem
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
    dTogItem:InitDisplayTogItem(index, curValue == index, togGroup, strList[i], bindEvent)
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

UISettingDisplayPanel.OnMaxFpsChanged = function(self, value, togItem)
  -- function num : 0_5
  if value then
    (self.ctrl):SetFrameRateIndex(togItem.index)
  end
end

UISettingDisplayPanel.OnDynShadowChanged = function(self, value)
  -- function num : 0_6
  ;
  (self.ctrl):SetDynShadowIndex(value == true and 1 or 0)
end

UISettingDisplayPanel.OnAntiAliasingChanged = function(self, value)
  -- function num : 0_7
  ;
  (self.ctrl):SetAntiAliasingIndex(value == true and 1 or 0)
end

return UISettingDisplayPanel

-- params : ...
-- function num : 0 , upvalues : _ENV
local UISettingDisplayPanel = class("UISettingDisplayPanel", UIBaseNode)
local UINDisplayTogItem = require("Game.Setting.UI.UINDisplayTogItem")
UISettingDisplayPanel.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    ((self.ui).multiTogItem):SetActive(false)
end

UISettingDisplayPanel.InitDisplayPanel =
    function(self, ctrl)
        -- function num : 0_1 , upvalues : _ENV
        self.ctrl = ctrl
        local displaySetting = (self.ctrl):GetSettingDisplayData()
        self.resolutionItemList = {}
        local resolution = displaySetting.resolution
        local resolutionCallback = BindCallback(self, self.OnResolutionChanged)
        self:InitMultiDisplayItem(resolution, (self.ui).str_Resolution,
                                  self.resolutionItemList,
                                  (self.ui).resolutionItem, resolutionCallback,
                                  true)
        self.textureLimitItemList = {}
        local textureLimit = displaySetting.texture_limit
        local textureLimitCallback = BindCallback(self,
                                                  self.OnTextureLimitChanged)
        self:InitMultiDisplayItem(textureLimit, (self.ui).str_TextureLimit,
                                  self.textureLimitItemList,
                                  (self.ui).textureLimitItem,
                                  textureLimitCallback, true)
        self.maxFpsItemList = {}
        local maxFps = displaySetting.frame_rate
        local maxFpsCallback = BindCallback(self, self.OnMaxFpsChanged)
        self:InitMultiDisplayItem(maxFps, (self.ui).str_MaxFps,
                                  self.maxFpsItemList, (self.ui).maxFpsItem,
                                  maxFpsCallback);
        (UIUtil.AddValueChangedListener)((self.ui).tog_Shadow, self,
                                         self.OnDynShadowChanged);
        (UIUtil.AddValueChangedListener)((self.ui).tog_aa, self,
                                         self.OnAntiAliasingChanged) -- DECOMPILER ERROR at PC75: Confused about usage of register: R9 in 'UnsetPending'
        ;
        ((self.ui).tog_Shadow).isOn = displaySetting.dyn_shadow == 1 -- DECOMPILER ERROR at PC83: Confused about usage of register: R9 in 'UnsetPending'
        ;
        ((self.ui).tog_aa).isOn = displaySetting.anti_aliasing == 1
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end

UISettingDisplayPanel.InitMultiDisplayItem =
    function(self, curValue, strList, ItemList, togGroup, bindEvent, isReverse)
        -- function num : 0_2 , upvalues : UINDisplayTogItem
        local s = 1
        local e = #strList
        local a = 1
        if isReverse then
            s = e
            a = -1
        end
        for i = s, e, a do
            local itemGo = ((self.ui).multiTogItem):Instantiate(
                               togGroup.transform)
            itemGo:SetActive(true)
            local dTogItem = (UINDisplayTogItem.New)()
            dTogItem:Init(itemGo)
            local index = i - 1
            dTogItem:InitDisplayTogItem(index, curValue == index, togGroup,
                                        strList[i], bindEvent)
            ItemList[i] = dTogItem
        end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end

UISettingDisplayPanel.OnResolutionChanged =
    function(self, value, togItem)
        -- function num : 0_3
        if value then (self.ctrl):SetResolutionIndex(togItem.index) end
    end

UISettingDisplayPanel.OnTextureLimitChanged =
    function(self, value, togItem)
        -- function num : 0_4
        if value then (self.ctrl):SetTextureLimit(togItem.index) end
    end

UISettingDisplayPanel.OnMaxFpsChanged = function(self, value, togItem)
    -- function num : 0_5
    if value then (self.ctrl):SetFrameRateIndex(togItem.index) end
end

UISettingDisplayPanel.OnDynShadowChanged =
    function(self, value)
        -- function num : 0_6

        (self.ctrl):SetDynShadowIndex(value == true and 1 or 0)
    end

UISettingDisplayPanel.OnAntiAliasingChanged =
    function(self, value)
        -- function num : 0_7

        (self.ctrl):SetAntiAliasingIndex(value == true and 1 or 0)
    end

return UISettingDisplayPanel

