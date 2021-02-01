-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {0, 0, 0}
local ath_efficiency = {
{shard = 100}
, 
{attribute_promote = 1100, level = 2, shard = 150}
, 
{attribute_promote = 1200, level = 3, shard = 200}
, 
{attribute_promote = 1300, level = 4, shard = 250}
, 
{attribute_promote = 1400, level = 5, shard = 300}
, 
{attribute_promote = 1500, level = 6, shard = 400}
, 
{attribute_promote = 1600, level = 7, shard = 450}
, 
{attribute_promote = 1700, level = 8, shard = 550}
, 
{attribute_promote = 1800, level = 9, shard = 600}
, 
{attribute_promote = 2000, level = 10, shard = 700}
, 
{attribute_promote = 2200, level = 11, shard = 800}
, 
{attribute_promote = 2400, level = 12, shard = 850}
, 
{attribute_promote = 2600, level = 13, shard = 950}
, 
{attribute_promote = 2800, level = 14, shard = 1050}
, 
{attribute_promote = 3000, level = 15, shard = 1150}
, 
{attribute_promote = 3200, level = 16, shard = 1300}
, 
{attribute_promote = 3400, level = 17, shard = 1400}
, 
{attribute_promote = 3600, level = 18, shard = 1500}
, 
{attribute_promote = 3800, level = 19, shard = 1650}
, 
{attribute_promote = 4000, level = 20}
}
local __default_values = {algorithm_space = __rt_1, attribute_promote = 1000, level = 1, shard = 0}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(ath_efficiency) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, maxLevel = 20}
setmetatable(ath_efficiency, {__index = __rawdata})
return ath_efficiency

