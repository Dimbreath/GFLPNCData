-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {3}
local __rt_2 = {3101}
local __rt_3 = {}
local __rt_4 = {3105}
local __rt_5 = {3110}
local __rt_6 = {4101}
local __rt_7 = {3112}
local __rt_8 = {4112}
local __rt_9 = {5112}
local __rt_10 = {4110}
local __rt_11 = {[1103] = 12, [1109] = 12, [1114] = 10}
local __rt_12 = {[1108] = 10, [1109] = 12, [1115] = 12}
local factory_order = {
{energy_cost = 200, name = 54192, outPutItemNum = 1000, pre_para1 = __rt_2, type = 1}
, 
{energy_cost = 200, id = 2, name = 90642, outPutItemId = 1004, outPutItemNum = 50, pre_para1 = __rt_2, type = 1}
, 
{energy_cost = 3, id = 3, outPutItemId = 1113, pre_para1 = __rt_4, type = 1}
, 
{energy_cost = 3, id = 4, name = 205558, outPutItemId = 1101, pre_para1 = __rt_4, type = 1}
, 
{energy_cost = 3, id = 5, name = 378213, outPutItemId = 1107, pre_para1 = __rt_4, type = 1}
, 
{energy_cost = 6, id = 6, name = 409093, outPutItemId = 1102, pre_para1 = __rt_5, type = 1}
, 
{energy_cost = 6, id = 7, name = 57460, outPutItemId = 1108, pre_para1 = __rt_5, type = 1}
, 
{energy_cost = 6, id = 8, name = 216077, outPutItemId = 1114, pre_para1 = __rt_5, type = 1}
, 
{energy_cost = 9, id = 9, name = 88340, outPutItemId = 1103, type = 1}
, 
{energy_cost = 9, id = 10, name = 419612, outPutItemId = 1115, type = 1}
, 
{energy_cost = 9, id = 11, name = 260995, outPutItemId = 1109, type = 1}
, 
{energy_cost = 5, id = 12, name = 476526, outPutItemId = 5001, outPutItemNum = 2, pre_para1 = __rt_2, 
raw_material = {[1107] = 1, [1113] = 1}
, type = 2}
, 
{id = 13, name = 263161, outPutItemId = 5002, pre_para1 = __rt_2, 
raw_material = {[1101] = 3, [1103] = 1, [1114] = 2}
, type = 2}
, 
{energy_cost = 30, id = 14, name = 436762, outPutItemId = 5007, pre_para1 = __rt_2, 
raw_material = {[1108] = 5, [1109] = 8, [1115] = 9}
, type = 2}
, 
{energy_cost = 100, id = 15, name = 269060, outPutItemId = 3005, pre_para1 = __rt_4, 
raw_material = {[1103] = 12, [1109] = 12, [1115] = 12}
, type = 2}
, 
{energy_cost = 20, id = 16, name = 287076, outPutItemId = 5005, pre_para1 = __rt_5, 
raw_material = {[1102] = 6, [1107] = 4, [1113] = 4}
, type = 2}
, 
{energy_cost = 50, id = 17, name = 162764, outPutItemId = 8030, 
raw_material = {[1004] = 20, [1008] = 500}
, type = 2}
, 
{energy_cost = 100, id = 18, name = 27994, outPutItemId = 8031, 
pre_para1 = {4108}
, 
raw_material = {[1004] = 50, [1008] = 2000}
, type = 2}
, 
{energy_cost = 200, id = 19, name = 276126, outPutItemId = 8032, 
pre_para1 = {5101}
, 
raw_material = {[1004] = 100, [1008] = 4000}
, type = 2}
, 
{id = 20, name = 50798, outPutItemId = 3100, pre_para1 = __rt_7, 
raw_material = {[1101] = 6, [1107] = 6, [1113] = 8}
}
, 
{id = 21, name = 452916, outPutItemId = 3101, pre_para1 = __rt_7, 
raw_material = {[1101] = 6, [1107] = 8, [1113] = 6}
}
, 
{id = 22, name = 458608, outPutItemId = 3102, pre_para1 = __rt_7, 
raw_material = {[1101] = 4, [1107] = 10, [1113] = 6}
}
, 
{id = 23, name = 256794, outPutItemId = 3104, pre_para1 = __rt_7, 
raw_material = {[1101] = 6, [1107] = 4, [1113] = 10}
}
, 
{id = 24, name = 139727, outPutItemId = 3105, pre_para1 = __rt_7, 
raw_material = {[1101] = 10, [1107] = 6, [1113] = 4}
}
, 
{energy_cost = 20, id = 25, name = 256989, outPutItemId = 3106, pre_para1 = __rt_8, 
raw_material = {[1102] = 12, [1108] = 6, [1114] = 8}
}
, 
{energy_cost = 20, id = 26, name = 495834, outPutItemId = 3107, pre_para1 = __rt_8, 
raw_material = {[1102] = 6, [1108] = 8, [1114] = 12}
}
, 
{energy_cost = 20, id = 27, name = 209339, outPutItemId = 3108, pre_para1 = __rt_8, 
raw_material = {[1102] = 10, [1108] = 10, [1114] = 6}
}
, 
{energy_cost = 20, id = 28, name = 143224, outPutItemId = 3109, pre_para1 = __rt_8, 
raw_material = {[1102] = 12, [1108] = 4, [1114] = 10}
}
, 
{energy_cost = 20, id = 29, name = 392694, outPutItemId = 3111, pre_para1 = __rt_8, 
raw_material = {[1102] = 10, [1108] = 6, [1114] = 10}
}
, 
{energy_cost = 40, id = 30, name = 209968, outPutItemId = 3103, pre_para1 = __rt_9, 
raw_material = {[1103] = 20, [1109] = 12, [1115] = 15}
}
, 
{energy_cost = 40, id = 31, name = 141217, outPutItemId = 3110, pre_para1 = __rt_9, 
raw_material = {[1103] = 15, [1109] = 20, [1115] = 12}
}
, 
{energy_cost = 40, id = 32, name = 172479, outPutItemId = 3112, pre_para1 = __rt_9, 
raw_material = {[1103] = 20, [1109] = 15, [1115] = 12}
}
, 
{energy_cost = 40, id = 33, name = 259884, outPutItemId = 3113, pre_para1 = __rt_9, 
raw_material = {[1103] = 15, [1109] = 12, [1115] = 20}
}
, 
{energy_cost = 40, id = 34, name = 320546, outPutItemId = 3114, pre_para1 = __rt_9, 
raw_material = {[1103] = 12, [1109] = 20, [1115] = 15}
}
, 
{energy_cost = 12, id = 35, name = 249287, outPutItemId = 1821, 
raw_material = {[1102] = 8, [1107] = 8, [1115] = 16}
, type = 4}
, 
{energy_cost = 12, id = 36, name = 468580, outPutItemId = 1822, 
raw_material = {[1108] = 8, [1109] = 16, [1113] = 8}
, type = 4}
, 
{energy_cost = 12, id = 37, name = 220933, outPutItemId = 1823, 
raw_material = {[1102] = 8, [1103] = 16, [1113] = 8}
, type = 4}
, 
{energy_cost = 12, id = 38, name = 451726, outPutItemId = 1824, 
raw_material = {[1101] = 8, [1103] = 16, [1114] = 8}
, type = 4}
, 
{energy_cost = 12, id = 39, name = 187793, outPutItemId = 1825, 
raw_material = {[1101] = 8, [1108] = 8, [1115] = 16}
, type = 4}
, 
{energy_cost = 30, id = 40, name = 479576, outPutItemId = 1516, pre_para1 = __rt_10, raw_material = __rt_11, type = 4}
, 
{energy_cost = 30, id = 41, name = 174580, outPutItemId = 1517, pre_para1 = __rt_10, 
raw_material = {[1102] = 10, [1103] = 12, [1115] = 12}
, type = 4}
, 
{energy_cost = 30, id = 42, name = 451221, outPutItemId = 1518, pre_para1 = __rt_10, raw_material = __rt_12, type = 4}
, 
{energy_cost = 30, id = 43, name = 157726, outPutItemId = 1519, pre_para1 = __rt_10, raw_material = __rt_12, type = 4}
, 
{energy_cost = 30, id = 44, name = 418081, outPutItemId = 1520, pre_para1 = __rt_10, raw_material = __rt_11, type = 4}
}
local __default_values = {energy_cost = 10, id = 1, name = 12542, outPutItemId = 1003, outPutItemNum = 1, pre_condition = __rt_1, pre_para1 = __rt_6, pre_para2 = __rt_3, raw_material = __rt_3, type = 3}
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
sudOrderListIds = {3, 5}
}
, 
{id = 13, 
sudOrderListIds = {4, 8, 9}
}
, 
{id = 14, 
sudOrderListIds = {7, 10, 11}
}
, 
{id = 15, 
sudOrderListIds = {9, 10, 11}
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
sudOrderListIds = {3, 4, 5}
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
sudOrderListIds = {6, 7, 8}
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
sudOrderListIds = {9, 10, 11}
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
sudOrderListIds = {5, 6, 10}
}
, 
{id = 36, 
sudOrderListIds = {3, 7, 11}
}
, 
{id = 37, 
sudOrderListIds = {3, 6, 9}
}
, 
{id = 38, 
sudOrderListIds = {4, 8, 9}
}
, 
{id = 39, 
sudOrderListIds = {4, 7, 10}
}
, 
{id = 40, 
sudOrderListIds = {8, 9, 11}
}
, 
{id = 41, 
sudOrderListIds = {6, 9, 10}
}
, 
{id = 42, 
sudOrderListIds = {7, 10, 11}
}
, 
{id = 43, 
sudOrderListIds = {7, 10, 11}
}
, 
{id = 44, 
sudOrderListIds = {8, 9, 11}
}
}
}
setmetatable(factory_order, {__index = __rawdata})
return factory_order

