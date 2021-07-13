-- params : ...
-- function num : 0 , upvalues : _ENV
local LotteryNetworkCtrl = class("LotteryNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
LotteryNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.onceTab = {}
  self.tenTab = {}
  self.onceSpecialTab = {}
  self.pickPtTab = {}
end

LotteryNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecOnce, self, proto_csmsg.SC_LOTTERY_ExecOnce, self.OnRecvExecOnce)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecTen, self, proto_csmsg.SC_LOTTERY_ExecTen, self.OnRecvExecTen)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecOnceSpecial, self, proto_csmsg.SC_LOTTERY_ExecOnceSpecial, self.SC_LOTTERY_ExecOnceSpecial)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_Detail, self, proto_csmsg.SC_LOTTERY_Detail, self.SC_LOTTERY_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_PickPt, self, proto_csmsg.SC_LOTTERY_PickPt, self.SC_LOTTERY_PickPt)
end

LotteryNetworkCtrl.SC_LOTTERY_SyncDiff = function(self, msg)
  -- function num : 0_2 , upvalues : _ENV
  (PlayerDataCenter.allLtrData):UpdAllLtrPoolData(msg.update)
end

LotteryNetworkCtrl.SendExecuteOnce = function(self, pool, callBack)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.onceTab).pool = pool
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce, proto_csmsg.CS_LOTTERY_ExecOnce, self.onceTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecOnce)
end

LotteryNetworkCtrl.SendExecuteTen = function(self, pool, callBack)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.tenTab).pool = pool
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen, proto_csmsg.CS_LOTTERY_ExecTen, self.tenTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecTen)
end

LotteryNetworkCtrl.OnRecvExecOnce = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce, {msg.elem})
  else
    local err = "OnRecvExecOnce error:" .. tostring(msg.ret)
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
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
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

LotteryNetworkCtrl.CS_LOTTERY_ExecOnceSpecial = function(self, poolId, callBack)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.onceSpecialTab).poolId = poolId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnceSpecial, proto_csmsg.CS_LOTTERY_ExecOnceSpecial, self.onceSpecialTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnceSpecial, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecOnceSpecial)
end

LotteryNetworkCtrl.SC_LOTTERY_ExecOnceSpecial = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "SC_LOTTERY_ExecOnceSpecial error:" .. tostring(msg.ret)
      error(err)
      ;
      (cs_MessageCommon.ShowMessageTips)(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnceSpecial)
      return 
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnceSpecial, {msg.elem})
  end
end

LotteryNetworkCtrl.CS_LOTTERY_Detail = function(self, callBack)
  -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_Detail, proto_csmsg.CS_LOTTERY_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_Detail, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_Detail)
end

LotteryNetworkCtrl.SC_LOTTERY_Detail = function(self, msg)
  -- function num : 0_10 , upvalues : _ENV
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  ;
  (PlayerDataCenter.allLtrData):UpdAllLtrPoolData(msg.detail)
end

LotteryNetworkCtrl.CS_LOTTERY_PickPt = function(self, poolId, pickKey, callBack)
  -- function num : 0_11 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.pickPtTab).poolId = poolId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.pickPtTab).pickKey = pickKey
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_PickPt, proto_csmsg.CS_LOTTERY_PickPt, self.pickPtTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_PickPt, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_PickPt)
end

LotteryNetworkCtrl.SC_LOTTERY_PickPt = function(self, msg)
  -- function num : 0_12 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_LOTTERY_PickPt error:" .. tostring(msg.ret)
    error(err)
    ;
    (cs_MessageCommon.ShowMessageTips)(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_PickPt)
    return 
  end
end

LotteryNetworkCtrl.Reset = function(self)
  -- function num : 0_13
end

return LotteryNetworkCtrl

