-- params : ...
-- function num : 0 , upvalues : _ENV
local PersistentDataBase = require("Game.PersistentManager.PersistentData.PersistentDataBase")
local DeploySaveData = class("DeploySaveData", PersistentDataBase)
DeploySaveData.GetSaveDataFilePath = function(self)
  -- function num : 0_0 , upvalues : _ENV
  return PathConsts:GetPersistentDeployDataPath(PlayerDataCenter.strPlayerId, self.__fileName)
end

DeploySaveData.ctor = function(self, fileName)
  -- function num : 0_1
  self.__fileName = fileName
end

DeploySaveData.InitBySaveData = function(self, table)
  -- function num : 0_2
  self.hero_pos = table.hero_pos
end

DeploySaveData.InitByDefaultData = function(self)
  -- function num : 0_3
  self.hero_pos = {}
end

return DeploySaveData

