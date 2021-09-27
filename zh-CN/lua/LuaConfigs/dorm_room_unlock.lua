local dorm_room_unlock = {
{
{unlock_logic = 0}
, 
{room_id = 2, unlock_logic = 0}
, 
{room_id = 3, unlock_para1 = 2108}
, 
{room_id = 4, unlock_para1 = 2114}
, 
{room_id = 5, unlock_para1 = 3102}
, 
{room_id = 6, unlock_para1 = 3108}
, 
{room_id = 7, unlock_para1 = 4102}
}
}
local __default_values = {house = 1, room_id = 1, unlock_logic = 1, unlock_para1 = 0}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(dorm_room_unlock) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_room_unlock, {__index = __rawdata})
return dorm_room_unlock

