-- params : ...
-- function num : 0 , upvalues : _ENV
local CherkerFriendshipLevel = {}
CherkerFriendshipLevel.LengthCheck = function(param)
  -- function num : 0_0
  if #param >= 3 then
    return true
  end
  return false
end

CherkerFriendshipLevel.HeroFriendShipLevel = function(heroId, friendshipLevel)
  -- function num : 0_1 , upvalues : _ENV
  local level = (PlayerDataCenter.allFriendshipData):GetLevel(heroId)
  if friendshipLevel <= level then
    return true
  end
  return false
end

CherkerFriendshipLevel.ParamsCheck = function(param)
  -- function num : 0_2 , upvalues : CherkerFriendshipLevel
  local ok = (CherkerFriendshipLevel.HeroFriendShipLevel)(param[2], param[3])
  return ok
end

CherkerFriendshipLevel.GetUnlockInfo = function(param)
  -- function num : 0_3 , upvalues : _ENV
  local heroId = param[2]
  local friendshipLevel = param[3]
  local hreoName = (LanguageUtil.GetLocaleText)(((ConfigData.hero_data)[heroId]).name)
  return (string.format)("%s亲密度达到%d级解锁", hreoName, friendshipLevel)
end

return CherkerFriendshipLevel

