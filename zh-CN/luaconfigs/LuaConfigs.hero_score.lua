-- params : ...
-- function num : 0 , upvalues : _ENV
local hero_score = {
{attribute_id = 103, attribute_name = 219873, 
score = {2250, 1855, 1460, 0}
, upper_limit = 3000}
, 
{attribute_id = 104, id = 2, 
score = {1950, 1282, 615, 0}
, sortId = 4}
, 
{attribute_id = 112, attribute_name = 356683, id = 3, sortId = 5}
, 
{attribute_name = 75483, id = 4, 
score = {67500, 53000, 38500, 0}
, sortId = 3, upper_limit = 90000}
, 
{attribute_id = 126, attribute_name = 3859, id = 5, 
score = {2325, 1995, 1666, 0}
, sortId = 2, upper_limit = 3100}
}
local __default_values = {attribute_id = 102, attribute_name = 219578, id = 1, 
score = {1950, 1235, 520, 0}
, sortId = 1, upper_limit = 2600}
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

