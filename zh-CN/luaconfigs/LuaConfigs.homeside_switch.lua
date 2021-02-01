-- params : ...
-- function num : 0 , upvalues : _ENV
local homeside_switch = {
{type_name = 402876}
, 
{id = 2, type_name = 505990}
, 
{id = 3, type_name = 207152}
, 
{id = 4, type_name = 328680}
; 
[6] = {id = 6, type_name = 503716}
, 
[7] = {id = 7}
}
local __default_values = {id = 1, type_name = 16107}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(homeside_switch) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(homeside_switch, {__index = __rawdata})
return homeside_switch

