-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {20, 50, 80}
local __rt_2 = {10, 25, 40}
local exploration_type = {
[400] = {id = 400}
, 
[1800] = {store_pool = 6}
, 
[1900] = {id = 1900}
, 
[2200] = {id = 2200}
, 
[2201] = {
chip_level_price = {5, 10, 15}
, 
chip_return_price = {5, 5, 5}
, id = 2201, store_pool = 7}
}
local __default_values = {chip_level_price = __rt_1, chip_return_price = __rt_2, id = 1800, store_pool = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(exploration_type) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(exploration_type, {__index = __rawdata})
return exploration_type

