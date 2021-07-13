-- params : ...
-- function num : 0 , upvalues : _ENV
local dorm_ai = {
[1001] = {}
}
local __default_values = {
actions = {1001, 1002, 1003}
, 
desire_init = {1000, 1000, 1000}
, 
desire_up_rate = {100, 200, 100}
, id = 1001, 
min_time = {30, 30, 30}
, 
time_weight = {0, 0, 0}
}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(dorm_ai) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_ai, {__index = __rawdata})
return dorm_ai

