-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {page = 4}
local __rt_2 = {}
local shop_normal = {
[101] = {__rt_1, 
{page = 4}
, 
{page = 4}
, 
{page = 4}
, 
{page = 4}
, 
{page = 4}
}
, 
[203] = {__rt_2, 
{}
, 
{}
, 
{}
, 
{page = 2, times = 100}
, 
{page = 2, times = 5}
, 
{page = 2, times = 20}
}
, 
[401] = {
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
[402] = {
{}
, 
{}
}
}
local __default_values = {page = 1, times = 0}
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
quickBuy_List = {}
}
setmetatable(shop_normal, {__index = __rawdata})
return shop_normal

