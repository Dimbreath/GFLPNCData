-- params : ...
-- function num : 0 , upvalues : _ENV
local item_currency_price = {
[1001] = {}
, 
[1002] = {item_id = 1002, num = 2}
, 
[1003] = {divisor = 1, item_id = 1003, num = 3}
, 
[1015] = {item_id = 1015, num = 4}
, 
[1016] = {divisor = 1000, item_id = 1016, num = 5}
}
local __default_values = {divisor = 100, item_id = 1001, num = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(item_currency_price) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(item_currency_price, {__index = __rawdata})
return item_currency_price

