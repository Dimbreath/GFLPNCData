-- params : ...
-- function num : 0 , upvalues : _ENV
local ActivityFrameNetworkCtrl = class("ActivityFrameNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
ActivityFrameNetworkCtrl.ctor = function(self)
  -- function num : 0_0
end

ActivityFrameNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Detail, self, proto_csmsg.SC_ACTIVITY_Detail, self.SC_ACTIVITY_Detail)
end

ActivityFrameNetworkCtrl.CS_ACTIVITY_Detail = function(self, callback)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Detail, proto_csmsg.CS_ACTIVITY_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Detail)
end

ActivityFrameNetworkCtrl.SC_ACTIVITY_Detail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  ;
  (ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)):UpdateActivity(msg.data)
end

ActivityFrameNetworkCtrl.ApplyActivityDiff = function(self, diffMsg)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC8: Unhandled construct in 'MakeBoolean' P3

  if (diffMsg ~= nil and (diffMsg.update ~= nil)) then
  end
end

ActivityFrameNetworkCtrl.Reset = function(self)
  -- function num : 0_5
end

return ActivityFrameNetworkCtrl

