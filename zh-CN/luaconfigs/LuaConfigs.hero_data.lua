-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {8, 4, 6}
local __rt_2 = {40, 55, 80, 100}
local __rt_3 = {3}
local __rt_4 = {4, 4, 10}
local __rt_5 = {90, 75, 50, 100}
local __rt_6 = {4}
local __rt_7 = {8, 6, 4}
local __rt_8 = {70, 70, 30, 100}
local __rt_9 = {1}
local __rt_10 = {4, 8, 6}
local __rt_11 = {100, 30, 30, 100}
local __rt_12 = {10, 4, 4}
local __rt_13 = {40, 80, 0, 100}
local __rt_14 = {5}
local __rt_15 = {5, 4}
local hero_data = {
[1001] = {algorithm_space = __rt_1, camp = 2, career = 5, move_order = 3, mvp_para = __rt_2, name_en = "Persicaria", range = 3, 
skill_list = {5, 1030, 1031, 1059}
, tag = __rt_3, talk = 397529}
, 
[1002] = {algorithm_space = __rt_4, camp = 2, career = 4, fragment = 2502, id = 1002, move_order = 2, mvp_para = __rt_5, name = 170919, name_en = "Antonina", range = 5, 
skill_list = {6, 1032, 1033, 1062}
, src_id = 1002, tag = __rt_6, talk = 176282}
, 
[1003] = {algorithm_space = __rt_7, camp = 2, career = 3, fragment = 2503, id = 1003, move_spd = 200, mvp_para = __rt_8, name = 14037, name_en = "Sol", 
skill_list = {8, 1038, 1039, 1065}
, src_id = 1003}
, 
[1004] = {camp = 1, fragment = 2504, id = 1004, move_order = 2, name = 412120, name_en = "Simo", range = 5, rank = 2, 
skill_list = {9, 1040, 1041, 100403}
, src_id = 1004, 
tag = {2}
}
, 
[1005] = {algorithm_space = __rt_12, camp = 1, career = 1, fragment = 2505, id = 1005, move_spd = 200, mvp_para = __rt_13, name = 279575, name_en = "Croque", rank = 6, 
skill_list = {7, 1034, 1035, 1058}
, src_id = 1005, tag = __rt_14}
, 
[1006] = {camp = 2, fragment = 2506, id = 1006, move_order = 2, name = 464803, name_en = "Fresnel", range = 5, 
skill_list = {4, 1036, 1037, 100603}
, src_id = 1006}
, 
[1007] = {algorithm_space = __rt_7, camp = 1, career = 3, fragment = 2507, id = 1007, move_spd = 200, mvp_para = __rt_8, name = 245114, name_en = "Chelsea", 
skill_list = {3, 1027, 1028, 1022}
, src_id = 1007}
, 
[1008] = {algorithm_space = __rt_1, career = 5, fragment = 2508, id = 1008, move_order = 3, 
mvp_para = {40, 55, 30, 90}
, name = 87399, name_en = "Gin", range = 3, rank = 6, 
skill_list = {14, 1050, 1051, 100803}
, src_id = 1008, tag = __rt_3}
, 
[1009] = {algorithm_space = __rt_4, camp = 2, fragment = 2509, id = 1009, move_order = 2, mvp_para = __rt_5, name = 424012, name_en = "Mai", range = 5, rank = 2, 
skill_list = {2, 100901, 1023}
, src_id = 1009, talk = 517361}
, 
[1010] = {algorithm_space = __rt_12, camp = 1, career = 1, fragment = 2510, id = 1010, move_spd = 200, mvp_para = __rt_13, name = 516981, name_en = "Evelyn", 
skill_list = {13, 1048, 1049}
, src_id = 1010, tag = __rt_15, talk = 441548}
, 
[1012] = {camp = 2, fragment = 2512, id = 1012, move_order = 2, name = 189805, name_en = "Max", range = 6, rank = 2, 
skill_list = {18, 1066, 1067}
, src_id = 1012}
, 
[1013] = {career = 3, fragment = 2513, id = 1013, move_spd = 200, name = 318511, name_en = "Betty", 
skill_list = {22, 101301, 101303, 101304}
, src_id = 1013}
, 
[1016] = {algorithm_space = __rt_4, camp = 4, career = 4, fragment = 2516, id = 1016, move_order = 2, mvp_para = __rt_5, name = 492510, name_en = "Banxsy", range = 2, rank = 6, 
skill_list = {11, 1044, 1045}
, src_id = 1016}
, 
[1017] = {algorithm_space = __rt_1, fragment = 2517, id = 1017, move_order = 3, mvp_para = __rt_2, name = 88362, name_en = "Angela", range = 3, 
skill_list = {17, 1056, 1057}
, src_id = 1017, tag = __rt_6, talk = 306803}
, 
[1020] = {algorithm_space = __rt_12, career = 3, fragment = 2520, id = 1020, move_spd = 200, mvp_para = __rt_13, name = 41160, name_en = "Yanny", 
skill_list = {26, 102001, 102002}
, src_id = 1020, 
tag = {1, 4}
}
, 
[1021] = {algorithm_space = __rt_4, camp = 4, career = 4, fragment = 2521, id = 1021, move_order = 3, mvp_para = __rt_5, name = 508749, name_en = "Groove", range = 5, rank = 2, 
skill_list = {15, 1063, 1064}
, src_id = 1021, tag = __rt_6}
, 
[1023] = {algorithm_space = __rt_12, camp = 3, career = 1, fragment = 2523, id = 1023, move_spd = 200, mvp_para = __rt_13, name = 511896, name_en = "Bonee", rank = 2, 
skill_list = {24, 102301, 102302}
, src_id = 1023, tag = __rt_14}
, 
[1027] = {algorithm_space = __rt_12, camp = 1, career = 1, fragment = 2527, id = 1027, move_spd = 200, mvp_para = __rt_13, name = 403087, name_en = "Zion", 
skill_list = {20, 102701, 102702}
, src_id = 1027, tag = __rt_15}
, 
[1031] = {camp = 3, career = 4, fragment = 2531, id = 1031, move_order = 3, name = 82891, name_en = "Imhotep", range = 6, 
skill_list = {19, 103101, 103102}
, src_id = 1031}
, 
[1034] = {camp = 1, career = 3, fragment = 2534, id = 1034, move_spd = 200, name = 36722, rank = 2, 
skill_list = {21, 103401, 103402}
, src_id = 1034, talk = 153459}
, 
[1035] = {career = 4, fragment = 2535, id = 1035, move_spd = 200, mvp_para = __rt_8, name = 296267, name_en = "Jessie", rank = 2, 
skill_list = {12, 1046, 1047, 103503}
, src_id = 1035, tag = __rt_3}
, 
[1036] = {algorithm_space = __rt_12, fragment = 2536, id = 1036, move_order = 2, name = 354312, name_en = "Lam", range = 5, rank = 2, src_id = 1036}
, 
[1037] = {camp = 2, fragment = 2537, id = 1037, move_order = 2, name = 228619, name_en = "Hubble", range = 9, rank = 6, 
skill_list = {16, 1054, 1055, 1060}
, src_id = 1037}
, 
[1038] = {career = 3, fragment = 2538, id = 1038, move_spd = 200, name = 524129, name_en = "Sakuya", 
skill_list = {23, 103801, 103802}
, src_id = 1038}
, 
[1039] = {algorithm_space = __rt_12, career = 3, fragment = 2539, id = 1039, move_spd = 200, mvp_para = __rt_13, name = 472491, name_en = "Centaureissi", rank = 6, 
skill_list = {25, 103901, 103902}
, src_id = 1039}
}
local __default_values = {algorithm_space = __rt_10, camp = 5, career = 2, dorm_ai = 1001, fragment = 2501, id = 1001, intensity = 10, move_order = 1, move_spd = 100, mvp_para = __rt_11, name = 139228, name_en = "Abigail", range = 1, rank = 4, 
skill_list = {10, 1042, 1043, 1061}
, src_id = 1001, tag = __rt_9, talk = 455241}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(hero_data) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, totalHeroCount = 25}
setmetatable(hero_data, {__index = __rawdata})
return hero_data

-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {8, 4, 6}
local __rt_2 = {40, 55, 80, 100}
local __rt_3 = {3}
local __rt_4 = {4, 4, 10}
local __rt_5 = {90, 75, 50, 100}
local __rt_6 = {4}
local __rt_7 = {8, 6, 4}
local __rt_8 = {70, 70, 30, 100}
local __rt_9 = {1}
local __rt_10 = {4, 8, 6}
local __rt_11 = {100, 30, 30, 100}
local __rt_12 = {10, 4, 4}
local __rt_13 = {40, 80, 0, 100}
local __rt_14 = {5}
local __rt_15 = {5, 4}
local hero_data = {
    [1001] = {
        algorithm_space = __rt_1,
        camp = 2,
        career = 5,
        move_order = 3,
        mvp_para = __rt_2,
        name_en = "Persicaria",
        range = 3,
        skill_list = {5, 1030, 1031, 1059},
        tag = __rt_3,
        talk = 397529
    },
    [1002] = {
        algorithm_space = __rt_4,
        camp = 2,
        career = 4,
        fragment = 2502,
        id = 1002,
        move_order = 2,
        mvp_para = __rt_5,
        name = 170919,
        name_en = "Antonina",
        range = 5,
        skill_list = {6, 1032, 1033, 1062},
        src_id = 1002,
        tag = __rt_6,
        talk = 176282
    },
    [1003] = {
        algorithm_space = __rt_7,
        camp = 2,
        career = 3,
        fragment = 2503,
        id = 1003,
        move_spd = 200,
        mvp_para = __rt_8,
        name = 14037,
        name_en = "Sol",
        skill_list = {8, 1038, 1039, 1065},
        src_id = 1003
    },
    [1004] = {
        camp = 1,
        fragment = 2504,
        id = 1004,
        move_order = 2,
        name = 412120,
        name_en = "Simo",
        range = 5,
        rank = 2,
        skill_list = {9, 1040, 1041, 100403},
        src_id = 1004,
        tag = {2}
    },
    [1005] = {
        algorithm_space = __rt_12,
        camp = 1,
        career = 1,
        fragment = 2505,
        id = 1005,
        move_spd = 200,
        mvp_para = __rt_13,
        name = 279575,
        name_en = "Croque",
        rank = 6,
        skill_list = {7, 1034, 1035, 1058},
        src_id = 1005,
        tag = __rt_14
    },
    [1006] = {
        camp = 2,
        fragment = 2506,
        id = 1006,
        move_order = 2,
        name = 464803,
        name_en = "Fresnel",
        range = 5,
        skill_list = {4, 1036, 1037, 100603},
        src_id = 1006
    },
    [1007] = {
        algorithm_space = __rt_7,
        camp = 1,
        career = 3,
        fragment = 2507,
        id = 1007,
        move_spd = 200,
        mvp_para = __rt_8,
        name = 245114,
        name_en = "Chelsea",
        skill_list = {3, 1027, 1028, 1022},
        src_id = 1007
    },
    [1008] = {
        algorithm_space = __rt_1,
        career = 5,
        fragment = 2508,
        id = 1008,
        move_order = 3,
        mvp_para = {40, 55, 30, 90},
        name = 87399,
        name_en = "Gin",
        range = 3,
        rank = 6,
        skill_list = {14, 1050, 1051, 100803},
        src_id = 1008,
        tag = __rt_3
    },
    [1009] = {
        algorithm_space = __rt_4,
        camp = 2,
        fragment = 2509,
        id = 1009,
        move_order = 2,
        mvp_para = __rt_5,
        name = 424012,
        name_en = "Mai",
        range = 5,
        rank = 2,
        skill_list = {2, 100901, 1023},
        src_id = 1009,
        talk = 517361
    },
    [1010] = {
        algorithm_space = __rt_12,
        camp = 1,
        career = 1,
        fragment = 2510,
        id = 1010,
        move_spd = 200,
        mvp_para = __rt_13,
        name = 516981,
        name_en = "Evelyn",
        skill_list = {13, 1048, 1049},
        src_id = 1010,
        tag = __rt_15,
        talk = 441548
    },
    [1012] = {
        camp = 2,
        fragment = 2512,
        id = 1012,
        move_order = 2,
        name = 189805,
        name_en = "Max",
        range = 6,
        rank = 2,
        skill_list = {18, 1066, 1067},
        src_id = 1012
    },
    [1013] = {
        career = 3,
        fragment = 2513,
        id = 1013,
        move_spd = 200,
        name = 318511,
        name_en = "Betty",
        skill_list = {22, 101301, 101303, 101304},
        src_id = 1013
    },
    [1016] = {
        algorithm_space = __rt_4,
        camp = 4,
        career = 4,
        fragment = 2516,
        id = 1016,
        move_order = 2,
        mvp_para = __rt_5,
        name = 492510,
        name_en = "Banxsy",
        range = 2,
        rank = 6,
        skill_list = {11, 1044, 1045},
        src_id = 1016
    },
    [1017] = {
        algorithm_space = __rt_1,
        fragment = 2517,
        id = 1017,
        move_order = 3,
        mvp_para = __rt_2,
        name = 88362,
        name_en = "Angela",
        range = 3,
        skill_list = {17, 1056, 1057},
        src_id = 1017,
        tag = __rt_6,
        talk = 306803
    },
    [1020] = {
        algorithm_space = __rt_12,
        career = 3,
        fragment = 2520,
        id = 1020,
        move_spd = 200,
        mvp_para = __rt_13,
        name = 41160,
        name_en = "Yanny",
        skill_list = {26, 102001, 102002},
        src_id = 1020,
        tag = {1, 4}
    },
    [1021] = {
        algorithm_space = __rt_4,
        camp = 4,
        career = 4,
        fragment = 2521,
        id = 1021,
        move_order = 3,
        mvp_para = __rt_5,
        name = 508749,
        name_en = "Groove",
        range = 5,
        rank = 2,
        skill_list = {15, 1063, 1064},
        src_id = 1021,
        tag = __rt_6
    },
    [1023] = {
        algorithm_space = __rt_12,
        camp = 3,
        career = 1,
        fragment = 2523,
        id = 1023,
        move_spd = 200,
        mvp_para = __rt_13,
        name = 511896,
        name_en = "Bonee",
        rank = 2,
        skill_list = {24, 102301, 102302},
        src_id = 1023,
        tag = __rt_14
    },
    [1027] = {
        algorithm_space = __rt_12,
        camp = 1,
        career = 1,
        fragment = 2527,
        id = 1027,
        move_spd = 200,
        mvp_para = __rt_13,
        name = 403087,
        name_en = "Zion",
        skill_list = {20, 102701, 102702},
        src_id = 1027,
        tag = __rt_15
    },
    [1031] = {
        camp = 3,
        career = 4,
        fragment = 2531,
        id = 1031,
        move_order = 3,
        name = 82891,
        name_en = "Imhotep",
        range = 6,
        skill_list = {19, 103101, 103102},
        src_id = 1031
    },
    [1034] = {
        camp = 1,
        career = 3,
        fragment = 2534,
        id = 1034,
        move_spd = 200,
        name = 36722,
        rank = 2,
        skill_list = {21, 103401, 103402},
        src_id = 1034,
        talk = 153459
    },
    [1035] = {
        career = 4,
        fragment = 2535,
        id = 1035,
        move_spd = 200,
        mvp_para = __rt_8,
        name = 296267,
        name_en = "Jessie",
        rank = 2,
        skill_list = {12, 1046, 1047, 103503},
        src_id = 1035,
        tag = __rt_3
    },
    [1036] = {
        algorithm_space = __rt_12,
        fragment = 2536,
        id = 1036,
        move_order = 2,
        name = 354312,
        name_en = "Lam",
        range = 5,
        rank = 2,
        src_id = 1036
    },
    [1037] = {
        camp = 2,
        fragment = 2537,
        id = 1037,
        move_order = 2,
        name = 228619,
        name_en = "Hubble",
        range = 9,
        rank = 6,
        skill_list = {16, 1054, 1055, 1060},
        src_id = 1037
    },
    [1038] = {
        career = 3,
        fragment = 2538,
        id = 1038,
        move_spd = 200,
        name = 524129,
        name_en = "Sakuya",
        skill_list = {23, 103801, 103802},
        src_id = 1038
    },
    [1039] = {
        algorithm_space = __rt_12,
        career = 3,
        fragment = 2539,
        id = 1039,
        move_spd = 200,
        mvp_para = __rt_13,
        name = 472491,
        name_en = "Centaureissi",
        rank = 6,
        skill_list = {25, 103901, 103902},
        src_id = 1039
    }
}
local __default_values = {
    algorithm_space = __rt_10,
    camp = 5,
    career = 2,
    dorm_ai = 1001,
    fragment = 2501,
    id = 1001,
    intensity = 10,
    move_order = 1,
    move_spd = 100,
    mvp_para = __rt_11,
    name = 139228,
    name_en = "Abigail",
    range = 1,
    rank = 4,
    skill_list = {10, 1042, 1043, 1061},
    src_id = 1001,
    tag = __rt_9,
    talk = 455241
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(hero_data) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base, totalHeroCount = 25}
setmetatable(hero_data, {__index = __rawdata})
return hero_data

