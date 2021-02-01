-- params : ...
-- function num : 0 , upvalues : _ENV
local NetworkDiffDeliver = {}
local diffOrderList = {proto_csmsg_SyncUpdateDiffEnum.DIFF_BUILDING, proto_csmsg_SyncUpdateDiffEnum.DIFF_RESOURCE, proto_csmsg_SyncUpdateDiffEnum.DIFF_EFFECTORRG}
local diffFuncTable = {[proto_csmsg_SyncUpdateDiffEnum.DIFF_ACHIEVEMENT] = function(syncUpdateDiff)
  -- function num : 0_0 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.achievement
  local AchivLevelNetwork = NetworkManager:GetNetwork(NetworkTypeID.AchivLevel)
  if diffMsg ~= nil and AchivLevelNetwork ~= nil then
    AchivLevelNetwork:AchieveLevelCommonDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_ATH] = function(syncUpdateDiff)
  -- function num : 0_1 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.ath
  local AthNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  if diffMsg ~= nil or AthNetwork ~= nil then
    AthNetwork:SC_ATH_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_BUILDING] = function(syncUpdateDiff)
  -- function num : 0_2 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.building
  local buildingNetwork = NetworkManager:GetNetwork(NetworkTypeID.Building)
  if diffMsg ~= nil or buildingNetwork ~= nil then
    buildingNetwork:OnRecvBuildingSyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_EFFECTORRG] = function(syncUpdateDiff)
  -- function num : 0_3 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.effectorRG
  local EffectorNetwork = NetworkManager:GetNetwork(NetworkTypeID.Effector)
  if diffMsg ~= nil and EffectorNetwork ~= nil then
    EffectorNetwork:SC_EFFECTOR_RGSyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_ENDLESS] = function(syncUpdateDiff)
  -- function num : 0_4 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.endless
  local SectorNetwork = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  if diffMsg ~= nil and SectorNetwork ~= nil then
    SectorNetwork:SC_ENDLESS_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_EXPLORATION] = function(syncUpdateDiff)
  -- function num : 0_5 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.exploration
  local epNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  if diffMsg ~= nil and epNetwork ~= nil then
    epNetwork:SC_EXPLORATION_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_FACTORY] = function(syncUpdateDiff)
  -- function num : 0_6 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.factory
  local FactoryNetwork = NetworkManager:GetNetwork(NetworkTypeID.Factory)
  if diffMsg ~= nil and FactoryNetwork ~= nil then
    FactoryNetwork:FactoryCommonDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_HERO] = function(syncUpdateDiff)
  -- function num : 0_7 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.hero
  local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  if diffMsg ~= nil and ObjectNetwork ~= nil then
    ObjectNetwork:SC_HERO_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_MAIL] = function(syncUpdateDiff)
  -- function num : 0_8 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.mail
  local MailNetwork = NetworkManager:GetNetwork(NetworkTypeID.Mail)
  if diffMsg ~= nil and MailNetwork ~= nil then
    MailNetwork:MailCommonDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_QUEST] = function(syncUpdateDiff)
  -- function num : 0_9 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.quest
  local TaskNetwork = NetworkManager:GetNetwork(NetworkTypeID.Task)
  if diffMsg ~= nil and TaskNetwork ~= nil then
    TaskNetwork:OnRecvSyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_SECTOR] = function(syncUpdateDiff)
  -- function num : 0_10 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.sector
  local SectorNetwork = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  if diffMsg ~= nil and SectorNetwork ~= nil then
    SectorNetwork:SC_SECTOR_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_CST] = function(syncUpdateDiff)
  -- function num : 0_11 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.cst
  local CommanderSkillNetwork = NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)
  if diffMsg ~= nil and CommanderSkillNetwork ~= nil then
    CommanderSkillNetwork:SC_COMMANDSKILL_SyncUpdate(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_COUNTER] = function(syncUpdateDiff)
  -- function num : 0_12 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.counter
  local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  if diffMsg ~= nil and ObjectNetwork ~= nil then
    ObjectNetwork:SC_COUNTER_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_FUNCTION] = function(syncUpdateDiff)
  -- function num : 0_13 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.functions
  local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  if diffMsg ~= nil and ObjectNetwork ~= nil then
    ObjectNetwork:SC_FUNCTION_SyncUpdateDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_RESOURCE] = function(syncUpdateDiff)
  -- function num : 0_14 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.resource
  local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  if diffMsg ~= nil and ObjectNetwork ~= nil then
    ObjectNetwork:ItemDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_USERBASE] = function(syncUpdateDiff)
  -- function num : 0_15 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.userBase
  local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  if diffMsg ~= nil and ObjectNetwork ~= nil then
    ObjectNetwork:userBaseDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_ALG] = function(syncUpdateDiff)
  -- function num : 0_16 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.alg
  local BattleDungeonNetwork = NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)
  if diffMsg ~= nil and BattleDungeonNetwork ~= nil then
    BattleDungeonNetwork:SC_BATTLE_NtfAlgDiff(diffMsg)
    return true
  end
end
, [proto_csmsg_SyncUpdateDiffEnum.DIFF_INTIMACY] = function(syncUpdateDiff)
  -- function num : 0_17 , upvalues : _ENV
  local diffMsg = syncUpdateDiff.intimacy
  local friendshipNetwork = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
  if diffMsg ~= nil and friendshipNetwork ~= nil then
    friendshipNetwork:SC_INTIMACY_SyncDiff(diffMsg)
    return true
  end
end
}
NetworkDiffDeliver.HandleDiff = function(self, syncUpdateDiff)
  -- function num : 0_18 , upvalues : _ENV, diffOrderList
  if syncUpdateDiff == nil then
    return 
  end
  local flagMap = syncUpdateDiff.flag
  if flagMap == nil then
    return 
  end
  local handledDiff = {}
  for k,syncUpdateDiffEnum in ipairs(diffOrderList) do
    if flagMap[syncUpdateDiffEnum] then
      self:__HandleDiffEnum(syncUpdateDiff, syncUpdateDiffEnum)
      handledDiff[syncUpdateDiffEnum] = true
    end
  end
  for syncUpdateDiffEnum,bool in pairs(flagMap) do
    if bool and not handledDiff[syncUpdateDiffEnum] then
      self:__HandleDiffEnum(syncUpdateDiff, syncUpdateDiffEnum)
    end
  end
end

NetworkDiffDeliver.__HandleDiffEnum = function(self, syncUpdateDiff, syncUpdateDiffEnum)
  -- function num : 0_19 , upvalues : diffFuncTable, _ENV
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

return NetworkDiffDeliver

