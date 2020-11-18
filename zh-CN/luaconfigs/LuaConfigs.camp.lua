-- params : ...
-- function num : 0 , upvalues : _ENV
local camp = {
{name = 387183}
, 
{icon = "2_camp", id = 2}
, 
{icon = "3_camp", id = 3, name = 28609}
, 
{icon = "4_camp", id = 4, name = 11829}
, 
{icon = "5_camp", id = 5, name = 444397}
}
local __default_values = {icon = "1_camp", id = 1, name = "42LAB"}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(camp) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(camp, {__index = __rawdata})
return camp

