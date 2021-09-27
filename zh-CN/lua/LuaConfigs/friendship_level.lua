local friendship_level = {
{friendship = 30}
, 
{friendship = 100, friendship_level = 2}
, 
{friendship = 180, friendship_level = 3}
, 
{friendship = 290, friendship_level = 4}
, 
{friendship = 350, friendship_level = 5}
, 
{friendship = 470, friendship_level = 6}
, 
{friendship = 590, friendship_level = 7}
, 
{friendship = 700, friendship_level = 8}
, 
{friendship = 1060, friendship_level = 9}
, 
{friendship = 1250, friendship_level = 10}
, 
{friendship = 1650, friendship_level = 11}
, 
{friendship = 2000, friendship_level = 12}
, 
{friendship = 2300, friendship_level = 13}
, 
{friendship = 2600, friendship_level = 14}
, 
{friendship_level = 15}
}
local __default_values = {friendship = 0, friendship_level = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(friendship_level) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(friendship_level, {__index = __rawdata})
return friendship_level

