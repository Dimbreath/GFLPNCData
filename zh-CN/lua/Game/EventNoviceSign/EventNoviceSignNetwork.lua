local EventNoviceSignNetwork = class("EventNoviceSignNetwork", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
EventNoviceSignNetwork.ctor = function(self)
  -- function num : 0_0
  self._sendRecive = {}
end

EventNoviceSignNetwork.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SIGNACTIVITY_Detail, self, proto_csmsg.SC_SIGNACTIVITY_Detail, self.SC_SIGNACTIVITY_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SIGNACTIVITY_Pick, self, proto_csmsg.SC_SIGNACTIVITY_Pick, self.SC_SIGNACTIVITY_Pick)
end

EventNoviceSignNetwork.CS_SIGNACTIVITY_Detail = function(self)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SIGNACTIVITY_Detail, proto_csmsg.CS_SIGNACTIVITY_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_SIGNACTIVITY_Detail, proto_csmsg_MSG_ID.MSG_SC_SIGNACTIVITY_Detail)
end

EventNoviceSignNetwork.SC_SIGNACTIVITY_Detail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret == 0 then
    (PlayerDataCenter.eventNoviceSignData):InitNoviceSignData(msg.signAct)
  else
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SIGNACTIVITY_Detail)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

EventNoviceSignNetwork.CS_SIGNACTIVITY_Pick = function(self, id, callback)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  self._sendRecive = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SIGNACTIVITY_Pick, proto_csmsg.CS_SIGNACTIVITY_Pick, self._sendRecive)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_SIGNACTIVITY_Pick, callback, proto_csmsg_MSG_ID.MSG_SC_SIGNACTIVITY_Pick)
end

EventNoviceSignNetwork.SC_SIGNACTIVITY_Pick = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret == 0 then
    (PlayerDataCenter.eventNoviceSignData):UpdateNoviceSignData(msg.elem)
  else
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SIGNACTIVITY_Pick)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

return EventNoviceSignNetwork

