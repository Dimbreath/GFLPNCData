local NetworkDiffDeliver = {}
local diffOrderList = {proto_csmsg_SyncUpdateDiffEnum.DIFF_FUNCTION, proto_csmsg_SyncUpdateDiffEnum.DIFF_USERBASE, proto_csmsg_SyncUpdateDiffEnum.DIFF_BATTLEPASS, proto_csmsg_SyncUpdateDiffEnum.DIFF_BUILDING, proto_csmsg_SyncUpdateDiffEnum.DIFF_INTIMACY, proto_csmsg_SyncUpdateDiffEnum.DIFF_QUEST, proto_csmsg_SyncUpdateDiffEnum.DIFF_FACTORY, proto_csmsg_SyncUpdateDiffEnum.DIFF_SECTOR, proto_csmsg_SyncUpdateDiffEnum.DIFF_ALG, proto_csmsg_SyncUpdateDiffEnum.DIFF_EXPLORATION, proto_csmsg_SyncUpdateDiffEnum.DIFF_ACHIEVEMENT, proto_csmsg_SyncUpdateDiffEnum.DIFF_HERO, proto_csmsg_SyncUpdateDiffEnum.DIFF_ATH, proto_csmsg_SyncUpdateDiffEnum.DIFF_RESOURCE, proto_csmsg_SyncUpdateDiffEnum.DIFF_EFFECTORRG, proto_csmsg_SyncUpdateDiffEnum.DIFF_LOTTERY, proto_csmsg_SyncUpdateDiffEnum.DIFF_COUNTER, proto_csmsg_SyncUpdateDiffEnum.DIFF_MAIL, proto_csmsg_SyncUpdateDiffEnum.DIFF_MONTHCARD, proto_csmsg_SyncUpdateDiffEnum.DIFF_ENDLESS, proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY, proto_csmsg_SyncUpdateDiffEnum.DIFF_FRIEND, proto_csmsg_SyncUpdateDiffEnum.DIFF_DUNGEON_DYNC, proto_csmsg_SyncUpdateDiffEnum.DIFF_TIMING_PRODUCT}
local diffFuncTable = {[proto_csmsg_SyncUpdateDiffEnum.DIFF_ACHIEVEMENT] = function(syncUpdateDiff)
  -- function num : 0_0 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.achievement
  local AchivLevelNetwork = NetworkManager:GetNetwork(NetworkTypeID.AchivLevel)
  if diffMsg ~= nil then
    AchivLevelNetwork:AchieveLevelCommonDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_ATH] = function(syncUpdateDiff)
  -- function num : 0_1 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.ath
  local AthNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  if diffMsg ~= nil then
    AthNetwork:SC_ATH_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_BUILDING] = function(syncUpdateDiff)
  -- function num : 0_2 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.building
  local buildingNetwork = NetworkManager:GetNetwork(NetworkTypeID.Building)
  if diffMsg ~= nil then
    buildingNetwork:OnRecvBuildingSyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_EFFECTORRG] = function(syncUpdateDiff)
  -- function num : 0_3 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.effectorRG
  local EffectorNetwork = NetworkManager:GetNetwork(NetworkTypeID.Effector)
  if diffMsg ~= nil then
    EffectorNetwork:SC_EFFECTOR_RGSyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_ENDLESS] = function(syncUpdateDiff)
  -- function num : 0_4 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.endless
  local SectorNetwork = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  if diffMsg ~= nil then
    SectorNetwork:SC_ENDLESS_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_EXPLORATION] = function(syncUpdateDiff)
  -- function num : 0_5 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.exploration
  local epNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  if diffMsg ~= nil then
    epNetwork:SC_EXPLORATION_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_FACTORY] = function(syncUpdateDiff)
  -- function num : 0_6 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.factory
  local FactoryNetwork = NetworkManager:GetNetwork(NetworkTypeID.Factory)
  if diffMsg ~= nil then
    FactoryNetwork:FactoryCommonDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_HERO] = function(syncUpdateDiff)
  -- function num : 0_7 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.hero
  local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  if diffMsg ~= nil then
    ObjectNetwork:SC_HERO_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_MAIL] = function(syncUpdateDiff)
  -- function num : 0_8 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.mail
  local MailNetwork = NetworkManager:GetNetwork(NetworkTypeID.Mail)
  if diffMsg ~= nil then
    MailNetwork:MailCommonDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_QUEST] = function(syncUpdateDiff)
  -- function num : 0_9 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.quest
  local TaskNetwork = NetworkManager:GetNetwork(NetworkTypeID.Task)
  if diffMsg ~= nil then
    TaskNetwork:OnRecvSyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_SECTOR] = function(syncUpdateDiff)
  -- function num : 0_10 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.sector
  local SectorNetwork = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  if diffMsg ~= nil then
    SectorNetwork:SC_SECTOR_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_COUNTER] = function(syncUpdateDiff)
  -- function num : 0_11 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.counter
  local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  if diffMsg ~= nil then
    ObjectNetwork:SC_COUNTER_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_FUNCTION] = function(syncUpdateDiff)
  -- function num : 0_12 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.functions
  local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  if diffMsg ~= nil then
    ObjectNetwork:SC_FUNCTION_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_RESOURCE] = function(syncUpdateDiff)
  -- function num : 0_13 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.resource
  local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  if diffMsg ~= nil then
    ObjectNetwork:ItemDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_USERBASE] = function(syncUpdateDiff)
  -- function num : 0_14 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.userBase
  local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  if diffMsg ~= nil then
    ObjectNetwork:userBaseDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_ALG] = function(syncUpdateDiff)
  -- function num : 0_15 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.alg
  local BattleDungeonNetwork = NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)
  if diffMsg ~= nil then
    BattleDungeonNetwork:SC_BATTLE_NtfAlgDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_INTIMACY] = function(syncUpdateDiff)
  -- function num : 0_16 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.intimacy
  local friendshipNetwork = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
  if diffMsg ~= nil then
    friendshipNetwork:SC_INTIMACY_SyncDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_BATTLEPASS] = function(syncUpdateDiff)
  -- function num : 0_17 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.battlepass
  if diffMsg ~= nil then
    (NetworkManager:GetNetwork(NetworkTypeID.BattlePass)):SC_BATTLEPASS_SyncDiff(diffMsg)
  end
  return true
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_MONTHCARD] = function(syncUpdateDiff)
  -- function num : 0_18 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.monthCard
  local dailySignInNetwork = NetworkManager:GetNetwork(NetworkTypeID.DailySignIn)
  if diffMsg ~= nil then
    dailySignInNetwork:ApplyMonthCardDiff(diffMsg.update)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY] = function(syncUpdateDiff)
  -- function num : 0_19 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.activity
  local netWorkController = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  if diffMsg ~= nil then
    netWorkController:ApplyActivityDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_LOTTERY] = function(syncUpdateDiff)
  -- function num : 0_20 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.lottery
  local netWorkController = NetworkManager:GetNetwork(NetworkTypeID.Lottery)
  if diffMsg ~= nil then
    netWorkController:SC_LOTTERY_SyncDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_FRIEND] = function(syncUpdateDiff)
  -- function num : 0_21 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.friend
  local netWorkController = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  if diffMsg ~= nil and netWorkController ~= nil then
    netWorkController:HandleFriendDiffer(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_DUNGEON_DYNC] = function(syncUpdateDiff)
  -- function num : 0_22 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.dungeonDync
  local netWorkController = NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)
  if diffMsg ~= nil and netWorkController ~= nil then
    netWorkController:SC_DUNGEON_Dync_SyncDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_TIMING_PRODUCT] = function(syncUpdateDiff)
  -- function num : 0_23 , upvalues : _ENV
  local timingProduct = syncUpdateDiff.timingProduct
  local netWorkController = NetworkManager:GetNetwork(NetworkTypeID.TimingProduct)
  if timingProduct ~= nil and netWorkController ~= nil then
    netWorkController:SC_TimingProduct_SyncUpdateDiff(timingProduct)
    return true
  end
end
}
local rewardCollectFuncTable = {[proto_csmsg_SyncUpdateDiffEnum.DIFF_RESOURCE] = function(syncUpdateDiff, rewardCache)
  -- function num : 0_24 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.resource
  if diffMsg.backpack == nil then
    return 
  end
  local rewardTable = rewardCache.rewardTable
  local consumeTable = rewardCache.consumeTable
  for id,updateItemInfo in pairs((diffMsg.backpack).updates) do
    local itemCount = PlayerDataCenter:GetItemCount(id)
    if itemCount < updateItemInfo.count then
      local addCount = updateItemInfo.count - itemCount
      rewardTable[id] = addCount
    else
      do
        do
          local consumeCount = itemCount - updateItemInfo.count
          consumeTable[id] = consumeCount
          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for id,_ in pairs((diffMsg.backpack).deletes) do
    local itemCount = PlayerDataCenter:GetItemCount(id)
    consumeTable[id] = itemCount
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_ATH] = function(syncUpdateDiff, rewardCache)
  -- function num : 0_25 , upvalues : _ENV
  local rewardTable = rewardCache.rewardTable
  local diffMsg = syncUpdateDiff.ath
  for _,ath in pairs(diffMsg.updateAth) do
    local itemId = ath.uid >> 32
    if rewardTable[itemId] ~= nil then
      rewardTable[itemId] = rewardTable[itemId] + 1
    else
      rewardTable[itemId] = 1
    end
  end
end
}
NetworkDiffDeliver.HandleDiff = function(self, syncUpdateDiff)
  -- function num : 0_26 , upvalues : _ENV, diffOrderList
  if self._itemChangeCache == nil then
    self._itemChangeCache = {
rewardTable = {}
, 
consumeTable = {}
}
  else
    for itemId,count in pairs((self._itemChangeCache).rewardTable) do
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R7 in 'UnsetPending'

      ((self._itemChangeCache).rewardTable)[itemId] = nil
    end
    for itemId,count in pairs((self._itemChangeCache).consumeTable) do
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R7 in 'UnsetPending'

      ((self._itemChangeCache).consumeTable)[itemId] = nil
    end
  end
  do
    if syncUpdateDiff == nil then
      return 
    end
    local flagMap = syncUpdateDiff.flag
    for k,syncUpdateDiffEnum in ipairs(diffOrderList) do
      if flagMap[syncUpdateDiffEnum] then
        self:__HandleDiffEnum(syncUpdateDiff, syncUpdateDiffEnum)
      end
    end
    MsgCenter:Broadcast(eMsgEventId.NetDiffSyncFinish)
  end
end

NetworkDiffDeliver.__HandleDiffEnum = function(self, syncUpdateDiff, syncUpdateDiffEnum)
  -- function num : 0_27 , upvalues : rewardCollectFuncTable, diffFuncTable, _ENV
  local rewardCollectFunc = rewardCollectFuncTable[syncUpdateDiffEnum]
  if rewardCollectFunc ~= nil then
    rewardCollectFunc(syncUpdateDiff, self._itemChangeCache)
  end
  local func = diffFuncTable[syncUpdateDiffEnum]
  if func ~= nil then
    local isSuccessUpdate = func(syncUpdateDiff)
    if not isSuccessUpdate then
      error("can\'t apply diff diffId=" .. tostring(syncUpdateDiffEnum))
    end
  else
    do
      error("don\'t have diffFunc diffId=" .. tostring(syncUpdateDiffEnum))
    end
  end
end

NetworkDiffDeliver.GetRewardCache = function(self)
  -- function num : 0_28
  return (self._itemChangeCache).rewardTable
end

NetworkDiffDeliver.GetConsumeCache = function(self)
  -- function num : 0_29
  return (self._itemChangeCache).consumeTable
end

return NetworkDiffDeliver

