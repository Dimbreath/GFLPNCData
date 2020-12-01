-- params : ...
-- function num : 0 , upvalues : _ENV
local friendship_level = {
{friendship = 30}
, 
{friendship = 100, friendship_level = 2}
, 
{friendship = 140, friendship_level = 3}
, 
{friendship = 230, friendship_level = 4}
, 
{friendship = 280, friendship_level = 5}
, 
{friendship = 390, friendship_level = 6}
, 
{friendship = 500, friendship_level = 7}
, 
{friendship = 600, friendship_level = 8}
, 
{friendship = 950, friendship_level = 9}
, 
{friendship = 1350, friendship_level = 10}
, 
{friendship = 1750, friendship_level = 11}
, 
{friendship = 2100, friendship_level = 12}
, 
{friendship = 2400, friendship_level = 13}
, 
{friendship = 2750, friendship_level = 14}
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

-- params : ...
-- function num : 0 , upvalues : _ENV
local friendship_level = {
    {friendship = 30}, {friendship = 100, friendship_level = 2},
    {friendship = 140, friendship_level = 3},
    {friendship = 230, friendship_level = 4},
    {friendship = 280, friendship_level = 5},
    {friendship = 390, friendship_level = 6},
    {friendship = 500, friendship_level = 7},
    {friendship = 600, friendship_level = 8},
    {friendship = 950, friendship_level = 9},
    {friendship = 1350, friendship_level = 10},
    {friendship = 1750, friendship_level = 11},
    {friendship = 2100, friendship_level = 12},
    {friendship = 2400, friendship_level = 13},
    {friendship = 2750, friendship_level = 14}, {friendship_level = 15}
}
local __default_values = {friendship = 0, friendship_level = 1}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(friendship_level) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(friendship_level, {__index = __rawdata})
return friendship_level

