local ActivityFrameNetworkCtrl = class("ActivityFrameNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
ActivityFrameNetworkCtrl.ctor = function(self)
  -- function num : 0_0
end

ActivityFrameNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Detail, self, proto_csmsg.SC_ACTIVITY_Detail, self.SC_ACTIVITY_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Wechat_Follow_Take, self, proto_csmsg.SC_ACTIVITY_Wechat_Follow_Take, self.SC_ACTIVITY_Wechat_Follow_Take)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Wechat_Detail, self, proto_csmsg.SC_ACTIVITY_Wechat_Detail, self.SC_ACTIVITY_Wechat_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Wechat_Followed_NTF, self, proto_csmsg.SC_ACTIVITY_Wechat_Followed_NTF, self.SC_ACTIVITY_Wechat_Followed_NTF)
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

ActivityFrameNetworkCtrl.CS_ACTIVITY_Wechat_Follow_Take = function(self, id, callback)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.id = id
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Wechat_Follow_Take, proto_csmsg.CS_ACTIVITY_Wechat_Follow_Take, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Wechat_Follow_Take, function()
    -- function num : 0_4_0 , upvalues : _ENV, id, callback
    local actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    actFrameCtr:UpdateWechatActivityRedeemed(id)
    callback()
  end
, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Wechat_Follow_Take)
end

ActivityFrameNetworkCtrl.SC_ACTIVITY_Wechat_Follow_Take = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= 0 then
      local err = "ActivityFrameNetworkCtrl:ACTIVITY_Wechat_Follow_Take error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Achievement)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ActivityFrameNetworkCtrl.CS_ACTIVITY_Wechat_Detail = function(self, ids, callback)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.ids = ids
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Wechat_Detail, proto_csmsg.CS_ACTIVITY_Wechat_Detail, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Wechat_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Wechat_Detail)
end

ActivityFrameNetworkCtrl.SC_ACTIVITY_Wechat_Detail = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV
  local actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  actFrameCtr:UpdateWechatActivityElems(msg.data)
end

ActivityFrameNetworkCtrl.SC_ACTIVITY_Wechat_Followed_NTF = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV
  local actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  actFrameCtr:UpdateWechatActivityFollowed(msg.id, true)
  MsgCenter:Broadcast(eMsgEventId.WechatUpdata)
end

ActivityFrameNetworkCtrl.ApplyActivityDiff = function(self, diffMsg)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC8: Unhandled construct in 'MakeBoolean' P3

  if (diffMsg ~= nil and (diffMsg.update ~= nil)) then
  end
end

ActivityFrameNetworkCtrl.Reset = function(self)
  -- function num : 0_10
end

return ActivityFrameNetworkCtrl

