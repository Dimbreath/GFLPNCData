local activity_name = {
{icon = "ICON_activity_1001", name = 298575}
, 
{icon = "ICON_activity_2001", name = 487929, name_id = 2}
, 
{icon = "ICON_activity_1002", name = 521814, name_id = 3}
, 
{name = 450158, name_id = 4}
, 
{icon = "ICON_activity_6001", name = 25793, name_id = 5}
, 
{name_id = 6}
, 
{icon = "", name = 44806, name_id = 7}
; 
[999999] = {icon = "ICON_activity_sign", name = 472901, name_id = 999999}
}
local __default_values = {icon = "ICON_activity_4001", name = 162033, name_id = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(activity_name) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_name, {__index = __rawdata})
return activity_name

