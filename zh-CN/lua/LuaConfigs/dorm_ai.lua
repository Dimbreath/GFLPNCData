local __rt_1 = {1001, 1002, 1003, 1005}
local dorm_ai = {
[1001] = {
desire_up_rate = {125, 125, 125, 125}
, 
max_time = {20, 20, 20, 20}
, 
min_time = {8, 8, 8, 8}
}
, 
[1002] = {
desire_init = {500, 500, 2500, 500}
, 
desire_up_rate = {50, 100, 300, 50}
, id = 1002, 
min_time = {8, 8, 15, 8}
, 
time_weight = {0, 1, 3, 0}
}
, 
[1003] = {
desire_init = {1000, 1300, 1300, 400}
, id = 1003, 
max_time = {30, 40, 40, 10}
, 
min_time = {8, 10, 10, 5}
, 
time_weight = {1, 2, 2, 0}
}
, 
[1004] = {
desire_init = {500, 50, 50, 3400}
, 
desire_up_rate = {100, 25, 25, 350}
, id = 1004, 
max_time = {20, 15, 15, 40}
, 
time_weight = {0, 0, 0, 2}
}
, 
[1005] = {
desire_init = {500, 2500, 500, 500}
, 
desire_up_rate = {100, 200, 100, 100}
, id = 1005, 
max_time = {30, 45, 30, 10}
, 
min_time = {8, 15, 8, 5}
, 
time_weight = {1, 2, 1, 0}
}
, 
[1006] = {
desire_init = {2500, 500, 500, 500}
, 
desire_up_rate = {200, 100, 100, 100}
, id = 1006, 
max_time = {30, 15, 15, 15}
, 
min_time = {15, 8, 8, 8}
, 
time_weight = {2, 0, 0, 0}
}
}
local __default_values = {actions = __rt_1, 
desire_init = {1000, 1000, 1000, 1000}
, 
desire_up_rate = {100, 175, 175, 50}
, id = 1001, 
max_time = {15, 15, 45, 15}
, 
min_time = {10, 8, 8, 15}
, 
time_weight = {0, 0, 0, 0}
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

