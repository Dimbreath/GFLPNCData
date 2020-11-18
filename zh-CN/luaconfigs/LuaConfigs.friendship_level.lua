-- params : ...
-- function num : 0 , upvalues : _ENV
local friendship_level = {
{friendship = 100}
, 
{friendship = 800, friendship_level = 2}
, 
{friendship = 2000, friendship_level = 3}
, 
{friendship = 5000, friendship_level = 4}
, 
{friendship = 10000, friendship_level = 5}
, 
{friendship = 20000, friendship_level = 6}
, 
{friendship = 32000, friendship_level = 7}
, 
{friendship = 45000, friendship_level = 8}
, 
{friendship = 60000, friendship_level = 9}
, 
{friendship_level = 10}
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

