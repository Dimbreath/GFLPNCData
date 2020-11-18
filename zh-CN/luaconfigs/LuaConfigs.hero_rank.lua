-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {
{itemId = 1003, num = 500000}
}
local hero_rank = {
{rare = 1, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 0}
}
}
, 
{rank = 2, rare = 1, star = 2, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 500}
}
, upgrade_star_frag_cost = 5}
, 
{rank = 3, rare = 2, star = 3, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 1000}
}
, upgrade_star_frag_cost = 10}
, 
{rank = 4, rare = 2, skill_level_max = 4, star = 4, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 2000}
}
, upgrade_star_frag_cost = 20}
, 
{rank = 5, skill_level_max = 4, star = 5, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 5000}
}
, upgrade_star_frag_cost = 30}
, 
{rank = 6, skill_level_max = 5, star = 6, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 10000}
}
, upgrade_star_frag_cost = 50}
, 
{rank = 7, skill_level_max = 6, star = 7, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 30000}
}
, upgrade_star_frag_cost = 60}
, 
{rank = 8, skill_level_max = 7, star = 8, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 50000}
}
, upgrade_star_frag_cost = 70}
, 
{rank = 9, skill_level_max = 8, star = 9, ultimateskill_level = 2, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 100000}
}
, upgrade_star_frag_cost = 80}
, 
{rank = 10, skill_level_max = 9, star = 10, ultimateskill_level = 3, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 250000}
}
, upgrade_star_frag_cost = 100}
, 
{rank = 11, skill_level_max = 10, star = 11, ultimateskill_level = 4, upgrade_star_frag_cost = 120}
, 
{rank = 12, skill_level_max = 10, star = 12, ultimateskill_level = 5, upgrade_star_frag_cost = 9999}
}
local __default_values = {rank = 1, rare = 3, repeat_frag_trans = 0, skill_level_max = 3, star = 1, ultimateskill_level = 1, upgrade_star_extra_cost = __rt_1, upgrade_star_frag_cost = 0}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(hero_rank) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, maxRank = 12, maxRare = 3, maxSkillLevel = 10, maxStar = 12}
setmetatable(hero_rank, {__index = __rawdata})
return hero_rank

