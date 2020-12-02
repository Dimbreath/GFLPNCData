-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local gashapon_reward_pool = {
{}
, 
{id = 2, item_reward = 2002}
, 
{id = 3, item_reward = 2003}
, 
{id = 4, item_reward = 2004, type = 103}
, 
{id = 5, item_reward = 2005, type = 101}
, 
{id = 6, item_reward = 2006}
, 
{id = 7, item_reward = 2007}
, 
{id = 8, item_reward = 2008, type = 101}
, 
{id = 9, item_reward = 2009, type = 103}
, 
{id = 10, item_reward = 2010}
; 
[12] = {id = 12, item_reward = 2012, type = 103}
, 
[13] = {id = 13, item_reward = 2013}
, 
[16] = {id = 16, item_reward = 2016, type = 101}
, 
[17] = {id = 17, item_reward = 2017}
, 
[20] = {id = 20, item_reward = 2020}
, 
[21] = {id = 21, item_reward = 2021, type = 103}
, 
[23] = {id = 23, item_reward = 2023, type = 103}
, 
[27] = {id = 27, item_reward = 2027}
, 
[31] = {id = 31, item_reward = 2031}
, 
[34] = {id = 34, item_reward = 2034, type = 103}
, 
[35] = {id = 35, item_reward = 2035, type = 103}
, 
[36] = {id = 36, item_reward = 2036, type = 103}
, 
[37] = {id = 37, item_reward = 2037, type = 101}
, 
[38] = {id = 38, item_reward = 2038}
, 
[39] = {id = 39, item_reward = 2039, type = 101}
}
local __default_values = {id = 1, item_reward = 2001, pre_condition = __rt_1, pre_para1 = __rt_1, pre_para2 = __rt_1, type = 102}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(gashapon_reward_pool) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
rewardTypeDic = {
[101] = {37, 39, 8, 16, 5}
, 
[102] = {1, 2, 3, 38, 10, 13, 17, 20, 7, 6, 27, 31}
, 
[103] = {36, 9, 12, 21, 23, 4, 35, 34}
}
}
setmetatable(gashapon_reward_pool, {__index = __rawdata})
return gashapon_reward_pool

