-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {0, 0, 0}
local hero_level = {
{exp = 150}
, 
{exp = 170, level = 2, level_growth = 500}
, 
{exp = 190, level = 3, level_growth = 1000}
, 
{exp = 270, level = 4, level_growth = 1500}
, 
{exp = 290, level = 5, level_growth = 2000}
, 
{exp = 310, level = 6, level_growth = 2500}
, 
{exp = 400, level = 7, level_growth = 3000}
, 
{exp = 480, level = 8, level_growth = 3500}
, 
{exp = 630, level = 9, level_growth = 4000}
, 
{exp = 1160, level = 10, level_growth = 4500}
, 
{exp = 1210, level = 11, level_growth = 5000}
, 
{exp = 1490, level = 12, level_growth = 5500}
, 
{exp = 1630, level = 13, level_growth = 6000}
, 
{exp = 1760, level = 14, level_growth = 6500}
, 
{exp = 2370, level = 15, level_growth = 7000}
, 
{exp = 2600, level = 16, level_growth = 7500}
, 
{exp = 2900, level = 17, level_growth = 8000}
, 
{exp = 3200, level = 18, level_growth = 8500}
, 
{exp = 3500, level = 19, level_growth = 9000}
, 
{exp = 4300, level = 20, level_growth = 9500}
, 
{exp = 5100, level = 21, level_growth = 10000}
, 
{exp = 5900, level = 22, level_growth = 10550}
, 
{exp = 6700, level = 23, level_growth = 11150}
, 
{exp = 8800, level = 24, level_growth = 11800}
, 
{exp = 9700, level = 25, level_growth = 12500}
, 
{exp = 10000, level = 26, level_growth = 13250}
, 
{exp = 11000, level = 27, level_growth = 14050}
, 
{exp = 13000, level = 28, level_growth = 14900}
, 
{exp = 14000, level = 29, level_growth = 15800}
, 
{exp = 15000, level = 30, level_growth = 16760}
, 
{exp = 16000, level = 31, level_growth = 17780}
, 
{exp = 17000, level = 32, level_growth = 18870}
, 
{exp = 18000, level = 33, level_growth = 20030}
, 
{exp = 19000, level = 34, level_growth = 21260}
, 
{exp = 20000, level = 35, level_growth = 22570}
, 
{exp = 21000, level = 36, level_growth = 23960}
, 
{exp = 22000, level = 37, level_growth = 25430}
, 
{exp = 23000, level = 38, level_growth = 26980}
, 
{exp = 24000, level = 39, level_growth = 28620}
, 
{exp = 25000, level = 40, level_growth = 30350}
, 
{exp = 26000, level = 41, level_growth = 32170}
, 
{exp = 27000, level = 42, level_growth = 34080}
, 
{exp = 28000, level = 43, level_growth = 36090}
, 
{exp = 29000, level = 44, level_growth = 38200}
, 
{exp = 30000, level = 45, level_growth = 40410}
, 
{level = 46, level_growth = 42720}
, 
{level = 47, level_growth = 45130}
, 
{exp = 34000, level = 48, level_growth = 47640}
, 
{exp = 35000, level = 49, level_growth = 50250}
, 
{exp = 36000, level = 50, level_growth = 52960}
, 
{exp = 37000, level = 51, level_growth = 55770}
, 
{exp = 38000, level = 52, level_growth = 58680}
, 
{exp = 39000, level = 53, level_growth = 61690}
, 
{exp = 44000, level = 54, level_growth = 64800}
, 
{exp = 45000, level = 55, level_growth = 68010}
, 
{exp = 46000, level = 56, level_growth = 71320}
, 
{exp = 47000, level = 57, level_growth = 74730}
, 
{exp = 49000, level = 58, level_growth = 78240}
, 
{exp = 50000, level = 59, level_growth = 81850}
, 
{exp = 60000, level = 60, level_growth = 85560}
}
local __default_values = {algorithm_space = __rt_1, exp = 32000, level = 1, level_growth = 0}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(hero_level) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(hero_level, {__index = __rawdata})
return hero_level

