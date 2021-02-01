-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {8103}
local __rt_2 = {1}
local __rt_3 = {1002}
local __rt_4 = {3001}
local __rt_5 = {3}
local active = {
{
{
rewardIds = {1007}
, 
rewardNums = {50}
}
, 
{id = 2, 
rewardIds = {5002}
, 
rewardNums = {2}
}
, 
{id = 3, rewardIds = __rt_1}
, 
{id = 4, 
rewardNums = {40}
}
, 
{id = 5, rewardIds = __rt_4}
}
, 
{
{activeId = 8, 
rewardIds = {1003}
, 
rewardNums = {4000}
, type = 2}
, 
{activeId = 8, id = 2, 
rewardIds = {6002}
, rewardNums = __rt_5, type = 2}
, 
{activeId = 8, id = 3, rewardIds = __rt_1, rewardNums = __rt_5, type = 2}
, 
{activeId = 8, id = 4, rewardIds = __rt_4, type = 2}
, 
{activeId = 8, id = 5, 
rewardNums = {250}
, type = 2}
}
}
local __default_values = {activeId = 7, activeNum = 20, id = 1, rewardIds = __rt_3, rewardNums = __rt_2, type = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(active) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(active, {__index = __rawdata})
return active

