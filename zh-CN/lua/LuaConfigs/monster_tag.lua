local monster_tag = {
{tag = 231848}
, 
{id = 2, tag = 247321}
, 
{id = 3, tag = 373065}
, 
{id = 4, tag = 498316}
, 
{id = 5, tag = 410514}
, 
{id = 6, tag = 362130}
, 
{id = 7}
, 
{id = 8, tag = 196316}
, 
{id = 9, tag = 383560}
, 
{id = 10, tag = 182327}
, 
{id = 11, tag = 497025}
, 
{id = 12, tag = 318980}
, 
{id = 13, tag = 43263}
, 
{id = 14, tag = 338221}
, 
{id = 15, tag = 181643}
, 
{id = 16, tag = 430214}
, 
{id = 17, tag = 394381}
, 
{id = 18, tag = 404615}
, 
{id = 19, tag = 72190}
}
local __default_values = {color = 1, id = 1, tag = 180243}
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

