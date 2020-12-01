-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {0, 0, 0}
local ath_efficiency = {
{shard = 100}
, 
{attribute_promote = 1100, level = 2, shard = 200}
, 
{attribute_promote = 1200, level = 3, shard = 300}
, 
{attribute_promote = 1300, level = 4, shard = 400}
, 
{attribute_promote = 1400, level = 5, shard = 600}
, 
{attribute_promote = 1500, level = 6, shard = 800}
, 
{attribute_promote = 1600, level = 7, shard = 1000}
, 
{attribute_promote = 1700, level = 8, shard = 1200}
, 
{attribute_promote = 1800, level = 9, shard = 1500}
, 
{attribute_promote = 2000, level = 10}
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
local __rawdata = {__basemetatable = base, maxLevel = 10}
setmetatable(ath_efficiency, {__index = __rawdata})
return ath_efficiency

-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {0, 0, 0}
local ath_efficiency = {
    {shard = 100}, {attribute_promote = 1100, level = 2, shard = 200},
    {attribute_promote = 1200, level = 3, shard = 300},
    {attribute_promote = 1300, level = 4, shard = 400},
    {attribute_promote = 1400, level = 5, shard = 600},
    {attribute_promote = 1500, level = 6, shard = 800},
    {attribute_promote = 1600, level = 7, shard = 1000},
    {attribute_promote = 1700, level = 8, shard = 1200},
    {attribute_promote = 1800, level = 9, shard = 1500},
    {attribute_promote = 2000, level = 10}
}
local __default_values = {
    algorithm_space = __rt_1,
    attribute_promote = 1000,
    level = 1,
    shard = 0
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(ath_efficiency) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base, maxLevel = 10}
setmetatable(ath_efficiency, {__index = __rawdata})
return ath_efficiency

