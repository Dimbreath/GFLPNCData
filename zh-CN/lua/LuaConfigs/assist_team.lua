local __rt_1 = {1002}
local __rt_2 = {1006}
local __rt_3 = {100}
local __rt_4 = {1001}
local __rt_5 = {1003}
local __rt_6 = {66}
local __rt_7 = {66, 66}
local __rt_8 = {1003, 1005}
local __rt_9 = {1004}
local __rt_10 = {100, 100}
local __rt_11 = {1003, 1007}
local assist_team = {
{
assist_lvs = {100, 1000, 100, 100, 100}
, 
param1 = {1001, 1003, 1005, 1022, 1037}
}
, 
{
assist_lvs = {90, 95, 1001}
, id = 2, 
param1 = {1005, 1006, 1001}
}
, 
{
assist_lvs = {100, 100, 100}
, id = 3, 
param1 = {1001, 1003, 1005}
}
, 
{assist_lvs = __rt_1, id = 4, param1 = __rt_2}
, 
{
assist_lvs = {1003, 1003, 1003}
, id = 5, 
param1 = {1001, 1005, 1003}
}
, 
{
assist_lvs = {90, 95}
, id = 6, 
param1 = {1005, 1006}
}
, 
{assist_lvs = __rt_3, id = 7, param1 = __rt_4}
, 
{assist_lvs = __rt_3, id = 8}
, 
{id = 9}
, 
{id = 10, param1 = __rt_2}
, 
{
assist_lvs = {68}
, id = 11, param1 = __rt_1}
, 
{assist_lvs = __rt_7, id = 12, 
param1 = {1006, 1003}
}
, 
{id = 13, param1 = __rt_2}
, 
{id = 14}
, 
{assist_lvs = __rt_7, id = 15, 
param1 = {1003, 1006}
}
, 
{assist_lvs = __rt_7, id = 16, param1 = __rt_8}
, 
{
assist_lvs = {66, 66, 66}
, id = 17, 
param1 = {1003, 1005, 1006}
}
, 
{id = 18}
, 
{assist_lvs = __rt_7, id = 19, param1 = __rt_8}
, 
{id = 20, param1 = __rt_9}
, 
{
assist_lvs = {325}
, id = 21, param1 = __rt_9}
, 
{assist_lvs = __rt_10, id = 22, 
param1 = {1005, 1027}
}
, 
{
assist_lvs = {316}
, id = 23, param1 = __rt_4}
, 
{
assist_lvs = {100, 100, 100, 100}
, id = 24, 
param1 = {1001, 1002, 1003, 1005}
}
, 
{assist_lvs = __rt_3, id = 25}
, 
{assist_lvs = __rt_3, id = 26, param1 = __rt_2}
, 
{assist_lvs = __rt_10, id = 27, 
param1 = {1006, 1004}
}
, 
{assist_lvs = __rt_10, id = 28, param1 = __rt_11}
, 
{id = 29}
, 
{assist_lvs = __rt_10, id = 30, param1 = __rt_11}
, 
{
assist_lvs = {160, 160, 160}
, id = 31, 
param1 = {1001, 1003, 1002}
}
}
local __default_values = {assist_lvs = __rt_6, id = 1, param1 = __rt_5}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(assist_team) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(assist_team, {__index = __rawdata})
return assist_team

