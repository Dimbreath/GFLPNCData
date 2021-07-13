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
  self.residentStoreLockTab = {}
  self.refreshFormationData = {}
  self.lastSendDataList = {}
  self.sendOverclockBuy = {}
  self.epAlgSoldTab = {}
  self.cacheAction = {}
  self.weeklyBattle = {}
  self.weeklyBattleSelectDebuff = {}
end

ExplorationNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Start, self, proto_csmsg.SC_EXPLORATION_Start, self.SC_EXPLORATION_Start)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff, self, proto_csmsg.SC_EXPLORATION_SyncUpdateDiff, self.SC_EXPLORATION_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Select, self, proto_csmsg.SC_EXPLORATION_Select, self.SC_EXPLORATION_Select)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Settle, self, proto_csmsg.SC_EXPLORATION_Settle, self.SC_EXPLORATION_Settle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_ALGSelect, self, proto_csmsg.SC_EXPLORATION_BATTLE_ALGSelect, self.SC_EXPLORATION_BATTLE_ALGSelect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_RefreshAlg, self, proto_csmsg.SC_EXPLORATION_BATTLE_RefreshAlg, self.SC_EXPLORATION_BATTLE_RefreshAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Detail, self, proto_csmsg.SC_EXPLORATION_Detail, self.SC_EXPLORATION_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_Purchase, self, proto_csmsg.SC_EXPLORATION_RESIDENT_STORE_Purchase, self.SC_EXPLORATION_RESIDENT_STORE_Purchase)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Start, self, proto_csmsg.SC_EXPLORATION_BATTLE_Start, self.SC_EXPLORATION_BATTLE_Start)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Restart, self, proto_csmsg.SC_EXPLORATION_BATTLE_Restart, self.SC_EXPLORATION_BATTLE_Restart)
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
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RewardsShow, self, proto_csmsg.SC_EXPLORATION_RewardsShow, self.SC_EXPLORATION_RewardsShow)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_CAMP_FETTER_USE, self, proto_csmsg.SC_EXPLORATION_CAMP_FETTER_USE, self.SC_EXPLORATION_CAMP_FETTER_USE)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_ReplaceAlg, self, proto_csmsg.SC_EXPLORATION_EVENT_ReplaceAlg, self.SC_EXPLORATION_EVENT_ReplaceAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_ReplaceExit, self, proto_csmsg.SC_EXPLORATION_EVENT_ReplaceExit, self.SC_EXPLORATION_EVENT_ReplaceExit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_GiveUpAlg, self, proto_csmsg.SC_EXPLORATION_BATTLE_GiveUpAlg, self.SC_EXPLORATION_BATTLE_GiveUpAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_OVERCLOCK_BUY, self, proto_csmsg.SC_EXPLORATION_OVERCLOCK_BUY, self.SC_EXPLORATION_OVERCLOCK_BUY)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Alg_Sold, self, proto_csmsg.SC_EXPLORATION_Alg_Sold, self.SC_EXPLORATION_Alg_Sold)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_Refresh, self, proto_csmsg.SC_EXPLORATION_RESIDENT_STORE_Refresh, self.SC_EXPLORATION_RESIDENT_STORE_Refresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_PurchaseExp, self, proto_csmsg.SC_EXPLORATION_RESIDENT_STORE_PurchaseExp, self.SC_EXPLORATION_RESIDENT_STORE_PurchaseExp)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_LockUnlock, self, proto_csmsg.SC_EXPLORATION_RESIDENT_STORE_LockUnlock, self.SC_EXPLORATION_RESIDENT_STORE_LockUnlock)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_Start, self, proto_csmsg.SC_WEEKLYCHALLENGE_Start, self.SC_WEEKLYCHALLENGE_Start)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_Start, self, proto_csmsg.SC_DAILYCHALLENGE_Start, self.SC_DAILYCHALLENGE_Start)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_SelectBuff, self, proto_csmsg.SC_WEEKLYCHALLENGE_SelectBuff, self.SC_WEEKLYCHALLENGE_SelectBuff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_SelectBuffExit, self, proto_csmsg.SC_WEEKLYCHALLENGE_SelectBuffExit, self.SC_WEEKLYCHALLENGE_SelectBuffExit)
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

ExplorationNetworkCtrl.CS_DAILYCHALLENGE_Start = function(self, fomationId, callback)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {formId = fomationId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Start, proto_csmsg.CS_DAILYCHALLENGE_Start, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Start, callback, proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_Start)
end

ExplorationNetworkCtrl.SC_DAILYCHALLENGE_Start = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    ExplorationManager:RecvEnterExploration(msg.explorationStart)
  else
    local err = "SC_DAILYCHALLENGE_Detail error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Start)
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ExplorationNetworkCtrl.CS_WEEKLYCHALLENGE_Start = function(self, id, buffIds, heroPos, treeId, skills)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R6 in 'UnsetPending'

  (self.weeklyBattle).id = id
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.weeklyBattle).buffGroup = {}
  for i,v in ipairs(buffIds) do
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R11 in 'UnsetPending'

    ((self.weeklyBattle).buffGroup)[v] = true
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.weeklyBattle).form = {heroGroup = heroPos, treeId = treeId, cst = skills}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_Start, proto_csmsg.CS_WEEKLYCHALLENGE_Start, self.weeklyBattle)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_Start, proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_Start)
end

ExplorationNetworkCtrl.SC_WEEKLYCHALLENGE_Start = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    ExplorationManager:RecvEnterExploration(msg.explorationStart)
  else
    local err = "SC_WEEKLYCHALLENGE_Start error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_Start)
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ExplorationNetworkCtrl.SC_EXPLORATION_SyncUpdateDiff = function(self, msg)
  -- function num : 0_8 , upvalues : LastSendType, _ENV
  local isLastNextFloor = #self.lastSendDataList > 0 and ((self.lastSendDataList)[1]).type == LastSendType.NextFloor
  if msg.epOp ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpOpStore, msg.epOp)
  end
  if msg.epRoleDyc ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpFormationDetailDiff, msg.epRoleDyc)
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
  if msg.epBattleGrid ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpServerGridDiff, msg.epBattleGrid)
  end
  if msg.epClock ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpOverclockDiff, msg.epClock)
  end
  if msg.epCommon ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpCommonDataDiff, msg.epCommon)
  end
  do
    if not isLastNextFloor and msg.epGrid ~= nil then
      local jumpCat = nil
      if msg.epOp ~= nil then
        jumpCat = (msg.epOp).jumpCat
      end
      MsgCenter:Broadcast(eMsgEventId.OnEpGridDetailDiff, msg.epGrid, jumpCat)
    end
    if #msg.epStmGoods > 0 then
      MsgCenter:Broadcast(eMsgEventId.OnEpRewardBagDiff, msg.epStmGoods)
    end
    if msg.epOp ~= nil then
      MsgCenter:Broadcast(eMsgEventId.OnEpOperatorDiff, msg.epOp)
    end
    do
      if #self.lastSendDataList > 0 then
        local lastData = (table.remove)(self.lastSendDataList, 1)
        -- DECOMPILER ERROR at PC141: Unhandled construct in 'MakeBoolean' P1

        if lastData.type == LastSendType.Select and msg.epOp ~= nil then
          MsgCenter:Broadcast(eMsgEventId.OnRoomSelected)
        end
      end
      if lastData.type == LastSendType.NextFloor then
        ExplorationManager:OnEnterNextSectionExploration(msg)
      end
      -- DECOMPILER ERROR: 15 unprocessed JMP targets
    end
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_Select = function(self, position)
  -- function num : 0_9 , upvalues : _ENV, LastSendType, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.epSelectData).position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Select, proto_csmsg.CS_EXPLORATION_Select, self.epSelectData)
  local saveList = {}
  saveList.type = LastSendType.Select
  ;
  (table.insert)(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Select, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Select, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff)
end

ExplorationNetworkCtrl.SC_EXPLORATION_Select = function(self, msg)
  -- function num : 0_10 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
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
  -- function num : 0_11 , upvalues : _ENV, LastSendType, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.nextFloorData).id = briefId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NextFloor, proto_csmsg.CS_EXPLORATION_NextFloor, self.nextFloorData)
  local saveList = {}
  saveList.type = LastSendType.NextFloor
  ;
  (table.insert)(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NextFloor, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_NextFloor, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff)
end

ExplorationNetworkCtrl.SC_EXPLORATION_NextFloor = function(self, msg)
  -- function num : 0_12 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
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

ExplorationNetworkCtrl.CS_EXPLORATION_Settle = function(self, position, isAutoSettle, isGiveUpLastEp, costumeStm, mvpHeroId, pickInfo, refreshLastEp, callBack)
  -- function num : 0_13 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  self.__isAutoSettle = isAutoSettle
  self.__isGiveUpLastEp = isGiveUpLastEp
  self.__refreshLastEp = refreshLastEp
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (self.settleData).position = position
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (self.settleData).costumeStm = costumeStm or false
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (self.settleData).mvpHero = mvpHeroId
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (self.settleData).pickInfo = pickInfo
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Settle, proto_csmsg.CS_EXPLORATION_Settle, self.settleData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Settle, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Settle)
end

ExplorationNetworkCtrl.SC_EXPLORATION_Settle = function(self, msg)
  -- function num : 0_14 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
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
    if self.__isAutoSettle or self.__isGiveUpLastEp or self.__refreshLastEp then
      self:CS_EXPLORATION_Detail()
    end
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_SettleFloor = function(self, position, callBack)
  -- function num : 0_15 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  local sendMsg = {position = position}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_SettleFloor, proto_csmsg.CS_EXPLORATION_SettleFloor, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_SettleFloor, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SettleFloor)
end

ExplorationNetworkCtrl.SC_EXPLORATION_SettleFloor = function(self, msg)
  -- function num : 0_16 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
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
  -- function num : 0_17 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.algSelectData).position = position
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.algSelectData).idx = rewardIndex
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_ALGSelect, proto_csmsg.CS_EXPLORATION_BATTLE_ALGSelect, self.algSelectData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_ALGSelect, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_ALGSelect, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff)
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_ALGSelect = function(self, msg)
  -- function num : 0_18 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
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

ExplorationNetworkCtrl.CS_EXPLORATION_BATTLE_RefreshAlg = function(self, idxList, callBack)
  -- function num : 0_19 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  local sendMsg = {locked = idxList}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_RefreshAlg, proto_csmsg.CS_EXPLORATION_BATTLE_RefreshAlg, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_RefreshAlg, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_RefreshAlg, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff)
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_RefreshAlg = function(self, msg)
  -- function num : 0_20 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_BATTLE_RefreshAlg error：" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_RefreshAlg)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_Detail = function(self)
  -- function num : 0_21 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Detail, proto_csmsg.CS_EXPLORATION_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Detail, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Detail)
end

ExplorationNetworkCtrl.CS_EXPLORATION_Detail_NoWait = function(self)
  -- function num : 0_22 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Detail, proto_csmsg.CS_EXPLORATION_Detail, table.emptytable)
end

ExplorationNetworkCtrl.SC_EXPLORATION_Detail = function(self, msg)
  -- function num : 0_23 , upvalues : _ENV
  ExplorationManager:RecordLastEpData(msg.detail)
end

ExplorationNetworkCtrl.CS_EXPLORATION_NtfServerEnter = function(self, callBack)
  -- function num : 0_24 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NtfServerEnter, proto_csmsg.CS_EXPLORATION_NtfServerEnter, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NtfServerEnter, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_NtfServerEnter)
end

ExplorationNetworkCtrl.SC_EXPLORATION_NtfServerEnter = function(self, msg)
  -- function num : 0_25 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_NtfServerEnter error：" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NtfServerEnter)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_Alg_Sold = function(self, id, callBack)
  -- function num : 0_26 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.epAlgSoldTab).id = id
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Alg_Sold, proto_csmsg.CS_EXPLORATION_Alg_Sold, self.epAlgSoldTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Alg_Sold, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Alg_Sold)
end

ExplorationNetworkCtrl.SC_EXPLORATION_Alg_Sold = function(self, msg)
  -- function num : 0_27 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_Alg_Sold error：" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Alg_Sold)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_RESIDENT_STORE_Refresh = function(self, callBack)
  -- function num : 0_28 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Refresh, proto_csmsg.CS_EXPLORATION_RESIDENT_STORE_Refresh, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Refresh, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_Refresh)
end

ExplorationNetworkCtrl.SC_EXPLORATION_RESIDENT_STORE_Refresh = function(self, msg)
  -- function num : 0_29 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_RESIDENT_STORE_Refresh error：" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Refresh)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_RESIDENT_STORE_PurchaseExp = function(self, callBack)
  -- function num : 0_30 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_PurchaseExp, proto_csmsg.CS_EXPLORATION_RESIDENT_STORE_PurchaseExp, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_PurchaseExp, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_PurchaseExp)
end

ExplorationNetworkCtrl.SC_EXPLORATION_RESIDENT_STORE_PurchaseExp = function(self, msg)
  -- function num : 0_31 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_RESIDENT_STORE_PurchaseExp error：" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_PurchaseExp)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_RESIDENT_STORE_Purchase = function(self, idx, callBack)
  -- function num : 0_32 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.residentStoreData).idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Purchase, proto_csmsg.CS_EXPLORATION_RESIDENT_STORE_Purchase, self.residentStoreData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Purchase, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_Purchase)
end

ExplorationNetworkCtrl.SC_EXPLORATION_RESIDENT_STORE_Purchase = function(self, msg)
  -- function num : 0_33 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_RESIDENT_STORE_Purchase error：" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Purchase)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_RESIDENT_STORE_LockUnlock = function(self, idx, callBack)
  -- function num : 0_34 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.residentStoreLockTab).idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_LockUnlock, proto_csmsg.CS_EXPLORATION_RESIDENT_STORE_LockUnlock, self.residentStoreLockTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_LockUnlock, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_LockUnlock)
end

ExplorationNetworkCtrl.SC_EXPLORATION_RESIDENT_STORE_LockUnlock = function(self, msg)
  -- function num : 0_35 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_RESIDENT_STORE_LockUnlock error：" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_LockUnlock)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_BATTLE_Start = function(self, sendMsg, action)
  -- function num : 0_36 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Start, proto_csmsg.CS_EXPLORATION_BATTLE_Start, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Start, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Start)
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_Start = function(self, msg)
  -- function num : 0_37 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_BATTLE_Start" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Start)
  else
    do
      cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Start, msg)
    end
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_BATTLE_Restart = function(self, action)
  -- function num : 0_38 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Restart, proto_csmsg.CS_EXPLORATION_BATTLE_Restart, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Restart, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Restart)
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_Restart = function(self, msg)
  -- function num : 0_39 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_BATTLE_Restart error：" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Restart)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_BATTLE_Settle = function(self, sendMsg, action)
  -- function num : 0_40 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Settle, proto_csmsg.CS_EXPLORATION_BATTLE_Settle, sendMsg)
  if sendMsg.win then
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Settle, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Settle, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff)
  else
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Settle, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Settle)
  end
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_Settle = function(self, msg)
  -- function num : 0_41 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "SC_EXPLORATION_BATTLE_Settle" .. tostring(msg.ret)
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
  -- function num : 0_42 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.refreshFormationData).data = posDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_FreshFromation, proto_csmsg.CS_EXPLORATION_FreshFromation, self.refreshFormationData)
end

ExplorationNetworkCtrl.SC_EXPLORATION_FreshFromation = function(self, msg)
  -- function num : 0_43 , upvalues : _ENV, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "EXPLORATION_FreshFromation，error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_BATTLE_Focus = function(self, pos, isAmbush, callBack)
  -- function num : 0_44 , upvalues : _ENV
  local msg = {}
  msg.position = pos
  msg.ambush = isAmbush
  self.rejudgeCallback = callBack
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Focus, proto_csmsg.CS_EXPLORATION_BATTLE_Focus, msg)
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_Focus = function(self, msg)
  -- function num : 0_45 , upvalues : _ENV, cs_MessageCommon
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
  -- function num : 0_46 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Ambush, proto_csmsg.CS_EXPLORATION_BATTLE_Ambush, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Ambush, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Ambush)
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_Ambush = function(self, msg)
  -- function num : 0_47 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_BATTLE_Ambush" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Ambush)
  else
    do
      cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Ambush, msg)
    end
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_BATTLE_Stealth = function(self, position)
  -- function num : 0_48 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Stealth, proto_csmsg.CS_EXPLORATION_BATTLE_Stealth, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Stealth, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Stealth)
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_Stealth = function(self, msg)
  -- function num : 0_49 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
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
  -- function num : 0_50 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  local msg = {}
  msg.position = position
  msg.algId = chipId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Sold, proto_csmsg.CS_EXPLORATION_AlgUpperLimit_Sold, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Sold, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_Sold)
end

ExplorationNetworkCtrl.SC_EXPLORATION_AlgUpperLimit_Sold = function(self, msg)
  -- function num : 0_51 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
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
  -- function num : 0_52 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  local msg = {}
  msg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_PurchaseLimit, proto_csmsg.CS_EXPLORATION_AlgUpperLimit_PurchaseLimit, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_PurchaseLimit, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_PurchaseLimit)
end

ExplorationNetworkCtrl.SC_EXPLORATION_AlgUpperLimit_PurchaseLimit = function(self, msg)
  -- function num : 0_53 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
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
  -- function num : 0_54 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  local msg = {}
  msg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Exit, proto_csmsg.CS_EXPLORATION_AlgUpperLimit_Exit, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Exit, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_Exit, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff)
end

ExplorationNetworkCtrl.SC_EXPLORATION_AlgUpperLimit_Exit = function(self, msg)
  -- function num : 0_55 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_AlgUpperLimit_Sold error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Exit)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_CAMP_FETTER_USE = function(self, uid, callback)
  -- function num : 0_56 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_CAMP_FETTER_USE, proto_csmsg.CS_EXPLORATION_CAMP_FETTER_USE, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_CAMP_FETTER_USE, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_CAMP_FETTER_USE)
end

ExplorationNetworkCtrl.SC_EXPLORATION_CAMP_FETTER_USE = function(self, msg)
  -- function num : 0_57 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_CAMP_FETTER_USE error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_CAMP_FETTER_USE)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_RewardsShow = function(self, callBack)
  -- function num : 0_58 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RewardsShow, proto_csmsg.CS_EXPLORATION_RewardsShow, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RewardsShow, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RewardsShow)
end

ExplorationNetworkCtrl.SC_EXPLORATION_RewardsShow = function(self, msg)
  -- function num : 0_59 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "CS_EXPLORATION_RewardsShow error:" .. tostring(msg.ret)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      error(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RewardsShow)
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RewardsShow, msg)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_EVENT_ReplaceAlg = function(self, position, algId, callback)
  -- function num : 0_60 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  local data = {postion = position, algId = algId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_ReplaceAlg, proto_csmsg.CS_EXPLORATION_EVENT_ReplaceAlg, data)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_ReplaceAlg, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_ReplaceAlg)
end

ExplorationNetworkCtrl.SC_EXPLORATION_EVENT_ReplaceAlg = function(self, msg)
  -- function num : 0_61 , upvalues : _ENV, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "MSG_SC_EXPLORATION_EVENT_ReplaceAlg error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_EVENT_ReplaceExit = function(self, position, callback)
  -- function num : 0_62 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  local data = {position = position}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_ReplaceExit, proto_csmsg.CS_EXPLORATION_EVENT_ReplaceExit, data)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_ReplaceExit, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_ReplaceExit)
end

ExplorationNetworkCtrl.SC_EXPLORATION_EVENT_ReplaceExit = function(self, msg)
  -- function num : 0_63 , upvalues : _ENV, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "MSG_SC_EXPLORATION_EVENT_ReplaceExit error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_BATTLE_GiveUpAlg = function(self, callback)
  -- function num : 0_64 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_GiveUpAlg, proto_csmsg.CS_EXPLORATION_BATTLE_GiveUpAlg, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_GiveUpAlg, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_GiveUpAlg)
end

ExplorationNetworkCtrl.SC_EXPLORATION_BATTLE_GiveUpAlg = function(self, msg)
  -- function num : 0_65 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "MSG_SC_EXPLORATION_BATTLE_GiveUpAlg error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_GiveUpAlg)
  end
end

ExplorationNetworkCtrl.CS_EXPLORATION_OVERCLOCK_BUY = function(self, clockId, level, param)
  -- function num : 0_66 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.sendOverclockBuy).id = clockId
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.sendOverclockBuy).level = level
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.sendOverclockBuy).param = param
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_OVERCLOCK_BUY, proto_csmsg.CS_EXPLORATION_OVERCLOCK_BUY, self.sendOverclockBuy)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_OVERCLOCK_BUY, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_OVERCLOCK_BUY)
end

ExplorationNetworkCtrl.SC_EXPLORATION_OVERCLOCK_BUY = function(self, msg)
  -- function num : 0_67 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_EXPLORATION_OVERCLOCK_BUY error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_OVERCLOCK_BUY)
  else
    do
      ;
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.OverlockSuccess))
    end
  end
end

ExplorationNetworkCtrl.CS_WEEKLYCHALLENGE_SelectBuff = function(self, buff, callback)
  -- function num : 0_68 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.weeklyBattleSelectDebuff).buff = buff
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_SelectBuff, proto_csmsg.CS_WEEKLYCHALLENGE_SelectBuff, self.weeklyBattleSelectDebuff)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_SelectBuff, callback, proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_SelectBuff)
end

ExplorationNetworkCtrl.SC_WEEKLYCHALLENGE_SelectBuff = function(self, msg)
  -- function num : 0_69 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_WEEKLYCHALLENGE_SelectBuff error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_SelectBuff)
  end
end

ExplorationNetworkCtrl.CS_WEEKLYCHALLENGE_SelectBuffExit = function(self, callback)
  -- function num : 0_70 , upvalues : _ENV, cs_WaitNetworkResponse
  if not self:__CheckCmdTimeliness() then
    return 
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_SelectBuffExit, proto_csmsg.CS_WEEKLYCHALLENGE_SelectBuffExit, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_SelectBuffExit, callback, proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_SelectBuffExit)
end

ExplorationNetworkCtrl.SC_WEEKLYCHALLENGE_SelectBuffExit = function(self, msg)
  -- function num : 0_71 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_WEEKLYCHALLENGE_SelectBuffExit error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_SelectBuffExit)
  end
end

ExplorationNetworkCtrl.__CheckCmdTimeliness = function(self)
  -- function num : 0_72 , upvalues : _ENV
  if ExplorationManager ~= nil and ExplorationManager:IsInExploration() then
    if ExplorationManager.moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
      local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
      local counterElem = timePassCtrl:getCounterElemData(proto_object_CounterModule.CounterModuleWeeklyChallengeFresh, 0)
      return counterElem ~= nil and PlayerDataCenter.timestamp + 1 < counterElem.nextExpiredTm
    elseif ExplorationManager.moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
      local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
      local counterElem = timePassCtrl:getCounterElemData(proto_object_CounterModule.CounterModuleDailyChallenge, 0)
      return counterElem ~= nil and PlayerDataCenter.timestamp + 1 < counterElem.nextExpiredTm
    else
      return true
    end
  end
  do return true end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

ExplorationNetworkCtrl.Reset = function(self)
  -- function num : 0_73
  self.lastSendDataList = {}
  self.cacheAction = {}
end

return ExplorationNetworkCtrl

