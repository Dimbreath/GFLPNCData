local HomeChatNetworkCtrl = class("HomeChatNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
HomeChatNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.msg4switchChannel = {}
  self.msg4send = {}
end

HomeChatNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CHAT_AssignChannel, self, proto_csmsg.SC_CHAT_AssignChannel, self.SC_CHAT_AssignChannel)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CHAT_AvailableChannels, self, proto_csmsg.SC_CHAT_AvailableChannels, self.SC_CHAT_AvailableChannels)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CHAT_SwitchChannel, self, proto_csmsg.SC_CHAT_SwitchChannel, self.SC_CHAT_SwitchChannel)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CHAT_Message, self, proto_csmsg.SC_CHAT_Message, self.SC_CHAT_Message)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CHAT_PushMessage, self, proto_csmsg.SC_CHAT_PushMessage, self.SC_CHAT_PushMessage)
end

HomeChatNetworkCtrl.SC_CHAT_AssignChannel = function(self, msg)
  -- function num : 0_2 , upvalues : _ENV
  (PlayerDataCenter.homeChatDataCenter):SetCurChannel(msg.channel)
end

HomeChatNetworkCtrl.CS_CHAT_AvailableChannels = function(self, callback)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_CHAT_AvailableChannels, proto_csmsg.CS_CHAT_AvailableChannels, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_CHAT_AvailableChannels, function()
    -- function num : 0_3_0 , upvalues : callback
    if callback ~= nil then
      callback()
    end
  end
, proto_csmsg_MSG_ID.MSG_SC_CHAT_AvailableChannels)
end

HomeChatNetworkCtrl.SC_CHAT_AvailableChannels = function(self, msg)
  -- function num : 0_4 , upvalues : cs_WaitNetworkResponse, _ENV
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_CHAT_AvailableChannels, msg)
end

HomeChatNetworkCtrl.CS_CHAT_SwitchChannel = function(self, channel, callback)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.msg4switchChannel).channel = channel
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_CHAT_SwitchChannel, proto_csmsg.CS_CHAT_SwitchChannel, self.msg4switchChannel)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_CHAT_SwitchChannel, function()
    -- function num : 0_5_0 , upvalues : callback
    if callback ~= nil then
      callback()
    end
  end
, proto_csmsg_MSG_ID.MSG_SC_CHAT_SwitchChannel)
end

HomeChatNetworkCtrl.SC_CHAT_SwitchChannel = function(self, msg)
  -- function num : 0_6 , upvalues : cs_WaitNetworkResponse, _ENV
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_CHAT_SwitchChannel, msg)
end

HomeChatNetworkCtrl.CS_CHAT_Message = function(self, emoji_id, message)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.msg4send).emoji_id = emoji_id
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.msg4send).message = message
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_CHAT_Message, proto_csmsg.CS_CHAT_Message, self.msg4send)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_CHAT_Message, proto_csmsg_MSG_ID.MSG_SC_CHAT_Message)
end

HomeChatNetworkCtrl.SC_CHAT_Message = function(self)
  -- function num : 0_8
end

HomeChatNetworkCtrl.SC_CHAT_PushMessage = function(self)
  -- function num : 0_9
end

HomeChatNetworkCtrl.Reset = function(self)
  -- function num : 0_10
end

return HomeChatNetworkCtrl

