-- params : ...
-- function num : 0 , upvalues : _ENV
local AchivLevelNetworkCtrl = class("AchivLevelNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
AchivLevelNetworkCtrl.ctor = function(self)
  -- function num : 0_0
end

AchivLevelNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_Detail, self, proto_csmsg.SC_ACHIEVEMENT_Detail, self.OnRecv_ACHIEVEMENT_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_LevelReward, self, proto_csmsg.SC_ACHIEVEMENT_LevelReward, self.OnRecv_ACHIEVEMENT_LevelReward)
end

AchivLevelNetworkCtrl.Send_ACHIEVEMENT_Detail = function(self)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_Detail, proto_csmsg.CS_ACHIEVEMENT_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_Detail, proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_Detail)
end

AchivLevelNetworkCtrl.OnRecv_ACHIEVEMENT_Detail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "OnRecv_ACHIEVEMENT_Detail error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_Detail)
      return 
    end
    if msg.data ~= nil then
      (PlayerDataCenter.achivLevelData):InitPickedLevels((msg.data).levelRewradsPicked)
      ;
      (PlayerDataCenter.achivLevelData):InitPickedAchivs((msg.data).questFinishedRecords)
    else
      ;
      (PlayerDataCenter.achivLevelData):InitPickedLevels(nil)
      ;
      (PlayerDataCenter.achivLevelData):InitPickedAchivs(nil)
    end
  end
end

AchivLevelNetworkCtrl.Send_ACHIEVEMENT_LevelReward = function(self, level)
  -- function num : 0_4 , upvalues : _ENV
  if self.__isGettingReward then
    return 
  end
  self.__isGettingReward = true
  local tabMsg = {lv = level}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_LevelReward, proto_csmsg.CS_ACHIEVEMENT_LevelReward, tabMsg)
end

AchivLevelNetworkCtrl.OnRecv_ACHIEVEMENT_LevelReward = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  self.__isGettingReward = false
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "OnRecv_ACHIEVEMENT_LevelReward error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    return 
  else
    do
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
      MsgCenter:Broadcast(eMsgEventId.GetAchivLevelRewardComplete, msg.rewards)
    end
  end
end

AchivLevelNetworkCtrl.AchieveLevelCommonDiff = function(self, diffMsg)
  -- function num : 0_6 , upvalues : _ENV
  if diffMsg.levelRewradsPicked ~= nil then
    (PlayerDataCenter.achivLevelData):AddPickedLevel(diffMsg.levelRewradsPicked)
  end
  if diffMsg.questFinishedRecords ~= nil then
    (PlayerDataCenter.achivLevelData):AddPickedAchivs(diffMsg.questFinishedRecords)
  end
end

AchivLevelNetworkCtrl.Reset = function(self)
  -- function num : 0_7
end

return AchivLevelNetworkCtrl

