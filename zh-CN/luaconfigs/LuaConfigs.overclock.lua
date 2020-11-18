-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1003}
local __rt_2 = {1000}
local __rt_3 = {5000}
local overclock = {
{
{describe = 376009}
, 
{buffid = 106, describe = 252855, level = 2}
, 
{buffid = 107, describe = 129701, level = 3}
}
, 
{
{buffid = 101, 
consumeNums = {200}
, describe = 165058, id = 2, name = 140173}
}
, 
{
{buffid = 102, 
consumeNums = {2000}
, describe = 384377, id = 3, name = 288393}
, 
{buffid = 103, consumeNums = __rt_3, id = 3, level = 2, name = 288393}
}
, 
{
{buffid = 104, consumeNums = __rt_3, describe = 138869, id = 4, name = 175110}
}
}
local __default_values = {buffid = 100, consumeIds = __rt_1, consumeNums = __rt_2, describe = 102457, icon = "", id = 1, level = 1, name = 2098}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(overclock) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(overclock, {__index = __rawdata})
return overclock

