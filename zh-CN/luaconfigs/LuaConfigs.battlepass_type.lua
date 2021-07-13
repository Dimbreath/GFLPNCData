-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {12}
local __rt_2 = {-1}
local battlepass_type = {
{activeItemId = 11, banner_skin = 301101, condition = 2, condition_para1 = 11, describe = 42274, limit_reward_id = 1001, limit_reward_num = 10, price_id = 1001, price_num = 100, ultimate_price = 100203, ultimate_reward_id = 11, ultimate_reward_num = 1500}
, 
{id = 2, name = 521814, senior_price = 100202, senior_reward_id = 1000, senior_reward_num = 1280}
}
local __default_values = {activeItemId = 0, banner_skin = 0, condition = 1, condition_para1 = 0, describe = "", id = 1, limit_reward_id = 0, limit_reward_num = 0, name = 298575, pre_condition = __rt_1, pre_para1 = __rt_2, pre_para2 = __rt_2, price_id = 0, price_num = 0, senior_price = 100201, senior_reward_id = 0, senior_reward_num = 0, ultimate_price = 0, ultimate_reward_id = 0, ultimate_reward_num = 0}
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

