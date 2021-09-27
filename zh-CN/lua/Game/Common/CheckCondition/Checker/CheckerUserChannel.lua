local CheckerUserChannel = {}
local UserChannelIdEnum = {UserChannelIdNone = 0, Gw = 3, Bili = 4}
CheckerUserChannel.LengthCheck = function(param)
  -- function num : 0_0
  if #param >= 2 then
    return true
  end
  return false
end

CheckerUserChannel.ParamsCheck = function(param)
  -- function num : 0_1 , upvalues : _ENV
  do return PlayerDataCenter.channelId == param[2] end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

CheckerUserChannel.GetUnlockInfo = function(param)
  -- function num : 0_2 , upvalues : _ENV
  do return PlayerDataCenter.channelId == param[2] end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return CheckerUserChannel

