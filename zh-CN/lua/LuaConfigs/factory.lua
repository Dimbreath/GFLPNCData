local __rt_1 = {3}
local __rt_2 = {3106}
local __rt_3 = {}
local factory = {
{model = 1, name = 263351, pre_para1 = __rt_2}
, 
{id = 2, intro = 24504, model = 2, name = 323753, pre_para1 = __rt_2}
, 
{id = 3, intro = 385725, model = 3, name = 64102, 
pre_para1 = {3112}
}
, 
{id = 4, intro = 222658, model = 2, name = 384122, 
pre_para1 = {4114}
}
, 
{id = 5, intro = 59591, is_open = 0, order_limit = 0, pre_condition = __rt_3}
, 
{id = 6, intro = 420812, is_open = 0, order_limit = 0, pre_condition = __rt_3}
, 
{id = 7, intro = 257745, is_open = 0, order_limit = 0, pre_condition = __rt_3}
}
local __default_values = {id = 1, intro = 187571, is_open = 1, model = 0, name = 499501, order_limit = 1, pre_condition = __rt_1, pre_para1 = __rt_3, pre_para2 = __rt_3}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(factory) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(factory, {__index = __rawdata})
return factory

