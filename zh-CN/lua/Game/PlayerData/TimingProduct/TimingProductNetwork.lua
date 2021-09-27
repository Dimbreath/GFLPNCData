local TimingProductNetwork = class("TimingProductNetwork", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
TimingProductNetwork.ctor = function(self)
  -- function num : 0_0
  self.send_PickFixedReward = {}
  self.send_TimingProduct_PickAll = {}
  self.send_TimingProduct_Detail = {}
end

TimingProductNetwork.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TimingProduct_Pick, self, proto_csmsg.SC_TimingProduct_Pick, self.SC_TimingProduct_Pick)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TimingProduct_PickAll, self, proto_csmsg.SC_TimingProduct_PickAll, self.SC_TimingProduct_PickAll)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TimingProduct_Detail, self, proto_csmsg.SC_TimingProduct_Detail, self.SC_TimingProduct_Detail)
end

TimingProductNetwork.CS_TimingProduct_Pick = function(self, moduleId, rewardId, callBack)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.send_PickFixedReward).moduleId = moduleId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.send_PickFixedReward).id = rewardId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Pick, proto_csmsg.CS_TimingProduct_Pick, self.send_PickFixedReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Pick, callBack, proto_csmsg_MSG_ID.MSG_SC_TimingProduct_Pick)
end

TimingProductNetwork.SC_TimingProduct_Pick = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  local addItemDic = self:_GenAddItemNumDic(msg.syncUpdateDiff)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "TimingProductNetwork:SC_TimingProduct_Pick erro:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Pick)
      return 
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Pick, addItemDic)
  end
end

TimingProductNetwork.CS_TimingProduct_PickAll = function(self, moduleId, callBack)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.send_TimingProduct_PickAll).moduleId = moduleId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_PickAll, proto_csmsg.CS_TimingProduct_PickAll, self.send_TimingProduct_PickAll)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_PickAll, callBack, proto_csmsg_MSG_ID.MSG_SC_TimingProduct_PickAll)
end

TimingProductNetwork.SC_TimingProduct_PickAll = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  local addItemDic = self:_GenAddItemNumDic(msg.syncUpdateDiff)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "TimingProductNetwork:SC_TimingProduct_PickAll erro:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_PickAll)
      return 
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_PickAll, addItemDic)
  end
end

TimingProductNetwork._GenAddItemNumDic = function(self, syncUpdateDiff)
  -- function num : 0_6 , upvalues : _ENV
  if syncUpdateDiff == nil or syncUpdateDiff.resource == nil or (syncUpdateDiff.resource).backpack == nil then
    return table.emptytable
  end
  local addItemDic = {}
  for resId,v in pairs(((syncUpdateDiff.resource).backpack).updates) do
    local lastNum = PlayerDataCenter:GetItemCount(resId)
    local addNum = v.count - lastNum
    addItemDic[resId] = addNum
  end
  return addItemDic
end

TimingProductNetwork.CS_TimingProduct_Detail = function(self, moduleId, callBack)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.send_TimingProduct_Detail).moduleId = moduleId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Detail, proto_csmsg.CS_TimingProduct_Detail, self.send_TimingProduct_Detail)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Detail, callBack, proto_csmsg_MSG_ID.MSG_SC_TimingProduct_Detail)
end

TimingProductNetwork.SC_TimingProduct_Detail = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "TimingProductNetwork:SC_TimingProduct_Detail erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Detail)
  end
end

TimingProductNetwork.SC_TimingProduct_SyncUpdateDiff = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV
  (PlayerDataCenter.allTimingProduct):UpdAllTimingProduct(msg)
end

return TimingProductNetwork

