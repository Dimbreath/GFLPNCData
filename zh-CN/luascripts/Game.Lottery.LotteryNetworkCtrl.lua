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
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_Detail, self, proto_csmsg.SC_LOTTERY_Detail, self.OnRecvDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecOnce, self, proto_csmsg.SC_LOTTERY_ExecOnce, self.OnRecvExecOnce)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecTen, self, proto_csmsg.SC_LOTTERY_ExecTen, self.OnRecvExecTen)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_SyncUpdateDiff, self, proto_csmsg.SC_LOTTERY_SyncUpdateDiff, self.OnRecvSyncUpdateDiff)
end

LotteryNetworkCtrl.SendGetLotteryDetail = function(self)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_Detail, proto_csmsg.CS_LOTTERY_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_Detail, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_Detail)
end

LotteryNetworkCtrl.SendExecuteOnce = function(self, pool, isFree, callBack)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  self.isFree = isFree
  local tabMsg = {pool = pool}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce, proto_csmsg.CS_LOTTERY_ExecOnce, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecOnce)
end

LotteryNetworkCtrl.SendExecuteTen = function(self, pool, callBack)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  local tabMsg = {pool = pool}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen, proto_csmsg.CS_LOTTERY_ExecTen, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecTen)
end

LotteryNetworkCtrl.OnRecvDetail = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    PlayerDataCenter:UpdateLotteryCfg(msg.detail)
    ;
    ((RedDotController.RedDotDriver).InitLotteryRedDot)()
    local window = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
    if window ~= nil then
      window:OnLotteryDataReUpdate()
    end
  else
    do
      local err = "LotteryNetworkCtrl:OnRecvDetail error:" .. tostring(msg.ret)
      print(err)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_Detail)
    end
  end
end

LotteryNetworkCtrl.OnRecvExecOnce = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    local window = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
    if window ~= nil then
      window:ShowResult({msg.elem})
    end
  else
    do
      local err = "HeroNetworkCtrl:OnRecvExecOnce error:" .. tostring(msg.ret)
      print(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
    end
  end
end

LotteryNetworkCtrl.OnRecvExecTen = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    local window = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
    if window ~= nil then
      window:ShowResult(msg.elem)
    end
  else
    do
      local err = "HeroNetworkCtrl:OnRecvExecTen error:" .. tostring(msg.ret)
      print(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
    end
  end
end

LotteryNetworkCtrl.OnRecvSyncUpdateDiff = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV
  PlayerDataCenter:UpdateLotteryCfg(msg.updates)
  if self.isFree then
    ((RedDotController.RedDotDriver).UpdateLotteryFreeEvent)()
    self.isFree = nil
  end
end

LotteryNetworkCtrl.Reset = function(self)
  -- function num : 0_9
end

return LotteryNetworkCtrl

