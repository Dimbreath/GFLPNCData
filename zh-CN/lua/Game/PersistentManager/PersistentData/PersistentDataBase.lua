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

PersistentDataBase.SetPstDataDirty = function(self)
  -- function num : 0_4
  self.isDirty = true
end

PersistentDataBase.IsPstDataDirty = function(self)
  -- function num : 0_5
  return self.isDirty
end

PersistentDataBase.ResetPstDataDirty = function(self)
  -- function num : 0_6
  self.isDirty = false
end

return PersistentDataBase

