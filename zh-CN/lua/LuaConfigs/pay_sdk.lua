local pay_sdk = {
{description = 77197, name = 342658}
, 
{description = 152426, id = 2, name = 5609, price_ZH_CN = 3000}
, 
{description = 411696, id = 3, name = 469147, price_ZH_CN = 9800}
, 
{description = 355543, id = 4, price_ZH_CN = 19800}
, 
{description = 351722, id = 5, name = 515433, price_ZH_CN = 32800}
, 
{id = 6, name = 260918, price_ZH_CN = 64800}
, 
{description = 424070, id = 7, name = 424070, price_ZH_CN = 3000}
, 
{description = 521814, id = 8, name = 521814, price_ZH_CN = 12800}
, 
{description = 524015, id = 9, name = 524015}
, 
{description = 344057, id = 10, name = 344057, price_ZH_CN = 19800}
, 
{description = 406363, id = 11, name = 406363, price_ZH_CN = 16800}
, 
{description = 88459, id = 12, name = 88459}
, 
{description = 276249, id = 13, name = 276249, price_ZH_CN = 4000}
, 
{description = 241306, id = 14, name = 241306, price_ZH_CN = 1800}
, 
{description = 451986, id = 15, name = 451986, price_ZH_CN = 10800}
, 
{description = 47438, id = 16, name = 47438, price_ZH_CN = 6800}
, 
{description = 290516, id = 17, name = 290516, price_ZH_CN = 9800}
, 
{description = 478001, id = 18, name = 478001}
, 
{description = 283230, id = 19, name = 283230}
, 
{description = 128580, id = 20, name = 128580, price_ZH_CN = 1800}
, 
{description = 506274, id = 21, name = 506274, price_ZH_CN = 1800}
, 
{description = 431114, id = 22, name = 431114, price_ZH_CN = 2500}
, 
{description = 236343, id = 23, name = 236343, price_ZH_CN = 2500}
, 
{description = 386512, id = 24, name = 386512, price_ZH_CN = 3000}
, 
{description = 412190, id = 25, name = 412190, price_ZH_CN = 3000}
, 
{description = 141503, id = 26, name = 141503, price_ZH_CN = 4000}
, 
{description = 471020, id = 27, name = 471020, price_ZH_CN = 4000}
, 
{description = 169813, id = 28, name = 169813, price_ZH_CN = 4500}
, 
{description = 270613, id = 29, name = 270613, price_ZH_CN = 4500}
, 
{description = 64837, id = 30, name = 64837, price_ZH_CN = 6800}
, 
{description = 394354, id = 31, name = 394354, price_ZH_CN = 6800}
, 
{description = 378386, id = 32, name = 378386, price_ZH_CN = 9800}
, 
{description = 183615, id = 33, name = 183615, price_ZH_CN = 9800}
, 
{description = 317240, id = 34, name = 317240, price_ZH_CN = 10800}
, 
{description = 122469, id = 35, name = 122469, price_ZH_CN = 10800}
, 
{description = 72231, id = 36, name = 72231, price_ZH_CN = 11800}
, 
{description = 401748, id = 37, name = 401748, price_ZH_CN = 11800}
, 
{description = 351510, id = 38, name = 351510, price_ZH_CN = 12800}
, 
{description = 156739, id = 39, name = 156739, price_ZH_CN = 12800}
, 
{description = 420050, id = 40, name = 420050, price_ZH_CN = 16800}
, 
{description = 225279, id = 41, name = 225279, price_ZH_CN = 16800}
, 
{description = 209311, id = 42, name = 209311, price_ZH_CN = 19800}
, 
{description = 14540, id = 43, name = 14540, price_ZH_CN = 19800}
, 
{description = 387408, id = 44, name = 387408, price_ZH_CN = 32800}
, 
{description = 200463, id = 45, name = 200463, price_ZH_CN = 14800}
; 
[99] = {description = 137893, id = 99, name = 137893, price_ZH_CN = 0}
}
local __default_values = {description = 120969, id = 1, name = 115968, price_ZH_CN = 600}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(pay_sdk) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(pay_sdk, {__index = __rawdata})
return pay_sdk

