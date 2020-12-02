-- params : ...
-- function num : 0 , upvalues : _ENV
local overload = {
{dps_up = 20, heal_down = 5, pop_up = true}
, 
{dps_up = 40, heal_down = 10, time = 2}
, 
{dps_up = 60, heal_down = 15, time = 3}
, 
{dps_up = 80, heal_down = 20, time = 4}
, 
{heal_down = 25, time = 5}
, 
{dps_up = 120, heal_down = 30, time = 6}
, 
{dps_up = 140, heal_down = 35, time = 7}
, 
{dps_up = 160, heal_down = 40, time = 8}
, 
{dps_up = 180, heal_down = 45, time = 9}
, 
{dps_up = 200, heal_down = 50, pop_up = true, time = 10}
, 
{dps_up = 220, heal_down = 55, time = 11}
, 
{dps_up = 240, heal_down = 60, time = 12}
, 
{dps_up = 260, heal_down = 65, time = 13}
, 
{dps_up = 280, heal_down = 70, time = 14}
, 
{dps_up = 300, heal_down = 75, time = 15}
, 
{dps_up = 320, heal_down = 80, time = 16}
, 
{dps_up = 340, heal_down = 85, time = 17}
, 
{dps_up = 360, heal_down = 90, time = 18}
, 
{dps_up = 380, heal_down = 95, time = 19}
, 
{dps_up = 400, pop_up = true, time = 20}
, 
{dps_up = 420, time = 21}
, 
{dps_up = 440, time = 22}
, 
{dps_up = 460, time = 23}
, 
{dps_up = 480, time = 24}
, 
{dps_up = 500, time = 25}
, 
{dps_up = 520, time = 26}
, 
{dps_up = 540, time = 27}
, 
{dps_up = 560, time = 28}
, 
{dps_up = 580, time = 29}
, 
{dps_up = 600, time = 30}
, 
{dps_up = 620, time = 31}
, 
{dps_up = 640, time = 32}
, 
{dps_up = 660, time = 33}
, 
{dps_up = 680, time = 34}
, 
{dps_up = 700, time = 35}
, 
{dps_up = 720, time = 36}
, 
{dps_up = 740, time = 37}
, 
{dps_up = 760, time = 38}
, 
{dps_up = 780, time = 39}
, 
{dps_up = 800, time = 40}
, 
{dps_up = 820, time = 41}
, 
{dps_up = 840, time = 42}
, 
{dps_up = 860, time = 43}
, 
{dps_up = 880, time = 44}
, 
{dps_up = 900, time = 45}
, 
{dps_up = 920, time = 46}
, 
{dps_up = 940, time = 47}
, 
{dps_up = 960, time = 48}
, 
{dps_up = 980, time = 49}
, 
{dps_up = 1000, time = 50}
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

