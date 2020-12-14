-- params : ...
-- function num : 0 , upvalues : _ENV
local dungeon_info = {
{info_text = 473359}
, 
{ui_type = 2}
, 
{info_text = 38224, ui_type = 3}
}
local __default_values = {info_text = 272831, ui_type = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(dungeon_info) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dungeon_info, {__index = __rawdata})
return dungeon_info

