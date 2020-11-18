-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1011, 1012, 1013}
local __rt_2 = {1041, 1042, 1043}
local __rt_3 = {1051, 1052, 1053}
local __rt_4 = {1061, 1062, 1063}
local __rt_5 = {1091, 1092, 1093}
local __rt_6 = {1101, 1102, 1103}
local __rt_7 = {9101, 9102, 9103}
local __rt_8 = {1511, 1512, 1513}
local __rt_9 = {1521, 1522, 1523}
local __rt_10 = {1531, 1532, 1533}
local __rt_11 = {1541, 1542, 1543}
local __rt_12 = {1551, 1552, 1553}
local __rt_13 = {1561, 1562, 1563}
local __rt_14 = {2011, 2012, 2013}
local __rt_15 = {2021, 2022, 2023}
local __rt_16 = {2031, 2032, 2033}
local __rt_17 = {2061, 2062, 2063}
local __rt_18 = {2091, 2092, 2093}
local __rt_19 = {2111, 2112, 2113}
local __rt_20 = {2511, 2512, 2513}
local __rt_21 = {2521, 2522, 2523}
local __rt_22 = {2531, 2532, 2533}
local __rt_23 = {2541, 2542, 2543}
local __rt_24 = {2551, 2552, 2553}
local __rt_25 = {2561, 2562, 2563}
local __rt_26 = {10001, 10002, 10004}
local __rt_27 = {10001, 10003, 10004}
local exploration = {
[100] = {chip_pool = __rt_1, scene_id = 3}
, 
[1011] = {chip_pool = __rt_1, id = 1011, scene_id = 3}
, 
[1021] = {
chip_pool = {1021, 1022, 1023}
, id = 1021, scene_id = 3}
, 
[1031] = {
chip_pool = {1031, 1032, 1033}
, id = 1031, scene_id = 3}
, 
[1041] = {chip_pool = __rt_2, id = 1041, scene_id = 3}
, 
[1042] = {chip_pool = __rt_2, id = 1042, scene_id = 3}
, 
[1051] = {chip_pool = __rt_3, id = 1051, scene_id = 3}
, 
[1052] = {chip_pool = __rt_3, id = 1052, scene_id = 3}
, 
[1061] = {chip_pool = __rt_4, id = 1061, scene_id = 3}
, 
[1062] = {chip_pool = __rt_4, id = 1062, scene_id = 3}
, 
[1063] = {chip_pool = __rt_4, id = 1063, scene_id = 3}
, 
[1071] = {
chip_pool = {1071, 1072, 1073}
, id = 1071, scene_id = 3}
, 
[1081] = {
chip_pool = {1081, 1082, 1083}
, id = 1081, scene_id = 3}
, 
[1091] = {chip_pool = __rt_5, id = 1091, scene_id = 3}
, 
[1092] = {chip_pool = __rt_5, id = 1092, scene_id = 3}
, 
[1093] = {chip_pool = __rt_5, id = 1093, scene_id = 3}
, 
[1101] = {chip_pool = __rt_6, id = 1101, scene_id = 3}
, 
[1102] = {chip_pool = __rt_6, id = 1102, scene_id = 3}
, 
[1301] = {chip_pool = __rt_7, id = 1301}
, 
[1302] = {chip_pool = __rt_7, id = 1302}
, 
[1303] = {chip_pool = __rt_7, id = 1303}
, 
[1511] = {chip_pool = __rt_8, id = 1511, scene_id = 3}
, 
[1512] = {chip_pool = __rt_8, id = 1512, scene_id = 3}
, 
[1521] = {chip_pool = __rt_9, id = 1521, scene_id = 3}
, 
[1522] = {chip_pool = __rt_9, id = 1522, scene_id = 3}
, 
[1523] = {chip_pool = __rt_9, id = 1523, scene_id = 3}
, 
[1531] = {chip_pool = __rt_10, id = 1531, scene_id = 3}
, 
[1532] = {chip_pool = __rt_10, id = 1532, scene_id = 3}
, 
[1533] = {chip_pool = __rt_10, id = 1533, scene_id = 3}
, 
[1541] = {chip_pool = __rt_11, id = 1541, scene_id = 3}
, 
[1542] = {chip_pool = __rt_11, id = 1542, scene_id = 3}
, 
[1543] = {chip_pool = __rt_11, id = 1543, scene_id = 3}
, 
[1551] = {chip_pool = __rt_12, id = 1551, scene_id = 3}
, 
[1552] = {chip_pool = __rt_12, id = 1552, scene_id = 3}
, 
[1553] = {chip_pool = __rt_12, id = 1553, scene_id = 3}
, 
[1561] = {chip_pool = __rt_13, id = 1561, scene_id = 3}
, 
[1562] = {chip_pool = __rt_13, id = 1562, scene_id = 3}
, 
[1563] = {chip_pool = __rt_13, id = 1563, scene_id = 3}
, 
[1564] = {chip_pool = __rt_13, id = 1564, scene_id = 3}
, 
[1565] = {chip_pool = __rt_13, id = 1565, scene_id = 3}
, 
[2011] = {chip_pool = __rt_14, id = 2011}
, 
[2012] = {chip_pool = __rt_14, id = 2012}
, 
[2021] = {chip_pool = __rt_15, id = 2021}
, 
[2022] = {chip_pool = __rt_15, id = 2022}
, 
[2031] = {chip_pool = __rt_16, id = 2031}
, 
[2032] = {chip_pool = __rt_16, id = 2032}
, 
[2041] = {
chip_pool = {2041, 2042, 2043}
, id = 2041}
, 
[2051] = {
chip_pool = {2051, 2052, 2053}
, id = 2051}
, 
[2061] = {chip_pool = __rt_17, id = 2061}
, 
[2062] = {chip_pool = __rt_17, id = 2062}
, 
[2063] = {chip_pool = __rt_17, id = 2063}
, 
[2071] = {
chip_pool = {2071, 2072, 2073}
, id = 2071}
, 
[2081] = {
chip_pool = {2081, 2082, 2083}
, id = 2081}
, 
[2091] = {chip_pool = __rt_18, id = 2091}
, 
[2092] = {chip_pool = __rt_18, id = 2092}
, 
[2093] = {chip_pool = __rt_18, id = 2093}
, 
[2101] = {
chip_pool = {2101, 2102, 2103}
, id = 2101}
, 
[2111] = {chip_pool = __rt_19, id = 2111}
, 
[2112] = {chip_pool = __rt_19, id = 2112}
, 
[2113] = {chip_pool = __rt_19, id = 2113}
, 
[2511] = {chip_pool = __rt_20, id = 2511}
, 
[2512] = {chip_pool = __rt_20, id = 2512}
, 
[2521] = {chip_pool = __rt_21, id = 2521}
, 
[2522] = {chip_pool = __rt_21, id = 2522}
, 
[2523] = {chip_pool = __rt_21, id = 2523}
, 
[2531] = {chip_pool = __rt_22, id = 2531}
, 
[2532] = {chip_pool = __rt_22, id = 2532}
, 
[2533] = {chip_pool = __rt_22, id = 2533}
, 
[2541] = {chip_pool = __rt_23, id = 2541}
, 
[2542] = {chip_pool = __rt_23, id = 2542}
, 
[2543] = {chip_pool = __rt_23, id = 2543}
, 
[2551] = {chip_pool = __rt_24, id = 2551}
, 
[2552] = {chip_pool = __rt_24, id = 2552}
, 
[2553] = {chip_pool = __rt_24, id = 2553}
, 
[2561] = {chip_pool = __rt_25, id = 2561}
, 
[2562] = {chip_pool = __rt_25, id = 2562}
, 
[2563] = {chip_pool = __rt_25, id = 2563}
, 
[2564] = {chip_pool = __rt_25, id = 2564}
, 
[2565] = {chip_pool = __rt_25, id = 2565}
, 
[3011] = {chip_pool = __rt_4, id = 3011, scene_id = 4}
, 
[3012] = {chip_pool = __rt_4, id = 3012, scene_id = 4}
, 
[3013] = {chip_pool = __rt_4, id = 3013, scene_id = 4}
, 
[100000] = {chip_pool = __rt_26, id = 100000, scene_id = 3}
, 
[100001] = {chip_pool = __rt_26, id = 100001, scene_id = 3}
, 
[100002] = {chip_pool = __rt_26, id = 100002, scene_id = 3}
, 
[100003] = {chip_pool = __rt_26, id = 100003, scene_id = 3}
, 
[100004] = {chip_pool = __rt_26, id = 100004, scene_id = 3}
, 
[100005] = {id = 100005, scene_id = 3}
, 
[100006] = {id = 100006, scene_id = 3}
, 
[100007] = {id = 100007, scene_id = 3}
, 
[100008] = {id = 100008, scene_id = 3}
, 
[100009] = {id = 100009, scene_id = 3}
, 
[100010] = {chip_pool = __rt_26, id = 100010, scene_id = 3}
, 
[100011] = {chip_pool = __rt_26, id = 100011, scene_id = 3}
, 
[100012] = {chip_pool = __rt_26, id = 100012, scene_id = 3}
, 
[100013] = {chip_pool = __rt_26, id = 100013, scene_id = 3}
, 
[100014] = {chip_pool = __rt_26, id = 100014, scene_id = 3}
, 
[100015] = {id = 100015, scene_id = 3}
, 
[100016] = {id = 100016, scene_id = 3}
, 
[100017] = {id = 100017, scene_id = 3}
, 
[100018] = {id = 100018, scene_id = 3}
, 
[100019] = {id = 100019, scene_id = 3}
, 
[100020] = {chip_pool = __rt_26, id = 100020, scene_id = 3}
, 
[100021] = {chip_pool = __rt_26, id = 100021, scene_id = 3}
, 
[100022] = {chip_pool = __rt_26, id = 100022, scene_id = 3}
, 
[100023] = {chip_pool = __rt_26, id = 100023, scene_id = 3}
, 
[100024] = {chip_pool = __rt_26, id = 100024, scene_id = 3}
, 
[100025] = {id = 100025, scene_id = 3}
, 
[100026] = {id = 100026, scene_id = 3}
, 
[100027] = {id = 100027, scene_id = 3}
, 
[100028] = {id = 100028, scene_id = 3}
, 
[100029] = {id = 100029, scene_id = 3}
, 
[100030] = {chip_pool = __rt_26, id = 100030, scene_id = 3}
, 
[100031] = {chip_pool = __rt_26, id = 100031, scene_id = 3}
, 
[100032] = {chip_pool = __rt_26, id = 100032, scene_id = 3}
, 
[100033] = {chip_pool = __rt_26, id = 100033, scene_id = 3}
, 
[100034] = {chip_pool = __rt_26, id = 100034, scene_id = 3}
, 
[100035] = {id = 100035, scene_id = 3}
, 
[100036] = {id = 100036, scene_id = 3}
, 
[100037] = {id = 100037, scene_id = 3}
, 
[100038] = {id = 100038, scene_id = 3}
, 
[100039] = {id = 100039, scene_id = 3}
, 
[100040] = {id = 100040, scene_id = 3}
, 
[100041] = {id = 100041, scene_id = 3}
, 
[100042] = {id = 100042, scene_id = 3}
, 
[100043] = {id = 100043, scene_id = 3}
, 
[100044] = {id = 100044, scene_id = 3}
, 
[100045] = {id = 100045, scene_id = 3}
, 
[100046] = {id = 100046, scene_id = 3}
, 
[100047] = {id = 100047, scene_id = 3}
, 
[100048] = {id = 100048, scene_id = 3}
, 
[100049] = {id = 100049, scene_id = 3}
, 
[100050] = {id = 100050, scene_id = 3}
, 
[100051] = {id = 100051, scene_id = 3}
, 
[100052] = {id = 100052, scene_id = 3}
, 
[100053] = {id = 100053, scene_id = 3}
, 
[100054] = {id = 100054, scene_id = 3}
, 
[100055] = {id = 100055, scene_id = 3}
, 
[100056] = {id = 100056, scene_id = 3}
, 
[100057] = {id = 100057, scene_id = 3}
, 
[100058] = {id = 100058, scene_id = 3}
, 
[100059] = {id = 100059, scene_id = 3}
, 
[100060] = {chip_pool = __rt_26, id = 100060}
, 
[100061] = {chip_pool = __rt_26, id = 100061}
, 
[100062] = {chip_pool = __rt_26, id = 100062}
, 
[100063] = {chip_pool = __rt_26, id = 100063}
, 
[100064] = {chip_pool = __rt_26, id = 100064}
, 
[100065] = {id = 100065}
, 
[100066] = {id = 100066}
, 
[100067] = {id = 100067}
, 
[100068] = {id = 100068}
, 
[100069] = {id = 100069}
, 
[100070] = {chip_pool = __rt_26, id = 100070}
, 
[100071] = {chip_pool = __rt_26, id = 100071}
, 
[100072] = {chip_pool = __rt_26, id = 100072}
, 
[100073] = {chip_pool = __rt_26, id = 100073}
, 
[100074] = {chip_pool = __rt_26, id = 100074}
, 
[100075] = {id = 100075}
, 
[100076] = {id = 100076}
, 
[100077] = {id = 100077}
, 
[100078] = {id = 100078}
, 
[100079] = {id = 100079}
, 
[100080] = {chip_pool = __rt_26, id = 100080}
, 
[100081] = {chip_pool = __rt_26, id = 100081}
, 
[100082] = {chip_pool = __rt_26, id = 100082}
, 
[100083] = {chip_pool = __rt_26, id = 100083}
, 
[100084] = {chip_pool = __rt_26, id = 100084}
, 
[100085] = {id = 100085}
, 
[100086] = {id = 100086}
, 
[100087] = {id = 100087}
, 
[100088] = {id = 100088}
, 
[100089] = {id = 100089}
, 
[100090] = {chip_pool = __rt_26, id = 100090}
, 
[100091] = {chip_pool = __rt_26, id = 100091}
, 
[100092] = {chip_pool = __rt_26, id = 100092}
, 
[100093] = {chip_pool = __rt_26, id = 100093}
, 
[100094] = {chip_pool = __rt_26, id = 100094}
, 
[100095] = {id = 100095}
, 
[100096] = {id = 100096}
, 
[100097] = {id = 100097}
, 
[100098] = {id = 100098}
, 
[100099] = {id = 100099}
, 
[100100] = {id = 100100}
, 
[100101] = {id = 100101}
, 
[100102] = {id = 100102}
, 
[100103] = {id = 100103}
, 
[100104] = {id = 100104}
, 
[100105] = {id = 100105}
, 
[100106] = {id = 100106}
, 
[100107] = {id = 100107}
, 
[100108] = {id = 100108}
, 
[100109] = {id = 100109}
, 
[100110] = {id = 100110}
, 
[100111] = {id = 100111}
, 
[100112] = {id = 100112}
, 
[100113] = {id = 100113}
, 
[100114] = {id = 100114}
, 
[100115] = {id = 100115}
, 
[100116] = {id = 100116}
, 
[100117] = {id = 100117}
, 
[100118] = {id = 100118}
, 
[100119] = {id = 100119}
}
local __default_values = {chip_pool = __rt_27, id = 100, scene_id = 2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(exploration) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(exploration, {__index = __rawdata})
return exploration

