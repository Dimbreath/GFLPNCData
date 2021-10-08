local activity_double = {
{}
}
local __default_values = {id = 1, 
logic = {23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23}
, 
para1 = {14, 15, 16, 17, 18, 10, 10, 10, 19, 19, 19, 11, 11, 11}
, 
para2 = {1, 2, 3, 4, 5, 1, 4, 7, 2, 5, 7, 3, 6, 7}
, 
para3 = {10005, 10005, 10005, 10005, 10005, 10005, 10005, 10005, 10005, 10005, 10005, 10005, 10005, 10005}
}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(activity_double) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_double, {__index = __rawdata})
return activity_double

