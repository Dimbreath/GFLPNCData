-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {1002, 3001, 3005}
local __rt_3 = {100, 1, 1}
local __rt_4 = {26, 3}
local __rt_5 = {1400, 1007}
local __rt_6 = {1002, 3001, 1003}
local __rt_7 = {100, 5, 1}
local __rt_8 = {2, 40}
local __rt_9 = {3, 50}
local __rt_10 = {1000, 1, 1}
local __rt_11 = {4, 60}
local __rt_12 = {3001, 1002, 3005}
local __rt_13 = {1, 100, 1}
local __rt_14 = {5, 100}
local achievement_level = {
{exp = 200, icon = "icon_qingtong1", logic = __rt_1, para1 = __rt_1, para2 = __rt_1, rewardIds = __rt_1, rewardNums = __rt_1}
, 
{exp = 200, icon = "icon_qingtong2", id = 2, 
logic = {26}
, 
para1 = {1400}
, 
para2 = {1}
}
, 
{exp = 500, icon = "icon_qingtong3", id = 3, 
para2 = {1, 10}
}
, 
{exp = 500, icon = "icon_qingtong4", id = 4, 
para2 = {1, 20}
, rewardIds = __rt_6, 
rewardNums = {100, 1, 20000}
}
, 
{exp = 500, icon = "icon_qingtong5", id = 5, 
para2 = {1, 30}
}
, 
{exp = 500, icon = "icon_hj1", id = 6, 
para2 = {2, 30}
, rewardNums = __rt_7}
, 
{icon = "icon_hj2", id = 7}
, 
{icon = "icon_hj3", id = 8}
, 
{icon = "icon_hj4", id = 9, 
para2 = {3, 40}
, rewardNums = __rt_7}
, 
{icon = "icon_hj5", id = 10, para2 = __rt_9}
, 
{id = 11, para2 = __rt_9, rewardNums = __rt_7}
, 
{icon = "icon_bj2", id = 12, 
para2 = {3, 60}
, rewardNums = __rt_10}
, 
{icon = "icon_bj3", id = 13, para2 = __rt_11, rewardNums = __rt_7}
, 
{icon = "icon_bj4", id = 14, para2 = __rt_11, rewardNums = __rt_10}
, 
{icon = "icon_bj5", id = 15, 
para2 = {5, 60}
, rewardIds = __rt_6, 
rewardNums = {100, 1, 100000}
}
, 
{icon = "icon_zs1", id = 16, 
para2 = {5, 70}
, 
rewardNums = {2000, 1, 1}
}
, 
{icon = "icon_zs2", id = 17, 
para2 = {5, 80}
, rewardIds = __rt_12, rewardNums = __rt_13}
, 
{icon = "icon_zs3", id = 18, 
para2 = {5, 90}
, rewardIds = __rt_12, rewardNums = __rt_13}
, 
{icon = "icon_zs4", id = 19, para2 = __rt_14, rewardIds = __rt_12, rewardNums = __rt_13}
, 
{exp = 0, icon = "icon_zs5", id = 20, para2 = __rt_14, rewardIds = __rt_12, rewardNums = __rt_13}
}
local __default_values = {exp = 1000, icon = "icon_bj1", id = 1, logic = __rt_4, para1 = __rt_5, para2 = __rt_8, para3 = __rt_1, rewardIds = __rt_2, rewardNums = __rt_3}
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

