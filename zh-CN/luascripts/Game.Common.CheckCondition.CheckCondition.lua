-- params : ...
-- function num : 0 , upvalues : _ENV
local CheckCondition = {}
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
CheckCondition.Check = function(...)
  -- function num : 0_0 , upvalues : _ENV, CheckerGlobalConfig
  local args = {...}
  if #args == 0 then
    print("[CheckCondition] not args")
    return false
  end
  local length = (args[1]).Count
  for i = 2, #args do
    if (args[i]).Count > 0 and (args[i]).Count ~= length then
      print("[CheckCondition] args length is different")
      return false
    end
  end
  for i = 0, length - 1 do
    local param = {}
    for _,v in ipairs(args) do
      if i < v.Count then
        (table.insert)(param, v[i])
      end
    end
    local checker = CheckerGlobalConfig[param[1]]
    if not ((checker.Checker).LengthCheck)(param) then
      return false
    end
    if not ((checker.Checker).ParamsCheck)(param) then
      return false
    end
  end
  return true
end

CheckCondition.CheckLua = function(...)
  -- function num : 0_1 , upvalues : _ENV, CheckerGlobalConfig
  local args = {...}
  if #args == 0 then
    print("[CheckCondition] not args")
    return false
  end
  local length = #args[1]
  for i = 2, #args do
    if #args[i] > 0 and #args[i] ~= length then
      print("[CheckCondition] args length is different")
      return false
    end
  end
  for i = 1, length do
    local param = {}
    for _,v in ipairs(args) do
      if i <= #v then
        (table.insert)(param, v[i])
      end
    end
    local checker = CheckerGlobalConfig[param[1]]
    if not ((checker.Checker).LengthCheck)(param) then
      return false
    end
    if not ((checker.Checker).ParamsCheck)(param) then
      return false
    end
  end
  return true
end

CheckCondition.GetUnlockInfo = function(...)
  -- function num : 0_2 , upvalues : _ENV, CheckerGlobalConfig
  local args = {...}
  if #args == 0 then
    print("[CheckCondition] not args")
    return ""
  end
  local length = (args[1]).Count
  for i = 2, #args do
    if (args[i]).Count > 0 and (args[i]).Count ~= length then
      print("[CheckCondition] args length is different")
      return ""
    end
  end
  local unlockStr = ""
  for i = 0, length - 1 do
    local param = {}
    for _,v in ipairs(args) do
      if i < v.Count then
        (table.insert)(param, v[i])
      end
    end
    local checker = CheckerGlobalConfig[param[1]]
    if ((checker.Checker).LengthCheck)(param) then
      unlockStr = unlockStr .. ((checker.Checker).GetUnlockInfo)(param) .. "\n"
    end
  end
  return unlockStr
end

CheckCondition.GetUnlockInfoLua = function(...)
  -- function num : 0_3 , upvalues : _ENV, CheckerGlobalConfig
  local args = {...}
  if #args == 0 then
    print("[CheckCondition] not args")
    return ""
  end
  local length = #args[1]
  for i = 2, #args do
    if #args[i] > 0 and #args[i] ~= length then
      print("[CheckCondition] args length is different")
      return false
    end
  end
  local unlockStr = ""
  for i = 1, length do
    local param = {}
    for _,v in ipairs(args) do
      if i <= #v then
        (table.insert)(param, v[i])
      end
    end
    local checker = CheckerGlobalConfig[param[1]]
    if ((checker.Checker).LengthCheck)(param) then
      if i == 1 then
        unlockStr = unlockStr .. ((checker.Checker).GetUnlockInfo)(param)
      else
        unlockStr = unlockStr .. "\n" .. ((checker.Checker).GetUnlockInfo)(param)
      end
    end
  end
  return unlockStr
end

return CheckCondition

-- params : ...
-- function num : 0 , upvalues : _ENV
local CheckCondition = {}
local CheckerTypeId, CheckerGlobalConfig =
    (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
CheckCondition.Check = function(...)
    -- function num : 0_0 , upvalues : _ENV, CheckerGlobalConfig
    local args = {...}
    if #args == 0 then
        print("[CheckCondition] not args")
        return false
    end
    local length = (args[1]).Count
    for i = 2, #args do
        if (args[i]).Count > 0 and (args[i]).Count ~= length then
            print("[CheckCondition] args length is different")
            return false
        end
    end
    for i = 0, length - 1 do
        local param = {}
        for _, v in ipairs(args) do
            if i < v.Count then (table.insert)(param, v[i]) end
        end
        local checker = CheckerGlobalConfig[param[1]]
        if not ((checker.Checker).LengthCheck)(param) then return false end
        if not ((checker.Checker).ParamsCheck)(param) then return false end
    end
    return true
end

CheckCondition.CheckLua = function(...)
    -- function num : 0_1 , upvalues : _ENV, CheckerGlobalConfig
    local args = {...}
    if #args == 0 then
        print("[CheckCondition] not args")
        return false
    end
    local length = #args[1]
    for i = 2, #args do
        if #args[i] > 0 and #args[i] ~= length then
            print("[CheckCondition] args length is different")
            return false
        end
    end
    for i = 1, length do
        local param = {}
        for _, v in ipairs(args) do
            if i <= #v then (table.insert)(param, v[i]) end
        end
        local checker = CheckerGlobalConfig[param[1]]
        if not ((checker.Checker).LengthCheck)(param) then return false end
        if not ((checker.Checker).ParamsCheck)(param) then return false end
    end
    return true
end

CheckCondition.GetUnlockInfo = function(...)
    -- function num : 0_2 , upvalues : _ENV, CheckerGlobalConfig
    local args = {...}
    if #args == 0 then
        print("[CheckCondition] not args")
        return ""
    end
    local length = (args[1]).Count
    for i = 2, #args do
        if (args[i]).Count > 0 and (args[i]).Count ~= length then
            print("[CheckCondition] args length is different")
            return ""
        end
    end
    local unlockStr = ""
    for i = 0, length - 1 do
        local param = {}
        for _, v in ipairs(args) do
            if i < v.Count then (table.insert)(param, v[i]) end
        end
        local checker = CheckerGlobalConfig[param[1]]
        if ((checker.Checker).LengthCheck)(param) then
            unlockStr = unlockStr .. ((checker.Checker).GetUnlockInfo)(param) ..
                            "\n"
        end
    end
    return unlockStr
end

CheckCondition.GetUnlockInfoLua = function(...)
    -- function num : 0_3 , upvalues : _ENV, CheckerGlobalConfig
    local args = {...}
    if #args == 0 then
        print("[CheckCondition] not args")
        return ""
    end
    local length = #args[1]
    for i = 2, #args do
        if #args[i] > 0 and #args[i] ~= length then
            print("[CheckCondition] args length is different")
            return false
        end
    end
    local unlockStr = ""
    for i = 1, length do
        local param = {}
        for _, v in ipairs(args) do
            if i <= #v then (table.insert)(param, v[i]) end
        end
        local checker = CheckerGlobalConfig[param[1]]
        if ((checker.Checker).LengthCheck)(param) then
            if i == 1 then
                unlockStr = unlockStr ..
                                ((checker.Checker).GetUnlockInfo)(param)
            else
                unlockStr = unlockStr .. "\n" ..
                                ((checker.Checker).GetUnlockInfo)(param)
            end
        end
    end
    return unlockStr
end

return CheckCondition

