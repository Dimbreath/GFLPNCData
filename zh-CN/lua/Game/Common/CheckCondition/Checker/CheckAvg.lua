local CheckAvg = {}
CheckAvg.LengthCheck = function(param)
  -- function num : 0_0
  if #param >= 2 then
    return true
  end
  return false
end

CheckAvg.IsCompletedAvg = function(avgId)
  -- function num : 0_1 , upvalues : _ENV
  if avgId == 0 then
    return true
  end
  return (ControllerManager:GetController(ControllerTypeId.AvgPlay, true)):IsAvgPlayed(avgId)
end

CheckAvg.ParamsCheck = function(param)
  -- function num : 0_2 , upvalues : CheckAvg
  local ok = (CheckAvg.IsCompletedAvg)(param[2])
  return ok
end

CheckAvg.GetUnlockInfo = function(param)
  -- function num : 0_3 , upvalues : _ENV
  local avgId = param[2]
  local avgCfg = (ConfigData.story_avg)[avgId]
  if avgCfg ~= nil then
    return (string.format)(ConfigData:GetTipContent(911), (LanguageUtil.GetLocaleText)(avgCfg.name))
  end
  return ""
end

return CheckAvg

