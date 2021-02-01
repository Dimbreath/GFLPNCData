-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1003}
local __rt_2 = {1000}
local __rt_3 = {3}
local __rt_4 = {2106}
local __rt_5 = {}
local __rt_6 = {2000}
local __rt_7 = {4101}
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
{buffid = 109, describe = 192420, id = 2, name = 398620, 
pre_para1 = {2115}
}
}
, 
{
{buffid = 104, consumeNums = __rt_6, describe = 138869, id = 3, name = 175110, 
pre_para1 = {3110}
}
}
, 
{
{buffid = 102, consumeNums = __rt_6, describe = 384377, id = 4, name = 288393, pre_para1 = __rt_7}
, 
{buffid = 103, consumeNums = __rt_6, id = 4, level = 2, name = 288393, pre_para1 = __rt_7}
}
}
local __default_values = {buffid = 100, consumeIds = __rt_1, consumeNums = __rt_2, describe = 102457, icon = "", id = 1, level = 1, name = 2098, pre_condition = __rt_3, pre_para1 = __rt_4, pre_para2 = __rt_5}
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

