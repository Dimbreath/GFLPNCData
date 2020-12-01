-- params : ...
-- function num : 0 , upvalues : _ENV
local monster_tag = {
{tag = 89171}
, 
{id = 2, tag = 486174}
, 
{id = 3, tag = 275035}
, 
{id = 4, tag = 507391}
, 
{id = 5, tag = 71793}
, 
{id = 6, tag = 498316}
, 
{id = 7, tag = 388173}
, 
{id = 8}
, 
{id = 9, tag = 363235}
, 
{id = 10, tag = 49598}
, 
{id = 11, tag = 180243}
, 
{id = 12, tag = 463792}
}
local __default_values = {id = 1, tag = 111432}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(monster_tag) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(monster_tag, {__index = __rawdata})
return monster_tag

-- params : ...
-- function num : 0 , upvalues : _ENV
local monster_tag = {
    {tag = 89171}, {id = 2, tag = 486174}, {id = 3, tag = 275035},
    {id = 4, tag = 507391}, {id = 5, tag = 71793}, {id = 6, tag = 498316},
    {id = 7, tag = 388173}, {id = 8}, {id = 9, tag = 363235},
    {id = 10, tag = 49598}, {id = 11, tag = 180243}, {id = 12, tag = 463792}
}
local __default_values = {id = 1, tag = 111432}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(monster_tag) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(monster_tag, {__index = __rawdata})
return monster_tag

