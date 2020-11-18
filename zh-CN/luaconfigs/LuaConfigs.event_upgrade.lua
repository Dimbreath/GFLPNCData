-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {0, 30, 60, 80, 100}
local __rt_2 = {1, 2, 3, 4, -1}
local event_upgrade = {
{}
, 
{id = 2, 
prices = {0}
, 
refresh_times = {1}
}
, 
{id = 3}
}
local __default_values = {choice_color = false, currency = 1, describe = 50442, icon = "event_icon_func", id = 1, prices = __rt_1, refresh_times = __rt_2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(event_upgrade) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(event_upgrade, {__index = __rawdata})
return event_upgrade

