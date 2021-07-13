-- params : ...
-- function num : 0 , upvalues : _ENV
local NetworkManager = class("NetworkManager")
local pb = require("pb")
;
(pb.option)("int64_as_number")
;
(pb.option)("enum_as_value")
local cs_NetworkManager = (CS.NetworkManager).Instance
local cs_NetMsgData = CS.NetMsgData
local cs_ResLoader = CS.ResLoader
local cs_Resources = (CS.UnityEngine).Resources
local LuaNetworkAgent = require("Framework.Network.LuaNetworkAgent")
local UpdateHandle = function(self)
  -- function num : 0_0
end

NetworkManager.ctor = function(self)
  -- function num : 0_1 , upvalues : LuaNetworkAgent, cs_NetworkManager, _ENV, UpdateHandle
  self.luaNetworkAgent = (LuaNetworkAgent.New)()
  cs_NetworkManager.luaNetworkAgent = self.luaNetworkAgent
  self.__msgEventTable = {}
  self.__update_handle = UpdateBeat:CreateListener(UpdateHandle, self)
  UpdateBeat:AddListener(self.__update_handle)
  self.__packet_recv_handle = BindCallback(self, self._OnPacketRecv)
  cs_NetworkManager:onTcpPacket("+", self.__packet_recv_handle)
  self.__network_ctrls = {}
end

NetworkManager.InitNetwork = function(self)
  -- function num : 0_2 , upvalues : cs_ResLoader, _ENV, pb, cs_Resources
  local resloader = (cs_ResLoader.Create)()
  for k,v in ipairs(NetworkProtoFiles) do
    local pbTextAsset = resloader:LoadABAsset(PathConsts.PbFilePath .. v)
    ;
    (pb.load)(pbTextAsset.bytes)
    ;
    (cs_Resources.UnloadAsset)(pbTextAsset)
  end
  resloader:Put2Pool()
  for k,v in pairs(NetworkTypeID) do
    local config = NetworkGlobalConfig[v]
    local network = ((config.NetworkClass).New)()
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.__network_ctrls)[v] = network
    network:InitNetwork()
  end
  local NetworkDiffDeliver = require("Framework.Network.NetworkDiffDeliver")
  self.networkDiffDeliver = NetworkDiffDeliver
end

NetworkManager.HandleDiff = function(self, syncUpdateDiff)
  -- function num : 0_3
  (self.networkDiffDeliver):HandleDiff(syncUpdateDiff)
end

NetworkManager.GetRewardShowCache = function(self)
  -- function num : 0_4
  return (self.networkDiffDeliver):GetRewardCache()
end

NetworkManager.GetNetwork = function(self, networkId)
  -- function num : 0_5
  local network = (self.__network_ctrls)[networkId]
  return network
end

NetworkManager._OnPacketRecv = function(self, msgData)
  -- function num : 0_6
  if msgData == nil then
    return 
  end
  local cmdId = msgData.CmdID
  if (self.__msgEventTable)[cmdId] ~= nil then
    ((self.__msgEventTable)[cmdId])(msgData)
  end
end

NetworkManager.SendMsg = function(self, cmdId, msgContent)
  -- function num : 0_7 , upvalues : cs_NetMsgData, cs_NetworkManager
  local msgData = (cs_NetMsgData.Get)()
  msgData.CmdID = cmdId
  msgData:Encode(msgContent)
  cs_NetworkManager:SendTcpMsg(msgData)
end

NetworkManager.RegisterListener = function(self, cmdId, func)
  -- function num : 0_8 , upvalues : _ENV
  if (self.__msgEventTable)[cmdId] ~= nil then
    error("消息ID：" .. tostring(cmdId) .. " 已经注册！！")
    return 
  end
  if cmdId == nil then
    print(cmdId)
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__msgEventTable)[cmdId] = func
end

NetworkManager.UnRegisterListener = function(self, cmdId)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.__msgEventTable)[cmdId] = nil
end

NetworkManager.ResetAllNetwork = function(self)
  -- function num : 0_10 , upvalues : _ENV
  for k,v in pairs(self.__network_ctrls) do
    v:Reset()
  end
end

NetworkManager.Delete = function(self)
  -- function num : 0_11 , upvalues : _ENV, cs_NetworkManager
  for k,v in pairs(self.__network_ctrls) do
    v:OnDelete()
  end
  UpdateBeat:RemoveListener(self.__update_handle)
  cs_NetworkManager:onTcpPacket("-", self.__packet_recv_handle)
end

return NetworkManager

