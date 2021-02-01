-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {2, 2, 2}
local __rt_2 = {40, 55, 80, 100}
local __rt_3 = {[2] = 6, [21] = 1, [23] = 4, [26] = 5, [202] = 3, [226] = 2}
local __rt_4 = {1, 2, 3, 8, 10, 9, 11, 12, 4, 13, 5, 14, 15, 16, 6, 17, 18, 7, 19, 20}
local __rt_5 = {3}
local __rt_6 = {90, 75, 50, 100}
local __rt_7 = {[7] = 5, [14] = 4, [23] = 2, [26] = 3, [226] = 1}
local __rt_8 = {4, 5, 1, 6, 7, 2, 8, 9, 10, 3, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}
local __rt_9 = {4}
local __rt_10 = {70, 70, 30, 100}
local __rt_11 = {[2] = 6, [3] = 5, [5] = 3, [15] = 4, [202] = 2, [203] = 1}
local __rt_12 = {11, 12, 13, 2, 1, 4, 14, 15, 16, 3, 17, 6, 5, 18, 8, 7, 19, 20, 9, 10}
local __rt_13 = {1}
local __rt_14 = {100, 30, 30, 100}
local __rt_15 = {[3] = 5, [9] = 2, [10] = 3, [12] = 4, [203] = 1}
local __rt_16 = {11, 12, 2, 13, 1, 4, 14, 15, 16, 3, 17, 6, 5, 18, 8, 7, 19, 20, 9, 10}
local __rt_17 = {40, 80, 0, 100}
local __rt_18 = {[2] = 4, [4] = 3, [14] = 6, [20] = 2, [202] = 1, [226] = 5}
local __rt_19 = {10, 17, 18, 1, 19, 20, 2, 3, 4, 11, 6, 12, 13, 5, 14, 15, 7, 8, 16, 9}
local __rt_20 = {5}
local __rt_21 = {5, 4}
local __rt_22 = {1, 4}
local hero_data = {
[1001] = {camp = 2, career = 5, move_order = 3, mvp_para = __rt_2, name = 139228, name_en = "Persicaria", priority_main_attribute_dic = __rt_3, priority_sub_attribute1_dic = __rt_3, priority_sub_attribute2_dic = __rt_3, priority_sub_attribute3_dic = __rt_3, priority_suit_dic = __rt_4, range = 3, 
skill_list = {5, 100101, 100102, 100103}
, tag = __rt_5, talk = 397529}
, 
[1002] = {camp = 2, career = 4, fragment = 2502, id = 1002, move_order = 2, mvp_para = __rt_6, name = 170919, name_en = "Antonina", priority_main_attribute_dic = __rt_7, priority_sub_attribute1_dic = __rt_7, priority_sub_attribute2_dic = __rt_7, priority_sub_attribute3_dic = __rt_7, priority_suit_dic = __rt_8, range = 5, 
skill_list = {6, 100201, 100202, 100203}
, src_id = 1002, tag = __rt_9, talk = 176282}
, 
[1003] = {camp = 2, career = 3, fragment = 2503, id = 1003, move_spd = 200, mvp_para = __rt_10, name = 14037, name_en = "Sol", priority_main_attribute_dic = __rt_11, priority_sub_attribute1_dic = __rt_11, priority_sub_attribute2_dic = __rt_11, priority_sub_attribute3_dic = __rt_11, priority_suit_dic = __rt_12, 
skill_list = {8, 100301, 100302, 100303}
, src_id = 1003}
, 
[1004] = {camp = 1, fragment = 2504, id = 1004, move_order = 2, mvp_para = __rt_14, name = 412120, name_en = "Simo", priority_main_attribute_dic = __rt_15, priority_sub_attribute1_dic = __rt_15, priority_sub_attribute2_dic = __rt_15, priority_sub_attribute3_dic = __rt_15, priority_suit_dic = __rt_16, range = 5, rank = 2, 
skill_list = {9, 100401, 100402, 100403}
, src_id = 1004, 
tag = {2}
}
, 
[1005] = {camp = 1, career = 1, fragment = 2505, id = 1005, move_spd = 200, name = 279575, name_en = "Croque", rank = 6, 
skill_list = {7, 100501, 100502, 100503}
, src_id = 1005, tag = __rt_20}
, 
[1006] = {camp = 2, fragment = 2506, id = 1006, move_order = 2, mvp_para = __rt_14, name = 464803, name_en = "Fresnel", priority_main_attribute_dic = __rt_15, priority_sub_attribute1_dic = __rt_15, priority_sub_attribute2_dic = __rt_15, priority_sub_attribute3_dic = __rt_15, priority_suit_dic = __rt_16, range = 5, 
skill_list = {4, 100601, 100602, 100603}
, src_id = 1006}
, 
[1007] = {camp = 1, career = 3, fragment = 2507, id = 1007, move_spd = 200, mvp_para = __rt_10, name = 245114, name_en = "Chelsea", priority_main_attribute_dic = __rt_11, priority_sub_attribute1_dic = __rt_11, priority_sub_attribute2_dic = __rt_11, priority_sub_attribute3_dic = __rt_11, priority_suit_dic = __rt_12, 
skill_list = {3, 100701, 100702, 100703}
, src_id = 1007}
, 
[1008] = {career = 5, fragment = 2508, id = 1008, move_order = 3, 
mvp_para = {40, 55, 30, 90}
, name = 87399, name_en = "Gin", priority_main_attribute_dic = __rt_3, priority_sub_attribute1_dic = __rt_3, priority_sub_attribute2_dic = __rt_3, priority_sub_attribute3_dic = __rt_3, priority_suit_dic = __rt_4, range = 3, rank = 6, 
skill_list = {14, 100801, 100802, 100803}
, src_id = 1008, tag = __rt_5}
, 
[1009] = {camp = 2, fragment = 2509, id = 1009, move_order = 2, mvp_para = __rt_6, name = 424012, name_en = "Mai", priority_main_attribute_dic = __rt_15, priority_sub_attribute1_dic = __rt_15, priority_sub_attribute2_dic = __rt_15, priority_sub_attribute3_dic = __rt_15, priority_suit_dic = __rt_16, range = 5, rank = 2, 
skill_list = {2, 100901, 100902}
, src_id = 1009, talk = 517361}
, 
[1010] = {camp = 1, career = 1, fragment = 2510, id = 1010, move_spd = 200, name = 516981, name_en = "Evelyn", 
skill_list = {13, 101001, 101002}
, src_id = 1010, tag = __rt_21, talk = 441548}
, 
[1011] = {camp = 2, career = 1, fragment = 2511, id = 1011, name = 63247, name_en = "Camellia", rank = 2, 
skill_list = {27, 101101, 101102}
, src_id = 1011, tag = __rt_21}
, 
[1012] = {camp = 2, fragment = 2512, id = 1012, move_order = 2, mvp_para = __rt_14, name = 189805, name_en = "Max", priority_main_attribute_dic = __rt_15, priority_sub_attribute1_dic = __rt_15, priority_sub_attribute2_dic = __rt_15, priority_sub_attribute3_dic = __rt_15, priority_suit_dic = __rt_16, range = 6, rank = 2, 
skill_list = {18, 101201, 101202}
, src_id = 1012}
, 
[1013] = {career = 3, fragment = 2513, id = 1013, move_spd = 200, mvp_para = __rt_14, name = 318511, name_en = "Betty", priority_main_attribute_dic = __rt_11, priority_sub_attribute1_dic = __rt_11, priority_sub_attribute2_dic = __rt_11, priority_sub_attribute3_dic = __rt_11, priority_suit_dic = __rt_12, 
skill_list = {22, 101301, 101302, 101303}
, src_id = 1013}
, 
[1014] = {career = 5, fragment = 2514, id = 1014, name_en = "Choco", priority_main_attribute_dic = __rt_3, priority_sub_attribute1_dic = __rt_3, priority_sub_attribute2_dic = __rt_3, priority_sub_attribute3_dic = __rt_3, priority_suit_dic = __rt_4, rank = 2, 
skill_list = {28, 101401, 101402}
, src_id = 1014, tag = __rt_5}
, 
[1015] = {camp = 3, career = 5, fragment = 2515, id = 1015, move_order = 3, move_spd = 150, name = 488452, name_en = "Panakeia", priority_main_attribute_dic = __rt_3, priority_sub_attribute1_dic = __rt_3, priority_sub_attribute2_dic = __rt_3, priority_sub_attribute3_dic = __rt_3, priority_suit_dic = __rt_4, range = 3, 
skill_list = {29, 101501, 101502}
, src_id = 1015, 
tag = {1, 3}
}
, 
[1016] = {camp = 4, career = 4, fragment = 2516, id = 1016, move_order = 2, mvp_para = __rt_6, name = 492510, name_en = "Banxsy", priority_main_attribute_dic = __rt_7, priority_sub_attribute1_dic = __rt_7, priority_sub_attribute2_dic = __rt_7, priority_sub_attribute3_dic = __rt_7, priority_suit_dic = __rt_8, range = 2, rank = 6, 
skill_list = {11, 101601, 101602, 101603}
, src_id = 1016}
, 
[1017] = {fragment = 2517, id = 1017, move_order = 3, mvp_para = __rt_2, name = 88362, name_en = "Angela", priority_main_attribute_dic = __rt_15, priority_sub_attribute1_dic = __rt_15, priority_sub_attribute2_dic = __rt_15, priority_sub_attribute3_dic = __rt_15, priority_suit_dic = __rt_16, range = 3, 
skill_list = {17, 101701, 101702, 101703}
, src_id = 1017, tag = __rt_9, talk = 306803}
, 
[1018] = {camp = 3, career = 5, fragment = 2518, id = 1018, name = 295556, name_en = "Florence", range = 4, rank = 6, 
skill_list = {30, 101801, 101802}
, src_id = 1018, 
tag = {3, 4}
}
, 
[1019] = {camp = 2, career = 3, fragment = 2519, id = 1019, name = 82968, name_en = "Fern", 
skill_list = {31, 101901, 101902}
, src_id = 1019}
, 
[1020] = {career = 3, fragment = 2520, id = 1020, move_spd = 200, name = 41160, name_en = "Yanny", priority_main_attribute_dic = __rt_11, priority_sub_attribute1_dic = __rt_11, priority_sub_attribute2_dic = __rt_11, priority_sub_attribute3_dic = __rt_11, priority_suit_dic = __rt_12, 
skill_list = {26, 102001, 102002, 102003}
, src_id = 1020, tag = __rt_22}
, 
[1021] = {camp = 4, career = 4, fragment = 2521, id = 1021, move_order = 3, mvp_para = __rt_6, name = 508749, name_en = "Groove", priority_main_attribute_dic = __rt_7, priority_sub_attribute1_dic = __rt_7, priority_sub_attribute2_dic = __rt_7, priority_sub_attribute3_dic = __rt_7, priority_suit_dic = __rt_8, range = 5, rank = 2, 
skill_list = {15, 102101, 102102}
, src_id = 1021, tag = __rt_9}
, 
[1022] = {career = 3, fragment = 2522, id = 1022, name = 365283, name_en = "Aki", rank = 6, 
skill_list = {32, 102201, 102202}
, src_id = 1022}
, 
[1023] = {camp = 3, career = 1, fragment = 2523, id = 1023, move_spd = 200, name = 511896, name_en = "Bonee", rank = 2, 
skill_list = {24, 102301, 102302}
, src_id = 1023, tag = __rt_20}
, 
[1024] = {camp = 1, fragment = 2524, id = 1024, move_order = 3, name = 432074, name_en = "Earhart", range = 4, 
skill_list = {36, 102401, 102402}
, src_id = 1024}
, 
[1025] = {fragment = 2525, id = 1025, move_order = 2, name = 43974, name_en = "Twigs", range = 3, rank = 6, 
skill_list = {34, 102501, 102502}
, src_id = 1025}
, 
[1026] = {camp = 4, fragment = 2526, id = 1026, move_order = 2, name = 297612, name_en = "Nanaka", range = 4, rank = 6, 
skill_list = {35, 102601, 102602}
, src_id = 1026}
, 
[1027] = {camp = 1, career = 1, fragment = 2527, id = 1027, move_spd = 200, name = 403087, name_en = "Zion", 
skill_list = {20, 102701, 102702}
, src_id = 1027, tag = __rt_21}
, 
[1028] = {camp = 3, career = 3, fragment = 2528, id = 1028, name = 454781, name_en = "Vee", rank = 6, 
skill_list = {33, 102801, 102802}
, src_id = 1028, tag = __rt_22}
, 
[1031] = {camp = 3, career = 4, fragment = 2531, id = 1031, move_order = 3, mvp_para = __rt_14, name = 82891, name_en = "Imhotep", priority_main_attribute_dic = __rt_7, priority_sub_attribute1_dic = __rt_7, priority_sub_attribute2_dic = __rt_7, priority_sub_attribute3_dic = __rt_7, priority_suit_dic = __rt_8, range = 6, 
skill_list = {19, 103101, 103102}
, src_id = 1031}
, 
[1034] = {camp = 1, career = 3, fragment = 2534, id = 1034, move_spd = 200, mvp_para = __rt_14, name = 36722, priority_main_attribute_dic = __rt_11, priority_sub_attribute1_dic = __rt_11, priority_sub_attribute2_dic = __rt_11, priority_sub_attribute3_dic = __rt_11, priority_suit_dic = __rt_12, rank = 2, 
skill_list = {21, 103401, 103402}
, src_id = 1034, talk = 153459}
, 
[1035] = {career = 4, fragment = 2535, id = 1035, move_spd = 200, mvp_para = __rt_10, name = 296267, name_en = "Jessie", priority_main_attribute_dic = __rt_7, priority_sub_attribute1_dic = __rt_7, priority_sub_attribute2_dic = __rt_7, priority_sub_attribute3_dic = __rt_7, priority_suit_dic = __rt_8, rank = 2, 
skill_list = {12, 103501, 103502, 103503}
, src_id = 1035, tag = __rt_5}
, 
[1036] = {fragment = 2536, id = 1036, move_order = 2, mvp_para = __rt_14, name = 354312, name_en = "Lam", priority_main_attribute_dic = __rt_15, priority_sub_attribute1_dic = __rt_15, priority_sub_attribute2_dic = __rt_15, priority_sub_attribute3_dic = __rt_15, priority_suit_dic = __rt_16, range = 5, rank = 2, src_id = 1036}
, 
[1037] = {camp = 2, fragment = 2537, id = 1037, move_order = 2, mvp_para = __rt_14, name = 228619, name_en = "Hubble", priority_main_attribute_dic = __rt_15, priority_sub_attribute1_dic = __rt_15, priority_sub_attribute2_dic = __rt_15, priority_sub_attribute3_dic = __rt_15, priority_suit_dic = __rt_16, range = 9, rank = 6, 
skill_list = {16, 103701, 103702, 103703}
, src_id = 1037}
, 
[1038] = {career = 3, fragment = 2538, id = 1038, move_spd = 200, mvp_para = __rt_14, name = 524129, name_en = "Sakuya", priority_main_attribute_dic = __rt_11, priority_sub_attribute1_dic = __rt_11, priority_sub_attribute2_dic = __rt_11, priority_sub_attribute3_dic = __rt_11, priority_suit_dic = __rt_12, 
skill_list = {23, 103801, 103802}
, src_id = 1038}
, 
[1039] = {career = 3, fragment = 2539, id = 1039, move_spd = 200, name = 472491, name_en = "Centaureissi", priority_main_attribute_dic = __rt_11, priority_sub_attribute1_dic = __rt_11, priority_sub_attribute2_dic = __rt_11, priority_sub_attribute3_dic = __rt_11, priority_suit_dic = __rt_12, rank = 6, 
skill_list = {25, 103901, 103902}
, src_id = 1039}
}
local __default_values = {algorithm_space = __rt_1, camp = 5, career = 2, dorm_ai = 1001, fragment = 2501, id = 1001, intensity = 10, move_order = 1, move_spd = 100, mvp_para = __rt_17, name = 126444, name_en = "Abigail", priority_main_attribute_dic = __rt_18, priority_sub_attribute1_dic = __rt_18, priority_sub_attribute2_dic = __rt_18, priority_sub_attribute3_dic = __rt_18, priority_suit_dic = __rt_19, range = 1, rank = 4, 
skill_list = {10, 103601, 103602, 103603}
, src_id = 1001, tag = __rt_13, talk = 455241}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in (_ENV.pairs)(hero_data) do
  (_ENV.setmetatable)(v, base)
end
local __rawdata = {__basemetatable = base, totalHeroCount = 35}
;
(_ENV.setmetatable)(hero_data, {__index = __rawdata})
return hero_data

