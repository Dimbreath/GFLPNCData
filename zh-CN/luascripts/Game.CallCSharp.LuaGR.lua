-- params : ...
-- function num : 0 , upvalues : _ENV
LuaGR = {}
local util = require("XLua.Common.util")
-- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

LuaGR.MsgCenterBroadcast = function(eventType, ...)
    -- function num : 0_0 , upvalues : _ENV
    MsgCenter:Broadcast(eventType, ...)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

LuaGR.RequireAndNew = function(name)
    -- function num : 0_1 , upvalues : _ENV
    return ((require(name)).New)()
end

local __QuitToLogin = function()
    -- function num : 0_2 , upvalues : _ENV
    (TimelineUtil.StopAll)()
    GuideManager:SkipGuide()
    ExplorationManager:ClearExploration()
    BattleDungeonManager:ClearBattleDungeon();
    ((CS.BattleManager).Instance):ForceExitBattle()
    ControllerManager:DeleteAllController()
    NetworkManager:ResetAllNetwork()
    UIManager:DeleteAllWindow()
    UIManager:ClearAllAsyncLoad();
    ((CS.UIManager).Instance):DeleteAllWindow();
    ((CS.NetworkManager).Instance):Disconnect()
    PlayerDataCenter:InitData();
    (RedDotController.RedDotDriver):ResetAllData();
    ((CS.GSceneManager).Instance):LoadSceneAsync((Consts.SceneName).Empty,
                                                 function()
        -- function num : 0_2_0 , upvalues : _ENV
        UIManager:ShowWindow(UIWindowTypeID.Login)
    end) -- DECOMPILER ERROR at PC57: Confused about usage of register: R0 in 'UnsetPending'
    ;
    (Time.unity_time).timeScale = 1
    PersistentManager:HandleLogOut()
end

local __LogoutToLogin = function(isLogoutUser)
    -- function num : 0_3 , upvalues : _ENV, __QuitToLogin
    local isUseSDK = ((CS.MicaSDKManager).Instance):IsUseSdk()
    if isLogoutUser and isUseSDK then
        ((CS.MicaSDKManager).Instance):Logout(__QuitToLogin)
    else
        __QuitToLogin()
    end
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

LuaGR.LogoutToLogin = function(isLogoutUser)
    -- function num : 0_4 , upvalues : _ENV, __LogoutToLogin, util
    local loginWindow = UIManager:GetWindow(UIWindowTypeID.Login)
    if loginWindow ~= nil then
        loginWindow:HideCreateUser();
        ((CS.NetworkManager).Instance):Disconnect()
        if isLogoutUser then ((CS.MicaSDKManager).Instance):Logout() end
    else
        local CS_GSceneMgr = (CS.GSceneManager).Instance
        do
            if not CS_GSceneMgr.isLoading then
                __LogoutToLogin(isLogoutUser)
            else
                local waitSceneLoad = function()
                    -- function num : 0_4_0 , upvalues : _ENV, CS_GSceneMgr, loginWindow, isLogoutUser, __LogoutToLogin
                    while 1 do
                        (coroutine.yield)()
                        if not CS_GSceneMgr.isLoading then
                            loginWindow =
                                UIManager:GetWindow(UIWindowTypeID.Login)
                            if loginWindow ~= nil then
                                loginWindow:HideCreateUser();
                                ((CS.NetworkManager).Instance):Disconnect()
                                if isLogoutUser then
                                    ((CS.MicaSDKManager).Instance):Logout()
                                end
                                break
                            end
                            __LogoutToLogin(isLogoutUser)
                            break
                        end
                    end
                end;
                (GR.StartCoroutine)((util.cs_generator)(waitSceneLoad))
            end
        end
    end
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

LuaGR.OnDisconected = function()
    -- function num : 0_5 , upvalues : _ENV
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
    if avgCtrl ~= nil then avgCtrl:SetAvgAutoPlayMode(false) end
    ((CS.AudioManager).Instance):StopAllAudio();
    ((CS.MovieManager).Instance):PauseAllMoviePlayer()
    local battleCtrl = ((CS.BattleManager).Instance).CurBattleController
    if battleCtrl ~= nil then battleCtrl:TryPauseBattle() end
end

