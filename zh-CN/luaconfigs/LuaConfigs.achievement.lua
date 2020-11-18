-- params : ...
-- function num : 0 , upvalues : _ENV
local achievement = {
{name = 188719}
, 
{name = 494809, task_type = 602, type = 2}
, 
{name = 44199, task_type = 603, type = 3}
, 
{name = 159232, task_type = 604, type = 4}
, 
{task_type = 605, type = 5}
}
local __default_values = {name = 104709, task_type = 601, type = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(achievement) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(achievement, {__index = __rawdata})
return achievement

