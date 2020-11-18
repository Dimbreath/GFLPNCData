-- params : ...
-- function num : 0 , upvalues : _ENV
local HeroFilterEnum = {}
HeroFilterEnum.eKindType = {Rare = 1, Camp = 2, Career = 3}
HeroFilterEnum.eKindMaxCount = {[(HeroFilterEnum.eKindType).Rare] = (ConfigData.hero_rank).maxRare, [(HeroFilterEnum.eKindType).Camp] = (ConfigData.game_config).heroMaxCamp, [(HeroFilterEnum.eKindType).Career] = (ConfigData.game_config).heroMaxCareer}
return HeroFilterEnum

