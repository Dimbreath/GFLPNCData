-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {26}
local __rt_3 = {1400}
local __rt_4 = {1}
local __rt_5 = {1002, 3001, 3005}
local __rt_6 = {100, 1, 1}
local __rt_7 = {26, 3}
local __rt_8 = {1400, 1007}
local __rt_9 = {1, 10}
local __rt_10 = {1002, 3001, 1003}
local __rt_11 = {2, 10}
local __rt_12 = {100, 5, 1}
local __rt_13 = {3, 20}
local __rt_14 = {1000, 1, 1}
local __rt_15 = {3001, 1002, 3005}
local __rt_16 = {1, 100, 1}
local achievement_level = {
{exp = 200, icon = "icon_qingtong1", logic = __rt_1, para1 = __rt_1, para2 = __rt_1, rewardIds = __rt_1, rewardNums = __rt_1}
, 
{exp = 200, icon = "icon_qingtong2", id = 2, logic = __rt_2, para1 = __rt_3, para2 = __rt_4}
, 
{exp = 500, icon = "icon_qingtong3", id = 3, logic = __rt_2, para1 = __rt_3, para2 = __rt_4}
, 
{exp = 500, icon = "icon_qingtong4", id = 4, para2 = __rt_9, rewardIds = __rt_10, 
rewardNums = {100, 1, 20000}
}
, 
{exp = 500, icon = "icon_qingtong5", id = 5, para2 = __rt_9}
, 
{exp = 500, icon = "icon_hj1", id = 6, para2 = __rt_11, rewardNums = __rt_12}
, 
{icon = "icon_hj2", id = 7, para2 = __rt_11}
, 
{icon = "icon_hj3", id = 8, 
para2 = {2, 20}
}
, 
{icon = "icon_hj4", id = 9, rewardNums = __rt_12}
, 
{icon = "icon_hj5", id = 10}
, 
{id = 11, rewardNums = __rt_12}
, 
{icon = "icon_bj2", id = 12, 
para2 = {3, 30}
, rewardNums = __rt_14}
, 
{icon = "icon_bj3", id = 13, 
para2 = {4, 30}
, rewardNums = __rt_12}
, 
{icon = "icon_bj4", id = 14, 
para2 = {4, 40}
, rewardNums = __rt_14}
, 
{icon = "icon_bj5", id = 15, 
para2 = {5, 40}
, rewardIds = __rt_10, 
rewardNums = {100, 1, 100000}
}
, 
{icon = "icon_zs1", id = 16, 
para2 = {5, 50}
, 
rewardNums = {2000, 1, 1}
}
, 
{icon = "icon_zs2", id = 17, 
para2 = {5, 60}
, rewardIds = __rt_15, rewardNums = __rt_16}
, 
{icon = "icon_zs3", id = 18, 
para2 = {5, 70}
, rewardIds = __rt_15, rewardNums = __rt_16}
, 
{icon = "icon_zs4", id = 19, 
para2 = {5, 80}
, rewardIds = __rt_15, rewardNums = __rt_16}
, 
{exp = 0, icon = "icon_zs5", id = 20, 
para2 = {5, 100}
, rewardIds = __rt_15, rewardNums = __rt_16}
}
local __default_values = {exp = 1000, icon = "icon_bj1", id = 1, logic = __rt_7, para1 = __rt_8, para2 = __rt_13, para3 = __rt_1, rewardIds = __rt_5, rewardNums = __rt_6}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(achievement_level) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(achievement_level, {__index = __rawdata})
return achievement_level

