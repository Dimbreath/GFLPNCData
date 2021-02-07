-- params : ...
-- function num : 0 , upvalues : _ENV
local UILogin = class("UILogin", UIBaseWindow)
local base = UIBaseWindow
local CS_Resources = (CS.UnityEngine).Resources
local CS_NetworkManager = (CS.NetworkManager).Instance
local CS_PlayerPrefs = (CS.UnityEngine).PlayerPrefs
local CS_PlayerPrefsExtension = CS.PlayerPrefsExtension
local CS_HotUpdateController = CS.HotUpdateController
local CS_ClientConsts = CS.ClientConsts
local CS_MicaSDKManager_Ins = (CS.MicaSDKManager).Instance
local isUseSDK = CS_MicaSDKManager_Ins:IsUseSdk()
local PlayerPrefsConsts = require("Game.Login.PlayerPrefsEnum")
local UINLoginLoading = require("Game.Login.UINLoginLoading")
UILogin.OnInit = function(self)
  -- function num : 0_0 , upvalues : CS_ClientConsts, _ENV, CS_Resources, CS_PlayerPrefsExtension, PlayerPrefsConsts, CS_PlayerPrefs, CS_NetworkManager, isUseSDK, UINLoginLoading
  ((self.ui).tex_Version):SetIndex(0, CS_ClientConsts.GameVersionStr)
  ;
  ((self.ui).obj_createUser):SetActive(false)
  AudioManager:PlayAudioById(3002)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Home).name, (eAuSelct.Home).base)
  ;
  (math.randomseed)((os.time)())
  local roleId = ((ConfigData.audio_voice_hero).totalVoiceHeroIdList)[(math.random)(#(ConfigData.audio_voice_hero).totalVoiceHeroIdList)]
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  cvCtr:PlayCv(roleId, eVoiceType.TITLE)
  self.serverConfigAsset = (CS_Resources.Load)("ServerConfigs")
  local listString = ((((CS.System).Collections).Generic).List)((CS.System).String)
  self.serverList = listString()
  for i = 0, ((self.serverConfigAsset).ServerConfigs).Length - 1 do
    local config = ((self.serverConfigAsset).ServerConfigs)[i]
    ;
    (self.serverList):Add(config.ServerName .. " - " .. config.IP .. ":" .. config.Port)
  end
  ;
  ((self.ui).serverDropdown):ClearOptions()
  ;
  ((self.ui).serverDropdown):AddOptions(self.serverList)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SwitchAccount, self, self.AccountSwitch)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnLogin, self, self.OnClickLogin)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnSkipLogin, self, self.OnClickSkipLogin)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Mode, self, self.OnServerModeChange)
  -- DECOMPILER ERROR at PC132: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tog_Mode).isOn = (CS_PlayerPrefsExtension.GetBool)(PlayerPrefsConsts.CustomServerMode)
  -- DECOMPILER ERROR at PC138: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).iptServer).text = (CS_PlayerPrefs.GetString)(PlayerPrefsConsts.CustomServerStr)
  -- DECOMPILER ERROR at PC144: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).serverDropdown).value = (CS_PlayerPrefs.GetInt)(PlayerPrefsConsts.ServerId)
  -- DECOMPILER ERROR at PC150: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).iptAcount).text = (CS_PlayerPrefs.GetString)(PlayerPrefsConsts.UserName)
  -- DECOMPILER ERROR at PC156: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).iptPassword).text = (CS_PlayerPrefs.GetString)(PlayerPrefsConsts.UserPassword)
  self.LoginNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Login)
  self.__onConnectComplete = BindCallback(self, self.OnConnectComplete)
  CS_NetworkManager:onConnectComplete("+", self.__onConnectComplete)
  self.__onRecvUserData = BindCallback(self, self.OnRecvUserData)
  MsgCenter:AddListener(eMsgEventId.SyncUserData, self.__onRecvUserData)
  if isEditorMode and ((CS.GMController).Instance).battleShortcut then
    self:OnClickLogin()
  end
  self.serverId = ((CS.FilePathHelper).Instance):ReadServerId()
  if self.serverId ~= nil and self.serverId ~= -1 then
    ((self.ui).selectServer):SetActive(false)
  else
    ;
    ((self.ui).selectServer):SetActive(true)
  end
  if isUseSDK then
    ((self.ui).loginInfo):SetActive(false)
    self.__requestGateInfo = BindCallback(self, self.RequestGateInfo)
    self:RequestGateInfo()
  end
  self.loadingNode = (UINLoginLoading.New)()
  ;
  (self.loadingNode):Init((self.ui).obj_enterTheGame)
end

UILogin.RequestGateInfo = function(self)
  -- function num : 0_1 , upvalues : _ENV, CS_MicaSDKManager_Ins
  ((CS.WaitNetworkResponse).Instance):StartWaitOrigin(eCustomWaitType.WaitGateInfo, nil, eCustomWaitType.WaitGateInfo)
  CS_MicaSDKManager_Ins:GetGateInfo(function(success)
    -- function num : 0_1_0 , upvalues : _ENV, self
    ((CS.WaitNetworkResponse).Instance):RemoveWait(eCustomWaitType.WaitGateInfo)
    if not success then
      ((CS.MessageCommon).ShowMessageBoxConfirm)(ConfigData:GetTipContent(TipContent.not_get_gateinfo), self.__requestGateInfo)
    end
  end
)
end

UILogin.OnServerModeChange = function(self, value)
  -- function num : 0_2
  ((self.ui).obj_server):SetActive(not value)
  ;
  ((self.ui).obj_customServer):SetActive(value)
end

UILogin.AccountSwitch = function(self)
  -- function num : 0_3 , upvalues : isUseSDK, CS_MicaSDKManager_Ins, CS_HotUpdateController
  if not isUseSDK then
    return 
  end
  CS_MicaSDKManager_Ins:AccountSwitch(function()
    -- function num : 0_3_0 , upvalues : CS_HotUpdateController, self
    (CS_HotUpdateController.TryCheckNewResVersion)(function(hasNewVersion)
      -- function num : 0_3_0_0 , upvalues : self
      self:__OnCheckVersionComplete(hasNewVersion)
    end
)
  end
)
end

UILogin.OnClickLogin = function(self)
  -- function num : 0_4 , upvalues : CS_PlayerPrefs, PlayerPrefsConsts, CS_PlayerPrefsExtension, isUseSDK, _ENV, CS_MicaSDKManager_Ins, CS_HotUpdateController
  (CS_PlayerPrefs.SetInt)(PlayerPrefsConsts.ServerId, ((self.ui).serverDropdown).value)
  local userName = ((self.ui).iptAcount).text
  ;
  (CS_PlayerPrefs.SetString)(PlayerPrefsConsts.UserName, userName)
  ;
  (CS_PlayerPrefs.SetString)(PlayerPrefsConsts.UserPassword, ((self.ui).iptPassword).text)
  ;
  (CS_PlayerPrefsExtension.SetBool)(PlayerPrefsConsts.CustomServerMode, ((self.ui).tog_Mode).isOn)
  ;
  (CS_PlayerPrefs.SetString)(PlayerPrefsConsts.CustomServerStr, ((self.ui).iptServer).text)
  if not isUseSDK then
    if (string.IsNullOrEmpty)(userName) then
      ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.login_NoticeUserName))
      return 
    end
    self:StartConnect()
  else
    CS_MicaSDKManager_Ins:StartLogin(function()
    -- function num : 0_4_0 , upvalues : CS_HotUpdateController, self
    (CS_HotUpdateController.TryCheckNewResVersion)(function(hasNewVersion)
      -- function num : 0_4_0_0 , upvalues : self
      self:__OnCheckVersionComplete(hasNewVersion)
    end
)
  end
)
  end
end

UILogin.__OnCheckVersionComplete = function(self, hasNewVersion)
  -- function num : 0_5 , upvalues : _ENV
  if hasNewVersion then
    ((CS.MessageCommon).ShowMessageBoxConfirm)(ConfigData:GetTipContent(TipContent.HasNewVersionToUpdate), function()
    -- function num : 0_5_0 , upvalues : _ENV
    (((CS.UnityEngine).Application).Quit)()
  end
)
  else
    self:StartConnectFromSDK()
  end
end

UILogin._TryCustomConnect = function(self)
  -- function num : 0_6 , upvalues : CS_ClientConsts, _ENV
  if CS_ClientConsts.CustomVersionInfo ~= nil and not (string.IsNullOrEmpty)((CS_ClientConsts.CustomVersionInfo).CustomGateAddress) then
    local gateInfo = (CS_ClientConsts.CustomVersionInfo).CustomGateAddress
    if not (string.IsNullOrEmpty)(gateInfo) then
      local tab = (string.split)(gateInfo, ":")
      if #tab == 2 then
        local ip = tab[1]
        local port = tonumber(tab[2])
        ;
        ((CS.NetworkEntry).Instance):StartConnect(ip, port)
        return true
      end
    end
    do
      do
        ;
        ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.login_IllegalServer))
        return false
      end
    end
  end
end

UILogin.StartConnectFromSDK = function(self)
  -- function num : 0_7 , upvalues : CS_MicaSDKManager_Ins, isUseSDK, _ENV
  if self:_TryCustomConnect() then
    return 
  end
  local ok, gateInfo = CS_MicaSDKManager_Ins:TryRandomGateInfo()
  if ok and isUseSDK then
    if not (string.IsNullOrEmpty)(gateInfo) then
      local tab = (string.split)(gateInfo, ":")
      if #tab == 2 then
        local ip = tab[1]
        local port = tonumber(tab[2])
        ;
        ((CS.NetworkEntry).Instance):StartConnect(ip, port)
        return 
      end
    end
    do
      ;
      ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.login_IllegalServer))
      do return  end
      ;
      ((CS.WaitNetworkResponse).Instance):StartWaitOrigin(eCustomWaitType.WaitGateInfo, eCustomWaitType.WaitGateInfo)
      CS_MicaSDKManager_Ins:GetGateInfo(function(success)
    -- function num : 0_7_0 , upvalues : _ENV, self
    ((CS.WaitNetworkResponse).Instance):RemoveWait(eCustomWaitType.WaitGateInfo)
    if not success then
      ((CS.MessageCommon).ShowMessageBoxConfirm)(ConfigData:GetTipContent(TipContent.not_get_gateinfo), function()
      -- function num : 0_7_0_0 , upvalues : self
      self:StartConnectFromSDK()
    end
)
    else
      self:StartConnectFromSDK()
    end
  end
)
    end
  end
end

UILogin.StartConnect = function(self, gateInfo)
  -- function num : 0_8 , upvalues : _ENV
  if self:_TryCustomConnect() then
    return 
  end
  if not ((self.ui).tog_Mode).isOn then
    local serverId = nil
    if self.serverId ~= nil and self.serverId ~= -1 then
      serverId = self.serverId
    else
      serverId = ((self.ui).serverDropdown).value
    end
    local ip, port = (self.serverConfigAsset):GetIpAndPort(serverId)
    if isGameDev then
      print("[Dev]server:", ip, port)
    end
    ;
    ((CS.NetworkEntry).Instance):StartConnect(ip, port)
  else
    do
      local customServer = ((self.ui).iptServer).text
      if not (string.IsNullOrEmpty)(customServer) then
        local tab = (string.split)(customServer, ":")
        if #tab == 2 then
          local ip = tab[1]
          local port = tonumber(tab[2])
          ;
          ((CS.NetworkEntry).Instance):StartConnect(ip, port)
          return 
        end
      end
      do
        ;
        ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.login_IllegalServer))
      end
    end
  end
end

UILogin.OnConnectComplete = function(self)
  -- function num : 0_9 , upvalues : CS_ClientConsts, _ENV, isUseSDK, CS_MicaSDKManager_Ins
  if CS_ClientConsts.CustomVersionInfo ~= nil and not (string.IsNullOrEmpty)((CS_ClientConsts.CustomVersionInfo).CustomUserName) and not (string.IsNullOrEmpty)((CS_ClientConsts.CustomVersionInfo).CustomToken) then
    (self.LoginNetworkCtrl):CS_Login((CS_ClientConsts.CustomVersionInfo).CustomUserName, (CS_ClientConsts.CustomVersionInfo).CustomToken)
    return 
  end
  if isUseSDK then
    (self.LoginNetworkCtrl):CS_Login(CS_MicaSDKManager_Ins.openId, CS_MicaSDKManager_Ins.accessToken)
  else
    ;
    (self.LoginNetworkCtrl):CS_Login(((self.ui).iptAcount).text)
  end
end

UILogin.OnRecvUserData = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.Login, true)):OnLoginUserDataComplete(true)
end

UILogin.GengrateRandomName = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local famulyName = require("LuaConfigs.player_familyName")
  local firstName = require("LuaConfigs.player_firstName")
  ;
  (math.randomseed)((os.time)())
  local num1 = (math.random)(#famulyName)
  local num2 = (math.random)(#firstName)
  local arg1 = (LanguageUtil.GetLocaleText)((famulyName[num1]).family_name)
  local arg2 = (LanguageUtil.GetLocaleText)((firstName[num2]).first_name)
  return arg1 .. arg2
end

UILogin.HideCreateUser = function(self)
  -- function num : 0_12
  ((self.ui).obj_createUser):SetActive(false)
end

UILogin.OnclickRandomNameBtn = function(self)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).inputField_createUser).text = self:GengrateRandomName()
end

UILogin.OnClickSkipLogin = function(self)
  -- function num : 0_14
  self:OnLoginComplete()
end

UILogin.ShowLoading = function(self)
  -- function num : 0_15
  ((self.ui).obj_login):SetActive(false)
  ;
  (self.loadingNode):Show()
  ;
  (self.loadingNode):InitLoginLoading()
end

UILogin.OnDelete = function(self)
  -- function num : 0_16 , upvalues : _ENV, CS_NetworkManager, CS_Resources, base
  (self.loadingNode):Delete()
  MsgCenter:RemoveListener(eMsgEventId.SyncUserData, self.__onRecvUserData)
  CS_NetworkManager:onConnectComplete("-", self.__onConnectComplete)
  ;
  (CS_Resources.UnloadAsset)(self.serverConfigAsset)
  ;
  (base.OnDelete)(self)
end

return UILogin

