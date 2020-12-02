-- params : ...
-- function num : 0 , upvalues : _ENV
local commander_skill_level = {
{exp = 100}
, 
{exp = 300, skill_level = 2}
, 
{exp = 600, skill_level = 3}
, 
{exp = 1000, skill_level = 4}
, 
{exp = 1400, skill_level = 5}
, 
{exp = 1600, skill_level = 6}
, 
{exp = 1800, skill_level = 7}
, 
{exp = 2000, skill_level = 8}
, 
{exp = 3000, skill_level = 9}
, 
{exp = 4000, skill_level = 10}
, 
{exp = 6000, skill_level = 11}
, 
{exp = 8000, skill_level = 12}
, 
{exp = 10000, skill_level = 13}
, 
{exp = 15000, skill_level = 14}
, 
{exp = 20000, skill_level = 15}
, 
{exp = 25000, skill_level = 16}
, 
{exp = 30000, skill_level = 17}
, 
{exp = 35000, skill_level = 18}
, 
{exp = 40000, skill_level = 19}
, 
{exp = 45000, skill_level = 20}
, 
{exp = 50000, skill_level = 21}
, 
{exp = 55000, skill_level = 22}
, 
{exp = 60000, skill_level = 23}
, 
{exp = 65000, skill_level = 24}
, 
{exp = 70000, skill_level = 25}
, 
{exp = 75000, skill_level = 26}
, 
{exp = 80000, skill_level = 27}
, 
{exp = 85000, skill_level = 28}
, 
{exp = 90000, skill_level = 29}
, 
{exp = 95000, skill_level = 30}
, 
{exp = 100000, skill_level = 31}
, 
{exp = 105000, skill_level = 32}
, 
{exp = 110000, skill_level = 33}
, 
{exp = 115000, skill_level = 34}
, 
{exp = 120000, skill_level = 35}
, 
{exp = 125000, skill_level = 36}
, 
{exp = 130000, skill_level = 37}
, 
{exp = 135000, skill_level = 38}
, 
{exp = 140000, skill_level = 39}
, 
{exp = 145000, skill_level = 40}
, 
{exp = 150000, skill_level = 41}
, 
{exp = 155000, skill_level = 42}
, 
{exp = 160000, skill_level = 43}
, 
{exp = 165000, skill_level = 44}
, 
{exp = 170000, skill_level = 45}
, 
{exp = 175000, skill_level = 46}
, 
{exp = 180000, skill_level = 47}
, 
{exp = 185000, skill_level = 48}
, 
{exp = 190000, skill_level = 49}
, 
{skill_level = 50}
}
local __default_values = {exp = 0, skill_level = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(commander_skill_level) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(commander_skill_level, {__index = __rawdata})
return commander_skill_level

