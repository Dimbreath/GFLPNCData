local exploration_monster_room = {
{}
}
local __default_values = {currency = 1, id = 1, 
prices = {10}
, 
refresh_times = {1}
}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(exploration_monster_room) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(exploration_monster_room, {__index = __rawdata})
return exploration_monster_room

