-- params : ...
-- function num : 0 , upvalues : _ENV
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
  local ok = (ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)):ValidateUnlock(param[2])
  return ok
end

CheckerFuncUnlock.GetUnlockInfo = function(param)
  -- function num : 0_2
  return ""
end

return CheckerFuncUnlock

-- params : ...
-- function num : 0 , upvalues : _ENV
local CheckerFuncUnlock = {}
CheckerFuncUnlock.LengthCheck = function(param)
    -- function num : 0_0
    if #param >= 2 then return true end
    return false
end

CheckerFuncUnlock.ParamsCheck = function(param)
    -- function num : 0_1 , upvalues : _ENV
    local ok = (ControllerManager:GetController(ControllerTypeId.FunctionUnlock,
                                                true)):ValidateUnlock(param[2])
    return ok
end

CheckerFuncUnlock.GetUnlockInfo = function(param)
    -- function num : 0_2
    return ""
end

return CheckerFuncUnlock

