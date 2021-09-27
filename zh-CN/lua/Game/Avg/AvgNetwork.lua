local AvgNetwork = class("AvgNetwork", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
AvgNetwork.ctor = function(self)
  -- function num : 0_0
  self.__avgCompleteTab = {}
end

AvgNetwork.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_AVG_Complete, self, proto_csmsg.SC_AVG_Complete, self.SC_AVG_Complete)
end

AvgNetwork.CS_AVG_Complete = function(self, avgId, callback)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.__avgCompleteTab).avgId = avgId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete, proto_csmsg.CS_AVG_Complete, self.__avgCompleteTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete, callback, proto_csmsg_MSG_ID.MSG_SC_AVG_Complete)
end

AvgNetwork.SC_AVG_Complete = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "SC_AVG_Complete error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete, false)
      cs_WaitNetworkResponse:WaitComplete(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete)
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete, true)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

AvgNetwork.Reset = function(self)
  -- function num : 0_4
end

return AvgNetwork

