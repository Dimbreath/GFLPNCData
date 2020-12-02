-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {25, 3}
local __rt_2 = {500, 1000}
local __rt_3 = {}
local factory = {
{}
, 
{cost_item = 1202, id = 2, 
para1 = {1202, 1202}
}
, 
{cost_item = 1203, id = 3, 
para1 = {1203, 1203}
}
, 
{cost_item = 1204, id = 4, 
para1 = {1204, 1204}
}
, 
{cost_item = 1205, id = 5, 
para1 = {1205, 1205}
}
}
local __default_values = {cost_item = 1201, id = 1, logic = __rt_1, 
para1 = {1201, 1201}
, para2 = __rt_2, para3 = __rt_3}
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

