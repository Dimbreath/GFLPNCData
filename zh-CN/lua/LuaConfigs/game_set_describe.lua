local __rt_1 = {512818, 233171}
local game_set_describe = {
{name = "skill"}
, 
{id = 2}
}
local __default_values = {defalt_detail = false, id = 1, name = "function", option_group_name = __rt_1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(game_set_describe) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(game_set_describe, {__index = __rawdata})
return game_set_describe

