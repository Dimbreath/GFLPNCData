local dorm_interpoint = {
{interact_name = 43784}
, 
{exit_curve = 4, id = 2, interact_front = 1, interact_point_type = 2, move_curve = 2}
, 
{exit_curve = 1, id = 3, interact_name = 170787, interact_point_type = 3}
, 
{exit_curve = 4, id = 4, interact_front = 2, interact_point_type = 2, move_curve = 2}
, 
{id = 5, interact_front = 3, interact_name = 43784}
, 
{id = 6, interact_front = 1, interact_name = 43784}
, 
{exit_curve = 4, id = 7, interact_point_type = 2, move_curve = 2}
}
local __default_values = {exit_curve = 3, furniture_action = "", id = 1, interact_front = 0, interact_name = 266043, interact_point_type = 1, is_exclusive = true, move_curve = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(dorm_interpoint) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_interpoint, {__index = __rawdata})
return dorm_interpoint

