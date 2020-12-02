-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationNetworkCtrl = class("ExplorationNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local LastSendType = {Select = 1, NextFloor = 2}
local cacheActionType = {StartBattle = 1, BattleSettle = 2}
ExplorationNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.epSendStartData = {}
  self.epSelectData = {}
  self.nextFloorData = {}
  self.settleData = {}
  self.algSelectData = {}
  self.residentStoreData = {}
  self.refreshFormationData = {}
  self.lastSendDataList = {}
  self.cacheAction = {}
end

ExplorationNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Start, self, proto_csmsg.SC_EXPLORATION_Start, self.SC_EXPLORATION_Start)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff, self, proto_csmsg.SC_EXPLORATION_SyncUpdateDiff, self.SC_EXPLORATION_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Select, self, proto_csmsg.SC_EXPLORATION_Select, self.SC_EXPLORATION_Select)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Settle, self, proto_csmsg.SC_EXPLORATION_Settle, self.SC_EXPLORATION_Settle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_ALGSelect, self, proto_csmsg.SC_EXPLORATION_BATTLE_ALGSelect, self.SC_EXPLORATION_BATTLE_ALGSelect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Detail, self, proto_csmsg.SC_EXPLORATION_Detail, self.SC_EXPLORATION_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_Purchase, self, proto_csmsg.SC_EXPLORATION_RESIDENT_STORE_Purchase, self.SC_EXPLORATION_RESIDENT_STORE_Purchase)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Start, self, proto_csmsg.SC_EXPLORATION_BATTLE_Start, self.SC_EXPLORATION_BATTLE_Start)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Settle, self, proto_csmsg.SC_EXPLORATION_BATTLE_Settle, self.SC_EXPLORATION_BATTLE_Settle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_FreshFromation, self, proto_csmsg.SC_EXPLORATION_FreshFromation, self.SC_EXPLORATION_FreshFromation)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_NtfServerEnter, self, proto_csmsg.SC_EXPLORATION_NtfServerEnter, self.SC_EXPLORATION_NtfServerEnter)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Focus, self, proto_csmsg.SC_EXPLORATION_BATTLE_Focus, self.SC_EXPLORATION_BATTLE_Focus)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Ambush, self, proto_csmsg.SC_EXPLORATION_BATTLE_Ambush, self.SC_EXPLORATION_BATTLE_Ambush)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Stealth, self, proto_csmsg.SC_EXPLORATION_BATTLE_Stealth, self.SC_EXPLORATION_BATTLE_Stealth)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SettleFloor, self, proto_csmsg.SC_EXPLORATION_SettleFloor, self.SC_EXPLORATION_SettleFloor)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_Sold, self, proto_csmsg.SC_EXPLORATION_AlgUpperLimit_Sold, self.SC_EXPLORATION_AlgUpperLimit_Sold)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_Exit, self, proto_csmsg.SC_EXPLORATION_AlgUpperLimit_Exit, self.SC_EXPLORATION_AlgUpperLimit_Exit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_PurchaseLimit, self, proto_csmsg.SC_EXPLORATION_AlgUpperLimit_PurchaseLimit, self.SC_EXPLORATION_AlgUpperLimit_PurchaseLimit)
end

ExplorationNetworkCtrl.CS_EXPLORATION_Start = function(self, dungeonId, formId, moduleId, callBack)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

  (self.epSendStartData).dungeonId = dungeonId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.epSendStartData).formId = formId
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R5 in 'UnsetPending'

  if not moduleId then
    (self.epSendStartData).moduleId = proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration
    local OverclockCtrl = ControllerManager:GetController(ControllerTypeId.Overclock, false)
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

    if OverclockCtrl ~= nil then
      (self.epSendStartData).ocChoice = {}
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.epSendStartData).ocChoice).data = OverclockCtrl:UseOverClock()
    end
    self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Start, proto_csmsg.CS_EXPLORATION_Start, self.epSendStartData)
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Start, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Start)
  end
end

ExplorationNetworkCtrl.SC_EXPLORATION_Start = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Start)
  end
  ExplorationManager:RecvEnterExploration(msg)
end

ExplorationNetworkCtrl.SC_EXPLORATION_SyncUpdateDiff = function(self, msg)
  -- function num : 0_4 , upvalues : LastSendType, _ENV
  local isLastNextFloor = #self.lastSendDataList > 0 and ((self.lastSendDataList)[1]).type == LastSendType.NextFloor
  if msg.epOp ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpOperatorDiff, msg.epOp)
  end
  if msg.epForm ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpFormationDetailDiff, msg.epForm)
  end
  if msg.epBackpack ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpBackpackDiff, msg.epBackpack)
  end
  if msg.epBuff ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpBuffDiff, msg.epBuff)
  end
  if msg.epResident ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpResidentDiff, msg.epResident)
  end
  if not isLastNextFloor and msg.epGrid ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpGridDetailDiff, msg.epGrid)
  end
  do
    if #self.lastSendDataList > 0 then
      local lastData = (table.remove)(self.lastSendDataList, 1)
      -- DECOMPILER ERROR at PC88: Unhandled construct in 'MakeBoolean' P1

      if lastData.type == LastSendType.Select and msg.epOp ~= nil then
        MsgCenter:Broadcast(eMsgEventId.OnRoomSelected)
      end
    end
    if lastData.type == LastSendType.NextFloor then
      ExplorationManager:OnEnterNextSectionExploration(msg)
    end
    -- DECOMPILER ERROR: 9 unprocessed JMP targets
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_Select = function(self, position)
  -- function num : 0_5 , upvalues : _ENV, LastSendType, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.epSelectData).position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Select, proto_csmsg.CS_EXPLORATION_Select, self.epSelectData)
  local saveList = {}
  saveList.type = LastSendType.Select
  ;
  (table.insert)(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Select, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Select, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff)
end

ExplorationNetworkCtrl.SC_EXPLORATION_Select = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_SelectRoomFailure) .. tostring(msg.ret))
    end
    error("SC_EXPLORATION_Select，error：" .. tostring(msg.ret))
    ;
    (table.remove)(self.lastSendDataList, 1)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Select)
    return 
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_NextFloor = function(self, briefId)
  -- function num : 0_7 , upvalues : _ENV, LastSendType, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.nextFloorData).id = briefId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NextFloor, proto_csmsg.CS_EXPLORATION_NextFloor, self.nextFloorData)
  local saveList = {}
  saveList.type = LastSendType.NextFloor
  ;
  (table.insert)(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NextFloor, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_NextFloor, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff)
end

ExplorationNetworkCtrl.SC_EXPLORATION_NextFloor = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_NextFloor error：" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    ;
    (table.remove)(self.lastSendDataList, 1)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NextFloor)
    return 
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_Settle = function(self, position, isAutoSettle, isGiveUpLastEp, callBack)
  -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse
  self.__isAutoSettle = isAutoSettle
  self.__isGiveUpLastEp = isGiveUpLastEp
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.settleData).position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Settle, proto_csmsg.CS_EXPLORATION_Settle, self.settleData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Settle, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Settle)
end

ExplorationNetworkCtrl.SC_EXPLORATION_Settle = function(self, msg)
  -- function num : 0_10 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "SC_EXPLORATION_Settle error：" .. tostring(msg.ret)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      error(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Settle)
      return 
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Settle, msg)
    if self.__isAutoSettle or self.__isGiveUpLastEp then
      self:CS_EXPLORATION_Detail()
    end
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_SettleFloor = function(self, position, callBack)
  -- function num : 0_11 , upvalues : _ENV, cs_WaitNetworkResponse
  local sendMsg = {position = position}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_SettleFloor, proto_csmsg.CS_EXPLORATION_SettleFloor, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_SettleFloor, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SettleFloor)
end

ExplorationNetworkCtrl.SC_EXPLORATION_SettleFloor = function(self, msg)
  -- function num : 0_12 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "SC_EXPLORATION_SettleFloor error：" .. tostring(msg.ret)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      error(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_SettleFloor)
      return 
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_SettleFloor, msg)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_BATTLE_ALGSelect = function(self, position, rewardIndex, callBack)
  -- function num : 0_13 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.algSelectData).position = position
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.algSelectData).idx = rewardIndex
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_ALGSelect, proto_csmsg.CS_EXPLORATION_BATTLE_ALGSelect, self.algSelectData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_ALGSelect, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_ALGSelect, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff)
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_ALGSelect = function(self, msg)
  -- function num : 0_14 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_BATTLE_ALGSelect error：" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_ALGSelect)
    return 
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_Detail = function(self)
  -- function num : 0_15 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Detail, proto_csmsg.CS_EXPLORATION_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Detail, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Detail)
end

ExplorationNetworkCtrl.SC_EXPLORATION_Detail = function(self, msg)
  -- function num : 0_16 , upvalues : _ENV
  ExplorationManager:RecordLastEpData(msg)
  ;
  (NetworkManager.luaNetworkAgent):OnRecvExploraionDetail()
end

ExplorationNetworkCtrl.CS_EXPLORATION_NtfServerEnter = function(self, callBack)
  -- function num : 0_17 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NtfServerEnter, proto_csmsg.CS_EXPLORATION_NtfServerEnter, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NtfServerEnter, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_NtfServerEnter)
end

ExplorationNetworkCtrl.SC_EXPLORATION_NtfServerEnter = function(self, msg)
  -- function num : 0_18 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_NtfServerEnter error：" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NtfServerEnter)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_RESIDENT_STORE_Purchase = function(self, idx, callBack)
  -- function num : 0_19 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.residentStoreData).idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Purchase, proto_csmsg.CS_EXPLORATION_RESIDENT_STORE_Purchase, self.residentStoreData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Purchase, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_Purchase)
end

ExplorationNetworkCtrl.SC_EXPLORATION_RESIDENT_STORE_Purchase = function(self, msg)
  -- function num : 0_20 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_RESIDENT_STORE_Purchase error：" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Purchase)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_BATTLE_Start = function(self, sendMsg, action)
  -- function num : 0_21 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Start, proto_csmsg.CS_EXPLORATION_BATTLE_Start, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Start, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Start)
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_Start = function(self, msg)
  -- function num : 0_22 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = ConfigData:GetTipContent(1002) .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Start)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_BATTLE_Settle = function(self, sendMsg, action)
  -- function num : 0_23 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Settle, proto_csmsg.CS_EXPLORATION_BATTLE_Settle, sendMsg)
  if sendMsg.win then
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Settle, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Settle, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff)
  else
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Settle, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Settle)
  end
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_Settle = function(self, msg)
  -- function num : 0_24 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = ConfigData:GetTipContent(1003) .. tostring(msg.ret)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      error(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Settle)
      return 
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Settle, msg)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_FreshFromation = function(self, posDic)
  -- function num : 0_25 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.refreshFormationData).data = posDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_FreshFromation, proto_csmsg.CS_EXPLORATION_FreshFromation, self.refreshFormationData)
end

ExplorationNetworkCtrl.SC_EXPLORATION_FreshFromation = function(self, msg)
  -- function num : 0_26 , upvalues : _ENV, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "EXPLORATION_FreshFromation，error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_BATTLE_Focus = function(self, pos, isAmbush, callBack)
  -- function num : 0_27 , upvalues : _ENV
  local msg = {}
  msg.position = pos
  msg.ambush = isAmbush
  self.rejudgeCallback = callBack
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Focus, proto_csmsg.CS_EXPLORATION_BATTLE_Focus, msg)
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_Focus = function(self, msg)
  -- function num : 0_28 , upvalues : _ENV, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "EXPLORATION rejudge error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
  else
    do
      if self.rejudgeCallback ~= nil then
        (self.rejudgeCallback)(msg.value)
        self.rejudgeCallback = nil
      end
    end
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_BATTLE_Ambush = function(self, sendMsg, action)
  -- function num : 0_29 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Ambush, proto_csmsg.CS_EXPLORATION_BATTLE_Ambush, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Ambush, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Ambush)
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_Ambush = function(self, msg)
  -- function num : 0_30 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = ConfigData:GetTipContent(1002) .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Ambush)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_BATTLE_Stealth = function(self, position)
  -- function num : 0_31 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Stealth, proto_csmsg.CS_EXPLORATION_BATTLE_Stealth, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Stealth, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Stealth)
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_Stealth = function(self, msg)
  -- function num : 0_32 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "Exploration stealth error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Stealth)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_AlgUpperLimit_Sold = function(self, position, chipId, callback)
  -- function num : 0_33 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.position = position
  msg.algId = chipId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Sold, proto_csmsg.CS_EXPLORATION_AlgUpperLimit_Sold, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Sold, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_Sold)
end

ExplorationNetworkCtrl.SC_EXPLORATION_AlgUpperLimit_Sold = function(self, msg)
  -- function num : 0_34 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_AlgUpperLimit_Sold error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Sold)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_AlgUpperLimit_PurchaseLimit = function(self, position)
  -- function num : 0_35 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_PurchaseLimit, proto_csmsg.CS_EXPLORATION_AlgUpperLimit_PurchaseLimit, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_PurchaseLimit, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_PurchaseLimit)
end

ExplorationNetworkCtrl.SC_EXPLORATION_AlgUpperLimit_PurchaseLimit = function(self, msg)
  -- function num : 0_36 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_AlgUpperLimit_PurchaseLimit error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_PurchaseLimit)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_AlgUpperLimit_Exit = function(self, position, callBack)
  -- function num : 0_37 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Exit, proto_csmsg.CS_EXPLORATION_AlgUpperLimit_Exit, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Exit, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_Exit, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff)
end

ExplorationNetworkCtrl.SC_EXPLORATION_AlgUpperLimit_Exit = function(self, msg)
  -- function num : 0_38 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_AlgUpperLimit_Sold error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Exit)
  end
end

ExplorationNetworkCtrl.Reset = function(self)
  -- function num : 0_39
  self.lastSendDataList = {}
  self.cacheAction = {}
end

return ExplorationNetworkCtrl

