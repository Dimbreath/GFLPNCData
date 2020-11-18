-- params : ...
-- function num : 0 , upvalues : _ENV
local CheckerBuilding = {}
CheckerBuilding.LengthCheck = function(param)
  -- function num : 0_0
  if #param >= 3 then
    return true
  end
  return false
end

CheckerBuilding.BuildingLevel = function(num, id, level)
  -- function num : 0_1 , upvalues : _ENV
  local ok = false
  local buildingDatas = PlayerDataCenter.AllBuildingData
  local count = 0
  for _,v in pairs(buildingDatas.built) do
    if v.id == id and level <= v.level and v.state ~= proto_object_BuildingState.BuildingStateCreate then
      count = count + 1
      if num <= count then
        ok = true
        break
      end
    end
  end
  do
    return ok
  end
end

CheckerBuilding.ParamsCheck = function(param)
  -- function num : 0_2 , upvalues : CheckerBuilding
  local ok = (CheckerBuilding.BuildingLevel)(1, param[2], param[3])
  return ok
end

CheckerBuilding.GetUnlockInfo = function(param)
  -- function num : 0_3 , upvalues : _ENV
  local buildId = param[2]
  local buildLevel = param[3]
  local buildCfg = (ConfigData.building)[buildId]
  if buildCfg ~= nil then
    return (string.format)("%d级%s解锁", buildLevel, (LanguageUtil.GetLocaleText)(buildCfg.name))
  end
  return ""
end

return CheckerBuilding

