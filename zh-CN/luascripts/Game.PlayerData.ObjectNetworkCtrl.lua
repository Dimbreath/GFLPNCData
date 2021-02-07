-- params : ...
-- function num : 0 , upvalues : _ENV
local ObjectNetworkCtrl = class("ObjectNetworkCtrl", NetworkCtrlBase)
ObjectNetworkCtrl.ctor = function(self)
  -- function num : 0_0
end

ObjectNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SyncUserData, self, proto_csmsg.SC_SyncUserData, self.SC_SyncUserData)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FUNCTION_SyncUpdateDiff, self, proto_csmsg.SC_FUNCTION_SyncUpdateDiff, self.SC_FUNCTION_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SyncUserBaseDiff, self, proto_csmsg.SC_SyncUserBaseDiff, self.SC_SyncUserBaseDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_RESOURCE_SyncUpdateDiff, self, proto_csmsg.SC_RESOURCE_SyncUpdateDiff, self.SC_RESOURCE_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_SyncUpdateDiff, self, proto_csmsg.SC_HERO_SyncUpdateDiff, self.SC_HERO_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_UserNameModify, self, proto_csmsg.SC_User_UserNameModify, self.SC_User_UserNameModify)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_GUIDE_TriggerComplete, self, proto_csmsg.SC_GUIDE_TriggerComplete, self.SC_GUIDE_TriggerComplete)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_ModifyShowGirl, self, proto_csmsg.SC_User_ModifyShowGirl, self.SC_User_ModifyShowGirl)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_ClientLastSectorMention, self, proto_csmsg.SC_User_ClientLastSectorMention, self.SC_User_ClientLastSectorMention)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_COUNTER_Detail, self, proto_csmsg.SC_COUNTER_Detail, self.SC_COUNTER_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_COUNTER_SyncUpdateDiff, self, proto_csmsg.SC_COUNTER_SyncUpdateDiff, self.SC_COUNTER_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BLITZ_Blitz, self, proto_csmsg.SC_BLITZ_Blitz, self.SC_BLITZ_Blitz)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_SystemOverDay, self, proto_csmsg.SC_User_SystemOverDay, self.SC_User_SystemOverDay)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_SyncDiff, self, proto_csmsg.SC_User_SyncDiff, self.SC_User_SyncDiff)
end

ObjectNetworkCtrl.WaitUserPreData = function(self)
  -- function num : 0_2 , upvalues : _ENV
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_SC_SyncUserData, function(listObj)
    -- function num : 0_2_0 , upvalues : _ENV
    PlayerDataCenter:OnPreDataRecvComplete()
  end
, proto_csmsg_MSG_ID.MSG_SC_SyncUserData, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Detail, proto_csmsg_MSG_ID.MSG_SC_SECTOR_Detail, proto_csmsg_MSG_ID.MSG_SC_EFFECTOR_ResourceGenerator, proto_csmsg_MSG_ID.MSG_SC_ENDLESS_Detail)
end

ObjectNetworkCtrl.SC_SyncUserData = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
  PlayerDataCenter:SyncUserData(msg)
  ;
  ((CS.NetworkManager).Instance):SetTimeHeartActive(true)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

ObjectNetworkCtrl.SC_FUNCTION_SyncUpdateDiff = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in pairs(msg.updates) do
    local openCfg = (ConfigData.system_open)[k]
    if openCfg ~= nil and openCfg.screening then
      do
        FunctionUnlockMgr:AddUnlockFunction(k)
        -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  for k,v in pairs(msg.deletes) do
    FunctionUnlockMgr:RemoveUnlockFunction(k)
  end
end

ObjectNetworkCtrl.userBaseDiff = function(self, diffMsg)
  -- function num : 0_5 , upvalues : _ENV
  if diffMsg.level ~= nil then
    (PlayerDataCenter.playerLevel):UpdatePlayerLevelData((diffMsg.level).level, (diffMsg.level).exp)
  end
end

ObjectNetworkCtrl.SC_SyncUserBaseDiff = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV
  if msg.level ~= nil then
    (PlayerDataCenter.playerLevel):UpdatePlayerLevelData((msg.level).level, (msg.level).exp)
  end
end

ObjectNetworkCtrl.ItemDiff = function(self, diffMsg)
  -- function num : 0_7 , upvalues : _ENV
  PlayerDataCenter:SyncItemUpdateDiff(diffMsg)
end

ObjectNetworkCtrl.SC_RESOURCE_SyncUpdateDiff = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV
  PlayerDataCenter:SyncItemUpdateDiff(msg)
end

ObjectNetworkCtrl.SC_HERO_SyncUpdateDiff = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV
  PlayerDataCenter:SyncHeroUpdateDiff(msg)
end

ObjectNetworkCtrl.CS_User_UserNameModify = function(self, name, successAction)
  -- function num : 0_10 , upvalues : _ENV
  local createMsg = {name = name}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_UserNameModify, proto_csmsg.CS_User_UserNameModify, createMsg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_User_UserNameModify, function()
    -- function num : 0_10_0 , upvalues : _ENV, name, successAction
    PlayerDataCenter:UpdateUserNameData(name)
    if successAction ~= nil then
      successAction()
    end
  end
, proto_csmsg_MSG_ID.MSG_SC_User_UserNameModify)
end

ObjectNetworkCtrl.SC_User_UserNameModify = function(self, msg)
  -- function num : 0_11 , upvalues : _ENV
  if msg.ret ~= proto_csmsg_ErrorCode.None or msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.name_Illegal))
    ;
    ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_UserNameModify)
  else
    local err = "ObjectNetworkCtrl:SC_User_UserNameModify error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    ;
    ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_UserNameModify)
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ObjectNetworkCtrl.CS_User_ModifyShowGirl = function(self, id)
  -- function num : 0_12 , upvalues : _ENV
  local msg = {id = id}
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  PlayerDataCenter.showGirlId = id
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_ModifyShowGirl, proto_csmsg.CS_User_ModifyShowGirl, msg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_User_ModifyShowGirl, proto_csmsg_MSG_ID.MSG_SC_User_ModifyShowGirl)
end

ObjectNetworkCtrl.SC_User_ModifyShowGirl = function(self, msg)
  -- function num : 0_13 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "ObjectNetworkCtrl:SC_User_ModifyShowGirl error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(err)
      end
      ;
      ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_ModifyShowGirl)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ObjectNetworkCtrl.CS_GUIDE_TriggerComplete = function(self, guideId)
  -- function num : 0_14 , upvalues : _ENV
  local sendMsg = {id = guideId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_GUIDE_TriggerComplete, proto_csmsg.CS_GUIDE_TriggerComplete, sendMsg)
end

ObjectNetworkCtrl.SC_GUIDE_TriggerComplete = function(self, msg)
  -- function num : 0_15 , upvalues : _ENV
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

ObjectNetworkCtrl.CS_User_ClientLastSectorMention = function(self, sectorMentionId, callback)
  -- function num : 0_16 , upvalues : _ENV
  local msg = {id = sectorMentionId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_ClientLastSectorMention, proto_csmsg.CS_User_ClientLastSectorMention, msg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_User_ClientLastSectorMention, callback, proto_csmsg_MSG_ID.MSG_SC_User_ClientLastSectorMention)
end

ObjectNetworkCtrl.SC_User_ClientLastSectorMention = function(self, msg)
  -- function num : 0_17 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "ObjectNetworkCtrl:SC_User_ClientLastSectorMention error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(err)
      end
      ;
      ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_ClientLastSectorMention)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ObjectNetworkCtrl.CS_COUNTER_Detail = function(self, callback)
  -- function num : 0_18 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_COUNTER_Detail, proto_csmsg.CS_COUNTER_Detail, table.emptytable)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_COUNTER_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_COUNTER_Detail)
end

ObjectNetworkCtrl.SC_COUNTER_Detail = function(self, msg)
  -- function num : 0_19 , upvalues : _ENV
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_COUNTER_Detail error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    ;
    ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_COUNTER_Detail)
  else
    do
      ;
      ((CS.WaitNetworkResponse).Instance):AddWaitData(proto_csmsg_MSG_ID.MSG_CS_COUNTER_Detail, msg.data)
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

ObjectNetworkCtrl.SC_COUNTER_SyncUpdateDiff = function(self, msg)
  -- function num : 0_20 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.TimePass, true)):OnUpdateTimePassData(msg)
end

ObjectNetworkCtrl.CS_User_SystemOverDay = function(self)
  -- function num : 0_21 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_SystemOverDay, proto_csmsg.CS_User_SystemOverDay, table.emptytable)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_User_SystemOverDay, callback, proto_csmsg_MSG_ID.MSG_SC_User_SystemOverDay)
end

ObjectNetworkCtrl.SC_User_SystemOverDay = function(self, msg)
  -- function num : 0_22 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "ObjectNetworkCtrl:SC_User_SystemOverDay error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(err)
      end
      ;
      ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_SystemOverDay)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ObjectNetworkCtrl.CS_BLITZ_Blitz = function(self, dungeonId, count)
  -- function num : 0_23 , upvalues : _ENV
  if not count then
    count = 1
  end
  local sendMsg = {cnt = count, dungeonId = dungeonId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BLITZ_Blitz, proto_csmsg.CS_BLITZ_Blitz, sendMsg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_BLITZ_Blitz, callback, proto_csmsg_MSG_ID.MSG_SC_BLITZ_Blitz)
end

ObjectNetworkCtrl.SC_BLITZ_Blitz = function(self, msg)
  -- function num : 0_24 , upvalues : _ENV
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "ObjectNetworkCtrl:SC_BLITZ_Blitz error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(err)
      end
      ;
      ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BLITZ_Blitz)
      return 
    end
    if #msg.rewards == 0 then
      return 
    end
    local reward = (msg.rewards)[1]
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_24_0 , upvalues : _ENV, reward
    if window == nil then
      return 
    end
    local rewardIds = {}
    local rewardNums = {}
    for _,data in pairs(reward.data) do
      (table.insert)(rewardIds, data.id)
      ;
      (table.insert)(rewardNums, data.num * data.stacking)
    end
    window:InitRewardsItem(rewardIds, rewardNums)
    window:InitRewardTitle(ConfigData:GetTipContent(291))
  end
)
  end
end

ObjectNetworkCtrl.SC_User_SyncDiff = function(self, msg)
  -- function num : 0_25 , upvalues : _ENV
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

ObjectNetworkCtrl.Reset = function(self)
  -- function num : 0_26
end

return ObjectNetworkCtrl

