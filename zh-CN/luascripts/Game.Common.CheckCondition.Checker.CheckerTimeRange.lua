-- params : ...
-- function num : 0 , upvalues : _ENV
local CheckerTimeRange = {}
CheckerTimeRange.LengthCheck = function(param)
  -- function num : 0_0
  if #param >= 3 then
    return true
  end
  return false
end

CheckerTimeRange.TimeInRange = function(startTime, endTime)
  -- function num : 0_1 , upvalues : _ENV
  local startOk, endOk = false, false
  if startTime == -1 then
    startOk = true
  else
    startOk = startTime <= PlayerDataCenter.timestamp
  end
  if endTime == -1 then
    endOk = true
  else
    endOk = PlayerDataCenter.timestamp <= endTime
  end
  do return not startOk or endOk end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

CheckerTimeRange.ParamsCheck = function(param)
  -- function num : 0_2 , upvalues : CheckerTimeRange
  local ok = (CheckerTimeRange.TimeInRange)(param[2], param[3])
  return ok
end

CheckerTimeRange.GetUnlockInfo = function(param)
  -- function num : 0_3
  return ""
end

return CheckerTimeRange

