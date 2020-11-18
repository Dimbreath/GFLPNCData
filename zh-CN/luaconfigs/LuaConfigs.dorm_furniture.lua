-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {
{0, 2}
, 
{1, 2}
}
local __rt_2 = {2, 2}
local __rt_3 = {2, 4}
local __rt_4 = {}
local dorm_furniture = {
[30001] = {
interact_point = {1, 1}
, 
interact_point_coord = {
{0.27, 0.384}
, 
{-0.27, 0.384}
}
, 
logic_point = {__rt_1, 
{__rt_2, 
{3, 2}
}
}
, name = 38601, prefab = "Furnitures_001/Prefabs/001_TPSofa_001"}
, 
[30002] = {id = 30002, 
interact_point = {1}
, 
interact_point_coord = {
{0, 0.384}
}
, 
logic_point = {__rt_1}
, name = 255749, prefab = "Furnitures_001/Prefabs/001_OPSofa_001", size = __rt_2}
, 
[30003] = {id = 30003, name = 211253, prefab = "Furnitures_001/Prefabs/001_Table_001"}
, 
[30004] = {can_binding = true, id = 30004, name = 75474, prefab = "Furnitures_001/Prefabs/001_OPBed_001", 
size = {3, 4}
}
, 
[30005] = {id = 30005, name = 347233, prefab = "Furnitures_001/Prefabs/001_Cabinet_001", 
size = {2, 3}
}
, 
[30006] = {id = 30006, name = 55513, 
size = {3, 1}
, type = 2}
, 
[30007] = {id = 30007, prefab = "Furnitures_001/Prefabs/001_Rug_001", 
size = {4, 6}
, type = 1}
}
local __default_values = {can_binding = false, comfort = 10, id = 30001, interact_point = __rt_4, interact_point_coord = __rt_4, intro = "", logic_point = __rt_4, name = 137305, prefab = "Furnitures_001/Prefabs/001_BookShelf_001", size = __rt_3, type = 3}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(dorm_furniture) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_furniture, {__index = __rawdata})
return dorm_furniture

