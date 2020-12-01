-- params : ...
-- function num : 0 , upvalues : _ENV
local PersistentDataBase = require("Game.PersistentManager.PersistentData.PersistentDataBase")
local UserData = class("UserData", PersistentDataBase)
UserData.InitBySaveData = function(self, table)
  -- function num : 0_0
  self.lastSectorEntered = table.lastSectorEntered
  self.userSetting = table.userSetting
  self.guideData = table.guideData
end

UserData.InitByDefaultData = function(self)
  -- function num : 0_1
  self.lastSectorEntered = 0
  self.userSetting = {}
  self:GetNoticeSwitchOff()
end

UserData.RecordLastSectorSelected = function(self, sectorMentionId)
  -- function num : 0_2
  self.lastSectorEntered = sectorMentionId
end

UserData.GetLastLocalSectorMentionId = function(self)
  -- function num : 0_3
  return self.lastSectorEntered
end

UserData.SetNoticeSwitchOff = function(self, homeside_info_id, bool)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.userSetting).homeNoticeOff)[homeside_info_id] = bool
end

UserData.GetNoticeSwitchOff = function(self)
  -- function num : 0_5 , upvalues : _ENV
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
  -- function num : 0_6
  self.guideData = {
skipGuideTask = {}
}
end

UserData.SaveSkipGuideTask = function(self, taskId)
  -- function num : 0_7
  if self.guideData == nil then
    self:__InitGuideData()
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.guideData).skipGuideTask)[taskId] = true
end

UserData.ContainSkipGuideTask = function(self, taskId)
  -- function num : 0_8
  if self.guideData == nil then
    return false
  end
  return ((self.guideData).skipGuideTask)[taskId]
end

return UserData

-- params : ...
-- function num : 0 , upvalues : _ENV
local PersistentDataBase = require(
                               "Game.PersistentManager.PersistentData.PersistentDataBase")
local UserData = class("UserData", PersistentDataBase)
UserData.InitBySaveData = function(self, table)
    -- function num : 0_0
    self.lastSectorEntered = table.lastSectorEntered
    self.userSetting = table.userSetting
    self.guideData = table.guideData
end

UserData.InitByDefaultData = function(self)
    -- function num : 0_1
    self.lastSectorEntered = 0
    self.userSetting = {}
    self:GetNoticeSwitchOff()
end

UserData.RecordLastSectorSelected = function(self, sectorMentionId)
    -- function num : 0_2
    self.lastSectorEntered = sectorMentionId
end

UserData.GetLastLocalSectorMentionId = function(self)
    -- function num : 0_3
    return self.lastSectorEntered
end

UserData.SetNoticeSwitchOff = function(self, homeside_info_id, bool)
    -- function num : 0_4
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

    ((self.userSetting).homeNoticeOff)[homeside_info_id] = bool
end

UserData.GetNoticeSwitchOff = function(self)
    -- function num : 0_5 , upvalues : _ENV
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

    if (self.userSetting).homeNoticeOff == nil then
        (self.userSetting).homeNoticeOff = {}
        for id, _ in pairs(ConfigData.homeside_info) do
            -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

            ((self.userSetting).homeNoticeOff)[id] = false
        end
    end
    do return (self.userSetting).homeNoticeOff end
end

UserData.__InitGuideData = function(self)
    -- function num : 0_6
    self.guideData = {skipGuideTask = {}}
end

UserData.SaveSkipGuideTask = function(self, taskId)
    -- function num : 0_7
    if self.guideData == nil then self:__InitGuideData() end -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'
    
    ((self.guideData).skipGuideTask)[taskId] = true
end

UserData.ContainSkipGuideTask = function(self, taskId)
    -- function num : 0_8
    if self.guideData == nil then return false end
    return ((self.guideData).skipGuideTask)[taskId]
end

return UserData

