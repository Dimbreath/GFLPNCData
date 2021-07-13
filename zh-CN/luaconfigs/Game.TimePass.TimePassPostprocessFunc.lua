-- params : ...
-- function num : 0 , upvalues : _ENV
local TimePassPostprocessFunc = {[proto_object_CounterModule.CounterModuleDailyChallenge] = function(isUpdate)
  -- function num : 0_0 , upvalues : _ENV
  local _, periodicRedNote = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, RedDotStaticTypeId.PeriodicChallenge)
  if not (PlayerDataCenter.periodicChallengeData):GetIsDailyChallengeFished() or not 0 then
    local num = periodicRedNote == nil or 1
  end
  periodicRedNote:SetRedDotCount(num)
end
}
return TimePassPostprocessFunc

