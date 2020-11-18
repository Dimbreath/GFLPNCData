-- params : ...
-- function num : 0 , upvalues : _ENV
local treasure_logic2 = {
[2001] = {}
}
local __default_values = {costId = 1, 
costNums = {5}
, id = 2001, 
times = {1}
}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(treasure_logic2) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(treasure_logic2, {__index = __rawdata})
return treasure_logic2

