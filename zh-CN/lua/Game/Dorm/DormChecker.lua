local DormChecker = {}
local HeroTalkUnlockType = {Friendship = 1, Rank = 2}
local HeroTalkCheckFunc = {[HeroTalkUnlockType.Friendship] = function(heroId, arg)
  -- function num : 0_0 , upvalues : _ENV
  local level = (PlayerDataCenter.allFriendshipData):GetLevel(heroId)
  do return arg <= level end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [HeroTalkUnlockType.Rank] = function(heroId, arg)
  -- function num : 0_1 , upvalues : _ENV
  local heroData = PlayerDataCenter:GetHeroData(heroId)
  if heroData == nil then
    return false
  end
  do return arg <= heroData.rank end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
}
DormChecker.CheckerTalkUnlock = function(heroId, unlockType, arg)
  -- function num : 0_2 , upvalues : HeroTalkCheckFunc
  local func = HeroTalkCheckFunc[unlockType]
  if func == nil then
    return false
  end
  return func(heroId, arg)
end

return DormChecker

