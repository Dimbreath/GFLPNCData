-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local shop_resource = {
[301] = {
{}
}
}
local __default_values = {currencyId = 1002, 
currencyNums = {50, 100, 200, 250, 300}
, goods_shelves = 1, itemId = 1007, 
itemNums = {100, 100, 100, 100, 100}
, pre_condition = __rt_1, pre_para1 = __rt_1, pre_para2 = __rt_1, shop_id = 301, 
times = {1, 2, 3, 4, 5}
}
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

-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local shop_resource = {[301] = {{}}}
local __default_values = {
    currencyId = 1002,
    currencyNums = {50, 100, 200, 250, 300},
    goods_shelves = 1,
    itemId = 1007,
    itemNums = {100, 100, 100, 100, 100},
    pre_condition = __rt_1,
    pre_para1 = __rt_1,
    pre_para2 = __rt_1,
    shop_id = 301,
    times = {1, 2, 3, 4, 5}
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(shop_resource) do
    for k1, v1 in pairs(v) do setmetatable(v1, base) end
end
local __rawdata = {__basemetatable = base}
setmetatable(shop_resource, {__index = __rawdata})
return shop_resource
