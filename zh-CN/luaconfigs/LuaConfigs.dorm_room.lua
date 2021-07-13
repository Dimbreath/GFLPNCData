-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {5, 8}
local __rt_2 = {}
local dorm_room = {
[710001] = {intro = 368099, name = 388617, prefab = "001_EntireR_001/Prefabs/001_EntireR_001"}
, 
[710002] = {comfort = 20, id = 710002, intro = 173328, name = 517748}
, 
[710003] = {comfort = 30, id = 710003, intro = 502845, name = 523363, prefab = "001_EmptyR_001/Prefabs/cs2016_001"}
, 
[710004] = {comfort = 40, id = 710004, intro = 308074, name = 328592, prefab = "001_EmptyR_001/Prefabs/cs2016_002"}
, 
[710005] = {comfort = 50, id = 710005, name = 133821, prefab = "001_EmptyR_001/Prefabs/cs2016_003"}
, 
[710006] = {comfort = 60, id = 710006, intro = 442820, name = 463338, prefab = "001_EmptyR_001/Prefabs/ft2016_001"}
, 
[710007] = {comfort = 70, id = 710007, intro = 248049, name = 268567, prefab = "001_EmptyR_001/Prefabs/js2017_001"}
, 
[710008] = {comfort = 80, id = 710008, intro = 53278, name = 73796, prefab = "001_EmptyR_001/Prefabs/kft2016_001"}
, 
[710009] = {comfort = 90, id = 710009, intro = 382795, name = 403313, prefab = "001_EmptyR_001/Prefabs/loft2016_001"}
, 
[710010] = {comfort = 100, id = 710010, intro = 9001, name = 497595, prefab = "001_EmptyR_001/Prefabs/rs2016_001"}
, 
[710011] = {comfort = 110, id = 710011, intro = 338518, name = 302824, prefab = "001_EmptyR_001/Prefabs/sn2016_001"}
, 
[710012] = {comfort = 120, id = 710012, intro = 143747, prefab = "001_EmptyR_001/Prefabs/sn2016_bs_001"}
, 
[710013] = {comfort = 130, id = 710013, intro = 473264, name = 437570, prefab = "001_EmptyR_001/Prefabs/ws2016_001"}
}
local __default_values = {comfort = 10, door = __rt_1, fixed_coord = __rt_2, fixed_furniture = 0, id = 710001, intro = 113303, name = 108053, prefab = "001_EmptyR_001/Prefabs/001_EmptyR_001"}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(dorm_room) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_room, {__index = __rawdata})
return dorm_room

