-- params : ...
-- function num : 0 , upvalues : _ENV
local FactoryNetworkCtrl = class("FactoryNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
FactoryNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.sendDataFactoryInstall = {}
  self.sendDataFactoryDestruct = {}
  self.sendDataFactoryRewardPick = {}
end

FactoryNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_Detail, self, proto_csmsg.SC_FACTORY_Detail, self.SC_FACTORY_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_LineInstall, self, proto_csmsg.SC_FACTORY_LineInstall, self.SC_FACTORY_LineInstall)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_LineDestruct, self, proto_csmsg.SC_FACTORY_LineDestruct, self.SC_FACTORY_LineDestruct)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_LineFinalRewardPick, self, proto_csmsg.SC_FACTORY_LineFinalRewardPick, self.SC_FACTORY_LineFinalRewardPick)
end

FactoryNetworkCtrl.CS_FACTORY_DETAIL = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Detail, proto_csmsg.CS_FACTORY_Detail, table.emptytable)
end

FactoryNetworkCtrl.SC_FACTORY_Detail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.Factory, true)):RecvFactoryDetail(msg)
end

FactoryNetworkCtrl.CS_FACTORY_LineInstall = function(self, id, cycle)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.sendDataFactoryInstall).id = id
  local msgTab = {}
  msgTab.id = id
  msgTab.cycle = cycle
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_LineInstall, proto_csmsg.CS_FACTORY_LineInstall, msgTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_LineInstall, proto_csmsg_MSG_ID.MSG_SC_FACTORY_LineInstall)
end

FactoryNetworkCtrl.SC_FACTORY_LineInstall = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.Factory, true)):RecvFactoryLineInstall(msg)
end

FactoryNetworkCtrl.CS_FACTORY_LineDestruct = function(self, uid)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.sendDataFactoryDestruct).uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_LineDestruct, proto_csmsg.CS_FACTORY_LineDestruct, self.sendDataFactoryDestruct)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_LineDestruct, proto_csmsg_MSG_ID.MSG_SC_FACTORY_LineDestruct)
end

FactoryNetworkCtrl.SC_FACTORY_LineDestruct = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.Factory, true)):RecvFactoryLineDestruct(msg)
end

FactoryNetworkCtrl.CS_FACTORY_LineFinalRewardPick = function(self, id)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.sendDataFactoryRewardPick).id = id
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_LineFinalRewardPick, proto_csmsg.CS_FACTORY_LineFinalRewardPick, self.sendDataFactoryRewardPick)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_LineFinalRewardPick, proto_csmsg_MSG_ID.MSG_SC_FACTORY_LineFinalRewardPick)
end

FactoryNetworkCtrl.SC_FACTORY_LineFinalRewardPick = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.Factory, true)):RecvFactoryRewardPick(msg)
end

FactoryNetworkCtrl.Reset = function(self)
  -- function num : 0_10
end

return FactoryNetworkCtrl

