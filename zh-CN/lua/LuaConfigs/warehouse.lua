local warehouse = {
{name = 377238}
, 
{icon = "warehouse_page_2", id = 2, name = 386406}
, 
{icon = "warehouse_page_3", id = 3, name = 185947}
, 
{icon = "warehouse_page_4", id = 4, name = 60812}
, 
{icon = "warehouse_page_5", id = 5, name = 371287}
, 
{icon = "warehouse_page_6", id = 6}
}
local __default_values = {icon = "warehouse_page_1", id = 1, name = 117342}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(warehouse) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warehouse, {__index = __rawdata})
return warehouse

