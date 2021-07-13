-- params : ...
-- function num : 0 , upvalues : _ENV
local overload = {
{dps_up = 25, heal_down = 5, pop_up = true}
, 
{dps_up = 25, time = 2}
, 
{dps_up = 25, heal_down = 15, time = 3}
, 
{dps_up = 25, heal_down = 20, time = 4}
, 
{dps_up = 25, heal_down = 25, time = 5}
, 
{dps_up = 50, heal_down = 30, time = 6}
, 
{dps_up = 50, heal_down = 35, time = 7}
, 
{dps_up = 50, heal_down = 40, time = 8}
, 
{dps_up = 50, heal_down = 45, time = 9}
, 
{dps_up = 50, heal_down = 50, pop_up = true, time = 10}
, 
{dps_up = 75, heal_down = 55, time = 11}
, 
{dps_up = 75, heal_down = 60, time = 12}
, 
{dps_up = 75, heal_down = 65, time = 13}
, 
{dps_up = 75, heal_down = 70, time = 14}
, 
{dps_up = 75, heal_down = 75, time = 15}
, 
{heal_down = 80, time = 16}
, 
{heal_down = 85, time = 17}
, 
{heal_down = 90, time = 18}
, 
{heal_down = 95, time = 19}
, 
{heal_down = 100, pop_up = true, time = 20}
}
local __default_values = {dps_up = 100, heal_down = 10, pop_up = false, time = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(overload) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(overload, {__index = __rawdata})
return overload

