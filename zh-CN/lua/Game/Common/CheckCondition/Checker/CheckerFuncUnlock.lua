local CheckerFuncUnlock = {}
CheckerFuncUnlock.LengthCheck = function(param)
  -- function num : 0_0
  if #param >= 2 then
    return true
  end
  return false
end

CheckerFuncUnlock.ParamsCheck = function(param)
  -- function num : 0_1 , upvalues : _ENV
  local ok = FunctionUnlockMgr:ValidateUnlock(param[2])
  return ok
end

CheckerFuncUnlock.GetUnlockInfo = function(param)
  -- function num : 0_2 , upvalues : _ENV
  local funcId = param[2]
  return FunctionUnlockMgr:GetFuncUnlockDecription(funcId)
end

return CheckerFuncUnlock

