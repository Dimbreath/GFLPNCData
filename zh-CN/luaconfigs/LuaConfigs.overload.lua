-- params : ...
-- function num : 0 , upvalues : _ENV
local overload = {
{dps_up = 50, heal_down = 5, pop_up = true}
, 
{dps_up = 50, heal_down = 10, time = 2}
, 
{dps_up = 50, heal_down = 15, time = 3}
, 
{dps_up = 50, heal_down = 20, time = 4}
, 
{dps_up = 50, heal_down = 25, time = 5}
, 
{heal_down = 30, time = 6}
, 
{heal_down = 35, time = 7}
, 
{heal_down = 40, time = 8}
, 
{heal_down = 45, time = 9}
, 
{heal_down = 50, pop_up = true, time = 10}
, 
{dps_up = 150, heal_down = 55, time = 11}
, 
{dps_up = 150, heal_down = 60, time = 12}
, 
{dps_up = 150, heal_down = 65, time = 13}
, 
{dps_up = 150, heal_down = 70, time = 14}
, 
{dps_up = 150, heal_down = 75, time = 15}
, 
{dps_up = 200, heal_down = 80, time = 16}
, 
{dps_up = 200, heal_down = 85, time = 17}
, 
{dps_up = 200, heal_down = 90, time = 18}
, 
{dps_up = 200, heal_down = 95, time = 19}
, 
{dps_up = 200, pop_up = true, time = 20}
, 
{dps_up = 250, time = 21}
, 
{dps_up = 250, time = 22}
, 
{dps_up = 250, time = 23}
, 
{dps_up = 250, time = 24}
, 
{dps_up = 250, time = 25}
, 
{dps_up = 300, time = 26}
, 
{dps_up = 300, time = 27}
, 
{dps_up = 300, time = 28}
, 
{dps_up = 300, time = 29}
, 
{dps_up = 300, time = 30}
, 
{dps_up = 350, time = 31}
, 
{dps_up = 350, time = 32}
, 
{dps_up = 350, time = 33}
, 
{dps_up = 350, time = 34}
, 
{dps_up = 350, time = 35}
, 
{dps_up = 400, time = 36}
, 
{dps_up = 400, time = 37}
, 
{dps_up = 400, time = 38}
, 
{dps_up = 400, time = 39}
, 
{dps_up = 400, time = 40}
, 
{dps_up = 450, time = 41}
, 
{dps_up = 450, time = 42}
, 
{dps_up = 450, time = 43}
, 
{dps_up = 450, time = 44}
, 
{dps_up = 450, time = 45}
, 
{dps_up = 500, time = 46}
, 
{dps_up = 500, time = 47}
, 
{dps_up = 500, time = 48}
, 
{dps_up = 500, time = 49}
, 
{dps_up = 500, time = 50}
}
local __default_values = {dps_up = 100, heal_down = 100, pop_up = false, time = 1}
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

