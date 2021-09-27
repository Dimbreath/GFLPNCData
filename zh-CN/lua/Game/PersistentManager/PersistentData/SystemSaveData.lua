local PersistentDataBase = require("Game.PersistentManager.PersistentData.PersistentDataBase")
local SystemSaveData = class("SystemSaveData", PersistentDataBase)
SystemSaveData.GetSaveDataFilePath = function(self)
  -- function num : 0_0 , upvalues : _ENV
  return PathConsts:GetPersistentSystemDataPath("system_data")
end

SystemSaveData.InitBySaveData = function(self, data)
  -- function num : 0_1
  if not data.audio then
    self.audio = {}
    if not data.display then
      self.display = {}
      if not data.oasisSky then
        self.oasisSky = {}
        self:__InitDefaultDisPlayData()
        self:_InitDefaultDescSet(data)
      end
    end
  end
end

SystemSaveData.InitByDefaultData = function(self)
  -- function num : 0_2 , upvalues : _ENV
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
  self.display = {}
  self:__InitDefaultDisPlayData()
  self.oasisSky = {}
  self:_InitDefaultDescSet()
end

SystemSaveData.__InitDefaultDisPlayData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local performanceCfg = self:__GetDefultPerformanceCfg()
  if performanceCfg == nil then
    error("performance setting cfg is null,id:" .. tostring((GameSystemInfo.GetDefaultPerformance)()))
    return 
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  if self.display == nil or (self.display).performance_level == nil then
    (self.display).performance_level = (GameSystemInfo.GetDefaultPerformance)()
  end
end

SystemSaveData.GetAudioData = function(self)
  -- function num : 0_4
  return self.audio
end

SystemSaveData.SetAudioDataVolume = function(self, index, value)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  if ((self.audio).volumes)[index] ~= value then
    ((self.audio).volumes)[index] = value
    self:SetPstDataDirty()
  end
end

SystemSaveData.SetAudioDataMute = function(self, index, value)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  if ((self.audio).mutes)[index] ~= value then
    ((self.audio).mutes)[index] = value
    self:SetPstDataDirty()
  end
end

SystemSaveData.GetDisplayData = function(self)
  -- function num : 0_7
  return self.display
end

SystemSaveData.GetDisplaySettingValue = function(self, keyName)
  -- function num : 0_8 , upvalues : _ENV
  local id = ((ConfigData.performance_typeinfo).name_index)[keyName]
  if id == nil then
    return 0
  end
  if not ((self.display).display_map)[id] then
    do return (self.display).performance_level ~= 0 or (self.display).display_map == nil or 0 end
    local performanceCfg = self:__GetCurrentPerformanceCfg()
    if performanceCfg == nil then
      return 0
    end
    do return performanceCfg[keyName] end
  end
end

SystemSaveData.SetDisplaySettingValue = function(self, keyName, value)
  -- function num : 0_9 , upvalues : _ENV
  local id = ((ConfigData.performance_typeinfo).name_index)[keyName]
  if id == nil then
    return 
  end
  if (self.display).display_map == nil then
    self:__InitDisplayMap()
  end
  if not value then
    value = 0
  end
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

  if ((self.display).display_map)[id] ~= value then
    ((self.display).display_map)[id] = value
    self:SetPstDataDirty()
  end
end

SystemSaveData.GetDisplayPerformanceLevelValue = function(self)
  -- function num : 0_10
  if self.display ~= nil then
    return (self.display).performance_level
  end
end

SystemSaveData.SetDisplayPerformanceLevelValue = function(self, value)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if not value then
    (self.display).performance_level = (self.display).performance_level == value or 0
    self:SetPstDataDirty()
  end
end

SystemSaveData.__GetDefultPerformanceCfg = function(self)
  -- function num : 0_12 , upvalues : _ENV
  return (ConfigData.performance_setting)[(GameSystemInfo.GetDefaultPerformance)()]
end

SystemSaveData.__GetCurrentPerformanceCfg = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if self.display then
    return (ConfigData.performance_setting)[(self.display).performance_level]
  end
  return self:__GetDefultPerformanceCfg()
end

SystemSaveData.__InitDisplayMap = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if (self.display).display_map ~= nil then
    return 
  end
  local performanceCfg = self:__GetDefultPerformanceCfg()
  if performanceCfg == nil then
    error("performance setting cfg is null,id:" .. tostring((GameSystemInfo.GetDefaultPerformance)()))
    return 
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  if (self.display).display_map == nil then
    (self.display).display_map = {}
  end
  for id,typeinfoCfg in pairs(ConfigData.performance_typeinfo) do
    local keyName = typeinfoCfg.name
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R8 in 'UnsetPending'

    if ((self.display).display_map)[id] == nil then
      ((self.display).display_map)[id] = performanceCfg[keyName]
    end
  end
end

SystemSaveData.GetOasisSkyPreset = function(self)
  -- function num : 0_15
  return (self.oasisSky).presetId or 0
end

SystemSaveData.SetOasisSkyPreset = function(self, value)
  -- function num : 0_16
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  if (self.oasisSky).presetId ~= value then
    (self.oasisSky).presetId = value
    self:SetPstDataDirty()
  end
end

SystemSaveData.GetOasisSkyLocation = function(self)
  -- function num : 0_17
  return (self.oasisSky).latitude or 0, (self.oasisSky).longitude or 0
end

SystemSaveData.SetOasisSkyLocation = function(self, latitude, longitude)
  -- function num : 0_18
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  if (self.oasisSky).latitude ~= latitude or (self.oasisSky).longitude ~= longitude then
    (self.oasisSky).latitude = latitude
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.oasisSky).longitude = longitude
    self:SetPstDataDirty()
  end
end

SystemSaveData._InitDefaultDescSet = function(self, data)
  -- function num : 0_19 , upvalues : _ENV
  if data == nil or data.gameSet == nil then
    self.gameSet = {}
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.gameSet).describes = {}
  else
    self.gameSet = data.gameSet
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

    if (data.gameSet).describes == nil then
      (self.gameSet).describes = {}
    else
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self.gameSet).describes = (data.gameSet).describes
    end
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  if (self.gameSet).describes == nil or #(self.gameSet).describes <= 0 then
    (self.gameSet).describes = {}
    for index,cfg in ipairs(ConfigData.game_set_describe) do
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

      ((self.gameSet).describes)[index] = cfg.defalt_detail
    end
  end
end

SystemSaveData.GetIsShowDetailDescribeValue = function(self, eDescTypeId)
  -- function num : 0_20
  local bool = self:GetIsShowDetailDescribe(eDescTypeId)
  return bool and 1 or 0
end

SystemSaveData.GetIsShowDetailDescribe = function(self, eDescTypeId)
  -- function num : 0_21
  return ((self.gameSet).describes)[eDescTypeId]
end

SystemSaveData.SetDescribeSetting = function(self, eDescTypeId, bool)
  -- function num : 0_22 , upvalues : _ENV
  local val = ((self.gameSet).describes)[eDescTypeId]
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  if val ~= bool then
    ((self.gameSet).describes)[eDescTypeId] = bool
    self:SetPstDataDirty()
    MsgCenter:Broadcast(eMsgEventId.DescribeSettingChange, eDescTypeId)
  end
end

return SystemSaveData

