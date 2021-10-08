local __rt_1 = {}
local __rt_2 = {701}
local skin = {
[300101] = {describe = 168779, name = 399050, src_id_icon = "ICON_Item_300101", src_id_pic = "persicaria_p2"}
, 
[300102] = {describe = 36727, id = 300102, is_locked = 1, name = 261071, needRank = 8, src_id_icon = "ICON_Item_300102", src_id_pic = "persicaria_p3", theme = 3}
, 
[300103] = {condition = 2301, 
condition_para = {4002}
, describe = 23527, id = 300103, name = 309756, needRank = 0, src_id_icon = "Skin_persicaria_sp", src_id_model = "persicaria_sp", src_id_pic = "persicaria_sp", theme = 0}
, 
[300201] = {describe = 202607, heroId = 1002, id = 300201, name = 169808, src_id_icon = "ICON_Item_300201", src_id_pic = "anna_p2"}
, 
[300202] = {describe = 82453, heroId = 1002, id = 300202, name = 161463, needRank = 8, src_id_icon = "ICON_Item_300202", src_id_pic = "anna_p3", theme = 3}
, 
[300301] = {describe = 222676, heroId = 1003, id = 300301, name = 349928, src_id_icon = "ICON_Item_300301", src_id_pic = "sol_p2"}
, 
[300302] = {describe = 386763, heroId = 1003, id = 300302, name = 74675, needRank = 8, src_id_icon = "ICON_Item_300302", src_id_pic = "sol_p3", theme = 3}
, 
[300401] = {describe = 155686, heroId = 1004, id = 300401, name = 46992, src_id_icon = "ICON_Item_300401", src_id_pic = "simo_p2"}
, 
[300402] = {describe = 110291, heroId = 1004, id = 300402, name = 16959, needRank = 8, src_id_icon = "ICON_Item_300402", src_id_pic = "simo_p3", theme = 3}
, 
[300501] = {describe = 290106, heroId = 1005, id = 300501, name = 411741, src_id_icon = "ICON_Item_300501", src_id_pic = "croque_p2"}
, 
[300502] = {describe = 397490, heroId = 1005, id = 300502, name = 471104, needRank = 8, src_id_icon = "ICON_Item_300502", src_id_pic = "croque_p3", theme = 3}
, 
[300503] = {condition = 2301, 
condition_para = {1001}
, describe = 483728, heroId = 1005, id = 300503, name = 317985, needRank = 0, src_id_icon = "Skin_croque_open", src_id_model = "croque_open", src_id_pic = "croque_open", theme = 5}
, 
[300601] = {describe = 424836, heroId = 1006, id = 300601, name = 286070, src_id_icon = "ICON_Item_300601", src_id_pic = "fresnel_p2"}
, 
[300602] = {describe = 139450, heroId = 1006, id = 300602, name = 476835, needRank = 8, src_id_icon = "ICON_Item_300602", src_id_pic = "fresnel_p3", theme = 3}
, 
[300701] = {describe = 255305, heroId = 1007, id = 300701, name = 26565, src_id_icon = "ICON_Item_300701", src_id_pic = "chelsea_p2"}
, 
[300702] = {describe = 522355, heroId = 1007, id = 300702, name = 112238, needRank = 8, src_id_icon = "ICON_Item_300702", src_id_pic = "chelsea_p3", theme = 3}
, 
[300801] = {describe = 462912, heroId = 1008, id = 300801, name = 183742, src_id_icon = "ICON_Item_300801", src_id_pic = "gin_p2"}
, 
[300802] = {describe = 382154, heroId = 1008, id = 300802, needRank = 8, src_id_icon = "ICON_Item_300802", src_id_pic = "gin_p3", theme = 3}
, 
[300901] = {describe = 221569, heroId = 1009, id = 300901, name = 66954, src_id_icon = "ICON_Item_300901", src_id_pic = "mai_p2"}
, 
[300902] = {describe = 267382, heroId = 1009, id = 300902, name = 135067, needRank = 8, src_id_icon = "ICON_Item_300902", src_id_pic = "mai_p3", theme = 3}
, 
[301001] = {describe = 154064, heroId = 1010, id = 301001, name = 12266, src_id_icon = "ICON_Item_301001", src_id_pic = "evelyn_p2"}
, 
[301002] = {describe = 367367, heroId = 1010, id = 301002, name = 37194, needRank = 8, src_id_icon = "ICON_Item_301002", src_id_pic = "evelyn_p3", theme = 3}
, 
[301101] = {describe = 290531, heroId = 1011, id = 301101, name = 125847, src_id_icon = "ICON_Item_301101", src_id_pic = "camellia_p2"}
, 
[301102] = {describe = 398849, heroId = 1011, id = 301102, name = 140945, needRank = 8, src_id_icon = "ICON_Item_301102", src_id_pic = "camellia_p3", theme = 3}
, 
[301201] = {describe = 218834, heroId = 1012, id = 301201, name = 162892, src_id_icon = "ICON_Item_301201", src_id_pic = "max_p2"}
, 
[301202] = {describe = 460982, heroId = 1012, id = 301202, name = 238731, needRank = 8, src_id_icon = "ICON_Item_301202", src_id_pic = "max_p3", theme = 3}
, 
[301301] = {describe = 12824, heroId = 1013, id = 301301, name = 379484, src_id_icon = "ICON_Item_301301", src_id_pic = "betty_p2"}
, 
[301302] = {describe = 124788, heroId = 1013, id = 301302, name = 441338, needRank = 8, src_id_icon = "ICON_Item_301302", src_id_pic = "betty_p3", theme = 3}
, 
[301401] = {describe = 154201, heroId = 1014, id = 301401, name = 213022, src_id_icon = "ICON_Item_301401", src_id_pic = "choco_p2"}
, 
[301402] = {describe = 333405, heroId = 1014, id = 301402, name = 136009, needRank = 8, src_id_icon = "ICON_Item_301402", src_id_pic = "choco_p3", theme = 3}
, 
[301501] = {describe = 23481, heroId = 1015, id = 301501, name = 449077, src_id_icon = "ICON_Item_301501", src_id_pic = "panakeia_p2"}
, 
[301502] = {describe = 206106, heroId = 1015, id = 301502, name = 279149, needRank = 8, src_id_icon = "ICON_Item_301502", src_id_pic = "panakeia_p3", theme = 3}
, 
[301601] = {describe = 82478, heroId = 1016, id = 301601, name = 88049, src_id_icon = "ICON_Item_301601", src_id_pic = "banxsy_p2"}
, 
[301602] = {describe = 339082, heroId = 1016, id = 301602, name = 318063, needRank = 8, src_id_icon = "ICON_Item_301602", src_id_pic = "banxsy_p3", theme = 3}
, 
[301603] = {condition = 610, condition_para = __rt_2, describe = 150862, heroId = 1016, id = 301603, name = 18269, needRank = 0, src_id_icon = "ICON_Item_301603", src_id_model = "banxsy_school", src_id_pic = "banxsy_school", theme = 4}
, 
[301701] = {describe = 113796, heroId = 1017, id = 301701, name = 323848, src_id_icon = "ICON_Item_301701", src_id_pic = "angela_p2"}
, 
[301702] = {describe = 345235, heroId = 1017, id = 301702, name = 64272, needRank = 8, src_id_icon = "ICON_Item_301702", src_id_pic = "angela_p3", theme = 3}
, 
[301801] = {describe = 280895, heroId = 1018, id = 301801, name = 52801, src_id_icon = "ICON_Item_301801", src_id_pic = "florence_p2"}
, 
[301802] = {describe = 188226, heroId = 1018, id = 301802, name = 500196, needRank = 8, src_id_icon = "ICON_Item_301802", src_id_pic = "florence_p3", theme = 3}
, 
[301901] = {describe = 194921, heroId = 1019, id = 301901, name = 374722, src_id_icon = "ICON_Item_301901", src_id_pic = "fern_p2"}
, 
[301902] = {heroId = 1019, id = 301902, name = 21598, needRank = 8, src_id_icon = "ICON_Item_301902", src_id_pic = "fern_p3", theme = 3}
, 
[302001] = {describe = 118116, heroId = 1020, id = 302001, name = 111422, src_id_icon = "ICON_Item_302001", src_id_pic = "yanny_p2"}
, 
[302002] = {describe = 298957, heroId = 1020, id = 302002, name = 412393, needRank = 8, src_id_icon = "ICON_Item_302002", src_id_pic = "yanny_p3", theme = 3}
, 
[302101] = {describe = 180065, heroId = 1021, id = 302101, name = 387268, src_id_icon = "ICON_Item_302101", src_id_pic = "groove_p2"}
, 
[302102] = {describe = 355486, heroId = 1021, id = 302102, name = 412648, needRank = 8, src_id_icon = "ICON_Item_302102", src_id_pic = "groove_p3", theme = 3}
, 
[302201] = {describe = 165719, heroId = 1022, id = 302201, name = 244133, src_id_icon = "ICON_Item_302201", src_id_pic = "aki_p2"}
, 
[302202] = {describe = 506434, heroId = 1022, id = 302202, name = 118386, needRank = 8, src_id_icon = "ICON_Item_302202", src_id_pic = "aki_p3", theme = 3}
, 
[302301] = {describe = 261077, heroId = 1023, id = 302301, name = 13633, src_id_icon = "ICON_Item_302301", src_id_pic = "bonee_p2"}
, 
[302302] = {describe = 6226, heroId = 1023, id = 302302, name = 280997, needRank = 8, src_id_icon = "ICON_Item_302302", src_id_pic = "bonee_p3", theme = 3}
, 
[302303] = {condition = 610, condition_para = __rt_2, describe = 184911, heroId = 1023, id = 302303, name = 261205, needRank = 0, src_id_icon = "ICON_Item_302303", src_id_model = "bonee_school", src_id_pic = "bonee_school", theme = 4}
, 
[302401] = {describe = 203515, heroId = 1024, id = 302401, name = 155070, src_id_icon = "ICON_Item_302401", src_id_pic = "earhart_p2"}
, 
[302402] = {describe = 462035, heroId = 1024, id = 302402, name = 13498, needRank = 8, src_id_icon = "ICON_Item_302402", src_id_pic = "earhart_p3", theme = 3}
, 
[302501] = {describe = 361407, heroId = 1025, id = 302501, name = 146277, src_id_pic = "twigs_p2"}
, 
[302502] = {describe = 299161, heroId = 1025, id = 302502, name = 153198, needRank = 8, src_id_icon = "ICON_Item_302502", src_id_pic = "twigs_p3", theme = 3}
, 
[302503] = {describe = 287203, heroId = 1025, id = 302503, name = 165820, needRank = 0, skin_locked = true, src_id_model = "twigs_swimsuit", src_id_pic = "twigs_swimsuit", theme = 4}
, 
[302601] = {describe = 336162, heroId = 1026, id = 302601, name = 499832, src_id_icon = "ICON_Item_302601", src_id_pic = "nanaka_p2"}
, 
[302602] = {describe = 471714, heroId = 1026, id = 302602, name = 391871, needRank = 8, src_id_icon = "ICON_Item_302602", src_id_pic = "nanaka_p3", theme = 3}
, 
[302701] = {describe = 459130, heroId = 1027, id = 302701, name = 94904, src_id_icon = "ICON_Item_302701", src_id_pic = "zion_p2"}
, 
[302702] = {describe = 427444, heroId = 1027, id = 302702, name = 292699, needRank = 8, src_id_icon = "ICON_Item_302702", src_id_pic = "zion_p3", theme = 3}
, 
[302801] = {describe = 203801, heroId = 1028, id = 302801, name = 471009, src_id_icon = "ICON_Item_302801", src_id_pic = "vee_p2"}
, 
[302802] = {describe = 250794, heroId = 1028, id = 302802, name = 178052, needRank = 8, src_id_icon = "ICON_Item_302802", src_id_pic = "vee_p3", theme = 3}
, 
[302901] = {describe = 408623, heroId = 1029, id = 302901, name = 444919, src_id_icon = "ICON_Item_302901", src_id_pic = "willow_p2"}
, 
[302902] = {describe = 214306, heroId = 1029, id = 302902, name = 268035, needRank = 8, src_id_icon = "ICON_Item_302902", src_id_pic = "willow_p3", theme = 3}
, 
[303001] = {describe = 111321, heroId = 1030, id = 303001, name = 175506, src_id_icon = "ICON_Item_303001", src_id_pic = "ksenia_p2"}
, 
[303002] = {describe = 188762, heroId = 1030, id = 303002, name = 118876, needRank = 8, src_id_icon = "ICON_Item_303002", src_id_pic = "ksenia_p3", theme = 3}
, 
[303101] = {describe = 350295, heroId = 1031, id = 303101, name = 409651, src_id_icon = "ICON_Item_303101", src_id_pic = "imhotep_p2"}
, 
[303102] = {describe = 13792, heroId = 1031, id = 303102, name = 67226, needRank = 8, src_id_icon = "ICON_Item_303102", src_id_pic = "imhotep_p3", theme = 3}
, 
[303103] = {condition = 610, condition_para = __rt_2, describe = 48175, heroId = 1031, id = 303103, name = 428700, needRank = 0, src_id_icon = "ICON_Item_303103", src_id_model = "imhotep_school", src_id_pic = "imhotep_school", theme = 4}
, 
[303201] = {describe = 35363, heroId = 1032, id = 303201, name = 16519, src_id_icon = "ICON_Item_303201", src_id_pic = "octogen_p2"}
, 
[303202] = {describe = 338286, heroId = 1032, id = 303202, name = 241138, needRank = 8, src_id_icon = "ICON_Item_303202", src_id_pic = "octogen_p3", theme = 3}
, 
[303301] = {describe = 221246, heroId = 1033, id = 303301, name = 273025, src_id_icon = "ICON_Item_303301", src_id_pic = "rise_p2"}
, 
[303302] = {describe = 442127, heroId = 1033, id = 303302, name = 42103, needRank = 8, src_id_icon = "ICON_Item_303302", src_id_pic = "rise_p3", theme = 3}
, 
[303303] = {condition = 610, condition_para = __rt_2, describe = 462120, heroId = 1033, id = 303303, name = 57545, needRank = 0, src_id_icon = "ICON_Item_303303", src_id_model = "rise_school", src_id_pic = "rise_school", theme = 4}
, 
[303401] = {describe = 414554, heroId = 1034, id = 303401, name = 313007, src_id_icon = "ICON_Item_303401"}
, 
[303402] = {describe = 504157, heroId = 1034, id = 303402, name = 265708, needRank = 8, src_id_icon = "ICON_Item_303402", src_id_pic = "abigail_p3", theme = 3}
, 
[303501] = {describe = 212901, heroId = 1035, id = 303501, name = 470074, src_id_icon = "ICON_Item_303501", src_id_pic = "jessie_p2"}
, 
[303502] = {describe = 474431, heroId = 1035, id = 303502, name = 220370, needRank = 8, src_id_icon = "ICON_Item_303502", src_id_pic = "jessie_p3", theme = 3}
, 
[303601] = {describe = 433867, heroId = 1036, id = 303601, name = 429431, src_id_icon = "ICON_Item_303601", src_id_pic = "lam_p2"}
, 
[303602] = {describe = 518317, heroId = 1036, id = 303602, name = 312774, needRank = 8, src_id_icon = "ICON_Item_303602", src_id_pic = "lam_p3", theme = 3}
, 
[303701] = {describe = 197540, heroId = 1037, id = 303701, name = 471207, src_id_icon = "ICON_Item_303701", src_id_pic = "hubble_p2"}
, 
[303702] = {describe = 434904, heroId = 1037, id = 303702, name = 136627, needRank = 8, src_id_icon = "ICON_Item_303702", src_id_pic = "hubble_p3", theme = 3}
, 
[303801] = {describe = 182883, heroId = 1038, id = 303801, name = 16387, src_id_icon = "ICON_Item_303801", src_id_pic = "sakuya_p2"}
, 
[303802] = {describe = 147099, heroId = 1038, id = 303802, name = 328201, needRank = 8, src_id_icon = "ICON_Item_303802", src_id_pic = "sakuya_p3", theme = 3}
, 
[303901] = {describe = 256412, heroId = 1039, id = 303901, name = 259376, src_id_icon = "ICON_Item_303901", src_id_pic = "centaureissi_p2"}
, 
[303902] = {describe = 132082, heroId = 1039, id = 303902, name = 163477, needRank = 8, src_id_icon = "ICON_Item_303902", src_id_pic = "centaureissi_p3", theme = 3}
, 
[304001] = {describe = 489649, heroId = 1040, id = 304001, name = 284553, src_id_icon = "ICON_Item_304001", src_id_pic = "dusevnyj_p2"}
, 
[304002] = {describe = 509229, heroId = 1040, id = 304002, name = 210998, needRank = 8, src_id_icon = "ICON_Item_304002", src_id_pic = "dusevnyj_p3", theme = 3}
}
local __default_values = {condition = 502, condition_para = __rt_1, describe = 109245, heroId = 1001, id = 300101, is_locked = 0, jumpId = 0, name = 104860, needRank = 7, skin_locked = false, src_id_icon = "ICON_Item_302501", src_id_model = "", src_id_pic = "abigail_p2", theme = 2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in (_ENV.pairs)(skin) do
  (_ENV.setmetatable)(v, base)
end
local __rawdata = {__basemetatable = base}
;
(_ENV.setmetatable)(skin, {__index = __rawdata})
return skin

