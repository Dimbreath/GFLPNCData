-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {2640, 2145, 1650, 0}
local hero_score = {
{attribute_id = 103, attribute_name = 219873, 
score = {3680, 2990, 2300, 0}
, upper_limit = 4600}
, 
{attribute_id = 104, attribute_name = 219578, id = 2, sortId = 4}
, 
{attribute_id = 112, attribute_name = 356683, id = 3, sortId = 5}
, 
{id = 4, 
score = {112000, 91000, 70000, 0}
, sortId = 3, upper_limit = 140000}
, 
{attribute_id = 126, attribute_name = 3859, id = 5, 
score = {3920, 3185, 2450, 0}
, sortId = 2, upper_limit = 4900}
}
local __default_values = {attribute_id = 102, attribute_name = 132428, id = 1, score = __rt_1, sortId = 1, upper_limit = 3300}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(hero_score) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(hero_score, {__index = __rawdata})
return hero_score

