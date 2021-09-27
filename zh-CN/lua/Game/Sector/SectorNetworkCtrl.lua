local SectorNetworkCtrl = class("SectorNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local SectorAchievementData = require("Game.Sector.Data.SectorAchievementData")
local CheckerTypeId, _ = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
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
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ENDLESS_Detail, self, proto_csmsg.SC_ENDLESS_Detail, self.SC_ENDLESS_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ENDLESS_SyncUpdateDiff, self, proto_csmsg.SC_ENDLESS_SyncUpdateDiff, self.SC_ENDLESS_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_Detail, self, proto_csmsg.SC_DAILYCHALLENGE_Detail, self.SC_DAILYCHALLENGE_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_Detail, self, proto_csmsg.SC_WEEKLYCHALLENGE_Detail, self.SC_WEEKLYCHALLENGE_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_RankPage, self, proto_csmsg.SC_WEEKLYCHALLENGE_RankPage, self.SC_WEEKLYCHALLENGE_RankPage)
end

SectorNetworkCtrl.SendAchievement = function(self)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Achievement, proto_csmsg.CS_SECTOR_Achievement, table.emptytable)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Achievement, proto_csmsg_MSG_ID.MSG_SC_SECTOR_Achievement)
end

SectorNetworkCtrl.OnRecvAchievement = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, SectorAchievementData, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if msg.ret == proto_csmsg_ErrorCode.None then
    PlayerDataCenter.sectorAchievementDatas = (SectorAchievementData.CreateAchivSectorData)(msg.sectorData)
  else
    local err = "SectorNetworkCtrl:OnRecvAchievement error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
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
  -- function num : 0_5 , upvalues : _ENV
  if msg.ret == proto_csmsg_ErrorCode.None then
    local chipSet = {}
    if msg.data ~= nil then
      for sectorId,chipDic in pairs(msg.data) do
        for chipId,v in pairs(chipDic.chipData) do
          chipSet[chipId] = v
        end
      end
    end
    do
      do
        MsgCenter:Broadcast(eMsgEventId.SectorChipSet, chipSet)
        do
          local err = "SectorNetworkCtrl:OnRecvChipSet error:" .. tostring(msg.ret)
          self:ShowSCErrorMsg(err)
          NetworkManager:HandleDiff(msg.syncUpdateDiff)
        end
      end
    end
  end
end

SectorNetworkCtrl.SendPickReward = function(self, sectorId, id, callback)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  local tabMsg = {sectorId = sectorId, id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SECTOR_PickReward, proto_csmsg.CS_SECTOR_PickReward, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_PickReward, callback, proto_csmsg_MSG_ID.MSG_SC_SECTOR_PickReward)
end

SectorNetworkCtrl.OnRecvPickReward = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    (PlayerDataCenter.sectorAchievementDatas):UpdateAchivData(msg)
    MsgCenter:Broadcast(eMsgEventId.SectorPickReward, msg.sectorId, msg.id)
  else
    local err = "SectorNetworkCtrl:OnRecvPickReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_PickReward)
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
  -- function num : 0_12 , upvalues : _ENV
  if msg.ret == proto_csmsg_ErrorCode.None then
    MsgCenter:Broadcast(eMsgEventId.PickFirstReward, msg.rewards)
  else
    local err = "On_SECTOR_BattleFirstRewardPick error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

SectorNetworkCtrl.CS_ENDLESS_Detail = function(self)
  -- function num : 0_13 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ENDLESS_Detail, proto_csmsg.CS_ENDLESS_Detail, table.emptytable)
end

SectorNetworkCtrl.SC_ENDLESS_Detail = function(self, msg)
  -- function num : 0_14 , upvalues : _ENV
  if msg.ret == proto_csmsg_ErrorCode.None then
    if msg.data == nil then
      return 
    end
    ;
    (PlayerDataCenter.infinityData):InitInfinityData((msg.data).highest, (msg.data).processing)
  else
    local err = "SC_ENDLESS_Detail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

SectorNetworkCtrl.SC_ENDLESS_SyncUpdateDiff = function(self, msg)
  -- function num : 0_15 , upvalues : _ENV, CheckerTypeId
  (PlayerDataCenter.infinityData):UpdateInfinityData(msg.completed, msg.processingUpdate)
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.InfinityDungeon)
end

SectorNetworkCtrl.CS_DAILYCHALLENGE_Detail = function(self, callback)
  -- function num : 0_16 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Detail, proto_csmsg.CS_DAILYCHALLENGE_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_Detail)
end

SectorNetworkCtrl.SC_DAILYCHALLENGE_Detail = function(self, msg)
  -- function num : 0_17 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    (PlayerDataCenter.periodicChallengeData):UpdateFromDailyChallengeMsg(msg)
  else
    local err = "SC_DAILYCHALLENGE_Detail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Detail)
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

SectorNetworkCtrl.CS_WEEKLYCHALLENGE_Detail = function(self, callback)
  -- function num : 0_18 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_Detail, proto_csmsg.CS_WEEKLYCHALLENGE_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_Detail)
end

SectorNetworkCtrl.SC_WEEKLYCHALLENGE_Detail = function(self, msg)
  -- function num : 0_19 , upvalues : _ENV
  if msg ~= nil then
    (PlayerDataCenter.allWeeklyChallengeData):UpdateByMsg(msg)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

SectorNetworkCtrl.CS_WEEKLYCHALLENGE_RankPage = function(self, isHistory, pageId, callback)
  -- function num : 0_20 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {history = isHistory or false, pageId = pageId or 1}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_RankPage, proto_csmsg.CS_WEEKLYCHALLENGE_RankPage, msg)
  if callback ~= nil then
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_RankPage, callback, proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_RankPage)
  end
end

SectorNetworkCtrl.SC_WEEKLYCHALLENGE_RankPage = function(self, msg)
  -- function num : 0_21 , upvalues : _ENV
  local weeklyRankWin = UIManager:GetWindow(UIWindowTypeID.WeeklyChallengeRank)
  if weeklyRankWin ~= nil then
    weeklyRankWin:OnReceiveRankMsg(msg)
  end
end

SectorNetworkCtrl.Reset = function(self)
  -- function num : 0_22
end

return SectorNetworkCtrl

