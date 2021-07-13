-- params : ...
-- function num : 0 , upvalues : _ENV
local LoginNetWorkCtrl = class("LoginNetWorkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_NetworkManager = (CS.NetworkManager).Instance
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
LoginNetWorkCtrl.ctor = function(self)
  -- function num : 0_0
end

LoginNetWorkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Login, self, proto_csmsg.SC_Login, self.SC_Login)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Logout, self, proto_csmsg.SC_Logout, self.SC_Logout)
end

LoginNetWorkCtrl.CS_Login = function(self, osdkUserId, token, clientVersionInfo, isReconnect, callBack)
  -- function num : 0_2 , upvalues : _ENV, cs_NetworkManager, cs_WaitNetworkResponse
  local loginMsg = {open_id = osdkUserId, token = token, version = clientVersionInfo}
  if not self.reConnSeq or not self.reConnSeq + 1 then
    self.reConnSeq = not isReconnect or 1
    if isGameDev and ((CS.GMController).Instance).netSeqLog then
      print("[CS_Login] reConnSeq : " .. tostring(self.reConnSeq))
    end
    loginMsg.reConnSeq = self.reConnSeq
    loginMsg.seq = {clientSeq = cs_NetworkManager.SeqClient, serverSeq = cs_NetworkManager.SeqServer}
    cs_WaitNetworkResponse:ResumeWait()
    local LuaNetworkAgent = require("Framework.Network.LuaNetworkAgent")
    LuaNetworkAgent:SaveLoginData(loginMsg)
    self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Login, proto_csmsg.CS_Login, loginMsg)
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Login, callBack, proto_csmsg_MSG_ID.MSG_SC_Login)
  end
end

LoginNetWorkCtrl.SC_Login = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_NetworkManager, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    PlayerDataCenter:UserLoginComplete(msg.role, msg.firstLogin)
    ;
    ((CS.WaitNetworkResponse).Instance):AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Login, true)
    if msg.seq == nil then
      (NetworkManager:GetNetwork(NetworkTypeID.Object)):WaitUserPreData()
    else
      cs_NetworkManager:DealReconnectedSeq((msg.seq).clientSeq, (msg.seq).serverSeq)
    end
  else
    local err = "LoginNetWorkCtrl:OnRecvLogin error:" .. tostring(msg.ret)
    warn(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    ;
    ((CS.WaitNetworkResponse).Instance):AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Login, false)
  end
end

LoginNetWorkCtrl.SC_Logout = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV
  local reason = msg.reason
  if reason == 0 then
    return 
  end
  local isLogin = ((CS.WaitNetworkResponse).Instance):ContainWait(proto_csmsg_MSG_ID.MSG_CS_Login)
  if reason > 100 then
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
      ;
      ((CS.NetworkManager).Instance):CloseAndQuitToLogin(msg)
      return 
    end
    if reason == proto_csmsg_UserStatus.StatusOtherDeviceLogin then
      ((CS.NetworkManager).Instance):CloseAndQuitToLogin(ConfigData:GetTipContent(270))
      return 
    end
    if reason == proto_csmsg_UserStatus.StatusHeatbeatOvertime then
      ((CS.NetworkManager).Instance):CloseAndQuitToLogin(ConfigData:GetTipContent(271))
      return 
    end
    if reason == proto_csmsg_UserStatus.StatusIsFreeze then
      ((CS.NetworkManager).Instance):CloseAndQuitToLogin(ConfigData:GetTipContent(276))
      return 
    end
    if reason == proto_csmsg_UserStatus.StatusInvalidGuestToken or reason == proto_csmsg_UserStatus.StatusInvalidUserToken then
      ((CS.NetworkManager).Instance):CloseAndQuitToLogin(ConfigData:GetTipContent(402))
      return 
    end
    ;
    ((CS.NetworkManager).Instance):CloseAndQuitToLogin((string.format)(ConfigData:GetTipContent(272), reason))
  end
end

LoginNetWorkCtrl.Reset = function(self)
  -- function num : 0_5
end

return LoginNetWorkCtrl

