local pay_product = {
[100001] = {name = 424070, sdk_id = 7}
, 
[100101] = {id = 100101, name = 342658, sdk_id = 1}
, 
[100102] = {id = 100102, name = 5609, sdk_id = 2}
, 
[100103] = {id = 100103, name = 469147, sdk_id = 3}
, 
[100104] = {id = 100104, sdk_id = 4}
, 
[100105] = {id = 100105, name = 515433, sdk_id = 5}
, 
[100106] = {id = 100106, name = 260918, sdk_id = 6}
, 
[100201] = {id = 100201, name = 47438, sdk_id = 16}
, 
[100202] = {id = 100202, name = 521814, sdk_id = 8}
, 
[100203] = {id = 100203, name = 290516, sdk_id = 17}
, 
[100204] = {id = 100204, name = 61415, sdk_id = 23}
, 
[100301] = {id = 100301, name = 524015, sdk_id = 9}
, 
[100302] = {id = 100302, name = 200463, sdk_id = 45}
, 
[100303] = {id = 100303, name = 128580, sdk_id = 20}
, 
[100304] = {id = 100304, name = 406363, sdk_id = 11}
, 
[100305] = {id = 100305, name = 169813, sdk_id = 28}
, 
[100306] = {id = 100306, name = 506274, sdk_id = 21}
, 
[100307] = {id = 100307, name = 36253}
, 
[100308] = {id = 100308, name = 323991}
, 
[100309] = {id = 100309, name = 292159}
, 
[100310] = {id = 100310, name = 388735, sdk_id = 12}
, 
[100311] = {id = 100311, name = 283169, sdk_id = 13}
, 
[100312] = {id = 100312, name = 137981, sdk_id = 14}
, 
[100313] = {id = 100313, name = 272875, sdk_id = 15}
, 
[100314] = {id = 100314, name = 431114, sdk_id = 22}
, 
[100315] = {id = 100315, name = 72231, sdk_id = 36}
, 
[100316] = {id = 100316, name = 412190, sdk_id = 25}
, 
[100317] = {id = 100317, name = 398902, sdk_id = 30}
, 
[100318] = {id = 100318, name = 187175, sdk_id = 32}
}
local __default_values = {id = 100001, name = 115968, sdk_id = 99}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(pay_product) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(pay_product, {__index = __rawdata})
return pay_product

