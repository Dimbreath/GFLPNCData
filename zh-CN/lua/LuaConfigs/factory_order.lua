local __rt_1 = {}
local __rt_2 = {3}
local __rt_3 = {3106}
local __rt_4 = {3112}
local __rt_5 = {1101, 1107, 1113}
local __rt_6 = {1008, 1004}
local __rt_7 = {4113}
local __rt_8 = {[1004] = 100, [1008] = 150}
local __rt_9 = {1102, 1108, 1114}
local __rt_10 = {4101}
local __rt_11 = {[1102] = 12, [1108] = 8, [1114] = 8}
local __rt_12 = {1109, 1103, 1115}
local __rt_13 = {4105}
local __rt_14 = {[1103] = 20, [1109] = 14, [1115] = 12}
local __rt_15 = {[1103] = 14, [1109] = 12, [1115] = 20}
local __rt_16 = {[1103] = 12, [1109] = 20, [1115] = 14}
local __rt_17 = {4114}
local factory_order = {
{name = 523996, outPutItemNum = 1200, time_cost = 7200, type = 1}
, 
{id = 2, name = 380891, outPutItemId = 1004, outPutItemNum = 50, time_cost = 7200, type = 1}
, 
{id = 3, name = 406428, outPutItemId = 1113, time_cost = 120, type = 1}
, 
{id = 4, name = 54601, outPutItemId = 1101, time_cost = 120, type = 1}
, 
{id = 5, name = 99474, outPutItemId = 1107, time_cost = 120, type = 1}
, 
{id = 6, name = 460713, outPutItemId = 1102, 
pre_para1 = {3107}
, time_cost = 240, type = 1}
, 
{id = 7, name = 505586, outPutItemId = 1108, 
pre_para1 = {3108}
, time_cost = 240, type = 1}
, 
{id = 8, name = 288252, outPutItemId = 1114, 
pre_para1 = {3109}
, time_cost = 240, type = 1}
, 
{id = 9, name = 465256, outPutItemId = 1103, 
pre_para1 = {3110}
, type = 1}
, 
{id = 10, name = 292795, outPutItemId = 1115, 
pre_para1 = {3111}
, type = 1}
, 
{id = 11, name = 510129, outPutItemId = 1109, pre_para1 = __rt_4, type = 1}
, 
{id = 12, materialOrder = __rt_5, name = 110346, outPutItemId = 5001, 
raw_material = {[1101] = 3, [1107] = 2, [1113] = 2}
, time_cost = 60, type = 2}
, 
{id = 13, 
materialOrder = {1107, 1108, 1103}
, name = 341267, outPutItemId = 5002, 
raw_material = {[1103] = 6, [1107] = 9, [1108] = 7}
, type = 2}
, 
{id = 14, materialOrder = __rt_5, name = 269060, outPutItemId = 3005, 
raw_material = {[1101] = 12, [1107] = 12, [1113] = 12}
, time_cost = 30, type = 2}
, 
{id = 15, materialOrder = __rt_6, name = 234135, outPutItemId = 6003, pre_para1 = __rt_7, raw_material = __rt_8, time_cost = 30, type = 2}
, 
{id = 16, materialOrder = __rt_6, name = 162764, outPutItemId = 8030, 
raw_material = {[1004] = 20, [1008] = 50}
, type = 2}
, 
{id = 17, materialOrder = __rt_6, name = 148991, outPutItemId = 8031, 
pre_para1 = {4108}
, 
raw_material = {[1004] = 50, [1008] = 100}
, time_cost = 720, type = 2}
, 
{id = 18, materialOrder = __rt_6, name = 161704, outPutItemId = 8032, 
pre_para1 = {5101}
, raw_material = __rt_8, time_cost = 1440, type = 2}
, 
{id = 19, materialOrder = __rt_5, name = 50798, outPutItemId = 3100, pre_para1 = __rt_4, 
raw_material = {[1101] = 6, [1107] = 6, [1113] = 8}
, time_cost = 1200}
, 
{id = 20, materialOrder = __rt_5, name = 452916, outPutItemId = 3103, pre_para1 = __rt_4, 
raw_material = {[1101] = 6, [1107] = 8, [1113] = 6}
, time_cost = 1200}
, 
{id = 21, materialOrder = __rt_5, name = 458608, outPutItemId = 3106, pre_para1 = __rt_4, 
raw_material = {[1101] = 4, [1107] = 10, [1113] = 6}
, time_cost = 1200}
, 
{id = 22, materialOrder = __rt_5, name = 256794, outPutItemId = 3109, pre_para1 = __rt_4, 
raw_material = {[1101] = 6, [1107] = 4, [1113] = 10}
, time_cost = 1200}
, 
{id = 23, materialOrder = __rt_5, name = 139727, outPutItemId = 3110, pre_para1 = __rt_4, 
raw_material = {[1101] = 10, [1107] = 6, [1113] = 4}
, time_cost = 1200}
, 
{id = 24, materialOrder = __rt_5, name = 517120, outPutItemId = 3115, pre_para1 = __rt_4, 
raw_material = {[1101] = 4, [1107] = 8, [1113] = 8}
, time_cost = 1200}
, 
{id = 25, materialOrder = __rt_5, name = 117450, outPutItemId = 3118, pre_para1 = __rt_4, 
raw_material = {[1101] = 4, [1107] = 6, [1113] = 10}
, time_cost = 1200}
, 
{id = 26, materialOrder = __rt_5, outPutItemId = 3121, pre_para1 = __rt_4, 
raw_material = {[1101] = 6, [1107] = 10, [1113] = 4}
, time_cost = 1200}
, 
{id = 27, materialOrder = __rt_9, name = 256989, outPutItemId = 3101, pre_para1 = __rt_10, raw_material = __rt_11, time_cost = 2880}
, 
{id = 28, materialOrder = __rt_9, name = 495834, outPutItemId = 3104, pre_para1 = __rt_10, 
raw_material = {[1102] = 8, [1108] = 8, [1114] = 12}
, time_cost = 2880}
, 
{id = 29, materialOrder = __rt_9, name = 209339, outPutItemId = 3107, pre_para1 = __rt_10, 
raw_material = {[1102] = 10, [1108] = 10, [1114] = 8}
, time_cost = 2880}
, 
{id = 30, materialOrder = __rt_9, name = 143224, outPutItemId = 3111, pre_para1 = __rt_10, 
raw_material = {[1102] = 12, [1108] = 6, [1114] = 10}
, time_cost = 2880}
, 
{id = 31, materialOrder = __rt_9, name = 392694, outPutItemId = 3112, pre_para1 = __rt_10, 
raw_material = {[1102] = 10, [1108] = 8, [1114] = 10}
, time_cost = 2880}
, 
{id = 32, materialOrder = __rt_9, name = 299126, outPutItemId = 3116, pre_para1 = __rt_10, 
raw_material = {[1102] = 8, [1108] = 10, [1114] = 10}
, time_cost = 2880}
, 
{id = 33, materialOrder = __rt_9, name = 22124, outPutItemId = 3119, pre_para1 = __rt_10, raw_material = __rt_11, time_cost = 2880}
, 
{id = 34, materialOrder = __rt_9, name = 493497, outPutItemId = 3122, pre_para1 = __rt_10, 
raw_material = {[1102] = 8, [1108] = 12, [1114] = 8}
, time_cost = 2880}
, 
{id = 35, materialOrder = __rt_12, name = 172479, outPutItemId = 3102, pre_para1 = __rt_13, 
raw_material = {[1103] = 20, [1109] = 12, [1115] = 14}
, time_cost = 7200}
, 
{id = 36, materialOrder = __rt_12, name = 259884, outPutItemId = 3105, pre_para1 = __rt_13, 
raw_material = {[1103] = 14, [1109] = 20, [1115] = 12}
, time_cost = 7200}
, 
{id = 37, materialOrder = __rt_12, name = 320546, outPutItemId = 3108, pre_para1 = __rt_13, raw_material = __rt_14, time_cost = 7200}
, 
{id = 38, materialOrder = __rt_12, name = 209968, outPutItemId = 3113, pre_para1 = __rt_13, raw_material = __rt_15, time_cost = 7200}
, 
{id = 39, materialOrder = __rt_12, name = 141217, outPutItemId = 3114, pre_para1 = __rt_13, raw_material = __rt_16, time_cost = 7200}
, 
{id = 40, materialOrder = __rt_12, name = 340108, outPutItemId = 3117, pre_para1 = __rt_13, raw_material = __rt_14, time_cost = 7200}
, 
{id = 41, materialOrder = __rt_12, name = 500268, outPutItemId = 3120, pre_para1 = __rt_13, raw_material = __rt_15, time_cost = 7200}
, 
{id = 42, materialOrder = __rt_12, name = 235855, outPutItemId = 3123, pre_para1 = __rt_13, raw_material = __rt_16, time_cost = 7200}
, 
{id = 43, 
materialOrder = {1816, 1102, 1115}
, name = 249287, outPutItemId = 1821, pre_para1 = __rt_17, 
raw_material = {[1102] = 15, [1115] = 13, [1816] = 3}
, type = 4}
, 
{id = 44, 
materialOrder = {1817, 1108, 1109}
, name = 468580, outPutItemId = 1822, pre_para1 = __rt_17, 
raw_material = {[1108] = 15, [1109] = 13, [1817] = 3}
, type = 4}
, 
{id = 45, 
materialOrder = {1818, 1102, 1103}
, name = 220933, outPutItemId = 1823, pre_para1 = __rt_17, 
raw_material = {[1102] = 15, [1103] = 13, [1818] = 3}
, type = 4}
, 
{id = 46, 
materialOrder = {1819, 1114, 1103}
, name = 451726, outPutItemId = 1824, pre_para1 = __rt_17, 
raw_material = {[1103] = 13, [1114] = 15, [1819] = 3}
, type = 4}
, 
{id = 47, 
materialOrder = {1820, 1108, 1115}
, name = 187793, outPutItemId = 1825, pre_para1 = __rt_17, 
raw_material = {[1108] = 15, [1115] = 13, [1820] = 3}
, type = 4}
, 
{id = 48, materialOrder = __rt_6, name = 129983, outPutItemId = 6001, pre_para1 = __rt_7, 
raw_material = {[1004] = 20, [1008] = 2}
, time_cost = 60, type = 2}
, 
{id = 49, materialOrder = __rt_6, name = 502114, outPutItemId = 6002, pre_para1 = __rt_7, 
raw_material = {[1004] = 100, [1008] = 10}
, time_cost = 180, type = 2}
, 
{id = 50, 
materialOrder = {1108, 1114, 1004}
, name = 346886, outPutItemId = 1502, 
pre_para1 = {4115}
, 
raw_material = {[1004] = 300, [1108] = 26, [1114] = 34}
, time_cost = 14400, type = 4}
}
local __default_values = {id = 1, materialOrder = __rt_1, name = 108828, outPutItemId = 1003, outPutItemNum = 1, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_1, raw_material = __rt_1, time_cost = 360, type = 3}
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
sudOrderListIds = {3, 4, 5}
}
, 
{id = 15, 
sudOrderListIds = {2}
}
, 
{id = 16, 
sudOrderListIds = {2}
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
sudOrderListIds = {3, 4, 5}
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
sudOrderListIds = {3, 4, 5}
}
, 
{id = 26, 
sudOrderListIds = {3, 4, 5}
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
sudOrderListIds = {6, 7, 8}
}
, 
{id = 32, 
sudOrderListIds = {6, 7, 8}
}
, 
{id = 33, 
sudOrderListIds = {6, 7, 8}
}
, 
{id = 34, 
sudOrderListIds = {6, 7, 8}
}
, 
{id = 35, 
sudOrderListIds = {9, 10, 11}
}
, 
{id = 36, 
sudOrderListIds = {9, 10, 11}
}
, 
{id = 37, 
sudOrderListIds = {9, 10, 11}
}
, 
{id = 38, 
sudOrderListIds = {9, 10, 11}
}
, 
{id = 39, 
sudOrderListIds = {9, 10, 11}
}
, 
{id = 40, 
sudOrderListIds = {9, 10, 11}
}
, 
{id = 41, 
sudOrderListIds = {9, 10, 11}
}
, 
{id = 42, 
sudOrderListIds = {9, 10, 11}
}
, 
{id = 43, 
sudOrderListIds = {6, 10}
}
, 
{id = 44, 
sudOrderListIds = {7, 11}
}
, 
{id = 45, 
sudOrderListIds = {6, 9}
}
, 
{id = 46, 
sudOrderListIds = {8, 9}
}
, 
{id = 47, 
sudOrderListIds = {7, 10}
}
, 
{id = 48, 
sudOrderListIds = {2}
}
, 
{id = 49, 
sudOrderListIds = {2}
}
, 
{id = 50, 
sudOrderListIds = {2, 7, 8}
}
}
}
setmetatable(factory_order, {__index = __rawdata})
return factory_order

