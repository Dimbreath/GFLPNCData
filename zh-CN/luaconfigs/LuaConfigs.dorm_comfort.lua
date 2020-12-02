-- params : ...
-- function num : 0 , upvalues : _ENV
local dorm_comfort = {
{}
, 
{comfort = 200, level = 2}
, 
{comfort = 560, level = 3}
, 
{comfort = 1090, level = 4}
, 
{comfort = 1800, level = 5}
, 
{comfort = 2700, level = 6}
, 
{comfort = 3800, level = 7}
, 
{comfort = 5110, level = 8}
, 
{comfort = 6640, level = 9}
, 
{comfort = 8400, level = 10}
, 
{comfort = 10400, level = 11}
, 
{comfort = 12650, level = 12}
, 
{comfort = 14900, level = 13}
, 
{comfort = 17150, level = 14}
, 
{comfort = 19400, level = 15}
, 
{comfort = 21650, level = 16}
, 
{comfort = 23900, level = 17}
, 
{comfort = 26150, level = 18}
, 
{comfort = 28400, level = 19}
, 
{comfort = 30650, level = 20}
, 
{comfort = 32900, level = 21}
, 
{comfort = 35150, level = 22}
, 
{comfort = 37400, level = 23}
, 
{comfort = 39650, level = 24}
, 
{comfort = 41900, level = 25}
, 
{comfort = 44150, level = 26}
, 
{comfort = 46400, level = 27}
, 
{comfort = 48650, level = 28}
, 
{comfort = 50900, level = 29}
, 
{comfort = 53150, level = 30}
, 
{comfort = 55400, level = 31}
}
local __default_values = {comfort = 0, level = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(dorm_comfort) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
level_sort = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31}
, max_level = 31}
setmetatable(dorm_comfort, {__index = __rawdata})
return dorm_comfort

