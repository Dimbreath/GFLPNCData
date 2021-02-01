-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1001}
local __rt_2 = {500}
local __rt_3 = {3003}
local __rt_4 = {3}
local __rt_5 = {1000}
local __rt_6 = {6}
local __rt_7 = {1500}
local __rt_8 = {9}
local __rt_9 = {3004}
local __rt_10 = {3006}
local __rt_11 = {3007}
local __rt_12 = {}
local sector_achievement = {
{
{conditionIds = __rt_3}
, 
{achivRewardNums = __rt_5, conditionIds = __rt_3, conditionNums = __rt_6, id = 2}
, 
{achivRewardNums = __rt_7, conditionIds = __rt_3, conditionNums = __rt_8, id = 3}
}
, 
{
{conditionIds = __rt_9}
, 
{achivRewardNums = __rt_5, conditionIds = __rt_9, conditionNums = __rt_6, id = 2}
, 
{achivRewardNums = __rt_7, conditionIds = __rt_9, conditionNums = __rt_8, id = 3}
}
, 
{
{conditionIds = __rt_10}
, 
{achivRewardNums = __rt_5, conditionIds = __rt_10, conditionNums = __rt_6, id = 2}
, 
{achivRewardNums = __rt_7, conditionIds = __rt_10, conditionNums = __rt_8, id = 3}
}
, 
{__rt_12, 
{achivRewardNums = __rt_5, conditionNums = __rt_6, id = 2}
, 
{achivRewardNums = __rt_7, conditionNums = __rt_8, id = 3}
}
, 
{__rt_12}
}
local __default_values = {achivRewardIds = __rt_1, achivRewardNums = __rt_2, conditionIds = __rt_11, conditionNums = __rt_4, id = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(sector_achievement) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(sector_achievement, {__index = __rawdata})
return sector_achievement

