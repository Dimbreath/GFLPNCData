-- params : ...
-- function num : 0 , upvalues : _ENV
local event_assist = {
{describe = 257043, icon = "event_icon_all"}
, 
{describe = 257043, icon = "event_icon_all", id = 2}
, 
{describe = 257043, icon = "event_icon_all", id = 3}
, 
{describe = 252440, icon = "event_icon_all", id = 4}
, 
{describe = 252440, icon = "event_icon_all", id = 5}
, 
{describe = 252440, icon = "event_icon_all", id = 6}
, 
{describe = 252440, icon = "event_icon_all", id = 7}
, 
{describe = 252440, id = 8}
, 
{id = 9}
, 
{id = 10}
, 
{id = 11}
, 
{id = 12}
, 
{id = 13}
, 
{id = 14}
, 
{id = 15}
, 
{id = 16}
, 
{id = 17}
, 
{id = 18}
, 
{id = 19}
, 
{id = 20}
, 
{id = 21}
, 
{id = 22}
, 
{id = 23}
, 
{id = 24}
, 
{id = 25}
, 
{id = 26}
}
local __default_values = {choice_color = false, describe = 204406, icon = "event_icon_help", id = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(event_assist) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(event_assist, {__index = __rawdata})
return event_assist

