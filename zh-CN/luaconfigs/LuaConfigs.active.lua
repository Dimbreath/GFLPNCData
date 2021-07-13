-- params : ...
-- function num : 0 , upvalues : _ENV
local active = {
{
{
rewardIds = {3005, 1003}
, 
rewardNums = {1, 500}
}
, 
{id = 2, 
rewardIds = {5002, 5001}
, 
rewardNums = {2, 2}
}
, 
{id = 3, 
rewardIds = {1007, 1003}
, 
rewardNums = {50, 500}
}
, 
{id = 4, 
rewardIds = {1007, 8102}
, 
rewardNums = {50, 2}
}
, 
{id = 5, 
rewardNums = {60, 2000}
}
}
, 
{
{activeId = 8, 
rewardIds = {6002, 8102}
, 
rewardNums = {3, 2}
, type = 2}
, 
{activeId = 8, id = 2, 
rewardIds = {8103, 6001}
, 
rewardNums = {3, 3}
, type = 2}
, 
{activeId = 8, id = 3, 
rewardIds = {1007, 3005, 1003}
, 
rewardNums = {100, 3, 1000}
, type = 2}
, 
{activeId = 8, id = 4, 
rewardIds = {3001, 8102, 1003}
, type = 2}
, 
{activeId = 8, id = 5, 
rewardIds = {1002, 5002, 1003}
, 
rewardNums = {300, 3, 3000}
, type = 2}
}
}
local __default_values = {activeId = 7, activeNum = 20, id = 1, 
rewardIds = {1002, 1003}
, 
rewardNums = {1, 2, 1000}
, type = 1}
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

