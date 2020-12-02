-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {0, 0, 0}
local hero_level = {
{exp = 160}
, 
{exp = 190, level = 2, level_growth = 11000}
, 
{exp = 220, level = 3, level_growth = 12000}
, 
{exp = 250, level = 4, level_growth = 13000}
, 
{exp = 300, level = 5, level_growth = 14000}
, 
{exp = 330, level = 6, level_growth = 15000}
, 
{exp = 400, level = 7, level_growth = 16000}
, 
{exp = 500, level = 8, level_growth = 17000}
, 
{exp = 600, level = 9, level_growth = 18000}
, 
{exp = 720, level = 10, level_growth = 19000}
, 
{exp = 860, level = 11, level_growth = 20000}
, 
{exp = 1000, level = 12, level_growth = 21000}
, 
{exp = 1200, level = 13, level_growth = 22000}
, 
{exp = 1400, level = 14, level_growth = 23000}
, 
{exp = 2400, level = 15, level_growth = 24000}
, 
{exp = 2700, level = 16, level_growth = 25000}
, 
{exp = 3200, level = 17, level_growth = 26000}
, 
{exp = 3500, level = 18, level_growth = 27000}
, 
{exp = 3800, level = 19, level_growth = 28000}
, 
{exp = 4400, level = 20, level_growth = 29000}
, 
{exp = 4600, level = 21, level_growth = 30000}
, 
{exp = 5300, level = 22, level_growth = 31000}
, 
{exp = 5600, level = 23, level_growth = 32000}
, 
{exp = 5800, level = 24, level_growth = 33000}
, 
{exp = 6000, level = 25, level_growth = 34000}
, 
{exp = 6100, level = 26, level_growth = 35000}
, 
{exp = 6300, level = 27, level_growth = 36000}
, 
{exp = 7400, level = 28, level_growth = 37000}
, 
{exp = 7700, level = 29, level_growth = 38000}
, 
{exp = 8400, level = 30, level_growth = 39000}
, 
{exp = 8800, level = 31, level_growth = 40000}
, 
{exp = 10000, level = 32, level_growth = 41000}
, 
{exp = 12000, level = 33, level_growth = 42000}
, 
{exp = 13000, level = 34, level_growth = 43000}
, 
{exp = 15000, level = 35, level_growth = 44000}
, 
{exp = 16000, level = 36, level_growth = 45000}
, 
{exp = 20000, level = 37, level_growth = 46000}
, 
{exp = 22000, level = 38, level_growth = 47000}
, 
{exp = 24000, level = 39, level_growth = 48000}
, 
{exp = 25000, level = 40, level_growth = 49000}
, 
{exp = 28000, level = 41, level_growth = 50000}
, 
{exp = 31000, level = 42, level_growth = 51000}
, 
{exp = 33000, level = 43, level_growth = 52000}
, 
{exp = 36000, level = 44, level_growth = 53000}
, 
{exp = 38000, level = 45, level_growth = 54000}
, 
{exp = 41000, level = 46, level_growth = 55000}
, 
{exp = 45000, level = 47, level_growth = 56000}
, 
{exp = 49000, level = 48, level_growth = 57000}
, 
{exp = 53000, level = 49, level_growth = 58000}
, 
{exp = 56000, level = 50, level_growth = 59000}
, 
{exp = 58000, level = 51, level_growth = 60000}
, 
{exp = 61000, level = 52, level_growth = 61000}
, 
{exp = 65000, level = 53, level_growth = 62000}
, 
{exp = 70000, level = 54, level_growth = 63000}
, 
{exp = 76000, level = 55, level_growth = 64000}
, 
{exp = 82000, level = 56, level_growth = 65000}
, 
{exp = 90000, level = 57, level_growth = 66000}
, 
{exp = 98000, level = 58, level_growth = 67000}
, 
{exp = 106000, level = 59, level_growth = 68000}
, 
{exp = 108000, level = 60, level_growth = 69000}
, 
{exp = 110000, level = 61, level_growth = 70000}
, 
{exp = 112000, level = 62, level_growth = 71000}
, 
{exp = 114000, level = 63, level_growth = 72000}
, 
{exp = 116000, level = 64, level_growth = 73000}
, 
{exp = 120000, level = 65, level_growth = 74000}
, 
{exp = 122000, level = 66, level_growth = 75000}
, 
{exp = 124000, level = 67, level_growth = 76000}
, 
{exp = 128000, level = 68, level_growth = 77000}
, 
{exp = 132000, level = 69, level_growth = 78000}
, 
{exp = 134000, level = 70, level_growth = 79000}
, 
{level = 71, level_growth = 80000}
, 
{level = 72, level_growth = 81000}
, 
{exp = 138000, level = 73, level_growth = 82000}
, 
{exp = 140000, level = 74, level_growth = 83000}
, 
{exp = 144000, level = 75, level_growth = 84000}
, 
{exp = 148000, level = 76, level_growth = 85000}
, 
{exp = 148000, level = 77, level_growth = 86000}
, 
{exp = 150000, level = 78, level_growth = 87000}
, 
{exp = 154000, level = 79, level_growth = 88000}
, 
{exp = 162000, level = 80, level_growth = 89000}
, 
{exp = 166000, level = 81, level_growth = 90000}
, 
{exp = 172000, level = 82, level_growth = 91000}
, 
{exp = 176000, level = 83, level_growth = 92000}
, 
{exp = 180000, level = 84, level_growth = 93000}
, 
{exp = 186000, level = 85, level_growth = 94000}
, 
{exp = 192000, level = 86, level_growth = 95000}
, 
{exp = 198000, level = 87, level_growth = 96000}
, 
{exp = 202000, level = 88, level_growth = 97000}
, 
{exp = 208000, level = 89, level_growth = 98000}
, 
{exp = 250000, level = 90, level_growth = 99000}
, 
{exp = 292000, level = 91, level_growth = 100000}
, 
{exp = 334000, level = 92, level_growth = 101000}
, 
{exp = 378000, level = 93, level_growth = 102000}
, 
{exp = 424000, level = 94, level_growth = 103000}
, 
{exp = 470000, level = 95, level_growth = 104000}
, 
{exp = 516000, level = 96, level_growth = 105000}
, 
{exp = 564000, level = 97, level_growth = 106000}
, 
{exp = 612000, level = 98, level_growth = 107000}
, 
{exp = 662000, level = 99, level_growth = 108000}
, 
{exp = 624000, level = 100, level_growth = 109000}
}
local __default_values = {algorithm_space = __rt_1, exp = 136000, level = 1, level_growth = 10000}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in (_ENV.pairs)(hero_level) do
  (_ENV.setmetatable)(v, base)
end
local __rawdata = {__basemetatable = base}
;
(_ENV.setmetatable)(hero_level, {__index = __rawdata})
return hero_level

