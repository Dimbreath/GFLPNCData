-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local lottery_reward_pool = {
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
[12] = {id = 12, item_reward = 2011, type = 103}
, 
[13] = {id = 13, item_reward = 2012, type = 103}
, 
[16] = {id = 16, item_reward = 2013}
, 
[17] = {id = 17, item_reward = 2014, type = 103}
, 
[20] = {id = 20, item_reward = 2015}
, 
[21] = {id = 21, item_reward = 2016, type = 101}
, 
[23] = {id = 23, item_reward = 2017}
, 
[27] = {id = 27, item_reward = 2018, type = 101}
, 
[31] = {id = 31, item_reward = 2019}
, 
[34] = {id = 34, item_reward = 2020}
, 
[35] = {id = 35, item_reward = 2021, type = 103}
, 
[36] = {id = 36, item_reward = 2022, type = 101}
, 
[37] = {id = 37, item_reward = 2023, type = 103}
, 
[38] = {id = 38, item_reward = 2024, type = 103}
, 
[39] = {id = 39, item_reward = 2025, type = 103}
, 
[40] = {id = 40, item_reward = 2026, type = 101}
, 
[41] = {id = 41, item_reward = 2027}
, 
[42] = {id = 42, item_reward = 2028, type = 101}
, 
[43] = {id = 43, item_reward = 2031}
, 
[44] = {id = 44, item_reward = 2034, type = 103}
, 
[45] = {id = 45, item_reward = 2035, type = 103}
, 
[46] = {id = 46, item_reward = 2036, type = 103}
, 
[47] = {id = 47, item_reward = 2037, type = 101}
, 
[48] = {id = 48, item_reward = 2038}
, 
[49] = {id = 49, item_reward = 2039, type = 101}
}
local __default_values = {id = 1, item_reward = 2001, pre_condition = __rt_1, pre_para1 = __rt_1, pre_para2 = __rt_1, type = 102}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(lottery_reward_pool) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
rewardTypeDic = {
[101] = {5, 8, 21, 27, 36, 40, 42, 47, 49}
, 
[102] = {1, 2, 3, 6, 7, 10, 16, 20, 23, 31, 34, 41, 43, 48}
, 
[103] = {4, 9, 12, 13, 17, 35, 37, 38, 39, 44, 45, 46}
}
}
setmetatable(lottery_reward_pool, {__index = __rawdata})
return lottery_reward_pool

