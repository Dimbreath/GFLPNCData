-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1002, 1015}
local weekly_challenge_rank_reward = {
{
rewardNums = {600, 500}
, type = 1}
, 
{id = 2, 
rewardNums = {500, 400}
, score = 50}
, 
{id = 3, 
rewardNums = {400, 300}
}
, 
{id = 4, 
rewardNums = {300, 200}
, score = 300}
, 
{id = 5, score = 500}
, 
{id = 6, 
rewardNums = {50, 50}
, score = 1000}
}
local __default_values = {id = 1, rewardIds = __rt_1, 
rewardNums = {100, 100}
, score = 100, type = 2}
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

