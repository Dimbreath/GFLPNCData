-- params : ...
-- function num : 0 , upvalues : _ENV
local dorm_action = {
[1001] = {action_name = "Dorm_Stand", type = 0}
, 
[1002] = {action_name = "Dorm_Sit", id = 1002, interact_point_type = 1}
, 
[1003] = {id = 1003, interact_point_type = 2}
, 
[1004] = {action_name = "Dorm_Walk1", id = 1004, interact_point_type = 3, type = 3}
, 
[1005] = {action_name = "Dorm_Walk2", id = 1005, type = 2}
}
local __default_values = {action_name = "Dorm_Lie", id = 1001, interact_point_type = 0, trans_time = 0.25, type = 1}
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

-- params : ...
-- function num : 0 , upvalues : _ENV
local dorm_action = {
    [1001] = {action_name = "Dorm_Stand", type = 0},
    [1002] = {action_name = "Dorm_Sit", id = 1002, interact_point_type = 1},
    [1003] = {id = 1003, interact_point_type = 2},
    [1004] = {
        action_name = "Dorm_Walk1",
        id = 1004,
        interact_point_type = 3,
        type = 3
    },
    [1005] = {action_name = "Dorm_Walk2", id = 1005, type = 2}
}
local __default_values = {
    action_name = "Dorm_Lie",
    id = 1001,
    interact_point_type = 0,
    trans_time = 0.25,
    type = 1
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(dorm_action) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_action, {__index = __rawdata})
return dorm_action

