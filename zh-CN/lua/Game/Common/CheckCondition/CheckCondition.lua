local CheckCondition = {}
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local paramGoup = {}
CheckCondition.CheckLua = function(...)
  -- function num : 0_0 , upvalues : _ENV, paramGoup, CheckerGlobalConfig
  local paramNum = select("#", ...)
  if paramNum == 0 then
    print("[CheckCondition] not args")
    return false
  end
  local para1 = select(1, ...)
  local length = #para1
  for i = 2, paramNum do
    local para = select(i, ...)
    local len = #para
    if len > 0 and len ~= length then
      print("[CheckCondition] args length is different")
      return false
    end
  end
  for i = 1, length do
    local index = 1
    for j = 1, paramNum do
      local para = select(j, ...)
      if #para > 0 then
        paramGoup[index] = para[i]
        index = index + 1
      end
    end
    for i = index, #paramGoup do
      paramGoup[i] = nil
    end
    local checker = CheckerGlobalConfig[paramGoup[1]]
    if checker == nil then
      error("Checker is nil  id:" .. tostring(paramGoup[1]))
    end
    if not ((checker.Checker).LengthCheck)(paramGoup) then
      return false
    end
    if not ((checker.Checker).ParamsCheck)(paramGoup) then
      return false
    end
  end
  return true
end

CheckCondition.GetUnlockInfoLua = function(...)
  -- function num : 0_1 , upvalues : _ENV, paramGoup, CheckerGlobalConfig
  local paramNum = select("#", ...)
  if paramNum == 0 then
    print("[CheckCondition] not args")
    return ""
  end
  local para1 = select(1, ...)
  local length = #para1
  for i = 2, paramNum do
    local para = select(i, ...)
    local len = #para
    if len > 0 and len ~= length then
      print("[CheckCondition] args length is different")
      return false
    end
  end
  local unlockStr = ""
  for i = 1, length do
    local index = 1
    for j = 1, paramNum do
      local para = select(j, ...)
      if #para > 0 then
        paramGoup[index] = para[i]
        index = index + 1
      end
    end
    for i = index, #paramGoup do
      paramGoup[i] = nil
    end
    local checker = CheckerGlobalConfig[paramGoup[1]]
    if ((checker.Checker).LengthCheck)(paramGoup) then
      if i == 1 then
        unlockStr = unlockStr .. ((checker.Checker).GetUnlockInfo)(paramGoup)
      else
        unlockStr = unlockStr .. "\n" .. ((checker.Checker).GetUnlockInfo)(paramGoup)
      end
    end
  end
  return unlockStr
end

return CheckCondition

