local CheckerStOCareerLevel = {}
local BuildEnum = require("Game.Oasis.Data.BuildingEnum")
CheckerStOCareerLevel.LengthCheck = function(param)
  -- function num : 0_0
  if #param >= 2 then
    return true
  end
  return false
end

CheckerStOCareerLevel.ParamsCheck = function(param)
  -- function num : 0_1 , upvalues : _ENV, BuildEnum
  local level = param[2]
  local target = 0
  for buildId,cfg in pairs(ConfigData.building) do
    if cfg.type == (BuildEnum.BuildingType).CareerMaster then
      local buildingData = ((PlayerDataCenter.AllBuildingData).built)[buildId]
      target = buildingData == nil or target + buildingData.level or 0
    end
  end
  do return level <= target end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

CheckerStOCareerLevel.GetUnlockInfo = function(param)
  -- function num : 0_2 , upvalues : _ENV
  local level = param[2]
  return (string.format)(ConfigData:GetTipContent(914), level)
end

return CheckerStOCareerLevel

