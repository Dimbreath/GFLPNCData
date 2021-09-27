local __rt_1 = {1, 20, -1}
local __rt_2 = {50, 100, 200}
local exploration_discard = {
{
discard_level = {1, 5, 10, -1}
, 
discard_scaleValues = {500, 500, 500, 500}
}
, 
{id = 2}
}
local __default_values = {
discard_level = {1, 2, 3, -1}
, discard_scaleId = 1, 
discard_scaleValues = {1000, 500, 334, 334}
, id = 1, upgrade_level = __rt_1, upgrade_scaleId = 1, upgrade_scaleValues = __rt_2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(exploration_discard) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(exploration_discard, {__index = __rawdata})
return exploration_discard

