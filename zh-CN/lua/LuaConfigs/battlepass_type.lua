local __rt_1 = {}
local battlepass_type = {
{activeItemId = 11, banner_skin = 300503, condition = 2, condition_para1 = 11, describe = 383940, describe2 = 27618, drop_group = "1001=10", hero_res = "BattlePassCroque", price_id = 1002, price_num = 80, supply_price = 100204, ultimate_price = 100203, weekly_exp = 1800}
, 
{color = __rt_1, id = 2, name = 521814, senior_price = 100202, senior_reward_id = 1000, senior_reward_num = 1280, ultimate_reward_ids = __rt_1, ultimate_reward_nums = __rt_1}
}
local __default_values = {activeItemId = 0, banner_skin = 0, 
color = {205, 233, 30}
, condition = 1, condition_para1 = 0, describe = "", describe2 = "", drop_group = "", hero_res = "", id = 1, name = 298575, price_id = 0, price_num = 0, senior_price = 100201, senior_reward_id = 0, senior_reward_num = 0, supply_price = 0, ultimate_price = 0, 
ultimate_reward_ids = {11, 400006, 5009}
, 
ultimate_reward_nums = {1000, 1, 4}
, weekly_exp = 0}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(battlepass_type) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(battlepass_type, {__index = __rawdata})
return battlepass_type

