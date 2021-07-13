-- params : ...
-- function num : 0 , upvalues : _ENV
local UISetting = class("UISetting", UIBaseWindow)
local base = UIBaseWindow
local UISettingDisplayPanel = require("Game.Setting.UI.UISettingDisplayPanel")
local UINSettingTypeItem = require("Game.Setting.UI.UINSettingTypeItem")
local UINNotifySettingNode = require("Game.Setting.UI.UINNotifySettingNode")
local UINCDKeyPanelNode = require("Game.Setting.UI.UINCDKeyPanelNode")
local cs_MicaSDKManager = (CS.MicaSDKManager).Instance
UISetting.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_MicaSDKManager
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.CloseSettingClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Logout, self, self.UserLogout)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_UserCenter, self, self.OpenUserCenter)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Customer, self, self.EnterCustomService)
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  self.notifySettingNode = nil
  self.__onCustomerNewMsg = BindCallback(self, self.OnCustomerNewMsg)
  cs_MicaSDKManager:onHaveNewMsg("+", self.__onCustomerNewMsg)
  if (CS.ClientConsts).IsAudit or cs_MicaSDKManager.channelId == (Consts.GameChannelType).Bilibili or cs_MicaSDKManager.channelId == (Consts.GameChannelType).BilibiliKol or cs_MicaSDKManager.channelId == (Consts.GameChannelType).BilibiliQATest then
    (((self.ui).btn_UserCenter).gameObject):SetActive(false)
    ;
    (((self.ui).btn_Customer).gameObject):SetActive(false)
  else
    cs_MicaSDKManager:CheckCustomNewMsg()
  end
  self:InitSettingTypeItem()
  local isGiftUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_GiftCode)
  self:SetCDKButtomActive(isGiftUnlock)
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
      else
        if index == 4 then
          ((self.ui).cDKeyPanel):SetActive(value)
          if value and not self.__iscDKeyPanel then
            self:InitCDKeyPanel()
            self.__iscDKeyPanel = true
          end
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
  (self.ctrl):SetSettingAudioVolume(index, value)
  ;
  ((CS.AudioManager).Instance):SetVolume(index, value)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).audioVolTextGroup)[index]).text = tostring((math.floor)(value * 100))
end

UISetting.OnAudioSwitchChaned = function(self, index, value)
  -- function num : 0_6 , upvalues : _ENV
  value = not value
  ;
  (self.ctrl):SetSettingAudioMute(index, value)
  ;
  ((CS.AudioManager).Instance):SetMute(index, value)
end

UISetting.InitNoticeSettingPanel = function(self)
  -- function num : 0_7 , upvalues : UINNotifySettingNode
  local noticeSwitchOffDic = (self.ctrl):GetSettingNoticeSwitch()
  if self.notifySettingNode == nil then
    self.notifySettingNode = (UINNotifySettingNode.New)()
    ;
    (self.notifySettingNode):Init((self.ui).notifiesPanel)
  end
  ;
  (self.notifySettingNode):InitNotifySettingNode(noticeSwitchOffDic)
end

UISetting.InitCDKeyPanel = function(self)
  -- function num : 0_8 , upvalues : UINCDKeyPanelNode
  if self.cDKeyPanelNode == nil then
    self.cDKeyPanelNode = (UINCDKeyPanelNode.New)()
    ;
    (self.cDKeyPanelNode):Init((self.ui).cDKeyPanel)
  end
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

UISetting.EnterCustomService = function(self)
  -- function num : 0_12
  ((self.ui).redDot_Customer):SetActive(false)
  ;
  (self.ctrl):EnterCustomService()
end

UISetting.OnCustomerNewMsg = function(self, value)
  -- function num : 0_13
  if value then
    ((self.ui).redDot_Customer):SetActive(true)
  end
end

UISetting.SetCDKButtomActive = function(self, active)
  -- function num : 0_14
  ((((self.ui).settingTypeGroup)[4]).gameObject):SetActive(active)
end

UISetting.SetUIMailHideCallback = function(self, callback)
  -- function num : 0_15
  self.__hideCallback = callback
end

UISetting.OnHide = function(self)
  -- function num : 0_16 , upvalues : base
  self:OnCloseWin()
  if self.__hideCallback ~= nil then
    (self.__hideCallback)()
  end
  ;
  (base.OnHide)()
end

UISetting.OnDelete = function(self)
  -- function num : 0_17 , upvalues : cs_MicaSDKManager, base, _ENV
  cs_MicaSDKManager:onHaveNewMsg("-", self.__onCustomerNewMsg)
  self.ctrl = nil
  ;
  (base.OnDelete)(self)
  PersistentManager:SaveModelData((PersistentConfig.ePackage).SystemData)
  PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
end

return UISetting

