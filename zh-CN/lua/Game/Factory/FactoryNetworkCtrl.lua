local FactoryNetworkCtrl = class("FactoryNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
FactoryNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.sendDataFactoryInstall = {}
  self.sendDataFactoryDestruct = {}
  self.sendDataFactoryRewardPick = {}
  self.ProductMsg = {}
  self.cancleOrderMsg = {}
end

FactoryNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_Detail, self, proto_csmsg.SC_FACTORY_Detail, self.SC_FACTORY_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_WorkshopProduct, self, proto_csmsg.SC_FACTORY_WorkshopProduct, self.SC_FACTORY_WorkshopProduct)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_ConsumeTimeProduct, self, proto_csmsg.SC_FACTORY_ConsumeTimeProduct, self.SC_FACTORY_ConsumeTimeProduct)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_CancelOrder, self, proto_csmsg.SC_FACTORY_CancelOrder, self.SC_FACTORY_CancelOrder)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_ImmediatelyComplete, self, proto_csmsg.SC_FACTORY_ImmediatelyComplete, self.SC_FACTORY_ImmediatelyComplete)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_Collect, self, proto_csmsg.SC_FACTORY_Collect, self.SC_FACTORY_Collect)
end

FactoryNetworkCtrl.CS_FACTORY_Detail = function(self, callback)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Detail, proto_csmsg.CS_FACTORY_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_Detail)
end

FactoryNetworkCtrl.SC_FACTORY_Detail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FactoryNetworkCtrl:SC_FACTORY_Detail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Detail)
  else
    do
      ;
      (ControllerManager:GetController(ControllerTypeId.Factory, false)):OnRecRoomHeroList((msg.detail).workshopGroup)
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

FactoryNetworkCtrl.FactoryCommonDiff = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.Factory, false)):HandleFactoryDiff(msg)
end

FactoryNetworkCtrl.CS_FACTORY_WorkshopProduct = function(self, Order4SendData, callback)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  (self.ProductMsg).id = Order4SendData.lineIndex
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.ProductMsg).order = Order4SendData.curOrderId
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.ProductMsg).orderNum = Order4SendData.curOrderNum
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.ProductMsg).assistOrders = Order4SendData.assistOrderDic
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.ProductMsg).helpList = nil
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_WorkshopProduct, proto_csmsg.CS_FACTORY_WorkshopProduct, self.ProductMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_WorkshopProduct, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_WorkshopProduct)
end

FactoryNetworkCtrl.SC_FACTORY_WorkshopProduct = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "FactoryNetworkCtrl:SC_FACTORY_WorkshopProduct error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_WorkshopProduct)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

FactoryNetworkCtrl.CS_FACTORY_ConsumeTimeProduct = function(self, Order4SendData, callback)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  (self.ProductMsg).id = Order4SendData.lineIndex
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.ProductMsg).order = Order4SendData.curOrderId
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.ProductMsg).orderNum = Order4SendData.curOrderNum
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.ProductMsg).assistOrders = Order4SendData.assistOrderDic
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.ProductMsg).helpList = nil
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_ConsumeTimeProduct, proto_csmsg.CS_FACTORY_ConsumeTimeProduct, self.ProductMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_ConsumeTimeProduct, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_ConsumeTimeProduct)
end

FactoryNetworkCtrl.SC_FACTORY_ConsumeTimeProduct = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "FactoryNetworkCtrl:SC_FACTORY_ConsumeTimeProduct error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_ConsumeTimeProduct)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

FactoryNetworkCtrl.CS_FACTORY_CancelOrder = function(self, roomIndex, uid, callback)
  -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.cancleOrderMsg).workshopId = roomIndex
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.cancleOrderMsg).uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_CancelOrder, proto_csmsg.CS_FACTORY_CancelOrder, self.cancleOrderMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_CancelOrder, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_CancelOrder)
end

FactoryNetworkCtrl.SC_FACTORY_CancelOrder = function(self, msg)
  -- function num : 0_10 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "FactoryNetworkCtrl:SC_FACTORY_CancelOrder error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_CancelOrder)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

FactoryNetworkCtrl.CS_FACTORY_ImmediatelyComplete = function(self, roomIndex, uid, callback)
  -- function num : 0_11 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.cancleOrderMsg).workshopId = roomIndex
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.cancleOrderMsg).uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_ImmediatelyComplete, proto_csmsg.CS_FACTORY_ImmediatelyComplete, self.cancleOrderMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_ImmediatelyComplete, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_ImmediatelyComplete)
end

FactoryNetworkCtrl.SC_FACTORY_ImmediatelyComplete = function(self, msg)
  -- function num : 0_12 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "FactoryNetworkCtrl:SC_FACTORY_ImmediatelyComplete error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_ImmediatelyComplete)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

FactoryNetworkCtrl.CS_FACTORY_Collect = function(self, roomIndex, uid, callback)
  -- function num : 0_13 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.cancleOrderMsg).workshopId = roomIndex
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.cancleOrderMsg).uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Collect, proto_csmsg.CS_FACTORY_Collect, self.cancleOrderMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Collect, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_Collect)
end

FactoryNetworkCtrl.SC_FACTORY_Collect = function(self, msg)
  -- function num : 0_14 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "FactoryNetworkCtrl:SC_FACTORY_Collect error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Collect)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

FactoryNetworkCtrl.Reset = function(self)
  -- function num : 0_15
end

return FactoryNetworkCtrl

