local sector_unlock_mention = {
[10] = {focus_priority = 2}
, 
[11] = {focus_priority = 3, id = 11}
, 
[12] = {focus_priority = 4, id = 12}
, 
[20] = {focus_priority = 5, id = 20}
, 
[22] = {focus_priority = 6, id = 22}
, 
[23] = {focus_priority = 7, id = 23}
, 
[30] = {focus_priority = 8, id = 30}
, 
[40] = {focus_priority = 9, id = 40}
, 
[50] = {focus_priority = 10, id = 50}
, 
[60] = {focus_priority = 11, id = 60}
, 
[70] = {focus_priority = 12, id = 70}
, 
[80] = {focus_priority = 13, id = 80}
, 
[90] = {focus_priority = 14, id = 90}
, 
[100] = {focus_priority = 15, id = 100}
, 
[110] = {focus_priority = 16, id = 110}
, 
[120] = {focus_priority = 17, id = 120}
, 
[130] = {focus_priority = 18, id = 130}
, 
[140] = {focus_priority = 19, id = 140}
, 
[1000] = {id = 1000}
}
local __default_values = {focus_priority = 1, id = 10}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(sector_unlock_mention) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(sector_unlock_mention, {__index = __rawdata})
return sector_unlock_mention

