-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {4}
local __rt_3 = {1002}
local __rt_4 = {3}
local __rt_5 = {5}
local __rt_6 = {2110}
local __rt_7 = {1112}
local __rt_8 = {2106}
local __rt_9 = {3106}
local __rt_10 = {4103}
local lottery_buildfree_pool = {
{item_reward = 2021, type = 201}
, 
{id = 2, item_reward = 2023, type = 201}
, 
{id = 3, item_reward = 2035, type = 201}
, 
{id = 4, item_reward = 2010, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_4, type = 201}
, 
{id = 5, item_reward = 2013, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_4, type = 201}
, 
{id = 6, item_reward = 2017, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_2, type = 201}
, 
{id = 7, item_reward = 2020, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_2, type = 201}
, 
{id = 8, item_reward = 2016, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_5, type = 201}
, 
{id = 9, item_reward = 2008, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_5, type = 201}
, 
{id = 10, type = 202}
, 
{id = 11, type = 202}
, 
{id = 12, type = 202}
, 
{id = 13, type = 202}
, 
{id = 14, item_reward = 5001}
, 
{id = 15, item_reward = 5002}
, 
{id = 16, item_reward = 5007}
, 
{id = 17, item_reward = 1101, pre_condition = __rt_4, pre_para1 = __rt_6}
, 
{id = 18, item_reward = 1102, pre_condition = __rt_4, pre_para1 = __rt_6}
, 
{id = 19, item_reward = 1103, pre_condition = __rt_4, pre_para1 = __rt_6}
, 
{id = 20, item_reward = 1107, pre_condition = __rt_4, pre_para1 = __rt_6}
, 
{id = 21, item_reward = 1108, pre_condition = __rt_4, pre_para1 = __rt_6}
, 
{id = 22, item_reward = 1109, pre_condition = __rt_4, pre_para1 = __rt_6}
, 
{id = 23, item_reward = 1113, pre_condition = __rt_4, pre_para1 = __rt_6}
, 
{id = 24, item_reward = 1114, pre_condition = __rt_4, pre_para1 = __rt_6}
, 
{id = 25, item_reward = 1115, pre_condition = __rt_4, pre_para1 = __rt_6}
, 
{id = 26, item_reward = 3100}
, 
{id = 27, item_reward = 3101}
, 
{id = 28, item_reward = 3102}
, 
{id = 29, item_reward = 3103}
, 
{id = 30, item_reward = 3104}
, 
{id = 31, item_reward = 3105}
, 
{id = 32, item_reward = 3106}
, 
{id = 33, item_reward = 3107}
, 
{id = 34, item_reward = 3108}
, 
{id = 35, item_reward = 3109}
, 
{id = 36, item_reward = 3110}
, 
{id = 37, item_reward = 3111}
, 
{id = 38, item_reward = 3112}
, 
{id = 39, item_reward = 3113}
, 
{id = 40, item_reward = 3114}
, 
{id = 41, item_reward = 1801, type = 204}
, 
{id = 42, item_reward = 1802, type = 204}
, 
{id = 43, item_reward = 1803, type = 204}
, 
{id = 44, item_reward = 1804, type = 204}
, 
{id = 45, item_reward = 1805, type = 204}
, 
{id = 46, item_reward = 1806, pre_condition = __rt_4, pre_para1 = __rt_7, type = 204}
, 
{id = 47, item_reward = 1807, pre_condition = __rt_4, pre_para1 = __rt_7, type = 204}
, 
{id = 48, item_reward = 1808, pre_condition = __rt_4, pre_para1 = __rt_7, type = 204}
, 
{id = 49, item_reward = 1809, pre_condition = __rt_4, pre_para1 = __rt_7, type = 204}
, 
{id = 50, item_reward = 1810, pre_condition = __rt_4, pre_para1 = __rt_7, type = 204}
, 
{id = 51, item_reward = 1811, pre_condition = __rt_4, pre_para1 = __rt_8, type = 204}
, 
{id = 52, item_reward = 1812, pre_condition = __rt_4, pre_para1 = __rt_8, type = 204}
, 
{id = 53, item_reward = 1813, pre_condition = __rt_4, pre_para1 = __rt_8, type = 204}
, 
{id = 54, item_reward = 1814, pre_condition = __rt_4, pre_para1 = __rt_8, type = 204}
, 
{id = 55, item_reward = 1815, pre_condition = __rt_4, pre_para1 = __rt_8, type = 204}
, 
{id = 56, item_reward = 1816, pre_condition = __rt_4, pre_para1 = __rt_9, type = 204}
, 
{id = 57, item_reward = 1817, pre_condition = __rt_4, pre_para1 = __rt_9, type = 204}
, 
{id = 58, item_reward = 1818, pre_condition = __rt_4, pre_para1 = __rt_9, type = 204}
, 
{id = 59, item_reward = 1819, pre_condition = __rt_4, pre_para1 = __rt_9, type = 204}
, 
{id = 60, item_reward = 1820, pre_condition = __rt_4, pre_para1 = __rt_9, type = 204}
, 
{id = 61, item_reward = 1821, pre_condition = __rt_4, pre_para1 = __rt_10, type = 204}
, 
{id = 62, item_reward = 1822, pre_condition = __rt_4, pre_para1 = __rt_10, type = 204}
, 
{id = 63, item_reward = 1823, pre_condition = __rt_4, pre_para1 = __rt_10, type = 204}
, 
{id = 64, item_reward = 1824, pre_condition = __rt_4, pre_para1 = __rt_10, type = 204}
, 
{id = 65, item_reward = 1825, pre_condition = __rt_4, pre_para1 = __rt_10, type = 204}
}
local __default_values = {id = 1, item_reward = 1006, pre_condition = __rt_1, pre_para1 = __rt_1, pre_para2 = __rt_1, type = 203}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(lottery_buildfree_pool) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
rewardTypeDic = {
[201] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
, 
[202] = {10, 11, 12, 13}
, 
[203] = {14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40}
, 
[204] = {41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65}
}
}
setmetatable(lottery_buildfree_pool, {__index = __rawdata})
return lottery_buildfree_pool

