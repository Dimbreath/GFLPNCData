local HeroFilterEnum = {}
HeroFilterEnum.eKindType = {Rank = 1, Camp = 2, Career = 3}
HeroFilterEnum.eKindMaxCount = {[(HeroFilterEnum.eKindType).Rank] = (ConfigData.hero_rank).maxRank, [(HeroFilterEnum.eKindType).Camp] = (ConfigData.game_config).heroMaxCamp, [(HeroFilterEnum.eKindType).Career] = (ConfigData.game_config).heroMaxCareer}
return HeroFilterEnum

