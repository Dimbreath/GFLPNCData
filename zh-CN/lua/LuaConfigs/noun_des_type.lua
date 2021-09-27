local noun_des_type = {
{id = 1, type_name = 49715}
, 
{id = 2, type_name = 43065}
, 
{id = 3, type_name = 203179}
, 
{id = 4}
, 
{id = 5, type_name = 272741}
, 
{id = 6, type_name = 299140}
; 
[0] = {type_name = 283024}
}
local __default_values = {id = 0, type_name = 196818}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(noun_des_type) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(noun_des_type, {__index = __rawdata})
return noun_des_type

