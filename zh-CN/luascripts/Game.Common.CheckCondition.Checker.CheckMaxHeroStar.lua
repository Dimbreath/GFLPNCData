-- params : ...
-- function num : 0 , upvalues : _ENV
local CheckMaxHeroStar = {}
CheckMaxHeroStar.LengthCheck = function(param)
  -- function num : 0_0
  if #param >= 3 then
    return true
  end
  return false
end

CheckMaxHeroStar.ParamsCheck = function(param)
  -- function num : 0_1 , upvalues : _ENV
  local heroId = param[2]
  local targetStar = param[3]
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  local heroStar = 0
  if heroData ~= nil then
    heroStar = heroData.star
  end
  local ok = heroStar <= targetStar
  do return ok end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

CheckMaxHeroStar.GetUnlockInfo = function(param)
  -- function num : 0_2 , upvalues : _ENV
  local heroId = param[2]
  local targetStar = param[3]
  local hreoName = (LanguageUtil.GetLocaleText)(((ConfigData.hero_data)[heroId]).name)
  return (string.format)("%s小于等于%d星开放", hreoName, targetStar)
end

return CheckMaxHeroStar

