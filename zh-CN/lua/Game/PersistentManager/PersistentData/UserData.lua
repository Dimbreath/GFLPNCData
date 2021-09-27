local PersistentDataBase = require("Game.PersistentManager.PersistentData.PersistentDataBase")
local UserData = class("UserData", PersistentDataBase)
UserData.GetSaveDataFilePath = function(self)
  -- function num : 0_0 , upvalues : _ENV
  return PathConsts:GetPersistentUserDataPath(PlayerDataCenter.strPlayerId)
end

UserData.InitBySaveData = function(self, table)
  -- function num : 0_1
  self.lastSectorEntered = table.lastSectorEntered
  if not table.userSetting then
    self.userSetting = {}
    self.guideData = table.guideData
    self.fomationData = table.fomationData
    self.dungeonExtrData = table.dungeonExtrData
    self.specialReddotData = table.specialReddotData
    self.gameNoticeData = table.gameNoticeData
    if not table.unlockNewSector then
      self.unlockNewSector = {}
      self.avgnoundic = table.avgnoundic
      self.avgplayspeed = table.avgplayspeed
    end
  end
end

UserData.InitByDefaultData = function(self)
  -- function num : 0_2
  self.lastSectorEntered = 0
  self.unlockNewSector = {maxLastPlayVideSectorId = 0, maxLastUnlockAnimaSectorId = 0}
  self.userSetting = {}
  self:GetNoticeSwitchOff()
  self:__InitFormationData()
  self:__InitDungeonExtrData()
  self:__InitSpecialReddotData()
end

UserData.__InitFormationData = function(self)
  -- function num : 0_3
  self.fomationData = {
lastFmtId = {}
, 
weeklyChallengeFmt = {}
, 
weeklyChallengeSkillList = {}
, lastDailyFmtId = 0, weeklyChallengeTreeId = 0}
end

UserData.__InitDungeonExtrData = function(self)
  -- function num : 0_4
  self.dungeonExtrData = {
lastSelectStageDic = {}
, unitBlood = 0, bossUnitBlood = 0}
end

UserData.__InitSpecialReddotData = function(self)
  -- function num : 0_5
  self.specialReddotData = {
specialReddotDic = {}
}
end

UserData.RecordLastSectorSelected = function(self, sectorMentionId)
  -- function num : 0_6
  if self.lastSectorEntered ~= sectorMentionId then
    self.lastSectorEntered = sectorMentionId
    self:SetPstDataDirty()
  end
end

UserData.GetLastLocalSectorMentionId = function(self)
  -- function num : 0_7
  return self.lastSectorEntered
end

UserData.RecordLastMaxUnlockSectorId = function(self, maxUnlockSectorId, isAnima)
  -- function num : 0_8 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  -- DECOMPILER ERROR at PC7: Unhandled construct in 'MakeBoolean' P1

  if isAnima and (self.unlockNewSector).maxLastUnlockAnimaSectorId ~= maxUnlockSectorId then
    (self.unlockNewSector).maxLastUnlockAnimaSectorId = maxUnlockSectorId
    self:SetPstDataDirty()
    PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  if (self.unlockNewSector).maxLastPlayVideSectorId ~= maxUnlockSectorId then
    (self.unlockNewSector).maxLastPlayVideSectorId = maxUnlockSectorId
    self:SetPstDataDirty()
    PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
  end
end

UserData.GetLastLocalMaxUnlockSectorId = function(self, isAnima)
  -- function num : 0_9
  if not (self.unlockNewSector).maxLastUnlockAnimaSectorId then
    do return not isAnima or 0 end
    do return (self.unlockNewSector).maxLastPlayVideSectorId or 0 end
  end
end

UserData.SetNoticeSwitchOff = function(self, homeside_info_id, bool)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  if ((self.userSetting).homeNoticeOff)[homeside_info_id] ~= bool then
    ((self.userSetting).homeNoticeOff)[homeside_info_id] = bool
    self:SetPstDataDirty()
  end
end

UserData.GetNoticeSwitchOff = function(self)
  -- function num : 0_11 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  if (self.userSetting).homeNoticeOff == nil then
    (self.userSetting).homeNoticeOff = {}
    for id,_ in pairs(ConfigData.homeside_info) do
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

      ((self.userSetting).homeNoticeOff)[id] = false
    end
  end
  do
    return (self.userSetting).homeNoticeOff
  end
end

UserData.__InitGuideData = function(self)
  -- function num : 0_12
  self.guideData = {
skipGuideTask = {}
}
end

UserData.SaveSkipGuideTask = function(self, taskId)
  -- function num : 0_13
  if self.guideData == nil then
    self:__InitGuideData()
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  if ((self.guideData).skipGuideTask)[taskId] ~= true then
    ((self.guideData).skipGuideTask)[taskId] = true
    self:SetPstDataDirty()
  end
end

UserData.ContainSkipGuideTask = function(self, taskId)
  -- function num : 0_14
  if self.guideData == nil then
    return false
  end
  return ((self.guideData).skipGuideTask)[taskId]
end

UserData.GetLastFormationId = function(self, moduleId)
  -- function num : 0_15
  local defaultFmtId = 1
  if self.fomationData == nil then
    return defaultFmtId
  end
  local fmtId = ((self.fomationData).lastFmtId)[moduleId]
  return fmtId or defaultFmtId
end

UserData.SetLastFormationId = function(self, moduleId, fmtId)
  -- function num : 0_16
  if self.fomationData == nil then
    self:__InitFormationData()
  end
  local lastId = ((self.fomationData).lastFmtId)[moduleId]
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.fomationData).lastFmtId)[moduleId] = fmtId
  if fmtId ~= lastId then
    self:SetPstDataDirty()
  end
end

UserData.GetLastDailyFormationId = function(self)
  -- function num : 0_17
  local defaultFmtId = 101
  if self.fomationData == nil or (self.fomationData).lastDailyFmtId == 0 or (self.fomationData).lastDailyFmtId == nil then
    return defaultFmtId
  end
  return (self.fomationData).lastDailyFmtId
end

UserData.SetLastDailyFormationId = function(self, fmtId)
  -- function num : 0_18
  if self.fomationData == nil then
    self:__InitFormationData()
  end
  local lastId = (self.fomationData).lastDailyFmtId
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.fomationData).lastDailyFmtId = fmtId
  if fmtId ~= lastId then
    self:SetPstDataDirty()
  end
end

UserData.GetLastDungeonStageId = function(self, dungeonId)
  -- function num : 0_19
  if self.dungeonExtrData == nil then
    return nil
  end
  local stageId = ((self.dungeonExtrData).lastSelectStageDic)[dungeonId]
  return stageId
end

UserData.SetLastDungeonStageId = function(self, dungeonId, stageId)
  -- function num : 0_20
  if self.dungeonExtrData == nil then
    self:__InitDungeonExtrData()
  end
  local lastId = ((self.dungeonExtrData).lastSelectStageDic)[dungeonId]
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  if stageId ~= lastId then
    ((self.dungeonExtrData).lastSelectStageDic)[dungeonId] = stageId
    self:SetPstDataDirty()
  end
end

UserData.GetLastWeeklyChallengeFmt = function(self)
  -- function num : 0_21
  if self.fomationData ~= nil then
    return (self.fomationData).weeklyChallengeFmt
  end
  return nil
end

UserData.SetLastWeeklyChallengeFmt = function(self, fmtDic)
  -- function num : 0_22 , upvalues : _ENV
  if self.fomationData == nil then
    self:__InitFormationData()
  end
  local isChanged = false
  if fmtDic ~= nil and (self.fomationData).weeklyChallengeFmt ~= nil then
    if (table.count)(fmtDic) ~= (table.count)((self.fomationData).weeklyChallengeFmt) then
      isChanged = true
    else
      for k,v in pairs((self.fomationData).weeklyChallengeFmt) do
        if fmtDic[k] == nil or fmtDic[k] ~= v then
          isChanged = true
          break
        end
      end
    end
  else
    do
      if fmtDic ~= (self.fomationData).weeklyChallengeFmt then
        isChanged = true
      end
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

      if isChanged then
        (self.fomationData).weeklyChallengeFmt = fmtDic
        self:SetPstDataDirty()
      end
    end
  end
end

UserData.GetLastWeeklySkillList = function(self)
  -- function num : 0_23
  if self.fomationData ~= nil then
    return (self.fomationData).weeklyChallengeTreeId, (self.fomationData).weeklyChallengeSkillList
  end
  return nil, nil
end

UserData.SetLastWeeklySkillList = function(self, treeId, skillList)
  -- function num : 0_24 , upvalues : _ENV
  if self.fomationData == nil then
    self:__InitFormationData()
  end
  local isChanged = false
  if (self.fomationData).weeklyChallengeTreeId ~= treeId then
    isChanged = true
  else
    if skillList == (self.fomationData).weeklyChallengeSkillList then
      isChanged = skillList ~= nil and (self.fomationData).weeklyChallengeSkillList ~= nil
      if #skillList ~= #(self.fomationData).weeklyChallengeSkillList then
        isChanged = true
      else
        for i,v in ipairs(skillList) do
          if not (table.contain)((self.fomationData).weeklyChallengeSkillList, v) then
            isChanged = true
            break
          end
        end
      end
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

      if isChanged then
        (self.fomationData).weeklyChallengeTreeId = treeId
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (self.fomationData).weeklyChallengeSkillList = skillList
        self:SetPstDataDirty()
      end
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
end

UserData.GetIsSReddotClose = function(self, redDotLoactionString)
  -- function num : 0_25
  if self.specialReddotData == nil then
    return nil
  end
  return ((self.specialReddotData).specialReddotDic)[redDotLoactionString]
end

UserData.SetSReddotClose = function(self, redDotLoactionString, bool)
  -- function num : 0_26 , upvalues : _ENV
  if self.specialReddotData == nil then
    self:__InitSpecialReddotData()
  end
  local last = ((self.specialReddotData).specialReddotDic)[redDotLoactionString]
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  if last ~= bool then
    ((self.specialReddotData).specialReddotDic)[redDotLoactionString] = bool
    self:SetPstDataDirty()
    PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
  end
end

UserData.GetIsAutoBattle = function(self)
  -- function num : 0_27
  return (self.userSetting).isAutoBattle or false
end

UserData.SetIsAutoBattle = function(self, isAutoBattle)
  -- function num : 0_28
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  if (self.userSetting).isAutoBattle ~= isAutoBattle then
    (self.userSetting).isAutoBattle = isAutoBattle
    self:SetPstDataDirty()
  end
end

UserData.GetBattleSpeed = function(self)
  -- function num : 0_29
  return ((self.userSetting).battleSpeed or 0) + 1
end

UserData.SetBattleSpeed = function(self, battleSpeed)
  -- function num : 0_30
  battleSpeed = battleSpeed - 1
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if (self.userSetting).battleSpeed ~= battleSpeed then
    (self.userSetting).battleSpeed = battleSpeed
    self:SetPstDataDirty()
  end
end

UserData.SetUnitBlood = function(self, unitBlood, bossUnitBlood)
  -- function num : 0_31
  if self.dungeonExtrData == nil then
    self:__InitDungeonExtrData()
  end
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  if unitBlood ~= (self.dungeonExtrData).unitBlood or bossUnitBlood ~= (self.dungeonExtrData).bossUnitBlood then
    (self.dungeonExtrData).unitBlood = unitBlood
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.dungeonExtrData).bossUnitBlood = bossUnitBlood
    self:SetPstDataDirty()
  end
end

UserData.GetUnitBlood = function(self)
  -- function num : 0_32
  if self.dungeonExtrData == nil then
    return 
  end
  return (self.dungeonExtrData).unitBlood, (self.dungeonExtrData).bossUnitBlood
end

UserData.__InitGameNoticeData = function(self)
  -- function num : 0_33
  if self.gameNoticeData ~= nil then
    return 
  end
  self.gameNoticeData = {timestamp = 0, 
readNotice = {}
}
end

UserData.SaveIsReadGameNotice = function(self, noticeID)
  -- function num : 0_34
  self:__InitGameNoticeData()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if ((self.gameNoticeData).readNotice)[noticeID] ~= true then
    ((self.gameNoticeData).readNotice)[noticeID] = true
    self:SetPstDataDirty()
  end
end

UserData.SaveGameNoticeTimestamp = function(self, timestamp)
  -- function num : 0_35
  self:__InitGameNoticeData()
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.gameNoticeData).timestamp = timestamp
  self:SetPstDataDirty()
end

UserData.GetGameNoticeTimestamp = function(self, timestamp)
  -- function num : 0_36
  if self.gameNoticeData == nil then
    return 0
  end
  return (self.gameNoticeData).timestamp
end

UserData.ContainGameNoticeIsRead = function(self, noticeID)
  -- function num : 0_37
  if self.gameNoticeData == nil then
    return false
  end
  return ((self.gameNoticeData).readNotice)[noticeID]
end

UserData.DiffLocalGNReadData = function(self, noticeIds)
  -- function num : 0_38 , upvalues : _ENV
  if self.gameNoticeData == nil or noticeIds == nil then
    return 
  end
  for id,bool in pairs((self.gameNoticeData).readNotice) do
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

    if noticeIds[id] == nil then
      ((self.gameNoticeData).readNotice)[id] = nil
    end
  end
  self:SetPstDataDirty()
end

UserData.ReadIsReceiveFriendApplication = function(self)
  -- function num : 0_39
  return not (self:GetNoticeSwitchOff())[100]
end

UserData.SaveAvgNoun = function(self, nounid)
  -- function num : 0_40
  if self.avgnoundic == nil then
    self.avgnoundic = {}
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.avgnoundic)[nounid] = true
  self:SetPstDataDirty()
end

UserData.GetAvgNounIsRead = function(self, nounid)
  -- function num : 0_41
  if self.avgnoundic == nil then
    return false
  end
  if (self.avgnoundic)[nounid] == nil then
    return false
  end
  return (self.avgnoundic)[nounid]
end

UserData.GetAvgplayspeed = function(self)
  -- function num : 0_42
  return self.avgplayspeed
end

UserData.Saveavgspeed = function(self, speed)
  -- function num : 0_43
  self.avgplayspeed = speed
  self:SetPstDataDirty()
end

return UserData

