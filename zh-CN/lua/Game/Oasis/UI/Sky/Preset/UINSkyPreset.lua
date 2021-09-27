local UINSkyPreset = class("UINSkyPreset", UIBaseNode)
local base = UIBaseNode
local UINSkyPresetItem = require("Game.Oasis.UI.Sky.Preset.UINSkyPresetItem")
UINSkyPreset.ctor = function(self, uiSkyRoot)
  -- function num : 0_0
  self.uiSkyRoot = uiSkyRoot
end

UINSkyPreset.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINSkyPresetItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CloseDefList, self, self._OnClickClose)
  ;
  ((self.ui).tog_PresetItem):SetActive(false)
  self.presetItemPool = (UIItemPool.New)(UINSkyPresetItem, (self.ui).tog_PresetItem)
  self._OnSelectPresetFunc = BindCallback(self, self._OnSelectPreset)
  local presetItem = (self.presetItemPool):GetOne()
  presetItem:InitSkyPresetItem(0, nil, self._OnSelectPresetFunc)
  for k,presetCfg in ipairs(ConfigData.oasis_weather_preset) do
    local presetItem = (self.presetItemPool):GetOne()
    local name = (LanguageUtil.GetLocaleText)(presetCfg.preset_name)
    presetItem:InitSkyPresetItem(k, name, self._OnSelectPresetFunc)
  end
end

UINSkyPreset.InitSkyPreset = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self._isInit = true
  self:Show()
  ;
  (UIUtil.SetTopStatus)(self, self.Hide)
  if not self._inited then
    self._inited = true
  end
  ;
  ((self.ui).list_TogGroup):SetAllTogglesOff()
  local presetId = ((self.uiSkyRoot).oasisSkyCtrl):GetSkyPresetId()
  do
    if presetId ~= -1 then
      local presetItem = ((self.presetItemPool).listItem)[presetId + 1]
      if presetItem ~= nil then
        presetItem:SetSkyPresetItemTogOn()
      end
    end
    self._isInit = false
  end
end

UINSkyPreset._OnSelectPreset = function(self, index)
  -- function num : 0_3
  if self._isInit then
    return 
  end
  ;
  (self.uiSkyRoot):SetUISkyPreset(index)
  self:_OnClickClose()
end

UINSkyPreset._OnClickClose = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UINSkyPreset.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.presetItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINSkyPreset

