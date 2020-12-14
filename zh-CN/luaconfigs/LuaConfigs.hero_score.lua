-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {4238, 2884, 1866, 0}
local hero_score = {
{attribute_id = 103, attribute_name = 219873}
, 
{attribute_id = 104, id = 2, 
score = {3111, 1970, 1166, 0}
, sortId = 4, upper_limit = 8000}
, 
{attribute_id = 112, attribute_name = 356683, id = 3, 
score = {3111, 1302, 777, 0}
, sortId = 5, upper_limit = 8000}
, 
{attribute_name = 75483, id = 4, 
score = {36866, 24357, 19055, 0}
, sortId = 3, upper_limit = 98000}
, 
{attribute_id = 126, attribute_name = 3859, id = 5, sortId = 2}
}
local __default_values = {attribute_id = 102, attribute_name = 219578, id = 1, score = __rt_1, sortId = 1, upper_limit = 12000}
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

