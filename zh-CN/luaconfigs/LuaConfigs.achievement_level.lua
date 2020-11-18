-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {1001, 1003}
local __rt_3 = {10, 1000}
local achievement_level = {
{icon = "icon_qingtong1", rewardIds = __rt_1, rewardNums = __rt_1, stamina = 5}
, 
{battle_exp = 20, icon = "icon_qingtong2", id = 2, resource = 20, stamina = 6}
, 
{battle_exp = 30, icon = "icon_qingtong3", id = 3, resource = 30, stamina = 7}
, 
{battle_exp = 40, icon = "icon_qingtong4", id = 4, resource = 40, stamina = 8}
, 
{battle_exp = 50, icon = "icon_qingtong5", id = 5, resource = 50, stamina = 9}
, 
{battle_exp = 60, icon = "icon_hj1", id = 6, resource = 60}
, 
{battle_exp = 70, icon = "icon_hj2", id = 7, resource = 70, stamina = 11}
, 
{battle_exp = 80, icon = "icon_hj3", id = 8, resource = 80, stamina = 12}
, 
{battle_exp = 90, icon = "icon_hj4", id = 9, resource = 90, stamina = 13}
, 
{battle_exp = 100, icon = "icon_hj5", id = 10, resource = 100, stamina = 14}
, 
{battle_exp = 110, id = 11, resource = 110, stamina = 15}
, 
{battle_exp = 120, icon = "icon_bj2", id = 12, resource = 120, stamina = 16}
, 
{battle_exp = 130, icon = "icon_bj3", id = 13, resource = 130, stamina = 17}
, 
{battle_exp = 140, icon = "icon_bj4", id = 14, resource = 140, stamina = 18}
, 
{battle_exp = 150, icon = "icon_bj5", id = 15, resource = 150, stamina = 19}
, 
{battle_exp = 160, icon = "icon_zs1", id = 16, resource = 160, stamina = 20}
, 
{battle_exp = 170, icon = "icon_zs2", id = 17, resource = 170, stamina = 21}
, 
{battle_exp = 180, icon = "icon_zs3", id = 18, resource = 180, stamina = 22}
, 
{battle_exp = 190, icon = "icon_zs4", id = 19, resource = 190, stamina = 23}
, 
{battle_exp = 200, exp = 0, icon = "icon_zs5", id = 20, resource = 200, stamina = 24}
}
local __default_values = {battle_exp = 10, exp = 300, icon = "icon_bj1", id = 1, logic = __rt_1, para1 = __rt_1, para2 = __rt_1, para3 = __rt_1, resource = 10, rewardIds = __rt_2, rewardNums = __rt_3, stamina = 10}
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

