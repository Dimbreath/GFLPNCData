-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {12}
local __rt_3 = {-1}
local __rt_4 = {0, 0, 0, 1, 1, 1, 0, 0, 0}
local lottery_para = {
{line = 2}
, 
{bg_path = "Lottery_Main_2", costId1 = 3005, costId2 = 3005, line = 3, lottery_id = 2, name = 385856, name_path = "Lottery_Enter_2", pool_type = 0, 
up_hero1_para = {0, 100, 0, 1, 0.5, 1, 0, 100, 0}
, up_reward1 = 1003, up_reward2 = 1004}
, 
{bg_path = "Lottery_Main_3", lottery_id = 3, name = 154151, name_path = "Lottery_Enter_3", 
pre_para1 = {1612684800}
, 
pre_para2 = {1613289600}
, up_reward1 = 1026, up_reward2 = 1022}
}
local __default_values = {bg1_path = "Lottery_Sub_0_Test", bg_path = "Lottery_Main_1", bg_type = 1, cd = 0, costId1 = 3001, costId2 = 3001, costNum1 = 1, costNum2 = 10, des = "", heroUpAllDic = __rt_1, intro_path = "Lottery_Tile_0_Test", line = 1, lottery_id = 1, name = 109204, name_path = "Lottery_Enter_1", pool_type = 1, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_3, prob = __rt_1, prob_in = __rt_1, prob_item = 0, prob_up = __rt_1, up_hero1_para = __rt_4, up_hero2_para = __rt_4, up_reward1 = 1001, up_reward2 = 1002}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(lottery_para) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
costId_dic = {3001, 3005, 3001}
}
setmetatable(lottery_para, {__index = __rawdata})
return lottery_para

