-- params : ...
-- function num : 0 , upvalues : _ENV
local dorm_interpoint = {
{}
, 
{id = 2, interact_point_type = 2}
, 
{id = 3, interact_point_type = 3}
}
local __default_values = {furniture_action = "", id = 1, interact_front = 0, interact_height = 0.3, interact_point_type = 1, is_exclusive = true}
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

