-- params : ...
-- function num : 0 , upvalues : _ENV
local FactoryNetworkCtrl = class("FactoryNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local cs_MessageCommon = CS.MessageCommon
FactoryNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.sendDataFactoryInstall = {}
  self.sendDataFactoryDestruct = {}
  self.sendDataFactoryRewardPick = {}
end

FactoryNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_Detail, self, proto_csmsg.SC_FACTORY_Detail, self.SC_FACTORY_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_WorkshopProduct, self, proto_csmsg.SC_FACTORY_WorkshopProduct, self.SC_FACTORY_WorkshopProduct)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_DispatchHero, self, proto_csmsg.SC_FACTORY_DispatchHero, self.SC_FACTORY_DispatchHero)
end

FactoryNetworkCtrl.CS_FACTORY_Detail = function(self)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Detail, proto_csmsg.CS_FACTORY_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_Detail)
end

FactoryNetworkCtrl.SC_FACTORY_Detail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FactoryNetworkCtrl:SC_FACTORY_Detail error:" .. tostring(msg.ret)
    print(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
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
  -- function num : 0_4
end

FactoryNetworkCtrl.CS_FACTORY_WorkshopProduct = function(self, Order4SendData, callback)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {id = Order4SendData.lineIndex, order = Order4SendData.curOrderId, orderNum = Order4SendData.curOrderNum, assistOrders = Order4SendData.assistOrderDic, helpList = nil}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_WorkshopProduct, proto_csmsg.CS_FACTORY_WorkshopProduct, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_WorkshopProduct, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_WorkshopProduct)
end

FactoryNetworkCtrl.SC_FACTORY_WorkshopProduct = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "FactoryNetworkCtrl:SC_FACTORY_WorkshopProduct error:" .. tostring(msg.ret)
      print(err)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_WorkshopProduct)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

FactoryNetworkCtrl.CS_FACTORY_DispatchHero = function(self, lineId, helpList, callback)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {lineId = lineId, helpList = helpList}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_DispatchHero, proto_csmsg.CS_FACTORY_DispatchHero, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_DispatchHero, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_DispatchHero)
end

FactoryNetworkCtrl.SC_FACTORY_DispatchHero = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "FactoryNetworkCtrl:SC_FACTORY_DispatchHero error:" .. tostring(msg.ret)
      print(err)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_DispatchHero)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

FactoryNetworkCtrl.Reset = function(self)
  -- function num : 0_9
end

return FactoryNetworkCtrl

