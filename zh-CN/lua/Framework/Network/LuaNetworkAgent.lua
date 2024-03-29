local LuaNetworkAgent = class("LuaNetworkAgent")
local util = require("XLua.Common.xlua_util")
local JumpManager = require("Game.Jump.JumpManager")
local cs_EventSystem = ((CS.UnityEngine).EventSystems).EventSystem
LuaNetworkAgent.ctor = function(self)
  -- function num : 0_0
  self.__startReconnect = false
end

LuaNetworkAgent.__ClearQuitData = function(self)
  -- function num : 0_1 , upvalues : _ENV, JumpManager
  ((CS.RenderManager).Instance):ResetRenderSetting()
  TimerManager:ClearCommand()
  ;
  (TimelineUtil.StopAll)()
  NoticeManager:OnLogOut()
  GuideManager:OnQuitAndClear()
  ExplorationManager:ClearExploration()
  BattleDungeonManager:ClearBattleDungeon(true)
  ;
  ((CS.BattleManager).Instance):ForceExitBattle()
  NetworkManager:ResetAllNetwork()
  UIManager:DeleteAllWindow()
  UIManager:HideAllWindow()
  UIManager:ClearAllAsyncLoad()
  ControllerManager:DeleteAllController()
  ;
  ((CS.UIManager).Instance):DeleteAllWindow()
  PlayerDataCenter:OnLogOut()
  UnlockCenter:InitUnlockCenter()
  ;
  (RedDotController.RedDotDriver):ResetAllData()
  JumpManager:CleanJumpManager()
  ;
  (UIUtil.CloseAllCover)()
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (Time.unity_time).timeScale = 1
  self._isDisconnected = false
  self._lastTimeScale = nil
end

LuaNetworkAgent.__QuitToLogin = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:__ClearQuitData()
  ;
  ((CS.NetworkManager).Instance):Disconnect()
  ;
  ((CS.GSceneManager).Instance):LoadSceneAsync((Consts.SceneName).Empty, function()
    -- function num : 0_2_0 , upvalues : _ENV
    UIManager:ShowWindow(UIWindowTypeID.Login)
  end
)
  PersistentManager:HandleLogOut()
end

LuaNetworkAgent.__LogoutToLogin = function(self, isLogoutUser)
  -- function num : 0_3 , upvalues : _ENV
  local isUseSDK = ((CS.MicaSDKManager).Instance):IsUseSdk()
  if isLogoutUser and isUseSDK then
    ((CS.MicaSDKManager).Instance):Logout(function()
    -- function num : 0_3_0 , upvalues : self
    self:__QuitToLogin()
  end
)
  else
    self:__QuitToLogin()
  end
end

LuaNetworkAgent.LogoutToLogin = function(self, isLogoutUser)
  -- function num : 0_4 , upvalues : _ENV, util
  local loginWindow = UIManager:GetWindow(UIWindowTypeID.Login)
  if loginWindow ~= nil then
    loginWindow:HideCreateUser()
    ;
    ((CS.NetworkManager).Instance):Disconnect()
    if isLogoutUser then
      ((CS.MicaSDKManager).Instance):Logout()
    end
    AudioManager:PlayAudioById(3002, nil, false)
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Home).name, (eAuSelct.Home).base)
  else
    local CS_GSceneMgr = (CS.GSceneManager).Instance
    do
      if not CS_GSceneMgr.isLoading then
        self:__LogoutToLogin(isLogoutUser)
      else
        local waitSceneLoad = function()
    -- function num : 0_4_0 , upvalues : _ENV, CS_GSceneMgr, loginWindow, isLogoutUser, self
    while 1 do
      (coroutine.yield)()
      if not CS_GSceneMgr.isLoading then
        loginWindow = UIManager:GetWindow(UIWindowTypeID.Login)
        if loginWindow ~= nil then
          loginWindow:HideCreateUser()
          ;
          ((CS.NetworkManager).Instance):Disconnect()
          if isLogoutUser then
            ((CS.MicaSDKManager).Instance):Logout()
          end
          break
        end
        self:__LogoutToLogin(isLogoutUser)
        break
      end
    end
  end

        ;
        (GR.StartCoroutine)((util.cs_generator)(waitSceneLoad))
      end
    end
  end
end

LuaNetworkAgent.OnServerKickOut = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local homeController = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeController ~= nil then
    homeController:StopHomeOnHookTimer()
  end
end

LuaNetworkAgent.OnDisconected = function(self)
  -- function num : 0_6 , upvalues : _ENV, cs_EventSystem
  MsgCenter:Broadcast(eMsgEventId.OnDisconnect)
  if not self._isDisconnected then
    local pauseTime = false
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
    if avgCtrl ~= nil then
      avgCtrl:SetAvgAutoPlayMode(false)
    end
    ;
    ((CS.MovieManager).Instance):PauseAllMoviePlayer()
    if ExplorationManager:IsInExploration() then
      ((ExplorationManager.epCtrl).autoCtrl):CloseAutoMode()
    end
    local battleCtrl = ((CS.BattleManager).Instance).CurBattleController
    if battleCtrl ~= nil and battleCtrl:BattleIsRunning() then
      pauseTime = true
      local uiBattleSkill = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
      if uiBattleSkill ~= nil and (uiBattleSkill.inputModeMaskUI).active then
        (uiBattleSkill.inputModeMaskUI):InvokeCancleInputAction()
      end
    end
    do
      do
        local ltrCtrl = ControllerManager:GetController(ControllerTypeId.Lottery)
        if ltrCtrl ~= nil and ltrCtrl:IsInLotteryShow() then
          pauseTime = true
        end
        if self._lastTimeScale == nil and pauseTime then
          self._lastTimeScale = (Time.unity_time).timeScale
          -- DECOMPILER ERROR at PC82: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (Time.unity_time).timeScale = 0
        end
        UIManager:HideWindow(UIWindowTypeID.MessageCommon)
        UIManager:DeleteWindow(UIWindowTypeID.GameNotice)
        ;
        (cs_EventSystem.current):SetSelectedGameObject(nil)
        self._isDisconnected = true
        self.loginData = nil
        if self.__startReconnect and self.__reconnectAction ~= nil then
          (self.__reconnectAction)(false)
        end
        self.__startReconnect = false
        self.__reconnectAction = nil
        self.__inExploration = false
      end
    end
  end
end

LuaNetworkAgent.SaveLoginData = function(self, loginData)
  -- function num : 0_7
  self.loginData = loginData
end

LuaNetworkAgent.CanReconnectGame = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local loginWindow = UIManager:GetWindow(UIWindowTypeID.Login)
  if loginWindow ~= nil then
    return false
  end
  if self.loginData == nil then
    return false
  end
  return true
end

LuaNetworkAgent.StartReconnectGame = function(self, reconnectAction)
  -- function num : 0_9 , upvalues : _ENV
  self.__reconnectAction = reconnectAction
  self.__startReconnect = true
  self.__inExploration = ExplorationManager:IsInExploration()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Login)):CS_Login((self.loginData).open_id, (self.loginData).token, (CS.ClientConsts).GameVersionStr, true, function(msgList)
    -- function num : 0_9_0 , upvalues : self, _ENV
    -- DECOMPILER ERROR at PC8: Unhandled construct in 'MakeBoolean' P1

    if msgList.Count == 0 and self.__reconnectAction ~= nil then
      (self.__reconnectAction)(false)
      self.__reconnectAction = nil
    end
    local success = msgList[0]
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    if success then
      if self._lastTimeScale ~= nil then
        (Time.unity_time).timeScale = self._lastTimeScale
        self._lastTimeScale = nil
      end
      ;
      ((CS.MovieManager).Instance):PauseAllMoviePlayer()
      self._isDisconnected = false
    end
    if self.__reconnectAction ~= nil then
      (self.__reconnectAction)(success)
      self.__reconnectAction = nil
    end
  end
)
end

LuaNetworkAgent.OnRecvExploraionDetail = function(self)
  -- function num : 0_10 , upvalues : _ENV, util
  if not self.__startReconnect then
    return 
  end
  self.__startReconnect = false
  ;
  (GR.StartCoroutine)((util.cs_generator)(self.__StartAfterReconnect, self))
end

LuaNetworkAgent.__StartAfterReconnect = function(self)
  -- function num : 0_11 , upvalues : _ENV
  while 1 do
    local CS_GSceneMgr = (CS.GSceneManager).Instance
    if CS_GSceneMgr.isLoading then
      do
        (coroutine.yield)()
        -- DECOMPILER ERROR at PC9: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC9: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  UIManager:HideWindow(UIWindowTypeID.Loading)
  if ExplorationManager:HasUncompletedEp() and self.__inExploration then
    self.__inExploration = false
    ExplorationManager:ContinueLastExploration()
    return 
  end
  ;
  (ControllerManager:GetController(ControllerTypeId.Login, true)):OnLoginUserDataComplete()
end

return LuaNetworkAgent

