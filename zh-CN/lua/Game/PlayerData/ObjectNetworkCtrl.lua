local ObjectNetworkCtrl = class("ObjectNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
ObjectNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.uidMsg = {}
  self.installSupportMsg = {}
  self.uninstallSupportMsg = {}
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
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_AvatarModify, self, proto_csmsg.SC_User_AvatarModify, self.SC_User_AvatarModify)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_SignatureMod, self, proto_csmsg.SC_User_SignatureMod, self.SC_User_SignatureMod)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_AvatarFrameMod, self, proto_csmsg.SC_User_AvatarFrameMod, self.SC_User_AvatarFrameMod)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_SexMod, self, proto_csmsg.SC_User_SexMod, self.SC_User_SexMod)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_BGPlateMod, self, proto_csmsg.SC_User_BGPlateMod, self.SC_User_BGPlateMod)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_AVATAR_Fetch, self, proto_csmsg.SC_AVATAR_Fetch, self.SC_AVATAR_Fetch)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_Install, self, proto_csmsg.SC_ASSISTANT_Install, self.SC_ASSISTANT_Install)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_Uninstall, self, proto_csmsg.SC_ASSISTANT_Uninstall, self.SC_ASSISTANT_Uninstall)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_FetchStranger, self, proto_csmsg.SC_ASSISTANT_FetchStranger, self.SC_ASSISTANT_FetchStranger)
end

ObjectNetworkCtrl.WaitUserPreData = function(self)
  -- function num : 0_2 , upvalues : _ENV
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_SC_SyncUserData, function(listObj)
    -- function num : 0_2_0 , upvalues : _ENV
    PlayerDataCenter:OnPreDataRecvComplete()
  end
, proto_csmsg_MSG_ID.MSG_SC_SyncUserData, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Detail, proto_csmsg_MSG_ID.MSG_SC_SECTOR_Detail, proto_csmsg_MSG_ID.MSG_SC_EFFECTOR_ResourceGenerator, proto_csmsg_MSG_ID.MSG_SC_ENDLESS_Detail, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Detail)
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
  if diffMsg.doc ~= nil then
    (PlayerDataCenter.inforData):UpdateUserDoc(diffMsg.doc)
  end
  if diffMsg.point ~= nil then
    (PlayerDataCenter.inforData):SetSupportPointData(diffMsg.point)
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

ObjectNetworkCtrl.CS_User_SexMod = function(self, sex, successAction)
  -- function num : 0_12 , upvalues : _ENV
  local createMsg = {sex = sex}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_SexMod, proto_csmsg.CS_User_SexMod, createMsg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_User_SexMod, function()
    -- function num : 0_12_0 , upvalues : _ENV, sex, successAction
    (PlayerDataCenter.inforData):SetSex(sex)
    if successAction ~= nil then
      successAction()
    end
  end
, proto_csmsg_MSG_ID.MSG_SC_User_SexMod)
end

ObjectNetworkCtrl.SC_User_SexMod = function(self, msg)
  -- function num : 0_13 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "ObjectNetworkCtrl:SC_User_SexMod error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(err)
      end
      ;
      ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_SexMod)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ObjectNetworkCtrl.CS_User_AvatarModify = function(self, id, successAction)
  -- function num : 0_14 , upvalues : _ENV
  local createMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_AvatarModify, proto_csmsg.CS_User_AvatarModify, createMsg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_User_AvatarModify, function()
    -- function num : 0_14_0 , upvalues : _ENV, id, successAction
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (PlayerDataCenter.inforData).avatarId = id
    if successAction ~= nil then
      successAction()
    end
  end
, proto_csmsg_MSG_ID.MSG_SC_User_AvatarModify)
end

ObjectNetworkCtrl.SC_User_AvatarModify = function(self, msg)
  -- function num : 0_15 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "ObjectNetworkCtrl:SC_User_AvatarModify error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(err)
      end
      ;
      ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_AvatarModify)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ObjectNetworkCtrl.CS_User_AvatarFrameMod = function(self, id, successAction)
  -- function num : 0_16 , upvalues : _ENV
  local createMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_AvatarFrameMod, proto_csmsg.CS_User_AvatarFrameMod, createMsg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_User_AvatarFrameMod, function()
    -- function num : 0_16_0 , upvalues : _ENV, id, successAction
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (PlayerDataCenter.inforData).avatarFrameId = id
    if successAction ~= nil then
      successAction()
    end
  end
, proto_csmsg_MSG_ID.MSG_SC_User_AvatarFrameMod)
end

ObjectNetworkCtrl.SC_User_AvatarFrameMod = function(self, msg)
  -- function num : 0_17 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "ObjectNetworkCtrl:SC_User_AvatarFrameMod error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(err)
      end
      ;
      ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_AvatarFrameMod)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ObjectNetworkCtrl.CS_User_SignatureMod = function(self, signature, successAction)
  -- function num : 0_18 , upvalues : _ENV
  local createMsg = {sign = signature}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_SignatureMod, proto_csmsg.CS_User_SignatureMod, createMsg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_User_SignatureMod, function()
    -- function num : 0_18_0 , upvalues : _ENV, signature, successAction
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (PlayerDataCenter.inforData).signature = signature
    if successAction ~= nil then
      successAction()
    end
  end
, proto_csmsg_MSG_ID.MSG_SC_User_SignatureMod)
end

ObjectNetworkCtrl.SC_User_SignatureMod = function(self, msg)
  -- function num : 0_19 , upvalues : _ENV
  if msg.ret ~= proto_csmsg_ErrorCode.None or msg.ret == proto_csmsg_ErrorCode.USER_SIGN_LEN_LIMIT then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Signature_Illegal))
    ;
    ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_SignatureMod)
  else
    if msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
      ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Signature_Illegal))
      ;
      ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_SignatureMod)
    else
      local err = "ObjectNetworkCtrl:SC_User_SignatureMod error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(err)
      end
      ;
      ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_SignatureMod)
    end
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ObjectNetworkCtrl.CS_User_BGPlateMod = function(self, id, successAction)
  -- function num : 0_20 , upvalues : _ENV
  local createMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_BGPlateMod, proto_csmsg.CS_User_BGPlateMod, createMsg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_User_BGPlateMod, function()
    -- function num : 0_20_0 , upvalues : _ENV, id, successAction
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (PlayerDataCenter.inforData).backgroudPlateId = id
    if successAction ~= nil then
      successAction()
    end
  end
, proto_csmsg_MSG_ID.MSG_SC_User_BGPlateMod)
end

ObjectNetworkCtrl.SC_User_BGPlateMod = function(self, msg)
  -- function num : 0_21 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "ObjectNetworkCtrl:SC_User_BGPlateMod error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(err)
      end
      ;
      ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_BGPlateMod)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ObjectNetworkCtrl.CS_User_ModifyShowGirl = function(self, id)
  -- function num : 0_22 , upvalues : _ENV
  local msg = {id = id}
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  PlayerDataCenter.showGirlId = id
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if PlayerDataCenter.inforData ~= nil then
    (PlayerDataCenter.inforData).showGirlId = id
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_ModifyShowGirl, proto_csmsg.CS_User_ModifyShowGirl, msg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_User_ModifyShowGirl, proto_csmsg_MSG_ID.MSG_SC_User_ModifyShowGirl)
end

ObjectNetworkCtrl.SC_User_ModifyShowGirl = function(self, msg)
  -- function num : 0_23 , upvalues : _ENV
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

ObjectNetworkCtrl.CS_GUIDE_TriggerComplete = function(self, guideId, action)
  -- function num : 0_24 , upvalues : _ENV
  local sendMsg = {id = guideId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_GUIDE_TriggerComplete, proto_csmsg.CS_GUIDE_TriggerComplete, sendMsg)
  if action ~= nil then
    ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_GUIDE_TriggerComplete, action, proto_csmsg_MSG_ID.MSG_SC_GUIDE_TriggerComplete)
  end
end

ObjectNetworkCtrl.SC_GUIDE_TriggerComplete = function(self, msg)
  -- function num : 0_25 , upvalues : _ENV
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

ObjectNetworkCtrl.CS_User_ClientLastSectorMention = function(self, sectorMentionId, callback)
  -- function num : 0_26 , upvalues : _ENV
  local msg = {id = sectorMentionId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_ClientLastSectorMention, proto_csmsg.CS_User_ClientLastSectorMention, msg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_User_ClientLastSectorMention, callback, proto_csmsg_MSG_ID.MSG_SC_User_ClientLastSectorMention)
end

ObjectNetworkCtrl.SC_User_ClientLastSectorMention = function(self, msg)
  -- function num : 0_27 , upvalues : _ENV
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
  -- function num : 0_28 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_COUNTER_Detail, proto_csmsg.CS_COUNTER_Detail, table.emptytable)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_COUNTER_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_COUNTER_Detail)
end

ObjectNetworkCtrl.SC_COUNTER_Detail = function(self, msg)
  -- function num : 0_29 , upvalues : _ENV
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
  -- function num : 0_30 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.TimePass, true)):OnUpdateTimePassData(msg)
end

ObjectNetworkCtrl.CS_User_SystemOverDay = function(self)
  -- function num : 0_31 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_SystemOverDay, proto_csmsg.CS_User_SystemOverDay, table.emptytable)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_User_SystemOverDay, proto_csmsg_MSG_ID.MSG_SC_User_SystemOverDay)
end

ObjectNetworkCtrl.SC_User_SystemOverDay = function(self, msg)
  -- function num : 0_32 , upvalues : _ENV
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
  -- function num : 0_33 , upvalues : _ENV
  if not count then
    count = 1
  end
  local sendMsg = {cnt = count, dungeonId = dungeonId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BLITZ_Blitz, proto_csmsg.CS_BLITZ_Blitz, sendMsg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_BLITZ_Blitz, callback, proto_csmsg_MSG_ID.MSG_SC_BLITZ_Blitz)
end

ObjectNetworkCtrl.SC_BLITZ_Blitz = function(self, msg)
  -- function num : 0_34 , upvalues : _ENV
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
    -- function num : 0_34_0 , upvalues : _ENV, reward
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
    window:InitRewardTitle(ConfigData:GetTipContent(291))
    window:InitRewardsItem(rewardIds, rewardNums)
  end
)
  end
end

ObjectNetworkCtrl.CS_AVATAR_Fetch = function(self, uid, callback)
  -- function num : 0_35 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.uidMsg).uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_AVATAR_Fetch, proto_csmsg.CS_AVATAR_Fetch, self.uidMsg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_AVATAR_Fetch, callback, proto_csmsg_MSG_ID.MSG_SC_AVATAR_Fetch)
end

ObjectNetworkCtrl.SC_AVATAR_Fetch = function(self, msg)
  -- function num : 0_36 , upvalues : _ENV
  if msg.avatar == nil then
    ((CS.WaitNetworkResponse).Instance):AddWaitData(proto_csmsg_MSG_ID.MSG_CS_AVATAR_Fetch, false)
  else
    ;
    ((CS.WaitNetworkResponse).Instance):AddWaitData(proto_csmsg_MSG_ID.MSG_CS_AVATAR_Fetch, msg.avatar)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

ObjectNetworkCtrl.CS_ASSISTANT_Install = function(self, heroId, index, callback)
  -- function num : 0_37 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.installSupportMsg).heroId = heroId
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.installSupportMsg).idx = index - 1
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_Install, proto_csmsg.CS_ASSISTANT_Install, self.installSupportMsg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_Install, callback, proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_Install)
end

ObjectNetworkCtrl.SC_ASSISTANT_Install = function(self, msg)
  -- function num : 0_38 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "ObjectNetworkCtrl:SC_ASSISTANT_Install error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(err)
      end
      ;
      ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_Install)
      return 
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ObjectNetworkCtrl.CS_ASSISTANT_Uninstall = function(self, heroId, callback)
  -- function num : 0_39 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.uninstallSupportMsg).heroId = heroId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_Uninstall, proto_csmsg.CS_ASSISTANT_Uninstall, self.uninstallSupportMsg)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_Uninstall, callback, proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_Uninstall)
end

ObjectNetworkCtrl.SC_ASSISTANT_Uninstall = function(self, msg)
  -- function num : 0_40 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "ObjectNetworkCtrl:SC_ASSISTANT_Uninstall error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(err)
      end
      ;
      ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_Uninstall)
      return 
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

ObjectNetworkCtrl.CS_ASSISTANT_FetchStranger = function(self, callback)
  -- function num : 0_41 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_FetchStranger, proto_csmsg.CS_ASSISTANT_FetchStranger, table.emptytable)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_FetchStranger, callback, proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_FetchStranger)
end

ObjectNetworkCtrl.SC_ASSISTANT_FetchStranger = function(self, msg)
  -- function num : 0_42 , upvalues : _ENV
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_ASSISTANT_FetchStranger error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    ;
    ((CS.WaitNetworkResponse).Instance):RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_FetchStranger)
    return 
  else
    do
      ;
      ((CS.WaitNetworkResponse).Instance):AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_FetchStranger, msg)
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

ObjectNetworkCtrl.SC_User_SyncDiff = function(self, msg)
  -- function num : 0_43 , upvalues : _ENV
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

ObjectNetworkCtrl.Reset = function(self)
  -- function num : 0_44
end

return ObjectNetworkCtrl

