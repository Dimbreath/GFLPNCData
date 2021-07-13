-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {2, 4}
local __rt_3 = {1, 2}
local __rt_4 = {2, 3}
local __rt_5 = {1, 1}
local __rt_6 = {3, 3}
local __rt_7 = {3, 2}
local __rt_8 = {2, 2}
local dorm_furniture = {
[720001] = {can_binding = true, intro = 140658, name = 63723, prefab = "Furnitures_001/Prefabs/cs2016_bed_001", size = __rt_2}
, 
[720002] = {id = 720002, intro = 74174, name = 469613, prefab = "Furnitures_001/Prefabs/cs2016_box_001", size = __rt_3}
, 
[720003] = {id = 720003, intro = 437080, name = 406656, prefab = "Furnitures_001/Prefabs/cs2016_box_002", size = __rt_4}
, 
[720004] = {id = 720004, intro = 60544, name = 285449, prefab = "Furnitures_001/Prefabs/cs2016_cabinet_001"}
, 
[720005] = {can_binding = true, id = 720005, intro = 471976, name = 94287, prefab = "Furnitures_001/Prefabs/cs2016_carton_001"}
, 
[720006] = {id = 720006, intro = 200963, name = 413998, prefab = "Furnitures_001/Prefabs/cs2016_carton_002", size = __rt_6}
, 
[720007] = {id = 720007, intro = 218693, name = 341947, prefab = "Furnitures_001/Prefabs/cs2016_window_001", size = __rt_4, type = 2}
, 
[720008] = {can_binding = true, id = 720008, intro = 506600, name = 237075, prefab = "Furnitures_001/Prefabs/ft2016_bed_icon_bs_001", size = __rt_7}
, 
[720009] = {can_binding = true, id = 720009, intro = 169491, name = 210251, prefab = "Furnitures_001/Prefabs/ft2016_chair_bs_001"}
, 
[720010] = {id = 720010, intro = 106633, name = 13810, prefab = "Furnitures_001/Prefabs/ft2016_deco_big_bs_001"}
, 
[720011] = {id = 720011, intro = 53549, name = 110914, prefab = "Furnitures_001/Prefabs/ft2016_deco_small_01_001"}
, 
[720012] = {id = 720012, intro = 375934, name = 80888, prefab = "Furnitures_001/Prefabs/ft2016_deco_small_03_bs_001", size = __rt_3}
, 
[720013] = {can_binding = true, id = 720013, intro = 517236, name = 149826, prefab = "Furnitures_001/Prefabs/ft2016_sofa_001", size = __rt_8}
, 
[720014] = {id = 720014, intro = 238659, name = 377293, prefab = "Furnitures_001/Prefabs/ft2016_table_bs_001", size = __rt_4}
, 
[720015] = {id = 720015, intro = 382514, name = 221842, prefab = "Furnitures_001/Prefabs/ft2016_walldeco_02_001", type = 2}
, 
[720016] = {id = 720016, intro = 244921, name = 519592, prefab = "Furnitures_001/Prefabs/ft2016_walldeco_03_bs_001", size = __rt_8, type = 2}
, 
[720017] = {can_binding = true, id = 720017, intro = 101107, name = 469299, prefab = "Furnitures_001/Prefabs/js2017_chair_a_001"}
, 
[720018] = {id = 720018, intro = 244386, name = 339209, prefab = "Furnitures_001/Prefabs/js2017_desk_a_001", size = __rt_8}
, 
[720019] = {can_binding = true, id = 720019, intro = 258104, name = 268622, prefab = "Furnitures_001/Prefabs/kft2016_bed_001", size = __rt_2}
, 
[720020] = {can_binding = true, id = 720020, intro = 448033, name = 184983, prefab = "Furnitures_001/Prefabs/kft2016_chair_a_001"}
, 
[720021] = {id = 720021, intro = 16153, prefab = "Furnitures_001/Prefabs/kft2016_table_001", size = __rt_8}
, 
[720022] = {id = 720022, intro = 422278, name = 497438, prefab = "Furnitures_001/Prefabs/kft2016_walldeco_001", size = __rt_7, type = 2}
, 
[720023] = {can_binding = true, id = 720023, intro = 202230, name = 212202, prefab = "Furnitures_001/Prefabs/loft2016_bed_001", 
size = {4, 3}
}
, 
[720024] = {id = 720024, intro = 90798, name = 92644, prefab = "Furnitures_001/Prefabs/loft2016_bedstand_001"}
, 
[720025] = {can_binding = true, id = 720025, intro = 481419, name = 256695, prefab = "Furnitures_001/Prefabs/loft2016_chair_a_001"}
, 
[720026] = {can_binding = true, id = 720026, intro = 135252, name = 509688, prefab = "Furnitures_001/Prefabs/rs2016_bed_001", 
size = {4, 2}
}
, 
[720027] = {can_binding = true, id = 720027, intro = 306611, name = 254101, prefab = "Furnitures_001/Prefabs/rs2016_chair_bs_001"}
, 
[720028] = {can_binding = true, id = 720028, intro = 435028, name = 435344, prefab = "Furnitures_001/Prefabs/rs2016_table_001", size = __rt_6}
, 
[720029] = {can_binding = true, id = 720029, 
interact_point = {2}
, 
interact_point_coord = {
{-0.2, 0.08, 0.1}
}
, 
interact_start_coord = {
{-0.3, 0.1}
}
, intro = 225013, name = 317525, prefab = "Furnitures_001/Prefabs/ws2016_bed_001", size = __rt_7}
, 
[720030] = {can_binding = true, id = 720030, 
interact_point = {1}
, 
interact_point_coord = {
{0, 0.02, 0.1}
}
, 
interact_start_coord = {
{0, 0.3}
}
, intro = 51186, name = 437127, prefab = "Furnitures_001/Prefabs/ws2016_chair_a_001"}
, 
[720031] = {id = 720031, intro = 192638, name = 192248, prefab = "Furnitures_001/Prefabs/ws2016_deco_big_001"}
, 
[720032] = {id = 720032, intro = 138593, name = 422693, prefab = "Furnitures_001/Prefabs/ws2016_table_001", size = __rt_6}
, 
[720033] = {id = 720033, name = 501109, prefab = "Furnitures_001/Prefabs/tx2016_walldeco_003", type = 2}
, 
[720034] = {can_binding = true, id = 720034, name = 516584, prefab = "Furnitures_001/Prefabs/hdc2018_deco_06", size = __rt_6}
, 
[720035] = {id = 720035, name = 46218, prefab = "Furnitures_001/Prefabs/bank2017_deco_001", 
size = {1, 4}
, type = 1}
, 
[720036] = {id = 720036, name = 461821, prefab = "Furnitures_001/Prefabs/SpringFes2021_deco_014", size = __rt_3}
, 
[720037] = {id = 720037, name = 258640, size = __rt_3}
}
local __default_values = {can_binding = false, comfort = 10, id = 720001, interact_point = __rt_1, interact_point_coord = __rt_1, interact_start_coord = __rt_1, intro = "", name = 104481, prefab = "Furnitures_001/Prefabs/SpringFes2021_deco_013", size = __rt_5, type = 3}
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

