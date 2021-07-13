-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {3}
local __rt_3 = {4101}
local __rt_4 = {4105}
local __rt_5 = {4106}
local __rt_6 = {1101, 1107, 1113}
local __rt_7 = {3105}
local __rt_8 = {1008, 1004}
local __rt_9 = {4108}
local __rt_10 = {[1004] = 100, [1008] = 150}
local __rt_11 = {4111}
local __rt_12 = {1102, 1108, 1114}
local __rt_13 = {4115}
local __rt_14 = {1109, 1103, 1115}
local factory_order = {
{energy_cost = 100, name = 523996, outPutItemNum = 2400, type = 1}
, 
{energy_cost = 200, id = 2, name = 380891, outPutItemId = 1004, outPutItemNum = 100, type = 1}
, 
{energy_cost = 3, id = 3, outPutItemId = 1113, type = 1}
, 
{energy_cost = 3, id = 4, name = 205558, outPutItemId = 1101, type = 1}
, 
{energy_cost = 3, id = 5, name = 378213, outPutItemId = 1107, type = 1}
, 
{energy_cost = 6, id = 6, name = 409093, outPutItemId = 1102, 
pre_para1 = {4102}
, type = 1}
, 
{energy_cost = 6, id = 7, name = 57460, outPutItemId = 1108, 
pre_para1 = {4103}
, type = 1}
, 
{energy_cost = 6, id = 8, name = 216077, outPutItemId = 1114, 
pre_para1 = {4104}
, type = 1}
, 
{energy_cost = 9, id = 9, name = 88340, outPutItemId = 1103, pre_para1 = __rt_4, type = 1}
, 
{energy_cost = 9, id = 10, name = 419612, outPutItemId = 1115, pre_para1 = __rt_5, type = 1}
, 
{energy_cost = 9, id = 11, name = 260995, outPutItemId = 1109, 
pre_para1 = {4107}
, type = 1}
, 
{energy_cost = 5, id = 12, materialOrder = __rt_6, name = 53613, outPutItemId = 5001, outPutItemNum = 4, pre_para1 = __rt_7, 
raw_material = {[1101] = 3, [1107] = 2, [1113] = 2}
, type = 2}
, 
{energy_cost = 20, id = 13, 
materialOrder = {1107, 1108, 1103}
, name = 364536, outPutItemId = 5002, outPutItemNum = 2, pre_para1 = __rt_7, 
raw_material = {[1103] = 2, [1107] = 5, [1108] = 4}
, type = 2}
, 
{energy_cost = 40, id = 14, 
materialOrder = {1114, 1109, 1115}
, name = 13849, outPutItemId = 5007, pre_para1 = __rt_7, 
raw_material = {[1109] = 7, [1114] = 7, [1115] = 9}
, type = 2}
, 
{energy_cost = 100, id = 15, materialOrder = __rt_6, name = 269060, outPutItemId = 3005, pre_para1 = __rt_4, 
raw_material = {[1101] = 12, [1107] = 12, [1113] = 12}
, type = 2}
, 
{energy_cost = 20, id = 16, 
materialOrder = {1107, 1113, 1102}
, name = 145977, outPutItemId = 5005, 
pre_para1 = {4110}
, 
raw_material = {[1102] = 6, [1107] = 4, [1113] = 4}
, type = 2}
, 
{id = 17, materialOrder = __rt_8, name = 234135, outPutItemId = 6003, pre_para1 = __rt_9, raw_material = __rt_10, type = 2}
, 
{energy_cost = 5, id = 18, materialOrder = __rt_8, name = 162764, outPutItemId = 8030, 
raw_material = {[1004] = 20, [1008] = 50}
, type = 2}
, 
{id = 19, materialOrder = __rt_8, name = 27994, outPutItemId = 8031, pre_para1 = __rt_9, 
raw_material = {[1004] = 50, [1008] = 100}
, type = 2}
, 
{energy_cost = 20, id = 20, materialOrder = __rt_8, name = 276126, outPutItemId = 8032, 
pre_para1 = {5101}
, raw_material = __rt_10, type = 2}
, 
{id = 21, materialOrder = __rt_6, name = 50798, outPutItemId = 3100, pre_para1 = __rt_11, 
raw_material = {[1101] = 6, [1107] = 6, [1113] = 8}
}
, 
{id = 22, materialOrder = __rt_6, name = 452916, outPutItemId = 3101, pre_para1 = __rt_11, 
raw_material = {[1101] = 6, [1107] = 8, [1113] = 6}
}
, 
{id = 23, materialOrder = __rt_6, name = 458608, outPutItemId = 3102, pre_para1 = __rt_11, 
raw_material = {[1101] = 4, [1107] = 10, [1113] = 6}
}
, 
{id = 24, materialOrder = __rt_6, name = 256794, outPutItemId = 3104, pre_para1 = __rt_11, 
raw_material = {[1101] = 6, [1107] = 4, [1113] = 10}
}
, 
{id = 25, materialOrder = __rt_6, name = 139727, outPutItemId = 3105, pre_para1 = __rt_11, 
raw_material = {[1101] = 10, [1107] = 6, [1113] = 4}
}
, 
{energy_cost = 20, id = 26, materialOrder = __rt_12, name = 256989, outPutItemId = 3106, pre_para1 = __rt_13, 
raw_material = {[1102] = 12, [1108] = 6, [1114] = 8}
}
, 
{energy_cost = 20, id = 27, materialOrder = __rt_12, name = 495834, outPutItemId = 3107, pre_para1 = __rt_13, 
raw_material = {[1102] = 6, [1108] = 8, [1114] = 12}
}
, 
{energy_cost = 20, id = 28, materialOrder = __rt_12, name = 209339, outPutItemId = 3108, pre_para1 = __rt_13, 
raw_material = {[1102] = 10, [1108] = 10, [1114] = 6}
}
, 
{energy_cost = 20, id = 29, materialOrder = __rt_12, name = 143224, outPutItemId = 3109, pre_para1 = __rt_13, 
raw_material = {[1102] = 12, [1108] = 4, [1114] = 10}
}
, 
{energy_cost = 20, id = 30, materialOrder = __rt_12, name = 392694, outPutItemId = 3111, pre_para1 = __rt_13, 
raw_material = {[1102] = 10, [1108] = 6, [1114] = 10}
}
, 
{energy_cost = 40, id = 31, materialOrder = __rt_14, name = 209968, outPutItemId = 3103, pre_para1 = __rt_5, 
raw_material = {[1103] = 20, [1109] = 12, [1115] = 15}
}
, 
{energy_cost = 40, id = 32, materialOrder = __rt_14, name = 141217, outPutItemId = 3110, pre_para1 = __rt_5, 
raw_material = {[1103] = 15, [1109] = 20, [1115] = 12}
}
, 
{energy_cost = 40, id = 33, materialOrder = __rt_14, name = 172479, outPutItemId = 3112, pre_para1 = __rt_5, 
raw_material = {[1103] = 20, [1109] = 15, [1115] = 12}
}
, 
{energy_cost = 40, id = 34, materialOrder = __rt_14, name = 259884, outPutItemId = 3113, pre_para1 = __rt_5, 
raw_material = {[1103] = 15, [1109] = 12, [1115] = 20}
}
, 
{energy_cost = 40, id = 35, materialOrder = __rt_14, name = 320546, outPutItemId = 3114, pre_para1 = __rt_5, 
raw_material = {[1103] = 12, [1109] = 20, [1115] = 15}
}
, 
{energy_cost = 12, id = 36, 
materialOrder = {1816, 1102, 1115}
, name = 249287, outPutItemId = 1821, 
raw_material = {[1102] = 4, [1115] = 8, [1816] = 3}
, type = 4}
, 
{energy_cost = 12, id = 37, 
materialOrder = {1817, 1108, 1109}
, name = 468580, outPutItemId = 1822, 
raw_material = {[1108] = 4, [1109] = 8, [1817] = 3}
, type = 4}
, 
{energy_cost = 12, id = 38, 
materialOrder = {1818, 1102, 1103}
, name = 220933, outPutItemId = 1823, 
raw_material = {[1102] = 4, [1103] = 8, [1818] = 3}
, type = 4}
, 
{energy_cost = 12, id = 39, 
materialOrder = {1819, 1114, 1103}
, name = 451726, outPutItemId = 1824, 
raw_material = {[1103] = 8, [1114] = 4, [1819] = 3}
, type = 4}
, 
{energy_cost = 12, id = 40, 
materialOrder = {1820, 1108, 1115}
, name = 187793, outPutItemId = 1825, 
raw_material = {[1108] = 4, [1115] = 8, [1820] = 3}
, type = 4}
, 
{id = 41, materialOrder = __rt_8, name = 129983, outPutItemId = 6001, 
raw_material = {[1004] = 20, [1008] = 2}
, type = 2}
, 
{energy_cost = 50, id = 42, materialOrder = __rt_8, name = 502114, outPutItemId = 6002, 
raw_material = {[1004] = 100, [1008] = 10}
, type = 2}
, 
{energy_cost = 40, id = 43, 
materialOrder = {1108, 1114, 1004}
, name = 346886, outPutItemId = 1502, 
pre_para1 = {5105}
, 
raw_material = {[1004] = 200, [1108] = 14, [1114] = 6}
, type = 4}
}
local __default_values = {energy_cost = 10, id = 1, materialOrder = __rt_1, name = 12542, outPutItemId = 1003, outPutItemNum = 1, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_1, raw_material = __rt_1, type = 3}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(factory_order) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
orderMap = {
{id = 1, 
sudOrderListIds = {}
}
, 
{id = 2, 
sudOrderListIds = {}
}
, 
{id = 3, 
sudOrderListIds = {}
}
, 
{id = 4, 
sudOrderListIds = {}
}
, 
{id = 5, 
sudOrderListIds = {}
}
, 
{id = 6, 
sudOrderListIds = {}
}
, 
{id = 7, 
sudOrderListIds = {}
}
, 
{id = 8, 
sudOrderListIds = {}
}
, 
{id = 9, 
sudOrderListIds = {}
}
, 
{id = 10, 
sudOrderListIds = {}
}
, 
{id = 11, 
sudOrderListIds = {}
}
, 
{id = 12, 
sudOrderListIds = {3, 4, 5}
}
, 
{id = 13, 
sudOrderListIds = {5, 7, 9}
}
, 
{id = 14, 
sudOrderListIds = {8, 10, 11}
}
, 
{id = 15, 
sudOrderListIds = {3, 4, 5}
}
, 
{id = 16, 
sudOrderListIds = {3, 5, 6}
}
, 
{id = 17, 
sudOrderListIds = {2}
}
, 
{id = 18, 
sudOrderListIds = {2}
}
, 
{id = 19, 
sudOrderListIds = {2}
}
, 
{id = 20, 
sudOrderListIds = {2}
}
, 
{id = 21, 
sudOrderListIds = {3, 4, 5}
}
, 
{id = 22, 
sudOrderListIds = {3, 4, 5}
}
, 
{id = 23, 
sudOrderListIds = {3, 4, 5}
}
, 
{id = 24, 
sudOrderListIds = {3, 4, 5}
}
, 
{id = 25, 
sudOrderListIds = {3, 4, 5}
}
, 
{id = 26, 
sudOrderListIds = {6, 7, 8}
}
, 
{id = 27, 
sudOrderListIds = {6, 7, 8}
}
, 
{id = 28, 
sudOrderListIds = {6, 7, 8}
}
, 
{id = 29, 
sudOrderListIds = {6, 7, 8}
}
, 
{id = 30, 
sudOrderListIds = {6, 7, 8}
}
, 
{id = 31, 
sudOrderListIds = {9, 10, 11}
}
, 
{id = 32, 
sudOrderListIds = {9, 10, 11}
}
, 
{id = 33, 
sudOrderListIds = {9, 10, 11}
}
, 
{id = 34, 
sudOrderListIds = {9, 10, 11}
}
, 
{id = 35, 
sudOrderListIds = {9, 10, 11}
}
, 
{id = 36, 
sudOrderListIds = {6, 10}
}
, 
{id = 37, 
sudOrderListIds = {7, 11}
}
, 
{id = 38, 
sudOrderListIds = {6, 9}
}
, 
{id = 39, 
sudOrderListIds = {8, 9}
}
, 
{id = 40, 
sudOrderListIds = {7, 10}
}
, 
{id = 41, 
sudOrderListIds = {2}
}
, 
{id = 42, 
sudOrderListIds = {2}
}
, 
{id = 43, 
sudOrderListIds = {2, 7, 8}
}
}
}
setmetatable(factory_order, {__index = __rawdata})
return factory_order

