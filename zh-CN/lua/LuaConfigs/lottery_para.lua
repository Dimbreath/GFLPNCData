local __rt_1 = {1006, 5, 60, 300}
local __rt_2 = {true, true, true}
local __rt_3 = {}
local __rt_4 = {0, 653, 0, 129, 0, 40}
local __rt_5 = {0, 0, 0, 1, 1, 1, 0, 0, 0}
local __rt_6 = {-263, -74.13, -352, -126.3}
local __rt_7 = {0, 653, 0, 129, 0, 38}
local __rt_8 = {0, 0, 0, 0, 0, 2667}
local __rt_9 = {0, 0, 0, 0, 0, 100}
local __rt_10 = {180}
local lottery_para = {
{costId3 = 1001, costNum3 = 50, des1 = 74089, des2 = 364988, guaranteeNums = 60, guaranteeType = 1, intro_des = 186139, line = 5, nav_tag = 0, nav_tagIcon = 0, nav_tagName = "", prob = __rt_4, sp_time_show = 436816, title1 = 372027, up_reward1 = 1001, up_reward2 = 1002}
, 
{bg_path = "Lottery_Main_2", costId1 = 3005, costId2 = 3005, des1 = 497831, des2 = 170536, des3 = 294079, 
drawTypeDic = {true, true}
, intro_des = 98478, line = 6, lottery_id = 2, name = 385856, name_path = "Lottery_Enter_2", nav_tag = 0, nav_tagIcon = 0, nav_tagName = "", pool_client_type = 0, pool_type = 0, 
prob = {0, 92, 0, 5, 0, 2}
, prob_item = 9700, title1 = 307839, title3 = 480798, 
up_hero1_para = {0, 100, 0, 1, 0.5, 1, 0, 100, 0}
, up_reward1 = 1003, up_reward2 = 1004}
; 
[4] = {bg_path = "Lottery_Main_4", costId3 = 1001, costNum3 = 50, des1 = 437498, des3 = 360232, guaranteeNums = 60, guaranteeType = 1, 
heroUpAllDic = {[1037] = true}
, hero_up_para = __rt_6, intro_des = 315537, is_pt = true, line = 4, lottery_id = 4, name = 433786, name_path = "Lottery_Enter_4", prob_in = __rt_8, prob_up = __rt_9, 
pt_first_reward = {[2537] = 30}
, pt_mark = 2037, pt_rewardCostNumList = __rt_10, 
pt_rewardItemIdList = {2037}
, sp_time_show = 436816, title3 = 323871}
, 
[5] = {bg_path = "Lottery_Main_5", costId1 = 1001, costId2 = 1001, costNum1 = 1500, costNum2 = 1500, count_limit = 10, des1 = 449760, des2 = 231342, 
drawTypeDic = {[2] = true}
, intro_des = 381301, is_prompt = true, lottery_id = 5, name = 477438, name_path = "Lottery_Enter_5", prob = __rt_4, title1 = 463393}
, 
[6] = {bg_path = "Lottery_Main_6", costId3 = 1001, costNum3 = 50, des1 = 426629, des3 = 360232, guaranteeNums = 60, guaranteeType = 1, 
heroUpAllDic = {[1022] = true}
, hero_up_para = __rt_6, intro_des = 268855, is_pt = true, line = 3, lottery_id = 6, name = 388618, name_path = "Lottery_Enter_6", prob_in = __rt_8, prob_up = __rt_9, 
pt_first_reward = {[2522] = 30}
, pt_mark = 2022, pt_rewardCostNumList = __rt_10, 
pt_rewardItemIdList = {2022}
, sp_time_show = 436816, title3 = 323871}
, 
[7] = {bg_path = "Lottery_Main_3", change_rule = __rt_3, costId1 = 0, costId2 = 0, costId4 = 1002, costNum1 = 0, costNum2 = 0, costNum4 = 980, count_limit = 1, des2 = "", 
drawTypeDic = {[4] = true}
, line = 2, lottery_id = 7, name = 228869, name_path = "Lottery_Enter_3", nav_tag = 99, nav_tagIcon = 2, nav_tagName = 19924, pool_type = 2, prob = __rt_3, title1 = "", title2 = "", up_reward1 = 0, up_reward2 = 0}
}
local __default_values = {bg1_path = "", bg_path = "Lottery_Main_1", bg_type = 1, cd = 0, change_rule = __rt_1, costId1 = 3001, costId2 = 3001, costId3 = 0, costNum1 = 1, costNum2 = 10, costNum3 = 0, count_limit = 0, des1 = "", des2 = 151999, des3 = "", drawTypeDic = __rt_2, guaranteeNums = 0, guaranteeType = 0, heroUpAllDic = __rt_3, hero_up_para = __rt_3, intro_des = "", intro_path = "", is_prompt = false, is_pt = false, line = 1, lottery_id = 1, name = 109204, name_path = "Lottery_Enter_1", nav_tag = 1, nav_tagIcon = 1, nav_tagName = 8625, pool_client_type = 1, pool_type = 1, prob = __rt_7, prob_in = __rt_3, prob_item = 0, prob_up = __rt_3, pt_first_reward = __rt_3, pt_mark = 0, pt_rewardCostNumList = __rt_3, pt_rewardItemIdList = __rt_3, sp_time_show = "", title1 = 53316, title2 = 272622, title3 = "", up_hero1_para = __rt_5, up_hero2_para = __rt_5, up_reward1 = 1026, up_reward2 = 1022}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(lottery_para) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
costId_dic = {3001, 3005, 3001, 1001, 3001}
, 
special_dic = {60}
}
setmetatable(lottery_para, {__index = __rawdata})
return lottery_para

