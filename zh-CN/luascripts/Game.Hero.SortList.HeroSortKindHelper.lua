-- params : ...
-- function num : 0 , upvalues : _ENV
local eKindType = {Star = 1, Camp = 2, Career = 3}
local eKindMaxCount = {[eKindType.Star] = (ConfigData.hero_rank).maxStar, [eKindType.Camp] = (ConfigData.game_config).heroMaxCamp, [eKindType.Career] = (ConfigData.game_config).heroMaxCareer}
local M = {eKindType, eKindMaxCount}
return M

-- params : ...
-- function num : 0 , upvalues : _ENV
local eKindType = {Star = 1, Camp = 2, Career = 3}
local eKindMaxCount = {
    [eKindType.Star] = (ConfigData.hero_rank).maxStar,
    [eKindType.Camp] = (ConfigData.game_config).heroMaxCamp,
    [eKindType.Career] = (ConfigData.game_config).heroMaxCareer
}
local M = {eKindType, eKindMaxCount}
return M

