-- params : ...
-- function num : 0 , upvalues : _ENV
local SectorNetworkCtrl = class("SectorNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local SectorData = require("Game.Sector.Data.SectorData")
SectorNetworkCtrl.ctor = function(self)
  -- function num : 0_0
end

SectorNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SECTOR_Achievement, self, proto_csmsg.SC_SECTOR_Achievement, self.OnRecvAchievement)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SECTOR_ChipSet, self, proto_csmsg.SC_SECTOR_ChipSet, self.OnRecvChipSet)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SECTOR_PickReward, self, proto_csmsg.SC_SECTOR_PickReward, self.OnRecvPickReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SECTOR_Detail, self, proto_csmsg.SC_SECTOR_Detail, self.SC_SECTOR_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SECTOR_SyncUpdateDiff, self, proto_csmsg.SC_SECTOR_SyncUpdateDiff, self.SC_SECTOR_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SECTOR_BattleFirstRewardPick, self, proto_csmsg.SC_SECTOR_BattleFirstRewardPick, self.On_SECTOR_BattleFirstRewardPick)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_OVERCLOCK_Detail, self, proto_csmsg.SC_EXPLORATION_OVERCLOCK_Detail, self.SC_EXPLORATION_OVERCLOCK_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ENDLESS_Detail, self, proto_csmsg.SC_ENDLESS_Detail, self.SC_ENDLESS_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ENDLESS_SyncUpdateDiff, self, proto_csmsg.SC_ENDLESS_SyncUpdateDiff, self.SC_ENDLESS_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_Detail, self, proto_csmsg.SC_DAILYCHALLENGE_Detail, self.SC_DAILYCHALLENGE_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_Start, self, proto_csmsg.SC_DAILYCHALLENGE_Start, self.SC_DAILYCHALLENGE_Start)
end

SectorNetworkCtrl.SendAchievement = function(self)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Achievement, proto_csmsg.CS_SECTOR_Achievement, table.emptytable)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Achievement, proto_csmsg_MSG_ID.MSG_SC_SECTOR_Achievement)
end

SectorNetworkCtrl.OnRecvAchievement = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, SectorData, cs_MessageCommon, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if msg.ret == proto_csmsg_ErrorCode.None then
    PlayerDataCenter.sectorDatas = (SectorData.CreateAll)(msg.sectorData)
  else
    local err = "SectorNetworkCtrl:OnRecvAchievement error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Achievement)
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

SectorNetworkCtrl.SendChipSet = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tabMsg = {}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SECTOR_ChipSet, proto_csmsg.CS_SECTOR_ChipSet, tabMsg)
end

SectorNetworkCtrl.OnRecvChipSet = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    local chipSet = {}
    if msg.data ~= nil then
      for k,v in pairs(msg.data) do
        chipSet[k] = v
      end
    end
    do
      do
        MsgCenter:Broadcast(eMsgEventId.SectorChipSet, chipSet)
        do
          local err = "SectorNetworkCtrl:OnRecvChipSet error:" .. tostring(msg.ret)
          error(err)
          if isGameDev then
            (cs_MessageCommon.ShowMessageTips)(err)
          end
          NetworkManager:HandleDiff(msg.syncUpdateDiff)
        end
      end
    end
  end
end

SectorNetworkCtrl.SendPickReward = function(self, sectorId, id)
  -- function num : 0_6 , upvalues : _ENV
  local tabMsg = {sectorId = sectorId, id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SECTOR_PickReward, proto_csmsg.CS_SECTOR_PickReward, tabMsg)
end

SectorNetworkCtrl.OnRecvPickReward = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, SectorData, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    (SectorData.UpdateAchivData)(msg)
    MsgCenter:Broadcast(eMsgEventId.SectorPickReward, msg.sectorId, msg.id)
  else
    local err = "SectorNetworkCtrl:OnRecvPickReward error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

SectorNetworkCtrl.CS_SECTOR_Detail = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Detail, proto_csmsg.CS_SECTOR_Detail, table.emptytable)
end

SectorNetworkCtrl.SC_SECTOR_Detail = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV
  (PlayerDataCenter.sectorStage):UpdateStageData(msg.data, true)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

SectorNetworkCtrl.SC_SECTOR_SyncUpdateDiff = function(self, msg)
  -- function num : 0_10 , upvalues : _ENV
  (PlayerDataCenter.sectorStage):UpdateStageData(msg.update, false)
  MsgCenter:Broadcast(eMsgEventId.SectorStateUpdate)
end

SectorNetworkCtrl.Send_SECTOR_BattleFirstRewardPick = function(self, id)
  -- function num : 0_11 , upvalues : _ENV
  local tabMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SECTOR_BattleFirstRewardPick, proto_csmsg.CS_SECTOR_BattleFirstRewardPick, tabMsg)
end

SectorNetworkCtrl.On_SECTOR_BattleFirstRewardPick = function(self, msg)
  -- function num : 0_12 , upvalues : _ENV, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    MsgCenter:Broadcast(eMsgEventId.PickFirstReward, msg.rewards)
  else
    local err = "On_SECTOR_BattleFirstRewardPick error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

SectorNetworkCtrl.CS_EXPLORATION_OVERCLOCK_Detail = function(self, callback)
  -- function num : 0_13 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_OVERCLOCK_Detail, proto_csmsg.CS_EXPLORATION_OVERCLOCK_Detail, {})
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_OVERCLOCK_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_OVERCLOCK_Detail)
end

SectorNetworkCtrl.SC_EXPLORATION_OVERCLOCK_Detail = function(self, msg)
  -- function num : 0_14 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.Overclock, false)):SetOverclockDetail(msg)
end

SectorNetworkCtrl.CS_ENDLESS_Detail = function(self)
  -- function num : 0_15 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ENDLESS_Detail, proto_csmsg.CS_ENDLESS_Detail, table.emptytable)
end

SectorNetworkCtrl.SC_ENDLESS_Detail = function(self, msg)
  -- function num : 0_16 , upvalues : _ENV, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    if msg.data == nil then
      return 
    end
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (PlayerDataCenter.infinityData).completed = (msg.data).completed
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (PlayerDataCenter.infinityData).processingUpdate = (msg.data).processing
  else
    local err = "SC_ENDLESS_Detail error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

SectorNetworkCtrl.SC_ENDLESS_SyncUpdateDiff = function(self, msg)
  -- function num : 0_17 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if (table.count)(msg.completed) > 1 then
    (PlayerDataCenter.infinityData).oldData = {}
    for key,value in pairs((PlayerDataCenter.infinityData).completed) do
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

      ((PlayerDataCenter.infinityData).oldData)[key] = value
    end
    for key,value in pairs((PlayerDataCenter.infinityData).processingUpdate) do
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'

      ((PlayerDataCenter.infinityData).oldData)[key] = value
    end
  end
  do
    ;
    (table.merge)((PlayerDataCenter.infinityData).completed, msg.completed)
    ;
    (table.merge)((PlayerDataCenter.infinityData).processingUpdate, msg.processingUpdate)
    for id,_ in pairs(msg.completed) do
      -- DECOMPILER ERROR at PC55: Confused about usage of register: R7 in 'UnsetPending'

      ((PlayerDataCenter.infinityData).processingUpdate)[id] = nil
    end
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (PlayerDataCenter.infinityData).freshData = {}
    ;
    (table.merge)((PlayerDataCenter.infinityData).freshData, msg.completed)
    ;
    (table.merge)((PlayerDataCenter.infinityData).freshData, msg.processingUpdate)
  end
end

SectorNetworkCtrl.CS_DAILYCHALLENGE_Detail = function(self, callback)
  -- function num : 0_18 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Detail, proto_csmsg.CS_DAILYCHALLENGE_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_Detail)
end

SectorNetworkCtrl.SC_DAILYCHALLENGE_Detail = function(self, msg)
  -- function num : 0_19 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    (PlayerDataCenter.periodicChallengeData):UpdateFromDailyChallengeMsg(msg)
  else
    local err = "SC_DAILYCHALLENGE_Detail error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Detail)
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

SectorNetworkCtrl.CS_DAILYCHALLENGE_Start = function(self, fomationId, callback)
  -- function num : 0_20 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {formId = fomationId}
  local OverclockCtrl = ControllerManager:GetController(ControllerTypeId.Overclock, false)
  if OverclockCtrl ~= nil then
    msg.ocChoice = {}
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (msg.ocChoice).data = OverclockCtrl:UseOverClock()
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Start, proto_csmsg.CS_DAILYCHALLENGE_Start, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Start, callback, proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_Start)
end

SectorNetworkCtrl.SC_DAILYCHALLENGE_Start = function(self, msg)
  -- function num : 0_21 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
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

SectorNetworkCtrl.Reset = function(self)
  -- function num : 0_22
end

return SectorNetworkCtrl

