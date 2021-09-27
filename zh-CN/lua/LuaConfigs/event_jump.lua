local __rt_1 = {}
local event_jump = {
{describe = 300225, icon = "event_icon_func"}
, 
{describe = 140821, icon = "event_icon_func", id = 2}
, 
{describe = 498804, icon = "event_icon_func", id = 3}
, 
{
choiceGetNew = {dataID = 10161, dataNum = 1}
, describe = 105454, icon = "event_icon_func", id = 4}
, 
{
choiceGetNew = {dataID = 10217, dataNum = 1}
, describe = 102790, id = 5}
, 
{describe = 507034, icon = "event_icon_func", id = 6}
, 
{auto_priority = 10, describe = 260867, icon = "event_icon_func", id = 7}
, 
{describe = 387471, icon = "event_icon_func", id = 8}
, 
{
choiceGetNew = {dataID = 10216, dataNum = 1}
, describe = 338657, id = 9}
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
}
local __default_values = {auto_choice_arg = __rt_1, auto_choice_type = 0, auto_priority = 100, choiceGetNew = __rt_1, choice_color = false, describe = 312144, icon = "event_icon_battle", id = 1, jump = true}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(event_jump) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(event_jump, {__index = __rawdata})
return event_jump

