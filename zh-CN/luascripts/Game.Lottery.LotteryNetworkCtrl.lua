-- params : ...
-- function num : 0 , upvalues : _ENV
local LotteryNetworkCtrl = class("LotteryNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
LotteryNetworkCtrl.ctor = function(self)
  -- function num : 0_0
end

LotteryNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecOnce, self, proto_csmsg.SC_LOTTERY_ExecOnce, self.OnRecvExecOnce)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecTen, self, proto_csmsg.SC_LOTTERY_ExecTen, self.OnRecvExecTen)
end

LotteryNetworkCtrl.SendExecuteOnce = function(self, pool, callBack)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  local tabMsg = {pool = pool}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce, proto_csmsg.CS_LOTTERY_ExecOnce, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecOnce)
end

LotteryNetworkCtrl.SendExecuteTen = function(self, pool, callBack)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  local tabMsg = {pool = pool}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen, proto_csmsg.CS_LOTTERY_ExecTen, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecTen)
end

LotteryNetworkCtrl.OnRecvExecOnce = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce, {msg.elem})
  else
    local err = "HeroNetworkCtrl:OnRecvExecOnce error:" .. tostring(msg.ret)
    print(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

LotteryNetworkCtrl.OnRecvExecTen = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen, msg.elem)
  else
    local err = "HeroNetworkCtrl:OnRecvExecTen error:" .. tostring(msg.ret)
    print(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

LotteryNetworkCtrl.Reset = function(self)
  -- function num : 0_6
end

return LotteryNetworkCtrl

