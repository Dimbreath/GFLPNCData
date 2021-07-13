-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {3}
local __rt_3 = {1007}
local __rt_4 = {10}
local __rt_5 = {1002, 3001, 3005}
local __rt_6 = {100, 1, 1}
local __rt_7 = {100, 5, 1}
local __rt_8 = {26, 3}
local __rt_9 = {1400, 1007}
local __rt_10 = {1, 10}
local __rt_11 = {500, 1, 1}
local __rt_12 = {1002, 3001, 1003}
local __rt_13 = {1, 20}
local __rt_14 = {100, 1, 50000}
local __rt_15 = {2, 30}
local __rt_16 = {1002, 3001, 1502}
local __rt_17 = {3, 40}
local __rt_18 = {4, 50}
local __rt_19 = {100, 1, 2}
local __rt_20 = {1002, 3001, 6003}
local __rt_21 = {4, 60}
local __rt_22 = {5, 70}
local __rt_23 = {5, 80}
local __rt_24 = {100, 1, 3}
local __rt_25 = {5, 90}
local achievement_level = {
{exp = 200, icon = "icon_qingtong1", logic = __rt_1, para1 = __rt_1, para2 = __rt_1, rewardIds = __rt_1, rewardNums = __rt_1}
, 
{icon = "icon_qingtong2", id = 2, logic = __rt_2, para1 = __rt_3, para2 = __rt_4}
, 
{icon = "icon_qingtong3", id = 3, logic = __rt_2, para1 = __rt_3, para2 = __rt_4, rewardNums = __rt_7}
, 
{icon = "icon_qingtong4", id = 4, para2 = __rt_10, rewardNums = __rt_11}
, 
{icon = "icon_qingtong5", id = 5, para2 = __rt_10, rewardIds = __rt_12, 
rewardNums = {100, 1, 20000}
}
, 
{icon = "icon_hj1", id = 6, para2 = __rt_13, rewardNums = __rt_11}
, 
{icon = "icon_hj2", id = 7, para2 = __rt_13, rewardIds = __rt_12, rewardNums = __rt_14}
, 
{icon = "icon_hj3", id = 8, 
para2 = {2, 20}
}
, 
{icon = "icon_hj4", id = 9}
, 
{icon = "icon_hj5", id = 10, rewardNums = __rt_7}
, 
{icon = "icon_bj1", id = 11, rewardIds = __rt_16, 
rewardNums = {100, 1, 5}
}
, 
{icon = "icon_bj2", id = 12, para2 = __rt_17}
, 
{icon = "icon_bj3", id = 13, para2 = __rt_17, rewardNums = __rt_11}
, 
{icon = "icon_bj4", id = 14, para2 = __rt_17, rewardIds = __rt_12, rewardNums = __rt_14}
, 
{icon = "icon_bj5", id = 15, 
para2 = {3, 50}
}
, 
{icon = "icon_zs1", id = 16, para2 = __rt_18, rewardNums = __rt_19}
, 
{icon = "icon_zs2", id = 17, para2 = __rt_18, rewardIds = __rt_20}
, 
{icon = "icon_zs3", id = 18, para2 = __rt_21, rewardNums = __rt_19}
, 
{icon = "icon_zs4", id = 19, para2 = __rt_21, rewardIds = __rt_16, 
rewardNums = {100, 1, 10}
}
, 
{id = 20, 
para2 = {5, 60}
, rewardNums = __rt_19}
, 
{id = 21, para2 = __rt_22, rewardNums = __rt_19}
, 
{id = 22, para2 = __rt_22, 
rewardNums = {500, 1, 2}
}
, 
{exp = 750, id = 23, para2 = __rt_22, rewardNums = __rt_19}
, 
{exp = 750, id = 24, para2 = __rt_23, rewardNums = __rt_24}
, 
{exp = 750, id = 25, para2 = __rt_23, rewardIds = __rt_20}
, 
{exp = 750, id = 26, para2 = __rt_23, 
rewardNums = {100, 5, 3}
}
, 
{exp = 750, id = 27, para2 = __rt_25, rewardNums = __rt_24}
, 
{exp = 850, id = 28, para2 = __rt_25, rewardNums = __rt_24}
, 
{exp = 1000, id = 29, para2 = __rt_25, rewardIds = __rt_20, rewardNums = __rt_19}
, 
{exp = 0, id = 30, 
para2 = {5, 100}
, 
rewardNums = {500, 1, 5}
}
}
local __default_values = {exp = 500, icon = "icon_zs5", id = 1, logic = __rt_8, para1 = __rt_9, para2 = __rt_15, para3 = __rt_1, rewardIds = __rt_5, rewardNums = __rt_6}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(achievement_level) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, maxLevel = 30}
setmetatable(achievement_level, {__index = __rawdata})
return achievement_level

