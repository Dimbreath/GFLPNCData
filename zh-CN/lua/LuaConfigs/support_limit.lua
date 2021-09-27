local support_limit = {
{is_limited = true}
, 
{id = 2}
, 
{id = 3}
, 
{id = 4}
, 
{id = 5}
, 
{id = 6}
, 
{id = 7, is_open = false}
, 
{id = 8}
}
local __default_values = {id = 1, is_limited = false, is_open = true}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(support_limit) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(support_limit, {__index = __rawdata})
return support_limit

