-- params : ...
-- function num : 0 , upvalues : _ENV
local recommend_dialogue = {
{}
, 
{id = 2, text = 398728}
, 
{id = 3, text = 218444}
, 
{id = 4, text = 337330}
, 
{id = 5, text = 507035}
, 
{id = 6, text = 413417}
, 
{id = 7, text = 329528}
, 
{id = 8, text = 291161}
}
local __default_values = {id = 1, text = 147252}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(recommend_dialogue) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
idList = {8, 1, 2, 3, 4, 5, 6, 7}
}
setmetatable(recommend_dialogue, {__index = __rawdata})
return recommend_dialogue

