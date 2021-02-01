-- params : ...
-- function num : 0 , upvalues : _ENV
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
  end
end

UserData.InitByDefaultData = function(self)
  -- function num : 0_2
  self.lastSectorEntered = 0
  self.userSetting = {}
  self:GetNoticeSwitchOff()
  self:__InitFormationData()
  self:__InitDungeonExtrData()
end

UserData.__InitFormationData = function(self)
  -- function num : 0_3
  self.fomationData = {
lastFmtId = {}
}
end

UserData.__InitDungeonExtrData = function(self)
  -- function num : 0_4
  self.dungeonExtrData = {
lastSelectStageDic = {}
}
end

UserData.RecordLastSectorSelected = function(self, sectorMentionId)
  -- function num : 0_5
  self.lastSectorEntered = sectorMentionId
end

UserData.GetLastLocalSectorMentionId = function(self)
  -- function num : 0_6
  return self.lastSectorEntered
end

UserData.SetNoticeSwitchOff = function(self, homeside_info_id, bool)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.userSetting).homeNoticeOff)[homeside_info_id] = bool
end

UserData.GetNoticeSwitchOff = function(self)
  -- function num : 0_8 , upvalues : _ENV
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
  -- function num : 0_9
  self.guideData = {
skipGuideTask = {}
}
end

UserData.SaveSkipGuideTask = function(self, taskId)
  -- function num : 0_10
  if self.guideData == nil then
    self:__InitGuideData()
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.guideData).skipGuideTask)[taskId] = true
end

UserData.ContainSkipGuideTask = function(self, taskId)
  -- function num : 0_11
  if self.guideData == nil then
    return false
  end
  return ((self.guideData).skipGuideTask)[taskId]
end

UserData.GetLastFormationId = function(self, moduleId)
  -- function num : 0_12
  local defaultFmtId = 1
  if self.fomationData == nil then
    return defaultFmtId
  end
  local fmtId = ((self.fomationData).lastFmtId)[moduleId]
  return fmtId or defaultFmtId
end

UserData.SetLastFormationId = function(self, moduleId, fmtId)
  -- function num : 0_13 , upvalues : _ENV
  if self.fomationData == nil then
    self:__InitFormationData()
  end
  local lastId = ((self.fomationData).lastFmtId)[moduleId]
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.fomationData).lastFmtId)[moduleId] = fmtId
  if fmtId ~= lastId then
    PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
  end
end

UserData.GetLastDungeonStageId = function(self, dungeonId)
  -- function num : 0_14
  if self.dungeonExtrData == nil then
    return nil
  end
  local stageId = ((self.dungeonExtrData).lastSelectStageDic)[dungeonId]
  return stageId
end

UserData.SetLastDungeonStageId = function(self, dungeonId, stageId)
  -- function num : 0_15 , upvalues : _ENV
  if self.dungeonExtrData == nil then
    self:__InitDungeonExtrData()
  end
  local lastId = ((self.dungeonExtrData).lastSelectStageDic)[dungeonId]
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  if stageId ~= lastId then
    ((self.dungeonExtrData).lastSelectStageDic)[dungeonId] = stageId
    PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
  end
end

return UserData

