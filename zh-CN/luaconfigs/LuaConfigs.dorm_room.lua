-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {0, 5}
local __rt_2 = {}
local dorm_room = {
    [40001] = {
        intro = 368099,
        name = 388617,
        prefab = "001_EntireR_001/Prefabs/001_EntireR_001"
    },
    [40002] = {comfort = 20, id = 40002}
}
local __default_values = {
    comfort = 10,
    door = __rt_1,
    fixed_coord = __rt_2,
    fixed_furniture = 0,
    id = 40001,
    intro = 173328,
    name = 193846,
    prefab = "001_EmptyR_001/Prefabs/001_EmptyR_002"
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(dorm_room) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_room, {__index = __rawdata})
return dorm_room

