-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1}
local __rt_2 = {}
local __rt_3 = {3}
local __rt_4 = {1101}
local __rt_5 = {1102}
local __rt_6 = {1103}
local __rt_7 = {1105}
local __rt_8 = {1106}
local __rt_9 = {1110}
local __rt_10 = {1108}
local __rt_11 = {1107}
local __rt_12 = {3108}
local __rt_13 = {1111}
local __rt_14 = {1104}
local __rt_15 = {4101}
local __rt_16 = {2113}
local __rt_17 = {3, 7}
local __rt_18 = {0, 1}
local __rt_19 = {3102}
local system_open = {
[100] = {name = 318630, pre_condition = __rt_1}
, 
[101] = {id = 101, name = 399288, pre_condition = __rt_1}
, 
[102] = {id = 102, name = 216801, pre_para1 = __rt_4}
, 
[103] = {id = 103, name = 236736, pre_para1 = __rt_4}
, 
[200] = {id = 200, name = 140477, pre_condition = __rt_1}
, 
[201] = {id = 201, is_push = true, name = 360654, pre_para1 = __rt_5}
, 
[202] = {id = 202, name = 267606, pre_condition = __rt_1}
, 
[203] = {id = 203, name = 442924, pre_condition = __rt_1}
, 
[204] = {id = 204, name = 170717, pre_condition = __rt_1}
, 
[205] = {id = 205, name = 317634, pre_para1 = __rt_6}
, 
[206] = {id = 206, name = 414084, pre_condition = __rt_1}
, 
[207] = {id = 207, name = 271885, pre_para1 = __rt_7}
, 
[300] = {id = 300, name = 104709, pre_condition = __rt_1}
, 
[301] = {id = 301, name = 294254, pre_para1 = __rt_4}
, 
[302] = {id = 302, name = 258853, pre_para1 = __rt_4}
, 
[400] = {id = 400, name = 359559, pre_condition = __rt_1}
, 
[401] = {id = 401, name = 203242, pre_condition = __rt_1, screening = true}
, 
[402] = {id = 402, name = 119391, pre_condition = __rt_1}
, 
[403] = {id = 403, is_push = true, name = 97868, pre_para1 = __rt_8}
, 
[404] = {id = 404, is_push = true, name = 115817, 
pre_para1 = {2103}
, unlock_view = true}
, 
[405] = {id = 405, name = 366745, pre_condition = __rt_1, screening = true}
, 
[406] = {id = 406, pre_condition = __rt_1}
, 
[407] = {id = 407, is_push = true, name = 516921, pre_para1 = __rt_9}
, 
[408] = {id = 408, name = 408213, pre_para1 = __rt_4}
, 
[409] = {id = 409, pre_para1 = __rt_6}
, 
[410] = {id = 410, is_push = true, name = 308351, pre_para1 = __rt_10, unlock_view = true}
, 
[411] = {id = 411, name = 246157, pre_para1 = __rt_5}
, 
[412] = {id = 412, name = 299290, pre_para1 = __rt_10, screening = true}
, 
[413] = {id = 413, name = 177236, pre_para1 = __rt_7}
, 
[414] = {id = 414, name = 115947, pre_para1 = __rt_11}
, 
[415] = {id = 415, name = 236347, pre_para1 = __rt_6}
, 
[416] = {id = 416, name = 77014, pre_para1 = __rt_8}
, 
[417] = {id = 417, name = 62761, pre_condition = __rt_1}
, 
[500] = {id = 500, name = 336365, pre_condition = __rt_1}
, 
[501] = {id = 501, name = 93396, pre_condition = __rt_1}
, 
[502] = {id = 502, name = 432664, pre_para1 = __rt_6}
, 
[503] = {id = 503, name = 514717, pre_para1 = __rt_12}
, 
[504] = {id = 504, name = 62926, pre_para1 = __rt_7, unlock_view = true}
, 
[505] = {id = 505, name = 207700, pre_para1 = __rt_9}
, 
[506] = {id = 506, is_push = true, name = 150835, pre_para1 = __rt_13}
, 
[600] = {id = 600, name = 521100, pre_para1 = __rt_4}
, 
[610] = {id = 610, name = 99205, pre_para1 = __rt_14}
, 
[611] = {id = 611, name = 233887, pre_para1 = __rt_14}
, 
[700] = {id = 700, name = 347301, pre_condition = __rt_1, screening = true}
, 
[800] = {id = 800, name = 431198, pre_condition = __rt_1}
, 
[801] = {id = 801, name = 431198, pre_para1 = __rt_6}
, 
[900] = {id = 900, is_push = true, name = 157038, pre_para1 = __rt_15, unlock_view = true}
, 
[901] = {id = 901, name = 99079, pre_condition = __rt_2, pre_para1 = __rt_2, screening = true}
, 
[1000] = {id = 1000, name = 87180, pre_condition = __rt_1, screening = true}
, 
[1001] = {id = 1001, name = 429705, pre_condition = __rt_1, screening = true}
, 
[1100] = {id = 1100, name = 143955, pre_condition = __rt_2, pre_para1 = __rt_2, screening = true}
, 
[1200] = {id = 1200, is_push = true, name = 328900, pre_para1 = __rt_16, unlock_view = true}
, 
[1201] = {id = 1201, name = 115255, pre_para1 = __rt_15}
, 
[1202] = {id = 1202, name = 230895, pre_condition = __rt_1, screening = true}
, 
[1203] = {id = 1203, name = 449749, pre_para1 = __rt_15}
, 
[1204] = {id = 1204, name = 480857, pre_para1 = __rt_15}
, 
[1300] = {id = 1300, name = 413834, pre_para1 = __rt_5}
, 
[1301] = {id = 1301, name = 25645, pre_condition = __rt_1}
, 
[1400] = {id = 1400, name = 258001, pre_para1 = __rt_13}
, 
[1401] = {id = 1401, is_push = true, name = 18753, pre_para1 = __rt_13, unlock_view = true}
, 
[1500] = {id = 1500, name = 189959, pre_condition = __rt_1}
, 
[1501] = {id = 1501, is_push = true, name = 414861, pre_para1 = __rt_8, unlock_view = true}
, 
[1502] = {id = 1502, name = 412892, pre_para1 = __rt_14}
, 
[1600] = {id = 1600, name = 211381, pre_condition = __rt_1}
, 
[1700] = {id = 1700, is_push = true, name = 131260, pre_para1 = __rt_11, unlock_view = true}
, 
[1701] = {id = 1701, name = 195943, pre_para1 = __rt_11}
, 
[1702] = {id = 1702, name = 491260, pre_para1 = __rt_11}
, 
[1703] = {id = 1703, name = 82201, pre_para1 = __rt_16}
, 
[1704] = {id = 1704, name = 217897, pre_condition = __rt_17, 
pre_para1 = {3109, 12002}
, pre_para2 = __rt_18}
, 
[1705] = {id = 1705, name = 482893, pre_para1 = __rt_11}
, 
[1706] = {id = 1706, name = 252100, pre_para1 = __rt_11}
, 
[1707] = {id = 1707, name = 218960, pre_para1 = __rt_11}
, 
[1708] = {id = 1708, name = 499747, pre_para1 = __rt_11}
, 
[1709] = {id = 1709, name = 280454, pre_para1 = __rt_11}
, 
[1710] = {id = 1710, name = 7289, pre_para1 = __rt_12}
, 
[1711] = {id = 1711, name = 40316, pre_para1 = __rt_12}
, 
[1712] = {id = 1712, name = 192744, pre_para1 = __rt_12}
, 
[1713] = {id = 1713, name = 350835, pre_para1 = __rt_12}
, 
[1714] = {id = 1714, name = 498958, pre_para1 = __rt_12}
, 
[1715] = {id = 1715, name = 222440, pre_condition = __rt_17, 
pre_para1 = {4109, 12006}
, pre_para2 = __rt_18}
, 
[1800] = {id = 1800, is_push = true, name = 241168, pre_para1 = __rt_9, unlock_view = true}
, 
[1801] = {id = 1801, name = 297704, 
pre_para1 = {2104}
, screening = true}
, 
[1900] = {id = 1900, is_push = true, name = 400858, 
pre_para1 = {1109}
, unlock_view = true}
, 
[2000] = {id = 2000, name = 445335, pre_condition = __rt_1}
, 
[2100] = {id = 2100, name = 105999, pre_para1 = __rt_16}
, 
[2200] = {id = 2200, name = 338649, pre_condition = __rt_1, 
pre_para1 = {100}
, screening = true}
, 
[2201] = {id = 2201, is_push = true, name = 210808, pre_para1 = __rt_19, unlock_view = true}
, 
[2202] = {id = 2202, name = 228583, pre_para1 = __rt_19}
, 
[2203] = {id = 2203, name = 164327, pre_para1 = __rt_19}
, 
[2204] = {id = 2204, is_push = true, name = 403987, 
pre_para1 = {3106}
, unlock_view = true}
, 
[2205] = {id = 2205, is_push = true, name = 139708, 
pre_para1 = {3113}
, unlock_view = true}
, 
[2300] = {id = 2300, name = 487929, pre_para1 = __rt_8, 
trigger = {1, 1, 1, 1, 1, 1}
, 
trigger_para1 = {100100, 100101, 100102, 100103, 100104, 100105}
}
, 
[2301] = {id = 2301, name = 171870, pre_condition = __rt_1}
, 
[2401] = {id = 2401, name = 129071, pre_para1 = __rt_6}
, 
[2501] = {id = 2501, is_push = true, name = 311305, 
pre_para1 = {2114}
}
, 
[2601] = {id = 2601, is_push = true, name = 422501, pre_para1 = __rt_14}
, 
[2602] = {id = 2602, is_push = true, name = 429796, pre_para1 = __rt_14}
, 
[2701] = {id = 2701, name = 51667, pre_para1 = __rt_5}
, 
[40201] = {id = 40201, name = 349157, pre_para1 = __rt_8}
, 
[40401] = {id = 40401, is_push = true, name = 133766, 
pre_para1 = {2108}
, unlock_view = true}
}
local __default_values = {id = 100, is_push = false, name = 388889, pre_condition = __rt_3, pre_para1 = __rt_1, pre_para2 = __rt_2, screening = false, trigger = __rt_2, trigger_para1 = __rt_2, trigger_para2 = __rt_2, type = 1, unlock_view = false}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(system_open) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
mainLevelUnlock = {[1105] = 504, [1106] = 1501, [1107] = 1700, [1108] = 410, [1109] = 1900, [1110] = 1800, [1111] = 1401, [2103] = 404, [2108] = 40401, [2113] = 1200, [3102] = 2201, [3106] = 2204, [3113] = 2205, [4101] = 900}
}
setmetatable(system_open, {__index = __rawdata})
return system_open

