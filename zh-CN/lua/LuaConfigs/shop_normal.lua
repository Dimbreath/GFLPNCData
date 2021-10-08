local __rt_1 = {}
local __rt_2 = {page = 8, times = 4}
local __rt_3 = {page = 8, times = 8}
local __rt_4 = {page = 10}
local __rt_5 = {page = 10, times = 5}
local __rt_6 = {times = 5}
local __rt_7 = {page = 7, times = 3}
local __rt_8 = {}
local __rt_9 = {page = 1, times = 0}
local __rt_10 = {page = 6, times = 0}
local __rt_11 = {page = 1, 
pre_condition = {12}
, 
pre_para1 = {-1}
, 
pre_para2 = {1634781599}
, times = 1}
local shop_normal = {
[101] = {__rt_2, __rt_3, __rt_4, __rt_5, 
{page = 10}
, 
{page = 10, times = 5}
, 
{page = 10}
, __rt_6, 
{page = 10}
, 
{times = 5}
, 
{page = 8, times = 4}
, 
{page = 8, times = 4}
, 
{page = 10}
, 
{page = 10}
, 
{times = 5}
, 
{page = 10, times = 5}
, 
{times = 5}
, __rt_7, 
{page = 7, times = 3}
, 
{page = 7, times = 3}
, 
{page = 7, times = 3}
, 
{page = 7, times = 3}
, 
{page = 7, times = 3}
, 
{page = 10, times = 5}
, 
{page = 10, times = 5}
, 
{page = 8, times = 8}
, 
{page = 10, times = 5}
, 
{page = 10}
, __rt_8, 
{}
, 
{}
, 
{}
, 
{}
, 
{}
, 
{}
, 
{}
, 
{}
, 
{}
}
, 
[203] = {__rt_9, 
{page = 1, times = 0}
, __rt_10, 
{page = 6, times = 0}
, 
{page = 6, times = 0}
, 
{page = 1, times = 0}
, 
{page = 6, times = 0}
}
, 
[701] = {__rt_11, 
{page = 1, 
pre_condition = {12}
, 
pre_para1 = {-1}
, 
pre_para2 = {1634781599}
, times = 1}
, 
{page = 1, 
pre_condition = {12}
, 
pre_para1 = {-1}
, 
pre_para2 = {1634781599}
, times = 1}
, 
{page = 1, 
pre_condition = {12}
, 
pre_para1 = {-1}
, 
pre_para2 = {1634781599}
, times = 1}
}
, 
[1003] = {
{page = 1, times = 1}
, 
{page = 1, times = 3}
, 
{page = 1, times = 0}
, 
{page = 1, times = 0}
, 
{page = 1, times = 0}
}
}
local __default_values = {page = 9, pre_condition = __rt_1, pre_para1 = __rt_1, pre_para2 = __rt_1, times = 2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(shop_normal) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base, 
quickBuy_List = {
[1001] = {
[1020] = {
{discount = 100, itemNum = 1, shelfId = 6, shopId = 203}
}
}
}
}
setmetatable(shop_normal, {__index = __rawdata})
return shop_normal

