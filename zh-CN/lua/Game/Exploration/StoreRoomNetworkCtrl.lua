local StoreRoomNetworkCtrl = class("StoreRoomNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
StoreRoomNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.__sendPosition = {}
  self.__sendItem = {}
end

StoreRoomNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Purchase, self, proto_csmsg.SC_EXPLORATION_STORE_Purchase, self.SC_EXPLORATION_STORE_Purchase)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Quit, self, proto_csmsg.SC_EXPLORATION_STORE_Quit, self.SC_EXPLORATION_STORE_Quit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Sold, self, proto_csmsg.SC_EXPLORATION_STORE_Sold, self.SC_EXPLORATION_STORE_Sold)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Refresh, self, proto_csmsg.SC_EXPLORATION_STORE_Refresh, self.SC_EXPLORATION_STORE_Refresh)
end

StoreRoomNetworkCtrl.CS_EXPLORATION_STORE_Purchase = function(self, idx, position, action)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  self.__sendItem = {}
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__sendItem).position = position
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__sendItem).idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Purchase, proto_csmsg.CS_EXPLORATION_STORE_Purchase, self.__sendItem)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Purchase, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Purchase)
end

StoreRoomNetworkCtrl.SC_EXPLORATION_STORE_Purchase = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Purchase)
    local err = "StoreRoomNetworkCtrl:SC_EXPLORATION_STORE_Purchase error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return 
  end
end

StoreRoomNetworkCtrl.CS_EXPLORATION_STORE_Sold = function(self, position, itemId, action)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  self.__sendItem = {}
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__sendItem).position = position
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__sendItem).algId = itemId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Sold, proto_csmsg.CS_EXPLORATION_STORE_Sold, self.__sendItem)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Sold, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Sold)
end

StoreRoomNetworkCtrl.SC_EXPLORATION_STORE_Sold = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Sold)
    local err = "StoreRoomNetworkCtrl:SC_EXPLORATION_STORE_Sold error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return 
  end
end

StoreRoomNetworkCtrl.CS_EXPLORATION_STORE_Refresh = function(self, position, callBack)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.__sendPosition).position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Refresh, proto_csmsg.CS_EXPLORATION_STORE_Refresh, self.__sendPosition)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Refresh, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Refresh)
end

StoreRoomNetworkCtrl.SC_EXPLORATION_STORE_Refresh = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Refresh)
    local err = "StoreRoomNetworkCtrl:SC_EXPLORATION_STORE_Refresh error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return 
  end
end

StoreRoomNetworkCtrl.CS_EXPLORATION_STORE_Quit = function(self, position)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.__sendPosition).position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Quit, proto_csmsg.CS_EXPLORATION_STORE_Quit, self.__sendPosition)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Quit, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Quit)
end

StoreRoomNetworkCtrl.SC_EXPLORATION_STORE_Quit = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Quit)
    local err = "StoreRoomNetworkCtrl:SC_EXPLORATION_STORE_Quit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return 
  end
  do
    if ExplorationManager.epCtrl == nil then
      return 
    end
    ;
    ((ExplorationManager.epCtrl).storeCtrl):OnStoreQuit()
  end
end

StoreRoomNetworkCtrl.Reset = function(self)
  -- function num : 0_10
end

return StoreRoomNetworkCtrl

