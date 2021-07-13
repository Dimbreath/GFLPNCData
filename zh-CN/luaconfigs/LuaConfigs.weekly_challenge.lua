-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {3}
local __rt_2 = {}
local weekly_challenge = {
[1501] = {
base_reward = {1}
, name = 414850}
, 
[1502] = {challenge_id = 102, have_rank = true, hero_level_max = 45, hero_level_min = 35, hero_rank_max = 4, hero_rank_min = 3, hero_skill_level_max = 5, hero_star_max = 8, hero_star_min = 6, id = 1502, introduce = 401065, 
pre_para1 = {4104}
}
}
local __default_values = {
base_reward = {1, 2}
, challenge_id = 101, have_rank = false, hero_level_max = 35, hero_level_min = 25, hero_rank_max = 3, hero_rank_min = 2, hero_skill_level_max = 1, hero_skill_level_min = 1, hero_star_max = 6, hero_star_min = 4, id = 1501, introduce = 155507, name = 404049, pic_small = "small_1", pre_condition = __rt_1, 
pre_para1 = {3102}
, pre_para2 = __rt_2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(weekly_challenge) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(weekly_challenge, {__index = __rawdata})
return weekly_challenge

