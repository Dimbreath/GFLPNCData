-- params : ...
-- function num : 0 , upvalues : _ENV
local hero_score = {
{attribute_name = 219873, 
score = {4238, 2884, 1866, 0}
, upper_limit = 12000}
, 
{id = 2, 
score = {3111, 1970, 1166, 0}
}
, 
{attribute_name = 356683, id = 3, 
score = {3111, 1302, 777, 0}
}
, 
{attribute_name = 75483, id = 4, 
score = {36866, 24357, 19055, 0}
, upper_limit = 98000}
, 
{attribute_name = 489075, id = 5, upper_limit = 500}
}
local __default_values = {attribute_name = 219578, id = 1, 
score = {300, 150, 80, 0}
, upper_limit = 8000}
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

