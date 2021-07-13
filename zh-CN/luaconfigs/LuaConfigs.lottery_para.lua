-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {true, true, true}
local __rt_2 = {}
local __rt_3 = {0, 658, 0, 150, 0, 30}
local __rt_4 = {0, 0, 0, 1, 1, 1, 0, 0, 0}
local __rt_5 = {true, true}
local __rt_6 = {0, 0, 0, 0, 0, 2667}
local __rt_7 = {0, 0, 0, 0, 0, 80}
local __rt_8 = {200}
local lottery_para = {
{costId3 = 1001, costNum3 = 66, des = 510458, line = 5, nav_tag = 0, nav_tagIcon = 0, nav_tagName = "", sp_time_show = 436816, up_reward1 = 1001, up_reward2 = 1002}
, 
{bg_path = "Lottery_Main_2", costId1 = 3005, costId2 = 3005, des = 445803, drawTypeDic = __rt_5, intro_des = 98478, line = 6, lottery_id = 2, name = 385856, name_path = "Lottery_Enter_2", nav_tag = 0, nav_tagIcon = 0, nav_tagName = "", pool_type = 0, 
prob = {0, 92, 0, 5, 0, 2}
, prob_item = 9700, 
up_hero1_para = {0, 100, 0, 1, 0.5, 1, 0, 100, 0}
, up_reward1 = 1003, up_reward2 = 1004}
, 
{bg_path = "Lottery_Main_3", costId1 = 1002, costId2 = 1002, costNum1 = 128, costNum2 = 1280, count_limit = 20, drawTypeDic = __rt_5, intro_des = 433793, lottery_id = 3, name = 67495, name_path = "Lottery_Enter_3", nav_tag = 99, nav_tagIcon = 2, nav_tagName = 19924, 
prob = {0, 658, 0, 150, 0, 75}
}
, 
{bg_path = "Lottery_Main_4", costId3 = 1001, costNum3 = 66, des = 79058, 
heroUpAllDic = {[1037] = true}
, intro_des = 462387, is_pt = true, line = 4, lottery_id = 4, name = 433786, name_path = "Lottery_Enter_4", 
prob = {0, 658, 0, 150, 0, 24}
, prob_in = __rt_6, prob_up = __rt_7, 
pt_first_reward = {[2537] = 30}
, pt_mark = 2037, pt_rewardCostNumList = __rt_8, 
pt_rewardItemIdList = {2037}
, sp_time_show = 436816}
, 
{bg_path = "Lottery_Main_5", costId1 = 1001, costId2 = 1001, costNum1 = 2000, costNum2 = 2000, count_limit = 10, des = 141020, 
drawTypeDic = {[2] = true}
, intro_des = 381301, line = 2, lottery_id = 5, name = 477438, name_path = "Lottery_Enter_5"}
, 
{bg_path = "Lottery_Main_6", costId3 = 1001, costNum3 = 66, des = 13350, 
heroUpAllDic = {[1028] = true}
, intro_des = 66945, is_pt = true, line = 3, lottery_id = 6, name = 122285, name_path = "Lottery_Enter_6", 
prob = {0, 658, 0, 150, 0, 22}
, prob_in = __rt_6, prob_up = __rt_7, 
pt_first_reward = {[2528] = 30}
, pt_mark = 2028, pt_rewardCostNumList = __rt_8, 
pt_rewardItemIdList = {2028}
, sp_time_show = 436816}
}
local __default_values = {bg1_path = "", bg_path = "Lottery_Main_1", bg_type = 1, cd = 0, costId1 = 3001, costId2 = 3001, costId3 = 0, costNum1 = 1, costNum2 = 10, costNum3 = 0, count_limit = 0, des = 118035, drawTypeDic = __rt_1, heroUpAllDic = __rt_2, intro_des = 214481, intro_path = "", is_pt = false, line = 1, lottery_id = 1, name = 109204, name_path = "Lottery_Enter_1", nav_tag = 1, nav_tagIcon = 1, nav_tagName = 8625, pool_type = 1, prob = __rt_3, prob_in = __rt_2, prob_item = 0, prob_up = __rt_2, pt_first_reward = __rt_2, pt_mark = 0, pt_rewardCostNumList = __rt_2, pt_rewardItemIdList = __rt_2, sp_time_show = "", up_hero1_para = __rt_4, up_hero2_para = __rt_4, up_reward1 = 1026, up_reward2 = 1022}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(lottery_para) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
costId_dic = {3001, 3005, 1002, 3001, 1001, 3001}
}
setmetatable(lottery_para, {__index = __rawdata})
return lottery_para

