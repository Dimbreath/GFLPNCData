local dorm_action = {
[1001] = {type = 0}
, 
[1002] = {action_name = "Dorm_Sit", exit_trigger = "DormExitSit", final_action = "Dorm_Sit_Loop", id = 1002, interact_action_type = 5, interact_point_type = 1}
, 
[1003] = {action_name = "Dorm_Lie_Start", exit_trigger = "DormExitLie", final_action = "Dorm_Lie_Loop", id = 1003, interact_action_type = 15, interact_point_type = 2}
, 
[1004] = {id = 1004, interact_point_type = 3, type = 3}
, 
[1005] = {action_name = "StandWalk2", id = 1005, type = 2}
}
local __default_values = {action_name = "StandWalk", exit_trigger = "", final_action = "", id = 1001, interact_action_type = 0, interact_point_type = 0, trans_time = 0.25, type = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(dorm_action) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_action, {__index = __rawdata})
return dorm_action

