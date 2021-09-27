local CheckerPlayLevel = {}
CheckerPlayLevel.LengthCheck = function(param)
  -- function num : 0_0
  if #param >= 2 then
    return true
  end
  return false
end

CheckerPlayLevel.ParamsCheck = function(param)
  -- function num : 0_1 , upvalues : _ENV
  do return param[2] <= (PlayerDataCenter.playerLevel).level end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

CheckerPlayLevel.GetUnlockInfo = function(param)
  -- function num : 0_2 , upvalues : _ENV
  local playerLevel = param[2]
  return (string.format)(ConfigData:GetTipContent(913), playerLevel)
end

return CheckerPlayLevel

