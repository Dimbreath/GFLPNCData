local UIUSkySystem = class("UIUSkySystem", UIBaseWindow)
local base = UIBaseWindow
local UINSkyPosInput = require("Game.Oasis.UI.Sky.UINSkyPosInput")
local UINSkyPreset = require("Game.Oasis.UI.Sky.Preset.UINSkyPreset")
local UINSkyMap = require("Game.Oasis.UI.Sky.UINSkyMap")
local cs_SkyController = CS.SkyController
local CS_EventTriggerListener = CS.EventTriggerListener
UIUSkySystem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, CS_EventTriggerListener, UINSkyMap
  (UIUtil.AddValueChangedListener)((self.ui).slider_Month, self, self._OnValueChange_Month)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).slider_Hour, self, self._OnValueChange_Hour)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ChangePos, self, self._OnClickChangePos)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Random, self, self._OnClickRandom)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_DefList, self, self._OnClickPreset)
  self._OnHourChangeFunc = BindCallback(self, self._OnHourChange)
  self._OnMonthChangeFunc = BindCallback(self, self._OnMonthChange)
  ;
  ((CS_EventTriggerListener.Get)(((self.ui).slider_Month).gameObject)):onDown("+", BindCallback(self, self._OnPointerDownSliderMonth))
  ;
  ((CS_EventTriggerListener.Get)(((self.ui).slider_Month).gameObject)):onUp("+", BindCallback(self, self._OnPointerUpSliderMonth))
  ;
  ((CS_EventTriggerListener.Get)(((self.ui).slider_Hour).gameObject)):onDown("+", BindCallback(self, self._OnPointerDownSliderHour))
  ;
  ((CS_EventTriggerListener.Get)(((self.ui).slider_Hour).gameObject)):onUp("+", BindCallback(self, self._OnPointerUpSliderHour))
  self.skyMapNode = (UINSkyMap.New)(self)
  ;
  (self.skyMapNode):Init((self.ui).mapNode)
end

UIUSkySystem.InitOasisSkyUI = function(self, oasisSkyCtrl)
  -- function num : 0_1 , upvalues : _ENV, cs_SkyController
  self.oasisSkyCtrl = oasisSkyCtrl
  ;
  (UIUtil.SetTopStatus)(self, self._ExitSkySystem)
  self:_UpdHour((math.floor)((cs_SkyController.Instance).Timeline))
  self:_UpdMonth((cs_SkyController.Instance).Month)
  local latitude = (cs_SkyController.Instance).Latitude
  local longitude = (cs_SkyController.Instance).Longitude
  self:UpdSkySystemLocation(latitude, longitude, false, true)
  ;
  (self.skyMapNode):InitSkyMap(latitude, longitude)
  self:_ShowSkySideTween(true)
end

UIUSkySystem.OnShow = function(self)
  -- function num : 0_2 , upvalues : base, cs_SkyController
  (base.OnShow)(self)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (cs_SkyController.Instance).OnHourChange = self._OnHourChangeFunc
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (cs_SkyController.Instance).OnMonthChange = self._OnMonthChangeFunc
end

UIUSkySystem.OnHide = function(self)
  -- function num : 0_3 , upvalues : cs_SkyController, base
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (cs_SkyController.Instance).OnHourChange = nil
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (cs_SkyController.Instance).OnMonthChange = nil
  ;
  (base.OnHide)(self)
end

UIUSkySystem._OnHourChange = function(self, hour)
  -- function num : 0_4
  self:_UpdHour(hour)
end

UIUSkySystem._OnMonthChange = function(self, month)
  -- function num : 0_5
  self:_UpdMonth(month)
end

UIUSkySystem._ShowSkySideTween = function(self, show)
  -- function num : 0_6
  if self.sideIsShow == show then
    return 
  end
  self.sideIsShow = show
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).root_CanvasGroup).blocksRaycasts = show
  if show then
    ((self.ui).sideTween):DORestart()
  else
    ;
    ((self.ui).sideTween):DOPlayBackwards()
  end
end

UIUSkySystem.UpdSkySystemLocation = function(self, latitude, longitude, withSet, notSetMap)
  -- function num : 0_7 , upvalues : _ENV
  if self.longitude == longitude and self.latitude == latitude then
    return 
  end
  self.longitude = longitude
  self.latitude = latitude
  local lontSign = ""
  if longitude > 0 then
    lontSign = "E"
  else
    if longitude < 0 then
      lontSign = "W"
    end
  end
  local latSign = ""
  if latitude > 0 then
    latSign = "N"
  else
    if latitude < 0 then
      latSign = "S"
    end
  end
  ;
  ((self.ui).tex_Pos):SetIndex(0, tostring(FormatNum((math.abs)(latitude))), latSign, tostring(FormatNum((math.abs)(longitude))), lontSign)
  if not notSetMap then
    (self.skyMapNode):SetSkyMapLocation(latitude, longitude)
  end
  if withSet then
    (self.oasisSkyCtrl):SetSkyLocation(latitude, longitude, self.hour)
    ;
    (self.oasisSkyCtrl):SetSkyPresetIdSave(-1)
  end
end

UIUSkySystem._UpdHour = function(self, hour, withSet)
  -- function num : 0_8 , upvalues : _ENV
  hour = FormatNum(hour)
  if self.hour == hour then
    return 
  end
  self.hour = hour
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Hour).text = tostring(hour)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  if ((self.ui).slider_Hour).value ~= hour then
    ((self.ui).slider_Hour).value = hour
  end
  if withSet then
    (self.oasisSkyCtrl):SetSkyHour(hour)
  end
end

UIUSkySystem._UpdMonth = function(self, month, withSet)
  -- function num : 0_9 , upvalues : _ENV
  month = FormatNum(month)
  if self.month == month then
    return 
  end
  self.month = month
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Month).text = tostring(month)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  if ((self.ui).slider_Month).value ~= month then
    ((self.ui).slider_Month).value = month
  end
  if withSet then
    (self.oasisSkyCtrl):SetSkyMonth(month)
  end
end

UIUSkySystem._OnValueChange_Month = function(self, value)
  -- function num : 0_10
  if self.month == value then
    return 
  end
  self:_UpdMonth(value, true)
end

UIUSkySystem._OnValueChange_Hour = function(self, value)
  -- function num : 0_11
  if self.hour == value then
    return 
  end
  self:_UpdHour(value, true)
end

UIUSkySystem._OnPointerDownSliderHour = function(self)
  -- function num : 0_12
  ((self.ui).normal):SetActive(false)
  ;
  ((self.ui).month):SetActive(false)
end

UIUSkySystem._OnPointerUpSliderHour = function(self)
  -- function num : 0_13
  ((self.ui).normal):SetActive(true)
  ;
  ((self.ui).month):SetActive(true)
end

UIUSkySystem._OnPointerDownSliderMonth = function(self)
  -- function num : 0_14
  ((self.ui).normal):SetActive(false)
  ;
  ((self.ui).hour):SetActive(false)
end

UIUSkySystem._OnPointerUpSliderMonth = function(self)
  -- function num : 0_15
  ((self.ui).normal):SetActive(true)
  ;
  ((self.ui).hour):SetActive(true)
end

UIUSkySystem._OnClickChangePos = function(self)
  -- function num : 0_16 , upvalues : UINSkyPosInput
  if self.posInputNode == nil then
    self.posInputNode = (UINSkyPosInput.New)(self)
    ;
    (self.posInputNode):Init((self.ui).posInputNode)
  end
  ;
  (self.posInputNode):InitSkyPosInput(self.latitude, self.longitude)
end

UIUSkySystem._OnClickRandom = function(self)
  -- function num : 0_17
  local longitude = nil
  local latitude, longitude, month, hour = (self.oasisSkyCtrl):GenRandomOasisSkySetting(self.hour)
  self:UpdSkySystemLocation(latitude, longitude, true)
  self:_UpdMonth(month, true)
  self:_UpdHour(hour, true)
end

UIUSkySystem._OnClickPreset = function(self)
  -- function num : 0_18 , upvalues : UINSkyPreset
  if self.presetNode == nil then
    self.presetNode = (UINSkyPreset.New)(self)
    ;
    (self.presetNode):Init((self.ui).presetListNode)
  end
  ;
  (self.presetNode):InitSkyPreset()
end

UIUSkySystem.SetUISkyPreset = function(self, presetId)
  -- function num : 0_19 , upvalues : _ENV
  local latitude, longitude, month, hour = nil, nil, nil, nil
  if presetId == 0 then
    latitude = (self.oasisSkyCtrl):GetDefaultSkySetting()
  else
    local presetCfg = (ConfigData.oasis_weather_preset)[presetId]
    latitude = presetCfg.latitude
    -- DECOMPILER ERROR at PC15: Overwrote pending register: R3 in 'AssignReg'

    -- DECOMPILER ERROR at PC25: Overwrote pending register: R5 in 'AssignReg'

    -- DECOMPILER ERROR at PC28: Overwrote pending register: R5 in 'AssignReg'

    -- DECOMPILER ERROR at PC31: Overwrote pending register: R5 in 'AssignReg'

    -- DECOMPILER ERROR at PC38: Overwrote pending register: R4 in 'AssignReg'

  end
  do
    -- DECOMPILER ERROR at PC40: Overwrote pending register: R4 in 'AssignReg'

    if presetCfg.day_time ~= 0 or presetCfg.month == 0 then
      self:_UpdHour(hour, true)
      self:_UpdMonth(month)
      ;
      (self.oasisSkyCtrl):SetSkyMonth(month)
      self:UpdSkySystemLocation(latitude, longitude, true)
      ;
      (self.oasisSkyCtrl):SetSkyPresetIdSave(presetId)
    end
  end
end

UIUSkySystem._ExitSkySystem = function(self)
  -- function num : 0_20 , upvalues : _ENV
  self:_ShowSkySideTween(false)
  PersistentManager:SaveModelData((PersistentConfig.ePackage).SystemData)
  ;
  ((self.oasisSkyCtrl).oasisCtrl):ExitOasisSkyMode()
end

UIUSkySystem.OnDelete = function(self)
  -- function num : 0_21 , upvalues : base
  if self.posInputNode ~= nil then
    (self.posInputNode):OnDelete()
  end
  if self.presetNode ~= nil then
    (self.presetNode):OnDelete()
  end
  ;
  (self.skyMapNode):OnDelete()
  ;
  (base.OnDelete)(self)
end

return UIUSkySystem

