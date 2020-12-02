-- params : ...
-- function num : 0 , upvalues : _ENV
local UISetting = class("UISetting", UIBaseWindow)
local base = UIBaseWindow
local UISettingDisplayPanel = require("Game.Setting.UI.UISettingDisplayPanel")
local UINSettingTypeItem = require("Game.Setting.UI.UINSettingTypeItem")
UISetting.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.CloseSettingClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Logout, self, self.UserLogout)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_UserCenter, self, self.OpenUserCenter)
  if ((CS.MicaSDKManager).Instance).channelId == (Consts.GameChannelType).Bilibili then
    (((self.ui).btn_UserCenter).gameObject):SetActive(false)
  end
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  self:InitSettingTypeItem()
end

UISetting.InitSettingTypeItem = function(self)
  -- function num : 0_1 , upvalues : UINSettingTypeItem, _ENV
  self.settingTypeItemList = {}
  for i = 1, #(self.ui).settingTypeGroup do
    local typeItem = (UINSettingTypeItem.New)()
    typeItem:Init((((self.ui).settingTypeGroup)[i]).transform)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.settingTypeItemList)[i] = typeItem
    ;
    (UIUtil.AddValueChangedListener)(((self.ui).settingTypeGroup)[i], self, self.OnPanelToggleValueChanged, i)
  end
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self.ui).settingTypeGroup)[1]).isOn = true
end

UISetting.OnPanelToggleValueChanged = function(self, index, value)
  -- function num : 0_2
  if index == 1 then
    ((self.ui).displayPanel):SetActive(value)
    if value and not self.__isDisplayInited then
      self:InitDisplaySettingPanel()
      self.__isDisplayInited = true
    end
  else
    if index == 2 then
      ((self.ui).audioPanel):SetActive(value)
      if value and not self.__isAudioInited then
        self:InitAudioSettingPanel()
        self.__isAudioInited = true
      end
    else
      if index == 3 then
        ((self.ui).notifiesPanel):SetActive(value)
        if value and not self.__isNoticeInited then
          self:InitNoticeSettingPanel()
          self.__isNoticeInited = true
        end
      end
    end
  end
  ;
  ((self.settingTypeItemList)[index]):SetSettingTypeItemActive(value, self.ui)
end

UISetting.InitDisplaySettingPanel = function(self)
  -- function num : 0_3 , upvalues : UISettingDisplayPanel
  self.displayPanel = (UISettingDisplayPanel.New)()
  ;
  (self.displayPanel):Init((self.ui).displayPanel)
  ;
  (self.displayPanel):InitDisplayPanel(self.ctrl)
end

UISetting.InitAudioSettingPanel = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local audioSetting = (self.ctrl):GetSettingAudioData()
  for index = 1, AudioManager.AudioTypeCount do
    (UIUtil.AddValueChangedListener)(((self.ui).audioSliderGroup)[index], self, self.OnAudioVolumeChanged, index)
    ;
    (UIUtil.AddValueChangedListener)(((self.ui).audioTogGroup)[index], self, self.OnAudioSwitchChaned, index)
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((self.ui).audioSliderGroup)[index]).value = (audioSetting.volumes)[index] or 1
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((self.ui).audioTogGroup)[index]).isOn = (not (audioSetting.mutes)[index] and true)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UISetting.OnAudioVolumeChanged = function(self, index, value)
  -- function num : 0_5 , upvalues : _ENV
  local audioSetting = (self.ctrl):GetSettingAudioData()
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (audioSetting.volumes)[index] = value
  ;
  ((CS.AudioManager).Instance):SetVolume(index, value)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).audioVolTextGroup)[index]).text = tostring((math.floor)(value * 100))
end

UISetting.OnAudioSwitchChaned = function(self, index, value)
  -- function num : 0_6 , upvalues : _ENV
  local audioSetting = (self.ctrl):GetSettingAudioData()
  value = not value
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (audioSetting.mutes)[index] = value
  ;
  ((CS.AudioManager).Instance):SetMute(index, value)
end

UISetting.InitNoticeSettingPanel = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local noticeSwitchOffDic = (self.ctrl):GetSettingNoticeSwitch()
  self.noticeBind = {}
  ;
  (UIUtil.LuaUIBindingTable)(((self.ui).notifiesPanel).transform, self.noticeBind)
  for noticeId,bool in pairs(noticeSwitchOffDic) do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

    (((self.noticeBind).NoticeTogs)[noticeId]).isOn = not bool
    ;
    (UIUtil.AddValueChangedListener)(((self.noticeBind).NoticeTogs)[noticeId], self, self.OnNoticeTogValueChange, noticeId)
  end
end

UISetting.OnNoticeTogValueChange = function(self, noticeId, value)
  -- function num : 0_8
  (self.ctrl):SetNoticeSwitchOff(noticeId, not value)
end

UISetting.CloseSettingClicked = function(self)
  -- function num : 0_9
  self:Delete()
end

UISetting.UserLogout = function(self)
  -- function num : 0_10
  (self.ctrl):UserLogout()
end

UISetting.OpenUserCenter = function(self)
  -- function num : 0_11
  (self.ctrl):OpenUserCenter()
end

UISetting.OnHide = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil then
    homeWin:BackFromOtherCoverWin()
  end
  ;
  (base.OnHide)()
end

UISetting.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base, _ENV
  self.ctrl = nil
  ;
  (base.OnDelete)(self)
  local PersistentConfig = require("Game.PersistentManager.PersistentData.PersistentConfig")
  PersistentManager:SaveModelData((PersistentConfig.ePackage).SystemData)
  PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
end

return UISetting

