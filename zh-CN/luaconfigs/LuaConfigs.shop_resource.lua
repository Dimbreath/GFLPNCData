-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {60}
local __rt_3 = {1}
local __rt_4 = {5}
local __rt_5 = {75}
local __rt_6 = {2}
local __rt_7 = {4}
local __rt_8 = {65}
local shop_resource = {
[301] = {
{currencyId = 1002, 
currencyNums = {50, 50, 80, 100, 120, 150, 200}
, 
itemNums = {100, 100, 100, 100, 100, 100, 100}
, shop_id = 301, 
times = {1, 2, 3, 4, 5, 6, 8}
}
, 
{currencyId = 1002, 
currencyNums = {50, 100}
, goods_shelves = 2, itemId = 1201, 
itemNums = {500, 500}
, shop_id = 301, 
times = {1, 2}
}
}
, 
[1002] = {
{itemId = 2511}
, 
{goods_shelves = 2, itemId = 2512}
, 
{goods_shelves = 3, itemId = 2508}
, 
{goods_shelves = 4, itemId = 2519}
, 
{goods_shelves = 5, itemId = 2534}
, 
{goods_shelves = 6, itemId = 2536}
, 
{currencyNums = __rt_5, goods_shelves = 7, itemId = 1821, itemNums = __rt_6, times = __rt_3}
, 
{currencyNums = __rt_5, goods_shelves = 8, itemId = 1822, itemNums = __rt_6, times = __rt_3}
, 
{currencyNums = __rt_5, goods_shelves = 9, itemId = 1823, itemNums = __rt_6, times = __rt_3}
, 
{currencyNums = __rt_5, goods_shelves = 10, itemId = 1824, itemNums = __rt_6, times = __rt_3}
, 
{currencyNums = __rt_5, goods_shelves = 11, itemId = 1825, itemNums = __rt_6, times = __rt_3}
, 
{
currencyNums = {250}
, goods_shelves = 12, itemId = 6003, times = __rt_3}
, 
{
currencyNums = {150}
, goods_shelves = 13, itemId = 1502, itemNums = __rt_7, times = __rt_3}
, 
{currencyNums = __rt_8, goods_shelves = 14, itemId = 1816, itemNums = __rt_7}
, 
{currencyNums = __rt_8, goods_shelves = 15, itemId = 1817, itemNums = __rt_7}
, 
{currencyNums = __rt_8, goods_shelves = 16, itemId = 1818, itemNums = __rt_7}
, 
{currencyNums = __rt_8, goods_shelves = 17, itemId = 1819, itemNums = __rt_7}
, 
{currencyNums = __rt_8, goods_shelves = 18, itemId = 1820, itemNums = __rt_7}
}
}
local __default_values = {currencyId = 1015, currencyNums = __rt_2, goods_shelves = 1, itemId = 1007, itemNums = __rt_3, pre_condition = __rt_1, pre_para1 = __rt_1, pre_para2 = __rt_1, shop_id = 1002, times = __rt_4}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(shop_resource) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(shop_resource, {__index = __rawdata})
return shop_resource

