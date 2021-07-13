-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {0, 0, 0}
local hero_level = {
{exp = 860}
, 
{exp = 880, level = 2, level_growth = 540}
, 
{exp = 970, level = 3, level_growth = 1100}
, 
{exp = 1000, level = 4, level_growth = 1670}
, 
{exp = 1090, level = 5, level_growth = 2250}
, 
{exp = 1110, level = 6, level_growth = 2840}
, 
{exp = 1210, level = 7, level_growth = 3450}
, 
{exp = 1230, level = 8, level_growth = 4080}
, 
{exp = 1320, level = 9, level_growth = 4740}
, 
{exp = 2140, level = 10, level_growth = 5410}
, 
{exp = 2280, level = 11, level_growth = 6410}
, 
{exp = 2430, level = 12, level_growth = 7170}
, 
{exp = 2590, level = 13, level_growth = 7950}
, 
{exp = 3400, level = 14, level_growth = 8750}
, 
{exp = 3590, level = 15, level_growth = 9580}
, 
{exp = 3740, level = 16, level_growth = 10430}
, 
{exp = 3870, level = 17, level_growth = 11310}
, 
{exp = 4640, level = 18, level_growth = 12230}
, 
{exp = 5280, level = 19, level_growth = 13180}
, 
{exp = 6960, level = 20, level_growth = 14850}
, 
{exp = 7990, level = 21, level_growth = 15910}
, 
{exp = 8900, level = 22, level_growth = 17030}
, 
{exp = 10000, level = 23, level_growth = 18200}
, 
{exp = 12900, level = 24, level_growth = 19410}
, 
{level = 25, level_growth = 20680}
, 
{level = 26, level_growth = 21980}
, 
{exp = 15400, level = 27, level_growth = 23340}
, 
{exp = 19300, level = 28, level_growth = 24750}
, 
{exp = 21900, level = 29, level_growth = 26200}
, 
{exp = 24500, level = 30, level_growth = 28960}
, 
{exp = 24500, level = 31, level_growth = 30600}
, 
{exp = 25800, level = 32, level_growth = 32290}
, 
{exp = 28300, level = 33, level_growth = 34050}
, 
{exp = 29600, level = 34, level_growth = 35880}
, 
{exp = 30900, level = 35, level_growth = 37760}
, 
{exp = 32200, level = 36, level_growth = 39700}
, 
{exp = 34800, level = 37, level_growth = 41720}
, 
{exp = 36100, level = 38, level_growth = 43790}
, 
{exp = 37400, level = 39, level_growth = 45930}
, 
{exp = 38700, level = 40, level_growth = 48120}
, 
{exp = 41200, level = 41, level_growth = 50390}
, 
{exp = 42500, level = 42, level_growth = 52710}
, 
{exp = 43800, level = 43, level_growth = 55090}
, 
{exp = 46400, level = 44, level_growth = 57560}
, 
{exp = 51600, level = 45, level_growth = 60090}
, 
{exp = 54100, level = 46, level_growth = 62700}
, 
{exp = 54100, level = 47, level_growth = 65400}
, 
{exp = 58000, level = 48, level_growth = 68170}
, 
{exp = 59300, level = 49, level_growth = 71010}
, 
{exp = 67000, level = 50, level_growth = 73920}
, 
{exp = 69000, level = 51, level_growth = 76930}
, 
{exp = 73000, level = 52, level_growth = 80050}
, 
{exp = 76000, level = 53, level_growth = 83270}
, 
{exp = 83000, level = 54, level_growth = 86580}
, 
{exp = 86000, level = 55, level_growth = 89990}
, 
{exp = 89000, level = 56, level_growth = 93510}
, 
{exp = 92000, level = 57, level_growth = 97140}
, 
{exp = 96000, level = 58, level_growth = 100850}
, 
{exp = 100000, level = 59, level_growth = 104680}
, 
{exp = 999999, level = 60, level_growth = 108570}
}
local __default_values = {algorithm_space = __rt_1, exp = 14100, level = 1, level_growth = 0}
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

