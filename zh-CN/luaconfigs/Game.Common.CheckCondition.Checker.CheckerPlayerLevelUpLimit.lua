-- params : ...
-- function num : 0 , upvalues : _ENV
local CheckerPlayerLevelUpLimit = {}
CheckerPlayerLevelUpLimit.LengthCheck = function(param)
  -- function num : 0_0
  if #param >= 2 then
    return true
  end
  return false
end

CheckerPlayerLevelUpLimit.ParamsCheck = function(param)
  -- function num : 0_1 , upvalues : _ENV
  do return (PlayerDataCenter.playerLevel).level <= param[2] end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

CheckerPlayerLevelUpLimit.GetUnlockInfo = function(param)
  -- function num : 0_2
  return ""
end

return CheckerPlayerLevelUpLimit

