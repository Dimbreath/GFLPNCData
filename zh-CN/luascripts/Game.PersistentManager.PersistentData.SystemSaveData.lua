-- params : ...
-- function num : 0 , upvalues : _ENV
local PersistentDataBase = require("Game.PersistentManager.PersistentData.PersistentDataBase")
local SystemSaveData = class("SystemSaveData", PersistentDataBase)
SystemSaveData.InitBySaveData = function(self, data)
  -- function num : 0_0
  if not data.audio then
    self.audio = {}
    if not data.display then
      self.display = {}
    end
  end
end

SystemSaveData.InitByDefaultData = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.audio = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.audio).volumes = {}
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.audio).mutes = {}
  for index = 1, AudioManager.AudioTypeCount do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

    ((self.audio).volumes)[index] = 1
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.audio).mutes)[index] = false
  end
  self.display = {resolution = 1, texture_limit = 0, frame_rate = 0, dyn_shadow = 1, anti_aliasing = 0}
end

SystemSaveData.GetAudioData = function(self)
  -- function num : 0_2
  return self.audio
end

SystemSaveData.GetDisplayData = function(self)
  -- function num : 0_3
  return self.display
end

return SystemSaveData

