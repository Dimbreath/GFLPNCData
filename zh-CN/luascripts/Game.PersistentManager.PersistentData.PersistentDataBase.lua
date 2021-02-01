-- params : ...
-- function num : 0 , upvalues : _ENV
local PersistentDataBase = class("PersistenDataBase")
PersistentDataBase.InitBySaveData = function(self, data)
  -- function num : 0_0
end

PersistentDataBase.InitByDefaultData = function(self)
  -- function num : 0_1
end

PersistentDataBase.GetSaveEncodeTable = function(self)
  -- function num : 0_2
  return self
end

PersistentDataBase.GetSaveDataFilePath = function(self)
  -- function num : 0_3
  return ""
end

return PersistentDataBase

