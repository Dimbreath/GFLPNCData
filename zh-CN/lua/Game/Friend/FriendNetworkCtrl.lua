local FriendNetworkCtrl = class("FriendNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local cs_MessageCommon = CS.MessageCommon
FriendNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.uidMsg = {}
end

FriendNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_Push, self, proto_csmsg.SC_FRIEND_Push, self.SC_FRIEND_Push)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_ApplyFriend, self, proto_csmsg.SC_FRIEND_ApplyFriend, self.SC_FRIEND_ApplyFriend)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_IgnoreApply, self, proto_csmsg.SC_FRIEND_IgnoreApply, self.SC_FRIEND_IgnoreApply)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_AgreeApply, self, proto_csmsg.SC_FRIEND_AgreeApply, self.SC_FRIEND_AgreeApply)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_DissolveFriend, self, proto_csmsg.SC_FRIEND_DissolveFriend, self.SC_FRIEND_DissolveFriend)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_NotifyNewApply, self, proto_csmsg.SC_FRIEND_NotifyNewApply, self.SC_FRIEND_NotifyNewApply)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FRIEND_RefreshFriend, self, proto_csmsg.SC_FRIEND_RefreshFriend, self.SC_FRIEND_RefreshFriend)
end

FriendNetworkCtrl.SC_FRIEND_Push = function(self, msg)
  -- function num : 0_2 , upvalues : _ENV
  (PlayerDataCenter.friendDataCenter):OnReceiveFriendInitData(msg)
end

FriendNetworkCtrl.HandleFriendDiffer = function(self, diffMsg)
  -- function num : 0_3 , upvalues : _ENV
  if diffMsg.friendUpdate ~= nil then
    (PlayerDataCenter.friendDataCenter):UpadteFrendList(diffMsg.friendUpdate)
  end
  if diffMsg.blackUpdate ~= nil then
    (PlayerDataCenter.friendDataCenter):UpdateFriendBlackList(diffMsg.blackUpdate)
  end
  if diffMsg.friendDelete ~= nil then
    (PlayerDataCenter.friendDataCenter):UpadteFrendList(diffMsg.friendDelete, true)
  end
  if diffMsg.blackDelete ~= nil then
    (PlayerDataCenter.friendDataCenter):UpdateFriendBlackList(diffMsg.blackDelete, true)
  end
end

FriendNetworkCtrl.CS_FRIEND_ApplyFriend = function(self, uid, callback)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.uidMsg).uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FRIEND_ApplyFriend, proto_csmsg.CS_FRIEND_ApplyFriend, self.uidMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_ApplyFriend, callback, proto_csmsg_MSG_ID.MSG_SC_FRIEND_ApplyFriend)
end

FriendNetworkCtrl.SC_FRIEND_ApplyFriend = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_FRIEND_ApplyFriend error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_ApplyFriend)
  else
    do
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

FriendNetworkCtrl.CS_FRIEND_IgnoreApply = function(self, uid, callback)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.uidMsg).uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FRIEND_IgnoreApply, proto_csmsg.CS_FRIEND_IgnoreApply, self.uidMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_IgnoreApply, callback, proto_csmsg_MSG_ID.MSG_SC_FRIEND_IgnoreApply)
end

FriendNetworkCtrl.SC_FRIEND_IgnoreApply = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_FRIEND_IgnoreApply error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_IgnoreApply)
  else
    do
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

FriendNetworkCtrl.CS_FRIEND_AgreeApply = function(self, uid, callback)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.uidMsg).uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FRIEND_AgreeApply, proto_csmsg.CS_FRIEND_AgreeApply, self.uidMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_AgreeApply, callback, proto_csmsg_MSG_ID.MSG_SC_FRIEND_AgreeApply)
end

FriendNetworkCtrl.SC_FRIEND_AgreeApply = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.ERROR_FRIEND_RECEIVE_FRIEND then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Friend_AddFailure))
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_FRIEND_AgreeApply, false)
  else
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "SC_FRIEND_AgreeApply error,code:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_AgreeApply)
    end
  end
  do
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_FRIEND_AgreeApply, true)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

FriendNetworkCtrl.CS_FRIEND_DissolveFriend = function(self, uid, callback)
  -- function num : 0_10 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.uidMsg).uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FRIEND_DissolveFriend, proto_csmsg.CS_FRIEND_DissolveFriend, self.uidMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_DissolveFriend, callback, proto_csmsg_MSG_ID.MSG_SC_FRIEND_DissolveFriend)
end

FriendNetworkCtrl.SC_FRIEND_DissolveFriend = function(self, msg)
  -- function num : 0_11 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_FRIEND_DissolveFriend error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_AgreeApply)
  else
    do
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

FriendNetworkCtrl.SC_FRIEND_NotifyNewApply = function(self, msg)
  -- function num : 0_12 , upvalues : _ENV
  (PlayerDataCenter.friendDataCenter):OnGetNewApplyNotice(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

FriendNetworkCtrl.CS_FRIEND_RefreshFriend = function(self)
  -- function num : 0_13 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FRIEND_RefreshFriend, proto_csmsg.CS_FRIEND_RefreshFriend, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_RefreshFriend, proto_csmsg_MSG_ID.MSG_SC_FRIEND_RefreshFriend)
end

FriendNetworkCtrl.SC_FRIEND_RefreshFriend = function(self, msg)
  -- function num : 0_14 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_FRIEND_RefreshFriend error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FRIEND_RefreshFriend)
  else
    do
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
      ;
      (PlayerDataCenter.friendDataCenter):UpdateHeroListData(msg.friend)
    end
  end
end

FriendNetworkCtrl.Reset = function(self)
  -- function num : 0_15
end

return FriendNetworkCtrl

