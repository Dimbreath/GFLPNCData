local __rt_1 = {}
local __rt_2 = {80}
local __rt_3 = {202}
local __rt_4 = {203}
local __rt_5 = {9}
local __rt_6 = {50}
local __rt_7 = {204}
local __rt_8 = {226}
local __rt_9 = {160}
local __rt_10 = {100}
local __rt_11 = {9, 10}
local __rt_12 = {150}
local __rt_13 = {4002}
local __rt_14 = {200}
local __rt_15 = {2}
local __rt_16 = {300}
local __rt_17 = {-100}
local __rt_18 = {-300}
local __rt_19 = {203, 204, 212, 202, 207, 209}
local __rt_20 = {505, 308, 601, 594, 110, 110}
local __rt_21 = {60}
local __rt_22 = {4}
local __rt_23 = {20}
local __rt_24 = {40}
local __rt_25 = {35}
local __rt_26 = {90}
local __rt_27 = {230}
local __rt_28 = {75}
local __rt_29 = {5}
local __rt_30 = {25}
local __rt_31 = {45}
local __rt_32 = {210}
local __rt_33 = {190}
local __rt_34 = {175}
local __rt_35 = {550}
local __rt_36 = {510}
local __rt_37 = {460}
local __rt_38 = {425}
local __rt_39 = {65}
local __rt_40 = {204, 203}
local __rt_41 = {10}
local __rt_42 = {500}
local __rt_43 = {12}
local __rt_44 = {1000}
local __rt_45 = {95}
local __rt_46 = {7}
local __rt_47 = {85}
local __rt_48 = {310}
local __rt_49 = {250}
local __rt_50 = {120}
local __rt_51 = {750}
local __rt_52 = {560}
local __rt_53 = {520}
local __rt_54 = {420}
local __rt_55 = {390}
local __rt_56 = {2000}
local __rt_57 = {0}
local __rt_58 = {17}
local __rt_59 = {23}
local __rt_60 = {30}
local __rt_61 = {205}
local __rt_62 = {15}
local __rt_63 = {-200}
local __rt_64 = {600}
local __rt_65 = {209}
local __rt_66 = {20035}
local __rt_67 = {202, 19}
local __rt_68 = {100, 100}
local __rt_69 = {0, 0}
local __rt_70 = {19}
local __rt_71 = {-500}
local __rt_72 = {-50}
local __rt_73 = {209, 207}
local __rt_74 = {-1000, -1000}
local __rt_75 = {16}
local __rt_76 = {202, 203}
local __rt_77 = {300, 300}
local __rt_78 = {150, 150}
local __rt_79 = {140}
local __rt_80 = {70}
local chip = {
[904] = {id = 904, influence = 101, skill_list = __rt_2}
, 
[7001] = {attribute_id = __rt_3, attribute_initial = __rt_2, id = 7001, influence = 101, level_increase = __rt_2}
, 
[7002] = {attribute_id = __rt_4, attribute_initial = __rt_2, id = 7002, influence = 101, level_increase = __rt_2}
, 
[7003] = {attribute_id = __rt_5, attribute_initial = __rt_6, id = 7003, influence = 101, level_increase = __rt_6, 
skill_list = {17003}
}
, 
[7004] = {attribute_id = __rt_7, attribute_initial = __rt_2, id = 7004, influence = 101, level_increase = __rt_2}
, 
[7005] = {attribute_id = __rt_8, attribute_initial = __rt_2, id = 7005, influence = 101, level_increase = __rt_2}
, 
[7006] = {attribute_id = __rt_3, attribute_initial = __rt_9, id = 7006, influence = 101, level_increase = __rt_9}
, 
[7007] = {attribute_id = __rt_4, attribute_initial = __rt_9, id = 7007, influence = 101, level_increase = __rt_9}
, 
[7008] = {attribute_id = __rt_5, attribute_initial = __rt_10, id = 7008, influence = 101, level_increase = __rt_10}
, 
[7009] = {attribute_id = __rt_7, attribute_initial = __rt_9, id = 7009, influence = 101, level_increase = __rt_9}
, 
[7010] = {attribute_id = __rt_8, attribute_initial = __rt_9, id = 7010, influence = 101, level_increase = __rt_9}
, 
[8000] = {attribute_id = __rt_11, 
attribute_initial = {20, 100}
, id = 8000, influence = 101}
, 
[8001] = {attribute_id = __rt_11, 
attribute_initial = {40, 200}
, id = 8001, influence = 101}
, 
[8002] = {attribute_id = __rt_11, 
attribute_initial = {60, 300}
, id = 8002, influence = 101, 
skill_list = {4012}
}
, 
[8003] = {attribute_id = __rt_11, 
attribute_initial = {80, 400}
, id = 8003, influence = 101, 
skill_list = {4013}
}
, 
[8004] = {attribute_id = __rt_7, attribute_initial = __rt_6, id = 8004, influence = 101}
, 
[8005] = {attribute_id = __rt_7, attribute_initial = __rt_10, id = 8005, influence = 101}
, 
[8006] = {attribute_id = __rt_7, attribute_initial = __rt_12, id = 8006, influence = 101, skill_list = __rt_13}
, 
[8007] = {attribute_id = __rt_7, attribute_initial = __rt_14, id = 8007, influence = 101, 
skill_list = {4003}
}
, 
[8008] = {attribute_id = __rt_7, attribute_initial = __rt_10, id = 8008, influence = 101, level_increase = __rt_15, 
skill_list = {4004}
}
, 
[8009] = {attribute_id = __rt_7, attribute_initial = __rt_12, id = 8009, influence = 101, level_increase = __rt_15, 
skill_list = {4005}
}
, 
[8010] = {attribute_id = __rt_7, 
attribute_initial = {220}
, id = 8010, influence = 101, level_increase = __rt_15, 
skill_list = {4006}
}
, 
[8011] = {attribute_id = __rt_7, attribute_initial = __rt_16, id = 8011, influence = 101, level_increase = __rt_15, 
skill_list = {4007}
}
, 
[8012] = {attribute_id = __rt_7, attribute_initial = __rt_17, id = 8012, influence = 601, markid = 14}
, 
[8013] = {attribute_id = __rt_7, 
attribute_initial = {-150}
, id = 8013, influence = 601, markid = 14}
, 
[8014] = {attribute_id = __rt_7, 
attribute_initial = {-220}
, id = 8014, influence = 601, markid = 14}
, 
[8015] = {attribute_id = __rt_7, attribute_initial = __rt_18, id = 8015, influence = 601, markid = 14}
, 
[8016] = {id = 8016, influence = 101, 
skill_list = {4008}
}
, 
[8017] = {id = 8017, influence = 101, 
skill_list = {4009}
}
, 
[8018] = {id = 8018, influence = 101, 
skill_list = {4010}
}
, 
[8019] = {id = 8019, influence = 101, 
skill_list = {4011}
}
, 
[9001] = {attribute_id = __rt_19, 
attribute_initial = {1000, 0, 0, 1000, 0, 0}
, id = 9001, influence = 101}
, 
[9002] = {attribute_id = __rt_19, attribute_initial = __rt_20, id = 9002, influence = 601, markid = 14}
, 
[9003] = {attribute_id = __rt_19, 
attribute_initial = {419, 241, 500, 435, 110, 110}
, id = 9003, influence = 101}
, 
[9004] = {attribute_id = __rt_19, 
attribute_initial = {323, 172, 350, 368, 110, 110}
, id = 9004, influence = 101}
, 
[9005] = {attribute_id = __rt_19, 
attribute_initial = {403, 227, 462, 468, 110, 110}
, id = 9005, influence = 101}
, 
[9006] = {attribute_id = __rt_19, 
attribute_initial = {422, 246, 500, 492, 110, 110}
, id = 9006, influence = 101}
, 
[9007] = {attribute_id = __rt_19, 
attribute_initial = {447, 260, 527, 527, 110, 110}
, id = 9007, influence = 101}
, 
[9008] = {attribute_id = __rt_19, 
attribute_initial = {453, 269, 545, 538, 110, 110}
, id = 9008, influence = 101}
, 
[9009] = {attribute_id = __rt_19, attribute_initial = __rt_20, id = 9009, influence = 101}
, 
[9010] = {attribute_id = __rt_19, 
attribute_initial = {492, 355, 612, 571, 110, 110}
, id = 9010, influence = 101}
, 
[9011] = {attribute_id = __rt_19, 
attribute_initial = {569, 360, 678, 689, 120, 120}
, id = 9011, influence = 101}
, 
[9012] = {attribute_id = __rt_19, 
attribute_initial = {654, 398, 735, 778, 170, 170}
, id = 9012, influence = 101}
, 
[9013] = {attribute_id = __rt_19, 
attribute_initial = {671, 355, 612, 760, 110, 110}
, id = 9013, influence = 101}
, 
[10000] = {attribute_id = __rt_19, 
attribute_initial = {481, 288, 582, 563, 110, 110}
, influence = 101}
, 
[10001] = {arg = 1, id = 10001, markid = 3, 
skill_list = {10001}
}
, 
[10002] = {arg = 2, id = 10002, markid = 4, 
skill_list = {10002}
}
, 
[10003] = {arg = 2, id = 10003, markid = 4, 
skill_list = {10003}
}
, 
[10004] = {arg = 1, id = 10004, markid = 3, 
skill_list = {10004}
}
, 
[10005] = {id = 10005, influence = 101, 
skill_list = {10005}
}
, 
[10006] = {id = 10006, influence = 101, 
skill_list = {10006}
}
, 
[10007] = {arg = 2, id = 10007, markid = 4, 
skill_list = {10007}
}
, 
[10008] = {arg = 2, id = 10008, influence = 104, markid = 1, 
skill_list = {10008}
}
, 
[10009] = {id = 10009, influence = 101, 
skill_list = {10009}
}
, 
[10010] = {arg = 2, id = 10010, markid = 4, 
skill_list = {10010}
}
, 
[10011] = {id = 10011, influence = 101, 
skill_list = {10011}
}
, 
[10012] = {id = 10012, influence = 101, 
skill_list = {10012}
}
, 
[10013] = {arg = 1, id = 10013, markid = 3, 
skill_list = {10013}
}
, 
[10014] = {arg = 2, id = 10014, markid = 4, 
skill_list = {10014}
}
, 
[10015] = {arg = 3, fun_tag = 5, id = 10015, markid = 5, 
skill_list = {10015}
}
, 
[10016] = {arg = 3, id = 10016, markid = 5, 
skill_list = {10016}
}
, 
[10017] = {id = 10017, influence = 101, 
skill_list = {10017}
}
, 
[10018] = {arg = 1, id = 10018, markid = 3, 
skill_list = {10018}
}
, 
[10019] = {id = 10019, influence = 101, 
skill_list = {10019}
}
, 
[10020] = {arg = 2, id = 10020, markid = 4, 
skill_list = {10020}
}
, 
[10021] = {id = 10021, influence = 101, 
skill_list = {10021}
}
, 
[10022] = {arg = 1, fun_tag = 2, id = 10022, markid = 3, 
skill_list = {10022}
}
, 
[10023] = {id = 10023, influence = 101, 
skill_list = {10023}
}
, 
[10024] = {id = 10024, influence = 101, 
skill_list = {10024}
}
, 
[10025] = {arg = 4, id = 10025, markid = 6, 
skill_list = {10025}
}
, 
[10026] = {id = 10026, influence = 101, 
skill_list = {10026}
}
, 
[10027] = {arg = 5, id = 10027, markid = 7, 
skill_list = {10027}
}
, 
[10028] = {arg = 1, id = 10028, markid = 3, 
skill_list = {10028}
}
, 
[10029] = {attribute_id = __rt_4, attribute_initial = __rt_21, id = 10029, influence = 101, level_increase = __rt_21}
, 
[10030] = {attribute_id = __rt_22, attribute_initial = __rt_23, id = 10030, influence = 101, level_increase = __rt_23}
, 
[10031] = {attribute_id = __rt_3, attribute_initial = __rt_21, id = 10031, influence = 101, level_increase = __rt_21}
, 
[10032] = {arg = 1, attribute_id = __rt_3, attribute_initial = __rt_24, id = 10032, influence = 104, level_increase = __rt_24, markid = 2}
, 
[10033] = {arg = 2, attribute_id = __rt_4, attribute_initial = __rt_25, id = 10033, influence = 104, level_increase = __rt_25, markid = 1}
, 
[10034] = {arg = 1, attribute_id = __rt_3, attribute_initial = __rt_26, id = 10034, level_increase = __rt_26, markid = 3}
, 
[10035] = {arg = 1, attribute_id = __rt_22, attribute_initial = __rt_27, id = 10035, level_increase = __rt_27, markid = 3}
, 
[10036] = {arg = 3, attribute_id = __rt_4, attribute_initial = __rt_28, id = 10036, level_increase = __rt_28, markid = 5}
, 
[10037] = {arg = 2, attribute_id = __rt_4, attribute_initial = __rt_28, id = 10037, level_increase = __rt_28, markid = 4}
, 
[10038] = {arg = 2, attribute_id = __rt_29, attribute_initial = __rt_30, id = 10038, level_increase = __rt_30, markid = 4}
, 
[10039] = {arg = 5, attribute_id = __rt_3, attribute_initial = __rt_31, id = 10039, level_increase = __rt_31, markid = 7}
, 
[10040] = {arg = 4, attribute_id = __rt_3, attribute_initial = __rt_31, id = 10040, level_increase = __rt_31, markid = 6}
, 
[10041] = {arg = 5, attribute_id = __rt_3, attribute_initial = __rt_27, id = 10041, level_increase = __rt_27, markid = 7}
, 
[10042] = {arg = 1, attribute_id = __rt_3, attribute_initial = __rt_32, id = 10042, influence = 104, level_increase = __rt_32, markid = 2}
, 
[10043] = {arg = 3, attribute_id = __rt_4, attribute_initial = __rt_33, id = 10043, level_increase = __rt_33, markid = 5}
, 
[10044] = {arg = 2, attribute_id = __rt_4, attribute_initial = __rt_34, id = 10044, influence = 104, level_increase = __rt_34, markid = 1}
, 
[10045] = {arg = 2, attribute_id = __rt_4, attribute_initial = __rt_33, id = 10045, level_increase = __rt_33, markid = 4}
, 
[10046] = {arg = 2, attribute_id = __rt_29, attribute_initial = __rt_30, id = 10046, level_increase = __rt_30, markid = 4}
, 
[10047] = {arg = 5, attribute_id = __rt_3, attribute_initial = __rt_35, id = 10047, level_increase = __rt_35, markid = 7}
, 
[10048] = {arg = 1, attribute_id = __rt_3, attribute_initial = __rt_36, id = 10048, influence = 104, level_increase = __rt_36, markid = 2}
, 
[10049] = {arg = 3, attribute_id = __rt_4, attribute_initial = __rt_37, id = 10049, level_increase = __rt_37, markid = 5}
, 
[10050] = {arg = 2, attribute_id = __rt_4, attribute_initial = __rt_38, id = 10050, influence = 104, level_increase = __rt_38, markid = 1}
, 
[10051] = {arg = 2, attribute_id = __rt_4, attribute_initial = __rt_37, id = 10051, level_increase = __rt_37, markid = 4}
, 
[10052] = {arg = 2, attribute_id = __rt_29, attribute_initial = __rt_39, id = 10052, level_increase = __rt_39, markid = 4}
, 
[10053] = {attribute_id = __rt_40, 
attribute_initial = {200, -100}
, id = 10053, influence = 101, 
level_increase = {200, 0}
}
, 
[10054] = {attribute_id = __rt_40, 
attribute_initial = {300, -150}
, id = 10054, influence = 101, 
level_increase = {300, 0}
}
, 
[10055] = {attribute_id = __rt_40, 
attribute_initial = {400, -200}
, id = 10055, influence = 101, 
level_increase = {400, 0}
}
, 
[10056] = {attribute_id = __rt_40, 
attribute_initial = {500, -250}
, id = 10056, influence = 101, 
level_increase = {500, 0}
}
, 
[10057] = {id = 10057, influence = 101, 
skill_list = {40008}
}
, 
[10058] = {id = 10058, influence = 101, skill_list = __rt_13}
, 
[10059] = {attribute_id = __rt_29, attribute_initial = __rt_30, id = 10059, influence = 101, level_increase = __rt_30}
, 
[10060] = {arg = 4, id = 10060, markid = 6, 
skill_list = {10060}
}
, 
[10061] = {arg = 3, fun_tag = 5, id = 10061, markid = 5, 
skill_list = {10061}
}
, 
[10062] = {id = 10062, influence = 101, 
skill_list = {10062}
}
, 
[10063] = {arg = 5, id = 10063, markid = 7, 
skill_list = {10063}
}
, 
[10064] = {arg = 5, id = 10064, markid = 7, 
skill_list = {10064}
}
, 
[10065] = {arg = 1, id = 10065, influence = 104, markid = 2, 
skill_list = {10065}
}
, 
[10066] = {arg = 4, fun_tag = 10, id = 10066, markid = 6, 
skill_list = {10066}
}
, 
[10067] = {arg = 1, id = 10067, influence = 104, markid = 2, 
skill_list = {10067}
}
, 
[10068] = {arg = 2, id = 10068, markid = 4, 
skill_list = {10068}
}
, 
[10069] = {id = 10069, influence = 101, 
skill_list = {10069}
}
, 
[10070] = {id = 10070, influence = 101}
, 
[10071] = {attribute_id = __rt_41, attribute_initial = __rt_42, id = 10071, influence = 101, level_increase = __rt_42}
, 
[10072] = {attribute_id = __rt_43, attribute_initial = __rt_41, id = 10072, influence = 101, level_increase = __rt_41}
, 
[10073] = {id = 10073, influence = 601, markid = 14, 
skill_list = {10073}
}
, 
[10074] = {arg = 2, fun_tag = 9, id = 10074, markid = 4, 
skill_list = {10074}
}
, 
[10075] = {id = 10075, influence = 601, markid = 14, 
skill_list = {10075}
}
, 
[10076] = {arg = 2, fun_tag = 18, id = 10076, influence = 104, info = 141665, markid = 1, 
skill_list = {10076}
}
, 
[10077] = {id = 10077, influence = 101, 
skill_list = {10077}
}
, 
[10078] = {arg = 4, id = 10078, markid = 6, 
skill_list = {10078}
}
, 
[10079] = {arg = 5, id = 10079, markid = 7, 
skill_list = {10079}
}
, 
[10080] = {id = 10080, influence = 101, 
skill_list = {10080}
}
, 
[10081] = {id = 10081, influence = 101, 
skill_list = {10081}
}
, 
[10082] = {arg = 1, id = 10082, influence = 104, markid = 2, 
skill_list = {10082}
}
, 
[10083] = {id = 10083, influence = 101, 
skill_list = {10083}
}
, 
[10084] = {attribute_id = __rt_4, attribute_initial = __rt_44, id = 10084, influence = 101, level_increase = __rt_44}
, 
[10085] = {attribute_id = __rt_3, attribute_initial = __rt_39, id = 10085, influence = 101, info = 84517, level_increase = __rt_39}
, 
[10086] = {arg = 5, attribute_id = __rt_3, attribute_initial = __rt_45, id = 10086, info = 84517, level_increase = __rt_45, markid = 7}
, 
[10087] = {arg = 4, attribute_id = __rt_43, attribute_initial = __rt_10, id = 10087, level_increase = __rt_10, markid = 6}
, 
[10088] = {arg = 2, attribute_id = __rt_29, attribute_initial = __rt_23, id = 10088, level_increase = __rt_23, markid = 4}
, 
[10089] = {arg = 1, attribute_id = __rt_46, attribute_initial = __rt_47, id = 10089, level_increase = __rt_47, markid = 3}
, 
[10090] = {arg = 3, attribute_id = __rt_5, attribute_initial = __rt_2, id = 10090, level_increase = __rt_2, markid = 5}
, 
[10091] = {attribute_id = __rt_41, attribute_initial = __rt_48, id = 10091, influence = 101, level_increase = __rt_48}
, 
[10092] = {id = 10092, influence = 101, 
skill_list = {10092}
}
, 
[10093] = {id = 10093, influence = 101, 
skill_list = {10093}
}
, 
[10094] = {id = 10094, influence = 101, 
skill_list = {10094}
}
, 
[10095] = {attribute_id = __rt_4, attribute_initial = __rt_9, id = 10095, influence = 101, level_increase = __rt_6}
, 
[10096] = {attribute_id = __rt_3, attribute_initial = __rt_9, id = 10096, influence = 101, info = 84517, level_increase = __rt_9}
, 
[10097] = {arg = 1, attribute_id = __rt_22, attribute_initial = __rt_49, id = 10097, level_increase = __rt_49, markid = 3}
, 
[10098] = {attribute_id = __rt_43, attribute_initial = __rt_12, id = 10098, influence = 101, level_increase = __rt_12}
, 
[10099] = {arg = 3, attribute_id = __rt_29, attribute_initial = __rt_6, id = 10099, level_increase = __rt_6, markid = 5}
, 
[10100] = {attribute_id = __rt_46, attribute_initial = __rt_50, id = 10100, influence = 101, level_increase = __rt_50}
, 
[10101] = {arg = 2, attribute_id = __rt_5, attribute_initial = __rt_33, id = 10101, level_increase = __rt_33, markid = 4}
, 
[10102] = {attribute_id = __rt_41, attribute_initial = __rt_51, id = 10102, influence = 101, level_increase = __rt_51}
, 
[10103] = {id = 10103, influence = 101, 
skill_list = {10103}
}
, 
[10104] = {id = 10104, influence = 101, 
skill_list = {10104}
}
, 
[10105] = {id = 10105, influence = 101, 
skill_list = {10105}
}
, 
[10106] = {arg = 3, attribute_id = __rt_4, attribute_initial = __rt_52, id = 10106, level_increase = __rt_52, markid = 5}
, 
[10107] = {arg = 1, attribute_id = __rt_3, attribute_initial = __rt_52, id = 10107, level_increase = __rt_52, markid = 3}
, 
[10108] = {arg = 1, attribute_id = __rt_22, attribute_initial = __rt_53, id = 10108, level_increase = __rt_53, markid = 3}
, 
[10109] = {arg = 3, attribute_id = __rt_43, attribute_initial = __rt_53, id = 10109, level_increase = __rt_53, markid = 5}
, 
[10110] = {arg = 2, attribute_id = __rt_29, attribute_initial = __rt_10, id = 10110, level_increase = __rt_10, markid = 4}
, 
[10111] = {arg = 4, attribute_id = __rt_46, attribute_initial = __rt_54, id = 10111, level_increase = __rt_54, markid = 6}
, 
[10112] = {arg = 2, attribute_id = __rt_5, attribute_initial = __rt_55, id = 10112, level_increase = __rt_55, markid = 4}
, 
[10113] = {arg = 2, attribute_id = __rt_41, attribute_initial = __rt_56, id = 10113, level_increase = __rt_56, markid = 4}
, 
[10114] = {arg = 4, id = 10114, markid = 6, 
skill_list = {10114}
}
, 
[10115] = {arg = 1, id = 10115, markid = 3, 
skill_list = {10115}
}
, 
[10116] = {arg = 3, id = 10116, markid = 5, 
skill_list = {10116}
}
, 
[10117] = {arg = 5, attribute_id = __rt_4, attribute_initial = __rt_52, id = 10117, level_increase = __rt_52, markid = 7}
, 
[10118] = {arg = 5, attribute_id = __rt_3, attribute_initial = __rt_52, id = 10118, info = 84517, level_increase = __rt_52, markid = 7}
, 
[10119] = {arg = 2, id = 10119, markid = 4, 
skill_list = {10119}
}
, 
[10120] = {arg = 3, fun_tag = 5, id = 10120, markid = 5, 
skill_list = {10120}
}
, 
[10121] = {arg = 3, id = 10121, markid = 5, 
skill_list = {10121}
}
, 
[10122] = {arg = 1, id = 10122, markid = 3, 
skill_list = {10122}
}
, 
[10123] = {arg = 2, fun_tag = 9, id = 10123, markid = 4, 
skill_list = {10123}
}
, 
[10124] = {arg = 4, fun_tag = 10, id = 10124, markid = 6, 
skill_list = {10124}
}
, 
[10125] = {arg = 5, id = 10125, markid = 7, 
skill_list = {10125}
}
, 
[10126] = {arg = 3, id = 10126, markid = 5, 
skill_list = {10126}
}
, 
[10127] = {arg = 1, fun_tag = 1, id = 10127, markid = 3, 
skill_list = {10127}
}
, 
[10128] = {arg = 3, fun_tag = 6, id = 10128, markid = 5, 
skill_list = {10128}
}
, 
[10129] = {arg = 2, id = 10129, markid = 4, 
skill_list = {10129}
}
, 
[10130] = {arg = 2, id = 10130, markid = 4, 
skill_list = {10130}
}
, 
[10131] = {arg = 4, id = 10131, markid = 6, 
skill_list = {10131}
}
, 
[10132] = {arg = 4, id = 10132, markid = 6, 
skill_list = {10132}
}
, 
[10133] = {arg = 5, fun_tag = 17, id = 10133, markid = 7, 
skill_list = {10133}
}
, 
[10134] = {arg = 1, id = 10134, markid = 3, 
skill_list = {10134}
}
, 
[10135] = {arg = 4, fun_tag = 12, id = 10135, markid = 6, 
skill_list = {10135}
}
, 
[10136] = {arg = 1, fun_tag = 3, id = 10136, markid = 3, 
skill_list = {10136}
}
, 
[10137] = {arg = 1, fun_tag = 2, id = 10137, markid = 3, 
skill_list = {10137}
}
, 
[10138] = {arg = 4, fun_tag = 10, id = 10138, markid = 6, 
skill_list = {10138}
}
, 
[10139] = {arg = 5, fun_tag = 14, id = 10139, markid = 7, 
skill_list = {10139}
}
, 
[10140] = {arg = 5, fun_tag = 14, id = 10140, markid = 7, 
skill_list = {10140}
}
, 
[10141] = {arg = 1, fun_tag = 1, id = 10141, markid = 3, 
skill_list = {10141}
}
, 
[10142] = {arg = 3, id = 10142, markid = 5, 
skill_list = {10142}
}
, 
[10143] = {arg = 1, fun_tag = 1, id = 10143, markid = 3, 
skill_list = {10143}
}
, 
[10144] = {arg = 3, id = 10144, markid = 5, 
skill_list = {10144}
}
, 
[10145] = {arg = 3, id = 10145, markid = 5, 
skill_list = {10145}
}
, 
[10146] = {arg = 3, id = 10146, markid = 5, 
skill_list = {10146}
}
, 
[10147] = {arg = 2, fun_tag = 7, id = 10147, markid = 4, 
skill_list = {10147}
}
, 
[10148] = {arg = 2, id = 10148, markid = 4, 
skill_list = {10148}
}
, 
[10149] = {arg = 4, fun_tag = 11, id = 10149, markid = 6, 
skill_list = {10149}
}
, 
[10150] = {arg = 4, fun_tag = 11, id = 10150, markid = 6, 
skill_list = {10150}
}
, 
[10151] = {arg = 4, fun_tag = 11, id = 10151, markid = 6, 
skill_list = {10151}
}
, 
[10152] = {arg = 5, fun_tag = 15, id = 10152, markid = 7, 
skill_list = {10152}
}
, 
[10153] = {arg = 5, id = 10153, markid = 7, 
skill_list = {10153}
}
, 
[10154] = {arg = 5, fun_tag = 15, id = 10154, markid = 7, 
skill_list = {10154}
}
, 
[10155] = {arg = 1, id = 10155, markid = 3, 
skill_list = {10155}
}
, 
[10156] = {arg = 2, id = 10156, markid = 4, 
skill_list = {10156}
}
, 
[10157] = {arg = 3, fun_tag = 6, id = 10157, markid = 5, 
skill_list = {10157}
}
, 
[10158] = {arg = 4, id = 10158, markid = 6, 
skill_list = {10158}
}
, 
[10159] = {arg = 4, id = 10159, markid = 6, 
skill_list = {10159}
}
, 
[10160] = {arg = 3, id = 10160, markid = 5, 
skill_list = {10160}
}
, 
[10161] = {arg = 5, id = 10161, markid = 7, 
skill_list = {10161}
}
, 
[10162] = {arg = 3, id = 10162, markid = 5, 
skill_list = {10162}
}
, 
[10164] = {arg = 4, id = 10164, markid = 6, 
skill_list = {10164}
}
, 
[10165] = {arg = 1, fun_tag = 17, id = 10165, influence = 104, markid = 2, 
skill_list = {10165}
}
, 
[10166] = {arg = 2, id = 10166, influence = 104, markid = 1, 
skill_list = {10166}
}
, 
[10167] = {arg = 3, fun_tag = 17, id = 10167, markid = 5, 
skill_list = {10167}
}
, 
[10168] = {arg = 1, id = 10168, markid = 3, 
skill_list = {10168}
}
, 
[10169] = {id = 10169, influence = 701, markid = 14, 
skill_list = {10169}
}
, 
[10170] = {id = 10170, influence = 101, 
skill_list = {10170}
}
, 
[10171] = {id = 10171, influence = 701, markid = 14, 
skill_list = {10171}
}
, 
[10172] = {id = 10172, influence = 701, markid = 14, 
skill_list = {10172}
}
, 
[10173] = {id = 10173, influence = 701, markid = 14, 
skill_list = {10173}
}
, 
[10174] = {id = 10174, influence = 101, 
skill_list = {10174}
}
, 
[10175] = {id = 10175, influence = 101, 
skill_list = {10175}
}
, 
[10176] = {id = 10176, influence = 701, markid = 14, 
skill_list = {10176}
}
, 
[10177] = {arg = 1, id = 10177, influence = 104, markid = 2, 
skill_list = {10177}
}
, 
[10178] = {arg = 2, id = 10178, influence = 104, markid = 1, 
skill_list = {10178}
}
, 
[10179] = {id = 10179, influence = 101, 
skill_list = {10179}
}
, 
[10180] = {id = 10180, influence = 101, 
skill_list = {10180}
}
, 
[10181] = {id = 10181, influence = 101, 
skill_list = {10181}
}
, 
[10182] = {id = 10182, influence = 701, markid = 14, 
skill_list = {10182}
}
, 
[10183] = {id = 10183, influence = 701, markid = 14, 
skill_list = {10183}
}
, 
[10184] = {id = 10184, influence = 101, 
skill_list = {10184}
}
, 
[10185] = {id = 10185, influence = 101, 
skill_list = {10185}
}
, 
[10186] = {id = 10186, influence = 101, 
skill_list = {10186}
}
, 
[10187] = {arg = 1, id = 10187, influence = 104, markid = 2, 
skill_list = {10187}
}
, 
[10188] = {arg = 2, id = 10188, influence = 104, markid = 1, 
skill_list = {10188}
}
, 
[10189] = {arg = 2, id = 10189, influence = 104, markid = 1, 
skill_list = {10189}
}
, 
[10190] = {id = 10190, influence = 101, 
skill_list = {10190}
}
, 
[10191] = {id = 10191, influence = 101, 
skill_list = {10191}
}
, 
[10192] = {arg = 5, id = 10192, markid = 7, 
skill_list = {10192}
}
, 
[10193] = {arg = 1, fun_tag = 18, id = 10193, influence = 104, markid = 2, 
skill_list = {10193}
}
, 
[10194] = {id = 10194, influence = 701, markid = 14, 
skill_list = {10194}
}
, 
[10195] = {arg = 1, id = 10195, influence = 104, markid = 2, 
skill_list = {10195}
}
, 
[10196] = {arg = 2, id = 10196, influence = 104, markid = 1, 
skill_list = {10196}
}
, 
[10197] = {id = 10197, influence = 101, 
skill_list = {10197}
}
, 
[10198] = {id = 10198, influence = 601, markid = 14, 
skill_list = {10198}
}
, 
[10199] = {id = 10199, influence = 701, markid = 14, 
skill_list = {10199}
}
, 
[10200] = {id = 10200, influence = 701, markid = 14, 
skill_list = {10200}
}
, 
[10201] = {id = 10201, influence = 101, 
skill_list = {10201}
}
, 
[10202] = {id = 10202, influence = 101, 
skill_list = {10202}
}
, 
[10203] = {id = 10203, influence = 701, markid = 14, 
skill_list = {10203}
}
, 
[10204] = {arg = 1, fun_tag = 3, id = 10204, markid = 3, 
skill_list = {10204}
}
, 
[10205] = {arg = 1, id = 10205, markid = 3, 
skill_list = {10205}
}
, 
[10206] = {arg = 3, fun_tag = 4, id = 10206, markid = 5, 
skill_list = {10206}
}
, 
[10207] = {arg = 3, fun_tag = 4, id = 10207, markid = 5, 
skill_list = {10207}
}
, 
[10208] = {arg = 3, id = 10208, markid = 5, 
skill_list = {10208}
}
, 
[10209] = {arg = 2, fun_tag = 8, id = 10209, markid = 4, 
skill_list = {10209}
}
, 
[10210] = {arg = 2, id = 10210, markid = 4, 
skill_list = {10210}
}
, 
[10211] = {arg = 2, fun_tag = 8, id = 10211, markid = 4, 
skill_list = {10211}
}
, 
[10212] = {arg = 3, fun_tag = 18, id = 10212, markid = 5, 
skill_list = {10212}
}
, 
[10213] = {arg = 4, fun_tag = 18, id = 10213, markid = 6, 
skill_list = {10213}
}
, 
[10214] = {arg = 5, id = 10214, markid = 7, 
skill_list = {10214}
}
, 
[10215] = {arg = 1, fun_tag = 16, id = 10215, markid = 3, 
skill_list = {10215}
}
, 
[10216] = {id = 10216, influence = 701, markid = 14, 
skill_list = {10216}
}
, 
[10217] = {id = 10217, influence = 601, markid = 14, 
skill_list = {10217}
}
, 
[10218] = {arg = 1, fun_tag = 3, id = 10218, markid = 3, 
skill_list = {10218}
}
, 
[10219] = {arg = 1, id = 10219, markid = 3, 
skill_list = {10219}
}
, 
[10220] = {arg = 3, fun_tag = 6, id = 10220, markid = 5, 
skill_list = {10220}
}
, 
[10221] = {arg = 3, fun_tag = 4, id = 10221, markid = 5, 
skill_list = {10221}
}
, 
[10222] = {arg = 3, fun_tag = 4, id = 10222, markid = 5, 
skill_list = {10222}
}
, 
[10223] = {arg = 2, fun_tag = 9, id = 10223, markid = 4, 
skill_list = {10223}
}
, 
[10224] = {arg = 2, fun_tag = 7, id = 10224, markid = 4, 
skill_list = {10224}
}
, 
[10225] = {arg = 2, fun_tag = 7, id = 10225, markid = 4, 
skill_list = {10225}
}
, 
[10226] = {arg = 2, fun_tag = 8, id = 10226, markid = 4, 
skill_list = {10226}
}
, 
[10227] = {arg = 4, fun_tag = 11, id = 10227, markid = 6, 
skill_list = {10227}
}
, 
[10228] = {arg = 4, fun_tag = 12, id = 10228, markid = 6, 
skill_list = {10228}
}
, 
[10229] = {arg = 4, id = 10229, markid = 6, 
skill_list = {10229}
}
, 
[10230] = {arg = 4, fun_tag = 12, id = 10230, markid = 6, 
skill_list = {10230}
}
, 
[10231] = {arg = 4, fun_tag = 12, id = 10231, markid = 6, 
skill_list = {10231}
}
, 
[10232] = {arg = 5, fun_tag = 14, id = 10232, markid = 7, 
skill_list = {10232}
}
, 
[10233] = {arg = 5, id = 10233, markid = 7, 
skill_list = {10233}
}
, 
[10234] = {arg = 5, fun_tag = 13, id = 10234, markid = 7, 
skill_list = {10234}
}
, 
[10235] = {arg = 5, id = 10235, markid = 7, 
skill_list = {10235}
}
, 
[10236] = {arg = 5, id = 10236, markid = 7, 
skill_list = {10236}
}
, 
[10237] = {arg = 5, id = 10237, markid = 7, 
skill_list = {10237}
}
, 
[10238] = {arg = 2, fun_tag = 16, id = 10238, markid = 4, 
skill_list = {10238}
}
, 
[10239] = {arg = 1, fun_tag = 16, id = 10239, influence = 104, markid = 2, 
skill_list = {10239}
}
, 
[10240] = {arg = 2, fun_tag = 16, id = 10240, influence = 104, markid = 1, 
skill_list = {10240}
}
, 
[10241] = {id = 10241, influence = 101, 
skill_list = {10241}
}
, 
[10242] = {id = 10242, influence = 101, 
skill_list = {10242}
}
, 
[10243] = {id = 10243, influence = 101, 
skill_list = {10243}
}
, 
[10244] = {id = 10244, influence = 101, 
skill_list = {10244}
}
, 
[10245] = {id = 10245, influence = 101, 
skill_list = {10245}
}
, 
[10246] = {arg = 1, fun_tag = 1, id = 10246, markid = 3, 
skill_list = {10246}
}
, 
[10247] = {arg = 2, fun_tag = 7, id = 10247, markid = 4, 
skill_list = {10247}
}
, 
[10248] = {arg = 5, fun_tag = 13, id = 10248, markid = 7, 
skill_list = {10248}
}
, 
[10249] = {arg = 5, id = 10249, markid = 7, 
skill_list = {10249}
}
, 
[10250] = {arg = 5, fun_tag = 13, id = 10250, markid = 7, 
skill_list = {10250}
}
, 
[10251] = {arg = 1, fun_tag = 3, id = 10251, markid = 3, 
skill_list = {10251}
}
, 
[10252] = {arg = 5, id = 10252, markid = 7, 
skill_list = {10252}
}
, 
[10253] = {arg = 5, id = 10253, markid = 7, 
skill_list = {10253}
}
, 
[10254] = {arg = 5, fun_tag = 15, id = 10254, markid = 7, 
skill_list = {10254}
}
, 
[10255] = {arg = 2, id = 10255, influence = 104, markid = 1, 
skill_list = {10255}
}
, 
[10256] = {arg = 3, id = 10256, markid = 5, 
skill_list = {10256}
}
, 
[10257] = {arg = 4, id = 10257, markid = 6, 
skill_list = {10257}
}
, 
[10258] = {arg = 1, id = 10258, influence = 104, markid = 2, 
skill_list = {10258}
}
, 
[10259] = {arg = 1, id = 10259, markid = 3, 
skill_list = {10259}
}
, 
[10260] = {arg = 1028, fun_tag = 24, id = 10260, influence = 105, markid = 2, 
skill_list = {10260}
}
, 
[10261] = {arg = 1028, fun_tag = 24, id = 10261, influence = 105, markid = 2, 
skill_list = {10261}
}
, 
[10262] = {arg = 3, fun_tag = 25, id = 10262, markid = 5, 
skill_list = {10262}
}
, 
[10263] = {arg = 3, fun_tag = 25, id = 10263, markid = 5, 
skill_list = {10263}
}
, 
[10264] = {arg = 3, fun_tag = 25, id = 10264, markid = 5, 
skill_list = {10264}
}
, 
[10265] = {arg = 3, fun_tag = 25, id = 10265, markid = 5, 
skill_list = {10265}
}
, 
[10266] = {arg = 2, fun_tag = 26, id = 10266, markid = 4, 
skill_list = {10266}
}
, 
[10267] = {arg = 2, fun_tag = 26, id = 10267, markid = 4, 
skill_list = {10267}
}
, 
[10268] = {arg = 2, fun_tag = 26, id = 10268, markid = 4, 
skill_list = {10268}
}
, 
[10269] = {arg = 2, fun_tag = 26, id = 10269, markid = 4, 
skill_list = {10269}
}
, 
[10270] = {arg = 4, fun_tag = 27, id = 10270, markid = 6, 
skill_list = {10270}
}
, 
[10271] = {arg = 4, fun_tag = 27, id = 10271, markid = 6, 
skill_list = {10271}
}
, 
[10272] = {arg = 4, fun_tag = 27, id = 10272, markid = 6, 
skill_list = {10272}
}
, 
[10273] = {arg = 4, fun_tag = 27, id = 10273, markid = 6, 
skill_list = {10273}
}
, 
[10274] = {arg = 5, fun_tag = 14, id = 10274, markid = 7, 
skill_list = {10274}
}
, 
[10275] = {arg = 5, fun_tag = 28, id = 10275, markid = 7, 
skill_list = {10275}
}
, 
[10276] = {arg = 5, fun_tag = 28, id = 10276, markid = 7, 
skill_list = {10276}
}
, 
[10277] = {arg = 5, fun_tag = 28, id = 10277, markid = 7, 
skill_list = {10277}
}
, 
[10278] = {arg = 5, fun_tag = 28, id = 10278, markid = 7, 
skill_list = {10278}
}
, 
[10279] = {arg = 3, fun_tag = 16, id = 10279, markid = 5, 
skill_list = {10279}
}
, 
[10280] = {arg = 1, fun_tag = 2, id = 10280, markid = 3, 
skill_list = {10280}
}
, 
[10281] = {arg = 1, fun_tag = 2, id = 10281, markid = 3, 
skill_list = {10281}
}
, 
[10282] = {arg = 1, fun_tag = 29, id = 10282, markid = 3, 
skill_list = {10282}
}
, 
[10283] = {arg = 1, fun_tag = 29, id = 10283, markid = 3, 
skill_list = {10283}
}
, 
[10284] = {arg = 1, fun_tag = 29, id = 10284, markid = 3, 
skill_list = {10284}
}
, 
[10285] = {arg = 1, fun_tag = 29, id = 10285, markid = 3, 
skill_list = {10285}
}
, 
[10286] = {arg = 3, fun_tag = 5, id = 10286, markid = 5, 
skill_list = {10286}
}
, 
[10287] = {arg = 3, fun_tag = 6, id = 10287, markid = 5, 
skill_list = {10287}
}
, 
[10288] = {arg = 2, fun_tag = 9, id = 10288, markid = 4, 
skill_list = {10288}
}
, 
[10289] = {arg = 2, fun_tag = 8, id = 10289, markid = 4, 
skill_list = {10289}
}
, 
[10290] = {arg = 4, fun_tag = 10, id = 10290, markid = 6, 
skill_list = {10290}
}
, 
[10291] = {arg = 5, fun_tag = 15, id = 10291, markid = 7, 
skill_list = {10291}
}
, 
[10292] = {arg = 5, fun_tag = 13, id = 10292, markid = 7, 
skill_list = {10292}
}
, 
[10293] = {arg = 2, fun_tag = 17, id = 10293, influence = 104, markid = 1, 
skill_list = {10293}
}
, 
[10294] = {fun_tag = 17, id = 10294, influence = 101, 
skill_list = {10294}
}
, 
[10295] = {fun_tag = 18, id = 10295, influence = 101, 
skill_list = {10295}
}
, 
[15001] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15001, influence = 101, level_increase = __rt_57}
, 
[15002] = {arg = 1, attribute_id = __rt_22, attribute_initial = __rt_10, id = 15002, level_increase = __rt_57}
, 
[15003] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15003, influence = 101, level_increase = __rt_57}
, 
[15004] = {arg = 1, attribute_id = __rt_22, attribute_initial = __rt_10, id = 15004, level_increase = __rt_57}
, 
[15005] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15005, influence = 101, level_increase = __rt_57}
, 
[15006] = {arg = 1, attribute_id = __rt_22, attribute_initial = __rt_10, id = 15006, level_increase = __rt_57}
, 
[15007] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15007, influence = 101, level_increase = __rt_57}
, 
[15008] = {arg = 3, attribute_id = __rt_58, attribute_initial = __rt_2, id = 15008, level_increase = __rt_57}
, 
[15009] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15009, influence = 101, level_increase = __rt_57}
, 
[15010] = {arg = 3, attribute_id = __rt_58, attribute_initial = __rt_2, id = 15010, level_increase = __rt_57}
, 
[15011] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15011, influence = 101, level_increase = __rt_57}
, 
[15012] = {arg = 3, attribute_id = __rt_58, attribute_initial = __rt_2, id = 15012, level_increase = __rt_57}
, 
[15013] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15013, influence = 101, level_increase = __rt_57}
, 
[15014] = {arg = 2, attribute_id = __rt_4, attribute_initial = __rt_2, id = 15014, level_increase = __rt_57}
, 
[15015] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15015, influence = 101, level_increase = __rt_57}
, 
[15016] = {arg = 2, attribute_id = __rt_4, attribute_initial = __rt_2, id = 15016, level_increase = __rt_57}
, 
[15017] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15017, influence = 101, level_increase = __rt_57}
, 
[15018] = {arg = 2, attribute_id = __rt_4, attribute_initial = __rt_2, id = 15018, level_increase = __rt_57}
, 
[15019] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15019, influence = 101, level_increase = __rt_57}
, 
[15020] = {arg = 4, attribute_id = __rt_59, attribute_initial = __rt_10, id = 15020, level_increase = __rt_57}
, 
[15021] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15021, influence = 101, level_increase = __rt_57}
, 
[15022] = {arg = 4, attribute_id = __rt_59, attribute_initial = __rt_10, id = 15022, level_increase = __rt_57}
, 
[15023] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15023, influence = 101, level_increase = __rt_57}
, 
[15024] = {arg = 4, attribute_id = __rt_59, attribute_initial = __rt_10, id = 15024, level_increase = __rt_57}
, 
[15025] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15025, influence = 101, level_increase = __rt_57}
, 
[15026] = {arg = 5, attribute_id = __rt_8, attribute_initial = __rt_2, id = 15026, level_increase = __rt_57}
, 
[15027] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15027, influence = 101, level_increase = __rt_57}
, 
[15028] = {arg = 5, attribute_id = __rt_8, attribute_initial = __rt_2, id = 15028, level_increase = __rt_57}
, 
[15029] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15029, influence = 101, level_increase = __rt_57}
, 
[15030] = {arg = 5, attribute_id = __rt_8, attribute_initial = __rt_2, id = 15030, level_increase = __rt_57}
, 
[15031] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15031, influence = 101, level_increase = __rt_57}
, 
[15032] = {attribute_id = __rt_8, attribute_initial = __rt_6, id = 15032, influence = 101, level_increase = __rt_57}
, 
[15033] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15033, influence = 101, level_increase = __rt_57}
, 
[15034] = {attribute_id = __rt_8, attribute_initial = __rt_6, id = 15034, influence = 101, level_increase = __rt_57}
, 
[15035] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15035, influence = 101, level_increase = __rt_57}
, 
[15036] = {attribute_id = __rt_8, attribute_initial = __rt_6, id = 15036, influence = 101, level_increase = __rt_57}
, 
[15037] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15037, influence = 101, level_increase = __rt_57}
, 
[15038] = {attribute_id = __rt_29, attribute_initial = __rt_60, id = 15038, influence = 101, level_increase = __rt_57}
, 
[15039] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15039, influence = 101, level_increase = __rt_57}
, 
[15040] = {attribute_id = __rt_29, attribute_initial = __rt_60, id = 15040, influence = 101, level_increase = __rt_57}
, 
[15041] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15041, influence = 101, level_increase = __rt_57}
, 
[15042] = {attribute_id = __rt_29, attribute_initial = __rt_60, id = 15042, influence = 101, level_increase = __rt_57}
, 
[15043] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15043, influence = 101, level_increase = __rt_57}
, 
[15044] = {attribute_id = __rt_29, attribute_initial = __rt_60, id = 15044, influence = 101, level_increase = __rt_57}
, 
[15045] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 15045, influence = 101, level_increase = __rt_57}
, 
[15046] = {attribute_id = __rt_29, attribute_initial = __rt_60, id = 15046, influence = 101, level_increase = __rt_57}
, 
[15047] = {arg = 1028, attribute_id = __rt_61, attribute_initial = __rt_49, id = 15047, influence = 105, level_increase = __rt_57, 
skill_list = {15047}
}
, 
[20001] = {id = 20001, influence = 701, 
skill_list = {20001}
}
, 
[20002] = {arg = 2, id = 20002, influence = 104, 
skill_list = {20002}
}
, 
[20003] = {id = 20003, influence = 101, 
skill_list = {20003}
}
, 
[20004] = {id = 20004, influence = 101, 
skill_list = {20004}
}
, 
[20005] = {id = 20005, influence = 101, 
skill_list = {20005}
}
, 
[20006] = {id = 20006, influence = 101, 
skill_list = {20006}
}
, 
[20007] = {id = 20007, influence = 701, 
skill_list = {20007}
}
, 
[20008] = {id = 20008, influence = 701, 
skill_list = {20008}
}
, 
[20009] = {id = 20009, influence = 701, 
skill_list = {20009}
}
, 
[20010] = {id = 20010, influence = 701, 
skill_list = {20010}
}
, 
[20011] = {id = 20011, influence = 101, 
skill_list = {20011}
}
, 
[20012] = {id = 20012, influence = 701, 
skill_list = {20012}
}
, 
[20013] = {id = 20013, influence = 701, 
skill_list = {20013}
}
, 
[20014] = {id = 20014, influence = 101, 
skill_list = {20014}
}
, 
[20015] = {id = 20015, influence = 101, 
skill_list = {20015}
}
, 
[20016] = {id = 20016, influence = 701, 
skill_list = {20016}
}
, 
[20017] = {attribute_id = __rt_62, attribute_initial = __rt_63, id = 20017, influence = 701, level_increase = __rt_57, 
skill_list = {20017}
}
, 
[20018] = {id = 20018, influence = 601, 
skill_list = {20018}
}
, 
[20019] = {id = 20019, influence = 601, 
skill_list = {20019}
}
, 
[20020] = {id = 20020, influence = 601, 
skill_list = {20020}
}
, 
[20021] = {id = 20021, influence = 601, 
skill_list = {20021}
}
, 
[20022] = {attribute_id = __rt_3, attribute_initial = __rt_64, id = 20022, influence = 601, level_increase = __rt_10}
, 
[20023] = {attribute_id = __rt_4, attribute_initial = __rt_64, id = 20023, influence = 601, level_increase = __rt_10}
, 
[20024] = {attribute_id = __rt_3, attribute_initial = __rt_64, id = 20024, influence = 601, level_increase = __rt_16}
, 
[20025] = {
attribute_id = {212}
, attribute_initial = __rt_42, id = 20025, influence = 601, level_increase = __rt_14}
, 
[20026] = {attribute_id = __rt_65, attribute_initial = __rt_42, id = 20026, influence = 601, level_increase = __rt_42}
, 
[20027] = {arg = 2, attribute_id = __rt_3, attribute_initial = __rt_18, id = 20027, influence = 104, level_increase = __rt_14}
, 
[20028] = {attribute_id = __rt_4, attribute_initial = __rt_16, id = 20028, influence = 601, level_increase = __rt_16}
, 
[20029] = {attribute_id = __rt_4, attribute_initial = __rt_16, id = 20029, influence = 601, level_increase = __rt_16}
, 
[20030] = {attribute_id = __rt_4, attribute_initial = __rt_16, id = 20030, influence = 601, level_increase = __rt_16}
, 
[20031] = {arg = 30000, id = 20031, influence = 605, 
skill_list = {20031}
}
, 
[20032] = {arg = 30000, id = 20032, influence = 605, 
skill_list = {20032}
}
, 
[20033] = {arg = 30000, id = 20033, influence = 605, 
skill_list = {20033}
}
, 
[20034] = {attribute_id = __rt_62, 
attribute_initial = {4400}
, id = 20034, influence = 701, level_increase = __rt_57}
, 
[20035] = {arg = 30001, id = 20035, influence = 605, skill_list = __rt_66}
, 
[20036] = {arg = 30001, id = 20036, influence = 605, 
skill_list = {20036}
}
, 
[20037] = {arg = 30001, attribute_id = __rt_67, attribute_initial = __rt_68, id = 20037, influence = 605, level_increase = __rt_69}
, 
[20038] = {arg = 30001, id = 20038, influence = 605, 
skill_list = {20038}
}
, 
[20039] = {arg = 30002, id = 20039, influence = 605, 
skill_list = {20039}
}
, 
[20040] = {arg = 30002, id = 20040, influence = 605, 
skill_list = {20040}
}
, 
[20041] = {arg = 30002, id = 20041, influence = 605, skill_list = __rt_66}
, 
[20042] = {arg = 30002, attribute_id = __rt_67, attribute_initial = __rt_68, id = 20042, influence = 605, level_increase = __rt_69}
, 
[20043] = {arg = 30003, id = 20043, influence = 605, 
skill_list = {20043}
}
, 
[20044] = {arg = 30003, id = 20044, influence = 605, 
skill_list = {20044}
}
, 
[20045] = {arg = 30003, id = 20045, influence = 605, 
skill_list = {20045}
}
, 
[20046] = {arg = 30003, id = 20046, influence = 605, 
skill_list = {20046}
}
, 
[20047] = {arg = 30003, id = 20047, influence = 605, 
skill_list = {20047}
}
, 
[20048] = {arg = 30004, id = 20048, influence = 605, 
skill_list = {20048}
}
, 
[20049] = {arg = 30004, attribute_id = __rt_8, attribute_initial = __rt_16, id = 20049, influence = 605}
, 
[20050] = {arg = 30004, id = 20050, influence = 605, 
skill_list = {20050}
}
, 
[20051] = {arg = 30004, id = 20051, influence = 605, 
skill_list = {20051}
}
, 
[20052] = {arg = 1, attribute_id = __rt_70, attribute_initial = __rt_42, id = 20052, influence = 104, level_increase = __rt_57}
, 
[20053] = {arg = 2, attribute_id = __rt_70, attribute_initial = __rt_71, id = 20053, influence = 104, level_increase = __rt_57}
, 
[20054] = {arg = 1, attribute_id = __rt_70, attribute_initial = __rt_71, id = 20054, influence = 104, level_increase = __rt_57}
, 
[20055] = {arg = 2, attribute_id = __rt_70, attribute_initial = __rt_42, id = 20055, influence = 104, level_increase = __rt_57}
, 
[20056] = {arg = 30004, id = 20056, influence = 605, 
skill_list = {202004}
}
, 
[20057] = {id = 20057, influence = 101, 
skill_list = {20057}
}
, 
[20058] = {id = 20058, influence = 701, 
skill_list = {20058}
}
, 
[20059] = {attribute_id = __rt_61, attribute_initial = __rt_10, id = 20059, influence = 101, 
skill_list = {20059}
}
, 
[20060] = {id = 20060, influence = 101, 
skill_list = {20060}
}
, 
[20061] = {attribute_id = __rt_4, attribute_initial = __rt_16, id = 20061, influence = 101, 
skill_list = {20061}
}
, 
[20062] = {arg = 2, 
attribute_id = {203, 202}
, 
attribute_initial = {500, -500}
, id = 20062, influence = 104}
, 
[20063] = {arg = 1, attribute_id = __rt_7, attribute_initial = __rt_16, id = 20063, influence = 104}
, 
[20064] = {attribute_id = __rt_61, attribute_initial = __rt_18, id = 20064, influence = 101}
, 
[20065] = {attribute_id = __rt_8, attribute_initial = __rt_16, id = 20065, influence = 101}
, 
[20066] = {arg = 1, attribute_id = __rt_3, attribute_initial = __rt_18, id = 20066, influence = 104}
, 
[20067] = {id = 20067, influence = 701, 
skill_list = {20067}
}
, 
[20071] = {attribute_id = __rt_3, attribute_initial = __rt_14, id = 20071, influence = 101, level_increase = __rt_14}
, 
[20072] = {attribute_id = __rt_3, attribute_initial = __rt_10, id = 20072, influence = 101, level_increase = __rt_10}
, 
[20073] = {attribute_id = __rt_3, attribute_initial = __rt_17, id = 20073, influence = 101, level_increase = __rt_17}
, 
[20074] = {attribute_id = __rt_3, attribute_initial = __rt_63, id = 20074, influence = 101, level_increase = __rt_63}
, 
[20075] = {attribute_id = __rt_3, attribute_initial = __rt_72, id = 20075, influence = 101, level_increase = __rt_72}
, 
[20078] = {attribute_id = __rt_62, 
attribute_initial = {25000}
, id = 20078, influence = 701, level_increase = __rt_57}
, 
[20079] = {
attribute_id = {202, 203, 226}
, 
attribute_initial = {1200, 500, 500}
, id = 20079, influence = 101}
, 
[20080] = {arg = 1, id = 20080, influence = 104, 
skill_list = {20080}
}
, 
[20081] = {attribute_id = __rt_73, attribute_initial = __rt_74, id = 20081, influence = 101}
, 
[20082] = {attribute_id = __rt_73, attribute_initial = __rt_74, id = 20082, influence = 601}
, 
[20083] = {arg = 1, 
attribute_id = {22, 19, 20}
, 
attribute_initial = {1500, -500, -700}
, id = 20083, influence = 104}
, 
[20084] = {attribute_id = __rt_62, 
attribute_initial = {50000}
, id = 20084, influence = 101}
, 
[20085] = {attribute_id = __rt_75, attribute_initial = __rt_56, id = 20085, influence = 701}
, 
[20086] = {arg = 4, attribute_id = __rt_59, attribute_initial = __rt_56, id = 20086}
, 
[20087] = {arg = 4, 
attribute_id = {19, 202}
, 
attribute_initial = {1000, -300}
, id = 20087, influence = 101}
, 
[20088] = {arg = 2, 
attribute_id = {19, 20}
, 
attribute_initial = {1000, -800}
, id = 20088, 
skill_list = {20088}
}
, 
[20089] = {arg = 3, 
attribute_id = {20, 19, 202}
, 
attribute_initial = {-400, 1000, -400}
, id = 20089}
, 
[20090] = {arg = 5, attribute_id = __rt_23, attribute_initial = __rt_16, id = 20090}
, 
[20091] = {arg = 2, attribute_id = __rt_67, 
attribute_initial = {-700, 0}
, id = 20091, influence = 604}
, 
[20092] = {
attribute_id = {203, 226, 20, 15}
, 
attribute_initial = {1000, 1000, 800, 99999}
, id = 20092, influence = 101}
, 
[20093] = {
attribute_id = {203, 115, 226, 21}
, 
attribute_initial = {500, 100000, 1000, 3000}
, id = 20093, influence = 101}
, 
[20094] = {
attribute_id = {203, 226}
, 
attribute_initial = {5000, 10000}
, id = 20094, influence = 601}
, 
[20095] = {attribute_id = __rt_65, 
attribute_initial = {-1000}
, id = 20095, influence = 101, 
skill_list = {20095}
}
, 
[20096] = {
attribute_id = {115}
, 
attribute_initial = {100000}
, id = 20096, influence = 101}
, 
[20097] = {id = 20097, influence = 101, 
skill_list = {20097}
}
, 
[20101] = {attribute_id = __rt_70, attribute_initial = __rt_41, id = 20101, influence = 101}
, 
[20102] = {attribute_id = __rt_29, 
attribute_initial = {-10}
, id = 20102, influence = 101}
, 
[20106] = {attribute_id = __rt_75, attribute_initial = __rt_23, id = 20106, influence = 101}
, 
[20107] = {id = 20107, influence = 101, 
skill_list = {20107}
}
, 
[20108] = {attribute_id = __rt_75, 
attribute_initial = {-10000}
, id = 20108, influence = 701}
, 
[20109] = {arg = 1001, 
attribute_id = {20, 23, 226}
, 
attribute_initial = {8000, 10000, 5000}
, id = 20109, influence = 105, 
skill_list = {20109}
}
, 
[20110] = {id = 20110, influence = 701, 
skill_list = {20110}
}
, 
[20111] = {id = 20111, influence = 101, 
skill_list = {20111}
}
, 
[20112] = {id = 20112, influence = 101, 
skill_list = {20112}
}
, 
[20113] = {id = 20113, influence = 701, 
skill_list = {20113}
}
, 
[20115] = {id = 20115, influence = 701, 
skill_list = {20115}
}
, 
[20116] = {arg = 30005, id = 20116, influence = 605, 
skill_list = {20116}
}
, 
[30000] = {arg = 1, id = 30000, markid = 3, 
skill_list = {30000}
}
, 
[30001] = {arg = 1, id = 30001, markid = 3, 
skill_list = {30001}
}
, 
[30002] = {arg = 1, id = 30002, markid = 3, 
skill_list = {30002}
}
, 
[30003] = {arg = 1, id = 30003, markid = 3, 
skill_list = {30003}
}
, 
[30004] = {arg = 1, id = 30004, markid = 3, 
skill_list = {30004}
}
, 
[30005] = {arg = 1, id = 30005, markid = 3, 
skill_list = {30005}
}
, 
[30006] = {arg = 3, id = 30006, markid = 5, 
skill_list = {30006}
}
, 
[30007] = {arg = 3, id = 30007, markid = 5, 
skill_list = {30007}
}
, 
[30008] = {arg = 2, id = 30008, markid = 4, 
skill_list = {30008}
}
, 
[30009] = {arg = 2, id = 30009, markid = 4, 
skill_list = {30009}
}
, 
[30010] = {arg = 3, id = 30010, markid = 5, 
skill_list = {30010}
}
, 
[30011] = {arg = 3, id = 30011, markid = 5, 
skill_list = {30011}
}
, 
[30012] = {arg = 4, id = 30012, markid = 6, 
skill_list = {30012}
}
, 
[30013] = {id = 30013, influence = 101, 
skill_list = {30013}
}
, 
[30014] = {id = 30014, influence = 701, 
skill_list = {30014}
}
, 
[30015] = {arg = 5, id = 30015, markid = 7, 
skill_list = {30015}
}
, 
[30016] = {arg = 5, id = 30016, markid = 7, 
skill_list = {30016}
}
, 
[30017] = {arg = 5, id = 30017, markid = 7, 
skill_list = {30017}
}
, 
[30018] = {id = 30018, influence = 101, 
skill_list = {30018}
}
, 
[30019] = {id = 30019, influence = 101, 
skill_list = {30019}
}
, 
[30020] = {arg = 1, id = 30020, markid = 3, 
skill_list = {30020}
}
, 
[30021] = {arg = 1, id = 30021, markid = 3, 
skill_list = {30021}
}
, 
[30022] = {arg = 3, id = 30022, markid = 5, 
skill_list = {30022}
}
, 
[30023] = {arg = 3, id = 30023, markid = 5, 
skill_list = {30023}
}
, 
[30024] = {arg = 2, id = 30024, markid = 4, 
skill_list = {30024}
}
, 
[30025] = {id = 30025, influence = 701, 
skill_list = {30025}
}
, 
[30026] = {arg = 4, id = 30026, markid = 6, 
skill_list = {30026}
}
, 
[30027] = {arg = 4, id = 30027, markid = 6, 
skill_list = {30027}
}
, 
[30028] = {id = 30028, influence = 701, 
skill_list = {30028}
}
, 
[30029] = {id = 30029, influence = 701, 
skill_list = {30029}
}
, 
[30030] = {arg = 3, id = 30030, markid = 5, 
skill_list = {30030}
}
, 
[30031] = {arg = 3, id = 30031, markid = 5, 
skill_list = {30031}
}
, 
[30032] = {arg = 2, id = 30032, markid = 4, 
skill_list = {30032}
}
, 
[30033] = {arg = 2, id = 30033, markid = 4, 
skill_list = {30033}
}
, 
[30034] = {arg = 2, id = 30034, markid = 4, 
skill_list = {30034}
}
, 
[30035] = {arg = 2, id = 30035, markid = 4, 
skill_list = {30035}
}
, 
[30036] = {id = 30036, influence = 701, 
skill_list = {30036}
}
, 
[30037] = {arg = 4, id = 30037, markid = 6, 
skill_list = {30037}
}
, 
[30038] = {id = 30038, influence = 101, 
skill_list = {30038}
}
, 
[30039] = {arg = 4, id = 30039, markid = 6, 
skill_list = {30039}
}
, 
[30040] = {arg = 5, id = 30040, markid = 7, 
skill_list = {30040}
}
, 
[30041] = {arg = 5, id = 30041, markid = 7, 
skill_list = {30041}
}
, 
[30042] = {id = 30042, influence = 101, 
skill_list = {30042}
}
, 
[30043] = {id = 30043, influence = 101, 
skill_list = {30043}
}
, 
[30044] = {id = 30044, influence = 101, 
skill_list = {30044}
}
, 
[30045] = {id = 30045, influence = 701, 
skill_list = {30045}
}
, 
[30046] = {id = 30046, influence = 601, 
skill_list = {30046}
}
, 
[50016] = {id = 50016, influence = 101, 
skill_list = {50016}
}
, 
[108000] = {attribute_id = __rt_76, attribute_initial = __rt_77, id = 108000, influence = 601, level_increase = __rt_77, markid = 14}
, 
[108001] = {attribute_id = __rt_3, attribute_initial = __rt_10, id = 108001, influence = 601, level_increase = __rt_10, markid = 14}
, 
[108002] = {attribute_id = __rt_4, attribute_initial = __rt_14, id = 108002, influence = 101, level_increase = __rt_14}
, 
[108003] = {attribute_id = __rt_76, attribute_initial = __rt_78, id = 108003, influence = 601, level_increase = __rt_78, markid = 14}
, 
[108004] = {attribute_id = __rt_3, attribute_initial = __rt_10, id = 108004, influence = 101, level_increase = __rt_10}
, 
[108005] = {attribute_id = __rt_4, attribute_initial = __rt_10, id = 108005, influence = 101, level_increase = __rt_10}
, 
[108006] = {attribute_id = __rt_7, attribute_initial = __rt_79, id = 108006, influence = 101, level_increase = __rt_79}
, 
[108007] = {attribute_id = __rt_3, attribute_initial = __rt_80, id = 108007, influence = 101, level_increase = __rt_80}
, 
[108008] = {attribute_id = __rt_3, attribute_initial = __rt_26, id = 108008, influence = 101, level_increase = __rt_26}
, 
[108009] = {attribute_id = __rt_3, attribute_initial = __rt_6, id = 108009, influence = 101, level_increase = __rt_6}
, 
[108010] = {attribute_id = __rt_4, attribute_initial = __rt_44, id = 108010, influence = 101, level_increase = __rt_44}
, 
[108011] = {attribute_id = __rt_3, attribute_initial = __rt_14, id = 108011, influence = 101, level_increase = __rt_14}
, 
[108012] = {attribute_id = __rt_3, attribute_initial = __rt_44, id = 108012, influence = 101}
, 
[108013] = {attribute_id = __rt_3, 
attribute_initial = {400}
, id = 108013, influence = 101}
, 
[800001] = {buff_id = 20003, id = 800001, influence = 0, info = "15", markid = 15, type = 3}
, 
[800002] = {buff_id = 20004, id = 800002, influence = 0, info = "15", markid = 15, type = 3}
, 
[800003] = {buff_id = 20005, id = 800003, influence = 0, info = "15", markid = 15, type = 3}
, 
[800004] = {buff_id = 20006, id = 800004, influence = 0, info = "15", markid = 15, type = 3}
, 
[800005] = {buff_id = 20007, id = 800005, influence = 0, info = "15", markid = 15, type = 3}
, 
[800006] = {buff_id = 20059, id = 800006, influence = 0, info = "15", markid = 15, type = 3}
, 
[800007] = {buff_id = 20057, id = 800007, influence = 0, info = "15", markid = 15, type = 3}
, 
[800008] = {buff_id = 20058, id = 800008, influence = 0, info = "15", markid = 15, type = 3}
, 
[800009] = {buff_id = 20067, id = 800009, influence = 0, info = "15", markid = 15, type = 3}
, 
[800010] = {buff_id = 20008, id = 800010, influence = 0, markid = 15, type = 3}
, 
[800011] = {buff_id = 20009, id = 800011, influence = 0, markid = 15, type = 3}
, 
[800012] = {buff_id = 20010, id = 800012, influence = 0, markid = 15, type = 3}
, 
[800013] = {buff_id = 20011, id = 800013, influence = 0, markid = 15, type = 3}
, 
[800014] = {buff_id = 20013, id = 800014, influence = 0, markid = 15, type = 3}
, 
[800015] = {buff_id = 20060, id = 800015, influence = 0, markid = 15, type = 3}
, 
[800016] = {buff_id = 20061, id = 800016, influence = 0, markid = 15, type = 3}
, 
[800017] = {buff_id = 20062, id = 800017, influence = 0, markid = 15, type = 3}
, 
[800018] = {buff_id = 20063, id = 800018, influence = 0, markid = 15, type = 3}
, 
[800019] = {buff_id = 20065, id = 800019, influence = 0, markid = 15, type = 3}
, 
[901001] = {id = 901001, influence = 901, markid = 15, 
skill_list = {100203}
, type = 2}
, 
[901002] = {id = 901002, influence = 901, markid = 15, 
skill_list = {100503}
, type = 2}
, 
[901003] = {id = 901003, influence = 901, markid = 15, 
skill_list = {100703}
, type = 2}
, 
[901004] = {id = 901004, influence = 901, markid = 15, 
skill_list = {100403}
, type = 2}
, 
[901005] = {id = 901005, influence = 901, markid = 15, 
skill_list = {100803}
, type = 2}
, 
[901006] = {id = 901006, influence = 901, markid = 15, 
skill_list = {102003}
, type = 2}
, 
[901007] = {id = 901007, influence = 901, markid = 15, 
skill_list = {102803}
, type = 2}
, 
[901008] = {id = 901008, influence = 901, markid = 15, 
skill_list = {103503}
, type = 2}
, 
[901009] = {id = 901009, influence = 901, markid = 15, 
skill_list = {103703}
, type = 2}
, 
[901010] = {id = 901010, influence = 901, markid = 15, 
skill_list = {100103}
, type = 2}
, 
[901011] = {id = 901011, influence = 901, markid = 15, 
skill_list = {101803}
, type = 2}
, 
[901012] = {id = 901012, influence = 901, markid = 15, 
skill_list = {100603}
, type = 2}
, 
[901013] = {id = 901013, influence = 901, markid = 15, 
skill_list = {101003}
, type = 2}
, 
[901014] = {id = 901014, influence = 901, markid = 15, 
skill_list = {101103}
, type = 2}
, 
[901015] = {id = 901015, influence = 901, markid = 15, 
skill_list = {101703}
, type = 2}
, 
[901016] = {id = 901016, influence = 901, markid = 15, 
skill_list = {101903}
, type = 2}
, 
[901018] = {id = 901018, influence = 901, markid = 15, 
skill_list = {102603}
, type = 2}
, 
[901019] = {id = 901019, influence = 901, markid = 15, 
skill_list = {102903}
, type = 2}
, 
[901021] = {id = 901021, influence = 901, markid = 15, 
skill_list = {103103}
, type = 2}
, 
[901022] = {id = 901022, influence = 901, markid = 15, 
skill_list = {103303}
, type = 2}
}
local __default_values = {arg = 0, attribute_id = __rt_1, attribute_initial = __rt_1, buff_id = 0, fun_tag = 0, id = 10000, influence = 102, info = "", level_increase = __rt_1, markid = 13, skill_list = __rt_1, type = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in (_ENV.pairs)(chip) do
  (_ENV.setmetatable)(v, base)
end
local __rawdata = {__basemetatable = base}
;
(_ENV.setmetatable)(chip, {__index = __rawdata})
return chip

