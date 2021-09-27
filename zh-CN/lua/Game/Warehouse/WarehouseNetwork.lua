local WarehouseNetwork = class("WarehouseNetwork", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
WarehouseNetwork.ctor = function(self)
  -- function num : 0_0
  self._sendUse = {}
  self._sendSelect = {}
  self._sendGroup = {}
end

WarehouseNetwork.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BACKPACK_UseItem, self, proto_csmsg.SC_BACKPACK_UseItem, self.SC_BACKPACK_UseItem)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BACKPACK_SelectItem, self, proto_csmsg.SC_BACKPACK_SelectItem, self.SC_BACKPACK_SelectItem)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BACKPACK_UseItemGroup, self, proto_csmsg.SC_BACKPACK_UseItemGroup, self.SC_BACKPACK_UseItemGroup)
end

WarehouseNetwork.CS_BACKPACK_UseItem = function(self, itemId, num, callback)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self._sendUse).id = itemId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._sendUse).num = num
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_UseItem, proto_csmsg.CS_BACKPACK_UseItem, self._sendUse)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_UseItem, callback, proto_csmsg_MSG_ID.MSG_SC_BACKPACK_UseItem)
end

WarehouseNetwork.SC_BACKPACK_UseItem = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= 0 then
      local err = "SC_BACKPACK_UseItem:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_UseItem)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

WarehouseNetwork.CS_BACKPACK_SelectItem = function(self, itemId, num, selectItemIdList, callback)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

  (self._sendSelect).id = itemId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._sendSelect).num = num
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._sendSelect).selected = {}
  for _,id in ipairs(selectItemIdList) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R10 in 'UnsetPending'

    ((self._sendSelect).selected)[id] = true
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_SelectItem, proto_csmsg.CS_BACKPACK_SelectItem, self._sendSelect)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_SelectItem, callback, proto_csmsg_MSG_ID.MSG_SC_BACKPACK_SelectItem)
end

WarehouseNetwork.SC_BACKPACK_SelectItem = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= 0 then
      local err = "SC_BACKPACK_SelectItem:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_SelectItem)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

WarehouseNetwork.CS_BACKPACK_UseItemGroup = function(self, group, callback)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self._sendGroup).group = group
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_UseItemGroup, proto_csmsg.CS_BACKPACK_UseItemGroup, self._sendGroup)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_UseItemGroup, callback, proto_csmsg_MSG_ID.MSG_SC_BACKPACK_UseItemGroup)
end

WarehouseNetwork.SC_BACKPACK_UseItemGroup = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= 0 then
      local err = "SC_BACKPACK_UseItemGroup:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_UseItem)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

return WarehouseNetwork

