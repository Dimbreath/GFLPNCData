-- params : ...
-- function num : 0 , upvalues : _ENV
local dorm_house = {
{intro = 214434, name = 459942, unlock_level = 1}
, 
{id = 2, unlock_item_id = 1001, unlock_item_num = 100, unlock_logic = 2}
, 
{id = 3, intro = 502845, name = 70400, room_limit = 2, unlock_level = 2}
}
local __default_values = {comfort_limit = 1000, id = 1, intro = 173328, name = 265171, room_limit = 7, type = 1, unlock_item_id = 0, unlock_item_num = 0, unlock_logic = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(dorm_house) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
id_sort_list = {1, 2, 3}
}
setmetatable(dorm_house, {__index = __rawdata})
return dorm_house

