-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemRoomNetworkCtrl = class("TreasureRoomNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
ItemRoomNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.__sendItem = {}
  self.__sendPosition = {}
end

ItemRoomNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Select, self, proto_csmsg.SC_EXPLORATION_ITEM_Select, self.SC_EXPLORATION_ITEM_Select)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Quit, self, proto_csmsg.SC_EXPLORATION_ITEM_Quit, self.SC_EXPLORATION_ITEM_Quit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_LockUnlock, self, proto_csmsg.SC_EXPLORATION_ITEM_LockUnlock, self.SC_EXPLORATION_ITEM_LockUnlock)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Fresh, self, proto_csmsg.SC_EXPLORATION_ITEM_Fresh, self.SC_EXPLORATION_ITEM_Fresh)
end

ItemRoomNetworkCtrl.CS_EXPLORATION_ITEM_Select = function(self, position, idx, action)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  if position == nil or idx == nil then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__sendItem).position = position
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__sendItem).idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Select, proto_csmsg.CS_EXPLORATION_ITEM_Select, self.__sendItem)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Select, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Select, proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfAlgDiff)
end

ItemRoomNetworkCtrl.SC_EXPLORATION_ITEM_Select = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Select)
    local err = "ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_Select error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    return 
  end
end

ItemRoomNetworkCtrl.CS_EXPLORATION_ITEM_Quit = function(self, position)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  if position == nil then
    return 
  end
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.__sendPosition).position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Quit, proto_csmsg.CS_EXPLORATION_ITEM_Quit, self.__sendPosition)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Quit, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Quit)
end

ItemRoomNetworkCtrl.SC_EXPLORATION_ITEM_Quit = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Quit)
    local err = "ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_Quit error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    return 
  end
  do
    if ExplorationManager.epCtrl == nil then
      return 
    end
    ;
    ((ExplorationManager.epCtrl).treasureCtrl):OnTreasureRoomQuit()
  end
end

ItemRoomNetworkCtrl.CS_EXPLORATION_ITEM_LockUnlock = function(self, position, idx)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  if position == nil or idx == nil then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__sendItem).position = position
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__sendItem).idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_LockUnlock, proto_csmsg.CS_EXPLORATION_ITEM_LockUnlock, self.__sendItem)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_LockUnlock, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_LockUnlock)
end

ItemRoomNetworkCtrl.SC_EXPLORATION_ITEM_LockUnlock = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_LockUnlock)
    local err = "ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_LockUnlock error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    return 
  end
  do
    if ExplorationManager.epCtrl == nil then
      return 
    end
    ;
    ((ExplorationManager.epCtrl).treasureCtrl):OnItemLockOrUnlock()
  end
end

ItemRoomNetworkCtrl.CS_EXPLORATION_ITEM_Fresh = function(self, position)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
  if position == nil then
    return 
  end
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.__sendPosition).position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Fresh, proto_csmsg.CS_EXPLORATION_ITEM_Fresh, self.__sendPosition)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Fresh, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Fresh)
  if ExplorationManager.epCtrl ~= nil then
    ((ExplorationManager.epCtrl).treasureCtrl):OnRefreshTreasureRoom(true)
  end
end

ItemRoomNetworkCtrl.SC_EXPLORATION_ITEM_Fresh = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Fresh)
    local err = "ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_Fresh error:" .. tostring(msg.ret)
    error(err)
    if ExplorationManager.epCtrl ~= nil then
      ((ExplorationManager.epCtrl).treasureCtrl):OnRefreshTreasureRoom(false)
    end
    return 
  end
end

ItemRoomNetworkCtrl.Reset = function(self)
  -- function num : 0_10
end

return ItemRoomNetworkCtrl

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemRoomNetworkCtrl = class("TreasureRoomNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
ItemRoomNetworkCtrl.ctor = function(self)
    -- function num : 0_0
    self.__sendItem = {}
    self.__sendPosition = {}
end

ItemRoomNetworkCtrl.InitNetwork = function(self)
    -- function num : 0_1 , upvalues : _ENV
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Select,
                         self, proto_csmsg.SC_EXPLORATION_ITEM_Select,
                         self.SC_EXPLORATION_ITEM_Select)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Quit, self,
                         proto_csmsg.SC_EXPLORATION_ITEM_Quit,
                         self.SC_EXPLORATION_ITEM_Quit)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_LockUnlock,
                         self, proto_csmsg.SC_EXPLORATION_ITEM_LockUnlock,
                         self.SC_EXPLORATION_ITEM_LockUnlock)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Fresh, self,
                         proto_csmsg.SC_EXPLORATION_ITEM_Fresh,
                         self.SC_EXPLORATION_ITEM_Fresh)
end

ItemRoomNetworkCtrl.CS_EXPLORATION_ITEM_Select =
    function(self, position, idx, action)
        -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
        if position == nil or idx == nil then return end -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'
        
        (self.__sendItem).position = position -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'
        ;
        (self.__sendItem).idx = idx
        self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Select,
                     proto_csmsg.CS_EXPLORATION_ITEM_Select, self.__sendItem)
        cs_WaitNetworkResponse:StartWait(
            proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Select, action,
            proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Select,
            proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfAlgDiff)
    end

ItemRoomNetworkCtrl.SC_EXPLORATION_ITEM_Select =
    function(self, msg)
        -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
        if msg.ret ~= proto_csmsg_ErrorCode.None then
            cs_WaitNetworkResponse:RemoveWait(
                proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Select)
            local err =
                "ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_Select error:" ..
                    tostring(msg.ret)
            error(err)
            if isGameDev then (cs_MessageCommon.ShowMessageTips)(err) end
            return
        end
    end

ItemRoomNetworkCtrl.CS_EXPLORATION_ITEM_Quit =
    function(self, position)
        -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
        if position == nil then return end -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'
        
        (self.__sendPosition).position = position
        self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Quit,
                     proto_csmsg.CS_EXPLORATION_ITEM_Quit, self.__sendPosition)
        cs_WaitNetworkResponse:StartWait(
            proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Quit,
            proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Quit)
    end

ItemRoomNetworkCtrl.SC_EXPLORATION_ITEM_Quit =
    function(self, msg)
        -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
        if msg.ret ~= proto_csmsg_ErrorCode.None then
            cs_WaitNetworkResponse:RemoveWait(
                proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Quit)
            local err = "ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_Quit error:" ..
                            tostring(msg.ret)
            error(err)
            if isGameDev then (cs_MessageCommon.ShowMessageTips)(err) end
            return
        end
        do
            if ExplorationManager.epCtrl == nil then return end
            ((ExplorationManager.epCtrl).treasureCtrl):OnTreasureRoomQuit()
        end
    end

ItemRoomNetworkCtrl.CS_EXPLORATION_ITEM_LockUnlock =
    function(self, position, idx)
        -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
        if position == nil or idx == nil then return end -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'
        
        (self.__sendItem).position = position -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (self.__sendItem).idx = idx
        self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_LockUnlock,
                     proto_csmsg.CS_EXPLORATION_ITEM_LockUnlock, self.__sendItem)
        cs_WaitNetworkResponse:StartWait(
            proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_LockUnlock,
            proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_LockUnlock)
    end

ItemRoomNetworkCtrl.SC_EXPLORATION_ITEM_LockUnlock =
    function(self, msg)
        -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
        if msg.ret ~= proto_csmsg_ErrorCode.None then
            cs_WaitNetworkResponse:RemoveWait(
                proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_LockUnlock)
            local err =
                "ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_LockUnlock error:" ..
                    tostring(msg.ret)
            error(err)
            if isGameDev then (cs_MessageCommon.ShowMessageTips)(err) end
            return
        end
        do
            if ExplorationManager.epCtrl == nil then return end
            ((ExplorationManager.epCtrl).treasureCtrl):OnItemLockOrUnlock()
        end
    end

ItemRoomNetworkCtrl.CS_EXPLORATION_ITEM_Fresh =
    function(self, position)
        -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
        if position == nil then return end -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'
        
        (self.__sendPosition).position = position
        self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Fresh,
                     proto_csmsg.CS_EXPLORATION_ITEM_Fresh, self.__sendPosition)
        cs_WaitNetworkResponse:StartWait(
            proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Fresh,
            proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Fresh)
        if ExplorationManager.epCtrl ~= nil then
            ((ExplorationManager.epCtrl).treasureCtrl):OnRefreshTreasureRoom(
                true)
        end
    end

ItemRoomNetworkCtrl.SC_EXPLORATION_ITEM_Fresh =
    function(self, msg)
        -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse
        if msg.ret ~= proto_csmsg_ErrorCode.None then
            cs_WaitNetworkResponse:RemoveWait(
                proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Fresh)
            local err =
                "ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_Fresh error:" ..
                    tostring(msg.ret)
            error(err)
            if ExplorationManager.epCtrl ~= nil then
                ((ExplorationManager.epCtrl).treasureCtrl):OnRefreshTreasureRoom(
                    false)
            end
            return
        end
    end

ItemRoomNetworkCtrl.Reset = function(self)
    -- function num : 0_10
end

return ItemRoomNetworkCtrl

