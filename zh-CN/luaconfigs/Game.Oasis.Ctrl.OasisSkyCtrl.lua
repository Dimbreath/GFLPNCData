-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Formation.Ctrl.FormationCtrlBase")
local OasisSkyCtrl = class("OasisCtrlBase", base)
local cs_SkyController = CS.SkyController
OasisSkyCtrl.ctor = function(self, oasisCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.oasisCtrl = oasisCtrl
  ;
  (table.insert)((self.oasisCtrl).ctrls, self)
end

OasisSkyCtrl.InitOasisSkyCtrl = function(self)
  -- function num : 0_1 , upvalues : _ENV, cs_SkyController
  local unlockSkySetting = ((PlayerDataCenter.AllBuildingData).built)[eBuildingId.SkyBuilding] ~= nil
  local systemData = PersistentManager:GetDataModel((PersistentConfig.ePackage).SystemData)
  self._systemData = systemData
  local presetId = (self:GetSkyPresetId())
  local latitude, longitude, month, hour = nil, nil, nil, nil
  if presetId == 0 or not unlockSkySetting then
    latitude = self:GetDefaultSkySetting()
  else
    -- DECOMPILER ERROR at PC35: Overwrote pending register: R5 in 'AssignReg'

    if presetId == -1 then
      latitude = systemData:GetOasisSkyLocation()
      -- DECOMPILER ERROR at PC39: Overwrote pending register: R6 in 'AssignReg'

      -- DECOMPILER ERROR at PC46: Overwrote pending register: R7 in 'AssignReg'

    else
      local presetCfg = (ConfigData.oasis_weather_preset)[presetId]
      if presetCfg == nil then
        error("Cant get ConfigData.oasis_weather_preset, presetId = " .. tostring(presetId))
        -- DECOMPILER ERROR at PC62: Overwrote pending register: R7 in 'AssignReg'

        -- DECOMPILER ERROR at PC63: Overwrote pending register: R6 in 'AssignReg'

        -- DECOMPILER ERROR at PC64: Overwrote pending register: R5 in 'AssignReg'

        latitude = self:GetDefaultSkySetting()
      else
        latitude = presetCfg.latitude
        -- DECOMPILER ERROR at PC68: Overwrote pending register: R5 in 'AssignReg'

        -- DECOMPILER ERROR at PC78: Overwrote pending register: R7 in 'AssignReg'

        -- DECOMPILER ERROR at PC81: Overwrote pending register: R7 in 'AssignReg'

        -- DECOMPILER ERROR at PC84: Overwrote pending register: R7 in 'AssignReg'

        -- DECOMPILER ERROR at PC90: Overwrote pending register: R6 in 'AssignReg'

      end
    end
  end
  do
    -- DECOMPILER ERROR at PC92: Overwrote pending register: R6 in 'AssignReg'

    -- DECOMPILER ERROR at PC94: Confused about usage of register: R8 in 'UnsetPending'

    if presetCfg.day_time ~= 0 or presetCfg.month == 0 then
      (cs_SkyController.Instance).Longitude = longitude
      -- DECOMPILER ERROR at PC96: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (cs_SkyController.Instance).Latitude = latitude
      -- DECOMPILER ERROR at PC98: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (cs_SkyController.Instance).Month = month
      -- DECOMPILER ERROR at PC100: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (cs_SkyController.Instance).Timeline = hour
      -- DECOMPILER ERROR: 9 unprocessed JMP targets
    end
  end
end

OasisSkyCtrl.ShowOasisSkySetting = function(self)
  -- function num : 0_2 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.USkySystem, function(window)
    -- function num : 0_2_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitOasisSkyUI(self)
  end
)
end

OasisSkyCtrl.GetDefaultSkySetting = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local latitude, longitude = 40, 116
  local month = tonumber((os.date)("%m"))
  local hour = tonumber((os.date)("%H"))
  return latitude, longitude, month, hour
end

OasisSkyCtrl.GetSkyPresetId = function(self)
  -- function num : 0_4
  local presetId = (self._systemData):GetOasisSkyPreset()
  return presetId
end

OasisSkyCtrl.SetSkyPresetIdSave = function(self, presetId)
  -- function num : 0_5
  (self._systemData):SetOasisSkyPreset(presetId)
end

OasisSkyCtrl.SetSkyHour = function(self, hour)
  -- function num : 0_6 , upvalues : cs_SkyController
  (cs_SkyController.Instance):SetHourTween(hour)
end

OasisSkyCtrl.GetCurSkyMonth = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local month = tonumber((os.date)("%m"))
  return month
end

OasisSkyCtrl.SetSkyMonth = function(self, month)
  -- function num : 0_8 , upvalues : cs_SkyController
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (cs_SkyController.Instance).Month = month
end

OasisSkyCtrl.SetSkyLocation = function(self, latitude, longitude, hour)
  -- function num : 0_9 , upvalues : cs_SkyController
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (cs_SkyController.Instance).Longitude = longitude
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (cs_SkyController.Instance).Latitude = latitude
  ;
  (cs_SkyController.Instance):SetHourTween(hour)
  ;
  (self._systemData):SetOasisSkyLocation(latitude, longitude)
end

OasisSkyCtrl.GenRandomOasisSkySetting = function(self, curTime)
  -- function num : 0_10 , upvalues : _ENV
  local longitude = (math.random)(-180, 180)
  local latitude = (math.random)(-90, 90)
  local month = (math.random)(1, 12)
  local time = (math.random)(curTime + 6, curTime + 12)
  time = time % 24
  return latitude, longitude, month, time
end

OasisSkyCtrl.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  UIManager:DeleteWindow(UIWindowTypeID.USkySystem)
  ;
  (base.OnDelete)(self)
end

return OasisSkyCtrl

