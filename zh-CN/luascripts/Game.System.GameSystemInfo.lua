-- params : ...
-- function num : 0 , upvalues : _ENV
local GameSystemInfo = {}
local cs_platform = ((CS.UnityEngine).Application).platform
GameSystemInfo.PlatformType = {Windows = 1, Mac = 2, Android = 3, iOS = 4}
if cs_platform == 11 then
  GameSystemInfo.Platform = (GameSystemInfo.PlatformType).Android
else
  if cs_platform == 8 then
    GameSystemInfo.Platform = (GameSystemInfo.PlatformType).iOS
  else
    if cs_platform == 0 or cs_platform == 1 then
      GameSystemInfo.Platform = (GameSystemInfo.PlatformType).Mac
    else
      GameSystemInfo.Platform = (GameSystemInfo.PlatformType).Windows
    end
  end
end
local CS_PlayerPrefs = (CS.UnityEngine).PlayerPrefs
local PlayerPrefsConsts = require("Game.Login.PlayerPrefsEnum")
GameSystemInfo.InitDefaultPerformance = function()
  -- function num : 0_0 , upvalues : CS_PlayerPrefs, PlayerPrefsConsts, GameSystemInfo, _ENV
  local performanceId = (CS_PlayerPrefs.GetInt)(PlayerPrefsConsts.DefaultPerformanceId)
  if performanceId > 0 then
    (GameSystemInfo.__SetDefaultPerformance)(performanceId, false)
    return 
  else
    local CS_SystemInfo = (CS.UnityEngine).SystemInfo
    local deviceModel = CS_SystemInfo.deviceModel
    if not (string.IsNullOrEmpty)(deviceModel) then
      deviceModel = (string.lower)(deviceModel)
      local levelId = (ConfigData.performance_device)[deviceModel]
      if levelId ~= nil and levelId > 0 then
        (GameSystemInfo.__SetDefaultPerformance)(levelId, true)
        return 
      end
      if (string.contains)(deviceModel, ",") then
        local listDevice = (string.split)(deviceModel, ",")
        if #listDevice >= 2 and not (string.IsNullOrEmpty)(listDevice[1]) then
          local devicePrefix = listDevice[1]
          levelId = (ConfigData.performance_device)[devicePrefix]
          if levelId ~= nil and levelId > 0 then
            (GameSystemInfo.__SetDefaultPerformance)(levelId, true)
            return 
          end
        end
      end
    end
    do
      local graphicsDeviceName = CS_SystemInfo.graphicsDeviceName
      if not (string.IsNullOrEmpty)(graphicsDeviceName) then
        graphicsDeviceName = (string.lower)(graphicsDeviceName)
        local levelId = (ConfigData.performance_gpu)[graphicsDeviceName]
        if levelId ~= nil and levelId > 0 then
          (GameSystemInfo.__SetDefaultPerformance)(levelId, true)
          return 
        end
      end
      do
        local systemMemorySize = CS_SystemInfo.systemMemorySize
        if systemMemorySize < 1600 then
          (GameSystemInfo.__SetDefaultPerformance)(1, true)
          return 
        end
        local supportsInstancing = CS_SystemInfo.supportsInstancing
        if not supportsInstancing then
          (GameSystemInfo.__SetDefaultPerformance)(1, true)
          return 
        end
        local graphicsMultiThreaded = CS_SystemInfo.graphicsMultiThreaded
        if not graphicsMultiThreaded then
          (GameSystemInfo.__SetDefaultPerformance)(1, true)
          return 
        end
        local operatingSystemFamily = (CS_SystemInfo.operatingSystemFamily):ToString()
        if operatingSystemFamily == "Windows" or operatingSystemFamily == "MacOSX" then
          (GameSystemInfo.__SetDefaultPerformance)(5, true)
          return 
        end
        local cpuFrequency = CS_SystemInfo.processorFrequency
        local cpuCount = CS_SystemInfo.processorCount
        if cpuFrequency >= 2400 and cpuCount >= 6 and systemMemorySize > 6000 then
          (GameSystemInfo.__SetDefaultPerformance)(4, true)
          return 
        end
        if (cpuFrequency < 2000 or cpuCount < 4) and systemMemorySize < 3000 then
          (GameSystemInfo.__SetDefaultPerformance)(1, true)
          return 
        end
        ;
        (GameSystemInfo.__SetDefaultPerformance)(3, true)
      end
    end
  end
end

GameSystemInfo.__SetDefaultPerformance = function(levelId, save)
  -- function num : 0_1 , upvalues : CS_PlayerPrefs, PlayerPrefsConsts, GameSystemInfo
  if save then
    (CS_PlayerPrefs.SetInt)(PlayerPrefsConsts.DefaultPerformanceId, levelId)
  end
  GameSystemInfo.PerformanceLevelId = levelId
end

GameSystemInfo.GetDefaultPerformance = function()
  -- function num : 0_2 , upvalues : GameSystemInfo
  return GameSystemInfo.PerformanceLevelId
end

return GameSystemInfo

