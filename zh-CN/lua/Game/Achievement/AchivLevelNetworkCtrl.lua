local AchivLevelNetworkCtrl = class("AchivLevelNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
AchivLevelNetworkCtrl.ctor = function(self)
  -- function num : 0_0
end

AchivLevelNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_Detail, self, proto_csmsg.SC_ACHIEVEMENT_Detail, self.OnRecv_ACHIEVEMENT_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_LevelReward, self, proto_csmsg.SC_ACHIEVEMENT_LevelReward, self.OnRecv_ACHIEVEMENT_LevelReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_OneKeyPick, self, proto_csmsg.SC_ACHIEVEMENT_OneKeyPick, self.OnRecvACHIEVEMENT_OneKeyPick)
end

AchivLevelNetworkCtrl.Send_ACHIEVEMENT_Detail = function(self)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_Detail, proto_csmsg.CS_ACHIEVEMENT_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_Detail, proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_Detail)
end

AchivLevelNetworkCtrl.OnRecv_ACHIEVEMENT_Detail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "OnRecv_ACHIEVEMENT_Detail error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
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
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  if self.__isGettingReward then
    return 
  end
  self.__isGettingReward = true
  local tabMsg = {lv = level}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_LevelReward, proto_csmsg.CS_ACHIEVEMENT_LevelReward, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_LevelReward, proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_LevelReward)
end

AchivLevelNetworkCtrl.OnRecv_ACHIEVEMENT_LevelReward = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  self.__isGettingReward = false
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "OnRecv_ACHIEVEMENT_LevelReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_LevelReward)
    return 
  else
    do
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
      MsgCenter:Broadcast(eMsgEventId.GetAchivLevelRewardComplete, msg.rewards)
    end
  end
end

AchivLevelNetworkCtrl.SendACHIEVEMENT_OneKeyPick = function(self, levels, backAction)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  local tabMsg = {lvs = levels}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_OneKeyPick, proto_csmsg.CS_ACHIEVEMENT_OneKeyPick, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_OneKeyPick, proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_OneKeyPick)
end

AchivLevelNetworkCtrl.OnRecvACHIEVEMENT_OneKeyPick = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  local items = {}
  for itemId,num in pairs(msg.rewards) do
    local itemCfg = (ConfigData.item)[itemId]
    if not itemCfg.is_shielded then
      (table.insert)(items, {id = itemId, warehouse_order = itemCfg.warehouse_order, count = num})
    end
  end
  ;
  (table.sort)(items, function(a, b)
    -- function num : 0_7_0
    if a.id >= b.id then
      do return a.warehouse_order ~= b.warehouse_order end
      do return a.warehouse_order < b.warehouse_order end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  local rewardIds = {}
  local rewardNums = {}
  for k,v in pairs(items) do
    (table.insert)(rewardIds, v.id)
    ;
    (table.insert)(rewardNums, v.count)
  end
  if #rewardIds > 0 then
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_7_1 , upvalues : rewardIds, rewardNums, self
    if window == nil then
      return 
    end
    window:InitRewardsItem(rewardIds, rewardNums, self._heroIdSnapShoot, false, true)
  end
)
  end
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "OnRecvACHIEVEMENT_OneKeyPick error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_LevelReward)
    return 
  else
    do
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

AchivLevelNetworkCtrl.AchieveLevelCommonDiff = function(self, diffMsg)
  -- function num : 0_8 , upvalues : _ENV
  if diffMsg.levelRewradsPicked ~= nil then
    (PlayerDataCenter.achivLevelData):AddPickedLevel(diffMsg.levelRewradsPicked)
  end
  if diffMsg.questFinishedRecords ~= nil then
    (PlayerDataCenter.achivLevelData):AddPickedAchivs(diffMsg.questFinishedRecords)
  end
end

AchivLevelNetworkCtrl.Reset = function(self)
  -- function num : 0_9
end

return AchivLevelNetworkCtrl

