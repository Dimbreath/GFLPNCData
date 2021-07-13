-- params : ...
-- function num : 0 , upvalues : _ENV
local EventRoomNetworkCtrl = class("EventRoomNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
EventRoomNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.__selectMsg = {}
  self._assistTab = {}
  self._algUpgradeBackTab = {}
end

EventRoomNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Select, self, proto_csmsg.SC_EXPLORATION_EVENT_Select, self.SC_EXPLORATION_EVENT_Select)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Focus, self, proto_csmsg.SC_EXPLORATION_EVENT_Focus, self.SC_EXPLORATION_EVENT_Focus)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_RandomConfirm, self, proto_csmsg.SC_EXPLORATION_EVENT_RandomConfirm, self.SC_EXPLORATION_EVENT_RandomConfirm)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_AlgUpgrade, self, proto_csmsg.SC_EXPLORATION_EVENT_AlgUpgrade, self.SC_EXPLORATION_EVENT_AlgUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_SpecifyExit, self, proto_csmsg.SC_EXPLORATION_EVENT_SpecifyExit, self.SC_EXPLORATION_EVENT_SpecifyExit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Assist, self, proto_csmsg.SC_EXPLORATION_EVENT_Assist, self.SC_EXPLORATION_EVENT_Assist)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_AlgUpgradeBack, self, proto_csmsg.SC_EXPLORATION_EVENT_AlgUpgradeBack, self.SC_EXPLORATION_EVENT_AlgUpgradeBack)
end

EventRoomNetworkCtrl.CS_EXPLORATION_EVENT_Select = function(self, position, index)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.__selectMsg).position = position
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__selectMsg).idx = index
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Select, proto_csmsg.CS_EXPLORATION_EVENT_Select, self.__selectMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Select, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Select)
end

EventRoomNetworkCtrl.SC_EXPLORATION_EVENT_Select = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Select)
    local errorLog = nil
    if msg.ret == proto_csmsg_ErrorCode.EXPLORATION_EVENT_CONSUME_NOT_ENOUGH then
      errorLog = ConfigData:GetTipContent(TipContent.eventRoom_ItemInfficient)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(errorLog)
      end
    else
      errorLog = "SC_EXPLORATION_EVENT_Select error:" .. tostring(msg.ret)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(errorLog)
      end
      error(errorLog)
    end
    return 
  end
  do
    if ExplorationManager.epCtrl == nil then
      return 
    end
    ;
    ((ExplorationManager.epCtrl):GetLastSelectChoiceCtrl()):OnChoiceItemSelectSuccess(msg)
  end
end

EventRoomNetworkCtrl.CS_EXPLORATION_EVENT_Focus = function(self, position)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Focus, proto_csmsg.CS_EXPLORATION_EVENT_Focus, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Focus, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Focus)
end

EventRoomNetworkCtrl.SC_EXPLORATION_EVENT_Focus = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Focus)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)("SC_EXPLORATION_EVENT_Focus error,code:" .. tostring(msg.ret))
    end
  end
  if ExplorationManager.epCtrl == nil then
    return 
  end
  ;
  ((ExplorationManager.epCtrl).eventCtrl):OnRejudegeOver(msg.value)
end

EventRoomNetworkCtrl.CS_EXPLORATION_EVENT_RandomConfirm = function(self, position)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_RandomConfirm, proto_csmsg.CS_EXPLORATION_EVENT_RandomConfirm, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_RandomConfirm, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_RandomConfirm)
end

EventRoomNetworkCtrl.SC_EXPLORATION_EVENT_RandomConfirm = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_RandomConfirm)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)("SC_EXPLORATION_EVENT_RandomConfirm error,code:" .. tostring(msg.ret))
    end
  end
  if ExplorationManager.epCtrl == nil then
    return 
  end
  ;
  ((ExplorationManager.epCtrl).eventCtrl):OnCollectRewardSuccess()
end

EventRoomNetworkCtrl.CS_EXPLORATION_EVENT_AlgUpgrade = function(self, position, chipId, callback)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
  self.__selectMsg = {}
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__selectMsg).position = position
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__selectMsg).algId = chipId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AlgUpgrade, proto_csmsg.CS_EXPLORATION_EVENT_AlgUpgrade, self.__selectMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AlgUpgrade, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_AlgUpgrade, proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfAlgDiff)
end

EventRoomNetworkCtrl.SC_EXPLORATION_EVENT_AlgUpgrade = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AlgUpgrade)
    local err = "EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_AlgUpgrade error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    return 
  end
end

EventRoomNetworkCtrl.CS_EXPLORATION_EVENT_SpecifyExit = function(self, position, callback)
  -- function num : 0_10 , upvalues : _ENV, cs_WaitNetworkResponse
  self.__selectMsg = {}
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__selectMsg).position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_SpecifyExit, proto_csmsg.CS_EXPLORATION_EVENT_SpecifyExit, self.__selectMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_SpecifyExit, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_SpecifyExit)
end

EventRoomNetworkCtrl.SC_EXPLORATION_EVENT_SpecifyExit = function(self, msg)
  -- function num : 0_11 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_SpecifyExit)
    local err = "EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_SpecifyExit error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    return 
  end
end

EventRoomNetworkCtrl.CS_EXPLORATION_EVENT_AlgUpgradeBack = function(self, position, callback)
  -- function num : 0_12 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self._algUpgradeBackTab).position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AlgUpgradeBack, proto_csmsg.CS_EXPLORATION_EVENT_AlgUpgradeBack, self._algUpgradeBackTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AlgUpgradeBack, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_AlgUpgradeBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff)
end

EventRoomNetworkCtrl.SC_EXPLORATION_EVENT_AlgUpgradeBack = function(self, msg)
  -- function num : 0_13 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AlgUpgradeBack)
    local err = "SC_EXPLORATION_EVENT_AlgUpgradeBack error:" .. tostring(msg.ret)
    error(err)
    ;
    (cs_MessageCommon.ShowMessageTips)(err)
    return 
  end
end

EventRoomNetworkCtrl.CS_EXPLORATION_EVENT_Assist = function(self, roomPos, quitHeroUidList, enterIdList, callback)
  -- function num : 0_14 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

  (self._assistTab).position = roomPos
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._assistTab).quit = quitHeroUidList
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._assistTab).enter = enterIdList
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Assist, proto_csmsg.CS_EXPLORATION_EVENT_Assist, self._assistTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Assist, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Assist)
end

EventRoomNetworkCtrl.SC_EXPLORATION_EVENT_Assist = function(self, msg)
  -- function num : 0_15 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Assist)
    local err = "SC_EXPLORATION_EVENT_Assist error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    return 
  end
  do
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Assist, msg)
  end
end

EventRoomNetworkCtrl.Reset = function(self)
  -- function num : 0_16
end

return EventRoomNetworkCtrl

