local weekly_challenge_rank_reward = {
{type = 1}
, 
{id = 2, score = 50}
, 
{id = 3}
, 
{id = 4, score = 300}
, 
{id = 5, score = 500}
, 
{id = 6, score = 1000}
}
local __default_values = {id = 1, reward = "", score = 100, type = 2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(weekly_challenge_rank_reward) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(weekly_challenge_rank_reward, {__index = __rawdata})
return weekly_challenge_rank_reward

