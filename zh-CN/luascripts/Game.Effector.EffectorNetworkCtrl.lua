-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectorNetworkCtrl = class("EffectorNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
EffectorNetworkCtrl.ctor = function(self)
  -- function num : 0_0
end

EffectorNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EFFECTOR_ResourceGenerator, self, proto_csmsg.SC_EFFECTOR_ResourceGenerator, self.SC_EFFECTOR_ResourceGenerator)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EFFECTOR_RGSyncUpdateDiff, self, proto_csmsg.SC_EFFECTOR_RGSyncUpdateDiff, self.SC_EFFECTOR_RGSyncUpdateDiff)
end

EffectorNetworkCtrl.CS_EFFECTOR_ResourceGenerator = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EFFECTOR_ResourceGenerator, proto_csmsg.CS_EFFECTOR_ResourceGenerator, table.emptytable)
end

EffectorNetworkCtrl.SC_EFFECTOR_ResourceGenerator = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
  for _,v in pairs(msg.rg) do
    (PlayerDataCenter.allEffectorData):UpdateResourceData(v)
  end
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Building)):InitBuildingRedDotOasis()
end

EffectorNetworkCtrl.SC_EFFECTOR_RGSyncUpdateDiff = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV
  local allEffectorData = PlayerDataCenter.allEffectorData
  for _,v in pairs(msg.update) do
    allEffectorData:UpdateResourceData(v)
  end
  for uid,_ in pairs(msg.delete) do
    allEffectorData:DeleteResourceData(uid)
  end
end

EffectorNetworkCtrl.Reset = function(self)
  -- function num : 0_5
end

return EffectorNetworkCtrl

