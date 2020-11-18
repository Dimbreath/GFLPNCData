-- params : ...
-- function num : 0 , upvalues : _ENV
local CheckMinHeroStar = {}
CheckMinHeroStar.LengthCheck = function(param)
  -- function num : 0_0
  if #param >= 3 then
    return true
  end
  return false
end

CheckMinHeroStar.ParamsCheck = function(param)
  -- function num : 0_1 , upvalues : _ENV
  local heroId = param[2]
  local targetStar = param[3]
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  local heroStar = 0
  if heroData ~= nil then
    heroStar = heroData.star
  end
  local ok = targetStar <= heroStar
  do return ok end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

CheckMinHeroStar.GetUnlockInfo = function(param)
  -- function num : 0_2 , upvalues : _ENV
  local heroId = param[2]
  local targetStar = param[3]
  local hreoName = (LanguageUtil.GetLocaleText)(((ConfigData.hero_data)[heroId]).name)
  return (string.format)("%s大于等于%d星开放", hreoName, targetStar)
end

return CheckMinHeroStar

