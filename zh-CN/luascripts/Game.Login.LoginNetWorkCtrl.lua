-- params : ...
-- function num : 0 , upvalues : _ENV
local LoginNetWorkCtrl = class("LoginNetWorkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
LoginNetWorkCtrl.ctor = function(self)
    -- function num : 0_0
end

LoginNetWorkCtrl.InitNetwork = function(self)
    -- function num : 0_1 , upvalues : _ENV
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Login, self,
                         proto_csmsg.SC_Login, self.OnRecvLogin)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Logout, self,
                         proto_csmsg.SC_Logout, self.SC_Logout)
end

LoginNetWorkCtrl.SendLogin = function(self, osdkUserId, token)
    -- function num : 0_2 , upvalues : _ENV
    local loginMsg = {open_id = osdkUserId, token = token}
    self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Login, proto_csmsg.CS_Login, loginMsg);
    ((CS.WaitNetworkResponse).Instance):StartWait(
        proto_csmsg_MSG_ID.MSG_CS_Login, proto_csmsg_MSG_ID.MSG_SC_Login)
end

LoginNetWorkCtrl.OnRecvLogin = function(self, msg)
    -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon
    if msg.ret ~= proto_csmsg_ErrorCode.LOGIN_USER_NOT_FOUNT or msg.ret ==
        proto_csmsg_ErrorCode.None then
        PlayerDataCenter:UserLoginComplete(msg.role);
        (NetworkManager:GetNetwork(NetworkTypeID.Object)):WaitUserPreData()
    else
        local err = "LoginNetWorkCtrl:OnRecvLogin error:" .. tostring(msg.ret)
        warn(err)
        if isGameDev then (cs_MessageCommon.ShowMessageTips)(err) end
    end
end

LoginNetWorkCtrl.SC_Logout = function(self, msg)
    -- function num : 0_4 , upvalues : _ENV
    local reason = msg.reason
    if reason == 0 then return end
    local isLogin = ((CS.WaitNetworkResponse).Instance):ContainWait(
                        proto_csmsg_MSG_ID.MSG_CS_Login)
    if reason > 100 then
        ((CS.MicaSDKManager).Instance):UpdateAddictionCode(reason, isLogin);
        ((CS.NetworkManager).Instance):ResetNetworkState()
        return
    end
    do
        if reason == proto_csmsg_UserStatus.StatusServerMaintain then
            local msg = nil
            if isLogin then
                msg = ConfigData:GetTipContent(269)
            else
                msg = ConfigData:GetTipContent(274)
            end
            ((CS.NetworkManager).Instance):CloseAndQuitToLogin(msg)
            return
        end
        if reason == proto_csmsg_UserStatus.StatusOtherDeviceLogin then
            ((CS.NetworkManager).Instance):CloseAndQuitToLogin(
                ConfigData:GetTipContent(270))
            return
        end
        if reason == proto_csmsg_UserStatus.StatusHeatbeatOvertime then
            ((CS.NetworkManager).Instance):CloseAndQuitToLogin(
                ConfigData:GetTipContent(271))
            return
        end
        if reason == proto_csmsg_UserStatus.StatusIsFreeze then
            ((CS.NetworkManager).Instance):CloseAndQuitToLogin(
                ConfigData:GetTipContent(276))
            return
        end
        ((CS.NetworkManager).Instance):CloseAndQuitToLogin(
            (string.format)(ConfigData:GetTipContent(272), reason))
    end
end

LoginNetWorkCtrl.Reset = function(self)
    -- function num : 0_5
end

return LoginNetWorkCtrl

