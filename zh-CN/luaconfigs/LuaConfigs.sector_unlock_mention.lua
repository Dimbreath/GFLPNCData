-- params : ...
-- function num : 0 , upvalues : _ENV
local sector_unlock_mention = {
[10] = {}
, 
[11] = {id = 11}
, 
[12] = {id = 12}
, 
[20] = {id = 20}
, 
[30] = {id = 30}
, 
[40] = {id = 40}
, 
[50] = {id = 50}
, 
[60] = {id = 60}
, 
[70] = {id = 70}
, 
[80] = {id = 80}
, 
[90] = {id = 90}
, 
[100] = {id = 100}
, 
[110] = {id = 110}
, 
[120] = {id = 120}
, 
[130] = {id = 130}
, 
[140] = {id = 140}
}
local __default_values = {id = 10}
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

