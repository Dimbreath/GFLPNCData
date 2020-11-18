-- params : ...
-- function num : 0 , upvalues : _ENV
local PersistentDataBase = require("Game.PersistentManager.PersistentData.PersistentDataBase")
local UserData = class("UserData", PersistentDataBase)
UserData.InitBySaveData = function(self, table)
  -- function num : 0_0
  self.lastSectorEntered = table.lastSectorEntered
end

UserData.InitByDefaultData = function(self)
  -- function num : 0_1
  self.lastSectorEntered = 0
end

UserData.RecordLastSectorSelected = function(self, sectorMentionId)
  -- function num : 0_2
  self.lastSectorEntered = sectorMentionId
end

UserData.GetLastLocalSectorMentionId = function(self)
  -- function num : 0_3
  return self.lastSectorEntered
end

return UserData

