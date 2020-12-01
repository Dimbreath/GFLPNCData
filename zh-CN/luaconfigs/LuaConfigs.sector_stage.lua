-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {1003, 5001, 1601}
local __rt_3 = {3}
local __rt_4 = {1102}
local __rt_5 = {5001}
local __rt_6 = {1103}
local __rt_7 = {1003, 5003}
local __rt_8 = {1105}
local __rt_9 = {1106}
local __rt_10 = {1108}
local __rt_11 = {1109}
local __rt_12 = {1002, 1602, 1500}
local __rt_13 = {50, 1, 1}
local __rt_14 = {1004, 1003}
local __rt_15 = {1003, 1601, 5003}
local __rt_16 = {2101}
local __rt_17 = {2105}
local __rt_18 = {1102, 1003}
local __rt_19 = {1105, 1003}
local __rt_20 = {1108, 1003}
local __rt_21 = {1111, 1003}
local __rt_22 = {1114, 1003}
local __rt_23 = {1003, 1601, 5001}
local __rt_24 = {3107}
local __rt_25 = {4101}
local __rt_26 = {4107}
local sector_stage = {
[1101] = {combat = 2000, cost_strength_num = 0, exp_gain = 1, 
first_reward_ids = {1003, 3001, 1601}
, 
first_reward_nums = {200, 1, 5}
, introduce = 498176, name = 395124, normal_drop = __rt_1, pre_condition = __rt_1, pre_para1 = __rt_1}
, 
[1102] = {combat = 2400, cost_strength_num = 0, exp_gain = 1, 
exploration_list = {1021}
, first_reward_ids = __rt_2, 
first_reward_nums = {220, 2, 5}
, id = 1102, introduce = 227018, name = 498359, normal_drop = __rt_1, num = 2, 
pre_para1 = {1101}
}
, 
[1103] = {combat = 2900, cost_strength_num = 0, exp_gain = 1, 
exploration_list = {1031}
, first_reward_ids = __rt_2, 
first_reward_nums = {240, 2, 5}
, id = 1103, introduce = 255665, name = 47263, normal_drop = __rt_1, num = 3, pre_para1 = __rt_4}
, 
[1104] = {combat = 3300, cost_strength_num = 20, exp_gain = 1, 
exploration_list = {1041, 1042}
, first_reward_ids = __rt_2, 
first_reward_nums = {260, 2, 5}
, id = 1104, introduce = 206496, name = 224855, num = 4, pre_para1 = __rt_6}
, 
[1105] = {combat = 3800, cost_strength_num = 20, exp_gain = 1, 
exploration_list = {1051, 1052}
, 
first_reward_ids = {1003, 5003, 5001}
, 
first_reward_nums = {280, 2, 2}
, id = 1105, introduce = 268547, name = 244382, 
normal_drop = {1101, 1107}
, num = 5, 
pre_para1 = {1104}
}
, 
[1106] = {combat = 4000, cost_strength_num = 10, 
exploration_list = {1061}
, first_reward_ids = __rt_7, 
first_reward_nums = {300, 5}
, id = 1106, introduce = 180589, name = 364876, 
normal_drop = {5003}
, num = 6}
, 
[1107] = {combat = 6300, cost_strength_num = 20, 
exploration_list = {1071, 1073}
, first_reward_ids = __rt_7, 
first_reward_nums = {320, 5}
, id = 1107, introduce = 411911, name = 108520, 
normal_drop = {1107, 1113}
, num = 7, pre_para1 = __rt_9}
, 
[1108] = {combat = 6500, cost_strength_num = 10, 
exploration_list = {1081}
, 
first_reward_ids = {1003, 5003, 21403}
, 
first_reward_nums = {340, 5, 1}
, id = 1108, introduce = 392361, name = 277554, 
normal_drop = {1104, 1110}
, num = 8, 
pre_para1 = {1107}
}
, 
[1109] = {combat = 7000, 
exploration_list = {1091, 1092, 1093}
, first_reward_ids = __rt_7, 
first_reward_nums = {360, 5}
, id = 1109, introduce = 16526, name = 324305, 
normal_drop = {1110, 1104}
, num = 9, pre_para1 = __rt_10}
, 
[1110] = {combat = 7500, cost_strength_num = 20, 
exploration_list = {1101, 1102}
, first_reward_ids = __rt_7, 
first_reward_nums = {380, 5}
, id = 1110, introduce = 89797, name = 150743, 
normal_drop = {1113, 1101}
, num = 10, pre_para1 = __rt_11}
, 
[1201] = {combat = 3800, cost_strength_num = 20, difficulty = 2, exp_gain = 1, 
exploration_list = {1511, 1512}
, id = 1201, introduce = 427391, name = 7614, 
normal_drop = {1101, 1003}
}
, 
[1202] = {combat = 4100, difficulty = 2, exp_gain = 1, 
exploration_list = {1521, 1522, 1523}
, id = 1202, introduce = 83558, name = 44590, 
normal_drop = {1104, 1003}
, num = 2, 
pre_para1 = {1201}
}
, 
[1203] = {combat = 4300, difficulty = 2, exp_gain = 1, 
exploration_list = {1531, 1532, 1533}
, id = 1203, introduce = 170920, name = 31706, 
normal_drop = {1107, 1003}
, num = 3, 
pre_para1 = {1202}
}
, 
[1204] = {combat = 7100, difficulty = 2, exp_gain = 1, 
exploration_list = {1541, 1542, 1543}
, id = 1204, introduce = 171537, name = 55728, 
normal_drop = {1110, 1003}
, num = 4, 
pre_para1 = {1203}
}
, 
[1205] = {combat = 8500, difficulty = 2, exp_gain = 1, 
exploration_list = {1551, 1552, 1553}
, id = 1205, introduce = 342644, name = 265326, 
normal_drop = {1113, 1003}
, num = 5, 
pre_para1 = {1204}
}
, 
[1206] = {combat = 8400, difficulty = 2, exp_gain = 1, 
exploration_list = {1561, 1562, 1563}
, id = 1206, introduce = 432151, name = 500112, normal_drop = __rt_14, num = 6, 
pre_para1 = {1205}
}
, 
[2101] = {combat = 7600, cost_strength_num = 20, exp_gain = 1, 
exploration_list = {2011, 2012}
, first_reward_ids = __rt_15, 
first_reward_nums = {400, 3, 5}
, id = 2101, introduce = 283565, name = 371209, 
normal_drop = {1601}
, pic = "StageIcon2", 
pre_para1 = {1110}
, sector = 2}
, 
[2102] = {combat = 7900, cost_strength_num = 20, exp_gain = 1, 
exploration_list = {2021, 2022}
, first_reward_ids = __rt_15, 
first_reward_nums = {420, 3, 5}
, id = 2102, introduce = 504105, name = 360464, num = 2, pic = "StageIcon2", pre_para1 = __rt_16, sector = 2}
, 
[2103] = {combat = 8000, cost_strength_num = 20, exp_gain = 1, 
exploration_list = {2031, 2032}
, first_reward_ids = __rt_15, 
first_reward_nums = {440, 3, 5}
, id = 2103, introduce = 432169, name = 461651, 
normal_drop = {1111, 1108}
, num = 3, pic = "StageIcon2", 
pre_para1 = {2102}
, sector = 2}
, 
[2104] = {combat = 8700, cost_strength_num = 10, exp_gain = 1, 
exploration_list = {2041}
, first_reward_ids = __rt_15, 
first_reward_nums = {460, 3, 5}
, id = 2104, introduce = 414245, name = 472840, num = 4, pic = "StageIcon2", 
pre_para1 = {2103}
, sector = 2}
, 
[2105] = {combat = 9200, exp_gain = 1, 
exploration_list = {2051, 2052, 2053}
, first_reward_ids = __rt_15, 
first_reward_nums = {480, 3, 5}
, id = 2105, introduce = 323395, name = 356066, 
normal_drop = {1102, 1105}
, num = 5, pic = "StageIcon2", 
pre_para1 = {2104}
, sector = 2}
, 
[2106] = {combat = 9400, cost_strength_num = 10, 
exploration_list = {2061}
, first_reward_ids = __rt_15, 
first_reward_nums = {500, 3, 5}
, id = 2106, introduce = 224716, name = 426043, num = 6, pic = "StageIcon2", pre_para1 = __rt_17, sector = 2}
, 
[2107] = {combat = 9700, cost_strength_num = 10, 
exploration_list = {2071}
, first_reward_ids = __rt_15, 
first_reward_nums = {525, 3, 5}
, id = 2107, introduce = 136495, name = 1238, 
normal_drop = {1108, 1114}
, num = 7, pic = "StageIcon2", 
pre_para1 = {2106}
, sector = 2}
, 
[2108] = {combat = 9800, 
exploration_list = {2081, 2082, 2083}
, first_reward_ids = __rt_15, 
first_reward_nums = {550, 3, 5}
, id = 2108, introduce = 13079, name = 289266, num = 8, pic = "StageIcon2", 
pre_para1 = {2107}
, sector = 2}
, 
[2109] = {combat = 10200, cost_strength_num = 10, 
exploration_list = {2091}
, first_reward_ids = __rt_15, 
first_reward_nums = {575, 3, 5}
, id = 2109, introduce = 216788, name = 508249, 
normal_drop = {1114, 1102}
, num = 9, pic = "StageIcon2", 
pre_para1 = {2108}
, sector = 2}
, 
[2110] = {combat = 11900, cost_strength_num = 10, exploration_list = __rt_16, first_reward_ids = __rt_15, 
first_reward_nums = {600, 3, 5}
, id = 2110, introduce = 483542, name = 284342, num = 10, pic = "StageIcon2", 
pre_para1 = {2109}
, sector = 2}
, 
[2201] = {combat = 10100, cost_strength_num = 20, difficulty = 2, exp_gain = 1, 
exploration_list = {2511, 2512}
, id = 2201, introduce = 62412, name = 393654, normal_drop = __rt_18, pic = "StageIcon2", pre_para1 = __rt_17, sector = 2}
, 
[2202] = {combat = 11100, difficulty = 2, exp_gain = 1, 
exploration_list = {2521, 2522, 2523}
, id = 2202, introduce = 139128, name = 304769, normal_drop = __rt_19, num = 2, pic = "StageIcon2", 
pre_para1 = {2201}
, sector = 2}
, 
[2203] = {combat = 13900, difficulty = 2, exp_gain = 1, 
exploration_list = {2531, 2532, 2533}
, id = 2203, introduce = 61395, name = 44590, normal_drop = __rt_20, num = 3, pic = "StageIcon2", 
pre_para1 = {2202}
, sector = 2}
, 
[2204] = {combat = 15300, difficulty = 2, exp_gain = 1, 
exploration_list = {2541, 2542, 2543}
, id = 2204, introduce = 202595, name = 59207, normal_drop = __rt_21, num = 4, pic = "StageIcon2", 
pre_para1 = {2203}
, sector = 2}
, 
[2205] = {combat = 15900, difficulty = 2, exp_gain = 1, 
exploration_list = {2551, 2552, 2553}
, id = 2205, introduce = 151104, name = 23854, normal_drop = __rt_22, num = 5, pic = "StageIcon2", 
pre_para1 = {2204}
, sector = 2}
, 
[2206] = {combat = 21800, difficulty = 2, exp_gain = 1, 
exploration_list = {2561, 2562, 2563}
, id = 2206, introduce = 257005, name = 500112, normal_drop = __rt_14, num = 6, pic = "StageIcon2", 
pre_para1 = {2205}
, sector = 2}
, 
[3101] = {combat = 12800, cost_strength_num = 10, deploy_rows = 3, 
exploration_list = {3011}
, first_reward_ids = __rt_23, 
first_reward_nums = {650, 3, 4}
, id = 3101, introduce = 61092, name = 30116, normal_drop = __rt_4, pic = "StageIcon3", 
pre_para1 = {2110}
, sector = 3, size_row = 7}
, 
[3102] = {combat = 14200, cost_strength_num = 20, deploy_rows = 3, 
exploration_list = {3021, 3022}
, first_reward_ids = __rt_23, 
first_reward_nums = {675, 3, 4}
, id = 3102, introduce = 204357, name = 297814, normal_drop = __rt_8, num = 2, pic = "StageIcon3", 
pre_para1 = {3101}
, sector = 3, size_row = 7}
, 
[3103] = {combat = 14700, cost_strength_num = 20, deploy_rows = 3, 
exploration_list = {3031, 3032}
, first_reward_ids = __rt_23, 
first_reward_nums = {700, 3, 4}
, id = 3103, introduce = 365862, name = 224849, normal_drop = __rt_10, num = 3, pic = "StageIcon3", 
pre_para1 = {3102}
, sector = 3, size_row = 7}
, 
[3104] = {combat = 14700, cost_strength_num = 10, deploy_rows = 3, 
exploration_list = {3041}
, first_reward_ids = __rt_23, 
first_reward_nums = {725, 3, 4}
, id = 3104, introduce = 38470, name = 45989, 
normal_drop = {1111}
, num = 4, pic = "StageIcon3", 
pre_para1 = {3103}
, sector = 3, size_row = 7}
, 
[3105] = {combat = 18900, cost_strength_num = 20, deploy_rows = 3, 
exploration_list = {3051, 3052}
, first_reward_ids = __rt_23, 
first_reward_nums = {750, 3, 4}
, id = 3105, introduce = 36686, name = 247456, 
normal_drop = {1114}
, num = 5, pic = "StageIcon3", 
pre_para1 = {3104}
, sector = 3, size_row = 7}
, 
[3106] = {combat = 20100, deploy_rows = 3, 
exploration_list = {3061, 3062, 3063}
, first_reward_ids = __rt_23, 
first_reward_nums = {775, 3, 4}
, id = 3106, introduce = 277962, name = 342766, 
normal_drop = {1108, 1115}
, num = 6, pic = "StageIcon3", 
pre_para1 = {3105}
, sector = 3, size_row = 7}
, 
[3107] = {combat = 20100, cost_strength_num = 20, deploy_rows = 3, 
exploration_list = {3071, 3072}
, first_reward_ids = __rt_23, 
first_reward_nums = {800, 3, 4}
, id = 3107, introduce = 306260, name = 479891, 
normal_drop = {1111, 1103}
, num = 7, pic = "StageIcon3", 
pre_para1 = {3106}
, sector = 3, size_row = 7}
, 
[3108] = {combat = 21600, cost_strength_num = 10, deploy_rows = 3, 
exploration_list = {3081}
, first_reward_ids = __rt_23, 
first_reward_nums = {825, 3, 4}
, id = 3108, introduce = 401386, name = 29831, 
normal_drop = {1114, 1106}
, num = 8, pic = "StageIcon3", pre_para1 = __rt_24, sector = 3, size_row = 7}
, 
[3109] = {deploy_rows = 3, 
exploration_list = {3091, 3092, 3093}
, first_reward_ids = __rt_23, 
first_reward_nums = {850, 3, 4}
, id = 3109, introduce = 165739, name = 80610, 
normal_drop = {1102, 1109}
, num = 9, pic = "StageIcon3", 
pre_para1 = {3108}
, sector = 3, size_row = 7}
, 
[3110] = {deploy_rows = 3, 
exploration_list = {3101, 3102, 3103}
, first_reward_ids = __rt_23, 
first_reward_nums = {875, 3, 4}
, id = 3110, introduce = 66499, name = 510912, 
normal_drop = {1105, 1112}
, num = 10, pic = "StageIcon3", 
pre_para1 = {3109}
, sector = 3, size_row = 7}
, 
[3201] = {combat = 20400, cost_strength_num = 20, deploy_rows = 3, difficulty = 2, 
exploration_list = {3511, 3512}
, id = 3201, introduce = 70094, name = 139829, normal_drop = __rt_18, pic = "StageIcon3", pre_para1 = __rt_24, sector = 3, size_row = 7}
, 
[3202] = {combat = 21800, deploy_rows = 3, difficulty = 2, 
exploration_list = {3521, 3522, 3523}
, id = 3202, introduce = 298189, name = 115014, normal_drop = __rt_19, num = 2, pic = "StageIcon3", 
pre_para1 = {3201}
, sector = 3, size_row = 7}
, 
[3203] = {combat = 23400, deploy_rows = 3, difficulty = 2, 
exploration_list = {3531, 3532, 3533}
, id = 3203, introduce = 20849, name = 455194, normal_drop = __rt_20, num = 3, pic = "StageIcon3", 
pre_para1 = {3202}
, sector = 3, size_row = 7}
, 
[3204] = {combat = 28200, deploy_rows = 3, difficulty = 2, 
exploration_list = {3541, 3542, 3543}
, id = 3204, introduce = 441209, name = 508342, normal_drop = __rt_21, num = 4, pic = "StageIcon3", 
pre_para1 = {3203}
, sector = 3, size_row = 7}
, 
[3205] = {combat = 29100, deploy_rows = 3, difficulty = 2, 
exploration_list = {3551, 3552, 3553}
, id = 3205, introduce = 510180, name = 224572, normal_drop = __rt_22, num = 5, pic = "StageIcon3", 
pre_para1 = {3204}
, sector = 3, size_row = 7}
, 
[3206] = {combat = 35200, deploy_rows = 3, difficulty = 2, 
exploration_list = {3561, 3562, 3563}
, id = 3206, introduce = 486637, name = 80491, normal_drop = __rt_14, num = 6, pic = "StageIcon3", 
pre_para1 = {3205}
, sector = 3, size_row = 7}
, 
[4101] = {cost_strength_num = 10, deploy_rows = 3, 
exploration_list = {4011}
, first_reward_ids = __rt_23, 
first_reward_nums = {900, 3, 5}
, id = 4101, name = 413011, 
normal_drop = {1103, 1109}
, pic = "StageIcon4", pre_para1 = __rt_25, sector = 4, size_row = 7}
, 
[4102] = {combat = 26800, cost_strength_num = 20, deploy_rows = 3, 
exploration_list = {4021, 4022}
, first_reward_ids = __rt_23, 
first_reward_nums = {925, 3, 5}
, id = 4102, name = 218240, 
normal_drop = {1106, 1112}
, num = 2, pic = "StageIcon4", pre_para1 = __rt_25, sector = 4, size_row = 7}
, 
[4103] = {combat = 26800, cost_strength_num = 20, deploy_rows = 3, 
exploration_list = {4031, 4032}
, first_reward_ids = __rt_23, 
first_reward_nums = {950, 3, 5}
, id = 4103, name = 23469, 
normal_drop = {1109, 1115}
, num = 3, pic = "StageIcon4", 
pre_para1 = {4102}
, sector = 4, size_row = 7}
, 
[4104] = {combat = 32500, deploy_rows = 3, 
exploration_list = {4041, 4042, 4043}
, first_reward_ids = __rt_23, 
first_reward_nums = {975, 3, 5}
, id = 4104, name = 352986, 
normal_drop = {1112, 1103}
, num = 4, pic = "StageIcon4", 
pre_para1 = {4103}
, sector = 4, size_row = 7}
, 
[4105] = {combat = 32500, deploy_rows = 3, 
exploration_list = {4051, 4052, 4053}
, first_reward_ids = __rt_23, 
first_reward_nums = {1000, 3, 5}
, id = 4105, name = 158215, 
normal_drop = {1115, 1106}
, num = 5, pic = "StageIcon4", 
pre_para1 = {4104}
, sector = 4, size_row = 7}
, 
[4106] = {combat = 33700, cost_strength_num = 20, deploy_rows = 3, 
exploration_list = {4061, 4062}
, first_reward_ids = __rt_23, 
first_reward_nums = {1030, 3, 5}
, id = 4106, name = 487732, normal_drop = __rt_10, num = 6, pic = "StageIcon4", 
pre_para1 = {4105}
, sector = 4, size_row = 7}
, 
[4107] = {combat = 33700, cost_strength_num = 20, deploy_rows = 3, 
exploration_list = {4071, 4072}
, first_reward_ids = __rt_23, 
first_reward_nums = {1060, 3, 5}
, id = 4107, name = 292961, normal_drop = __rt_9, num = 7, pic = "StageIcon4", 
pre_para1 = {4106}
, sector = 4, size_row = 7}
, 
[4108] = {combat = 33700, deploy_rows = 3, 
exploration_list = {4081, 4082, 4083}
, first_reward_ids = __rt_23, 
first_reward_nums = {1090, 3, 5}
, id = 4108, name = 98190, normal_drop = __rt_11, num = 8, pic = "StageIcon4", pre_para1 = __rt_26, sector = 4, size_row = 7}
, 
[4109] = {combat = 35300, deploy_rows = 3, 
exploration_list = {4091, 4092, 4093}
, first_reward_ids = __rt_23, 
first_reward_nums = {1120, 3, 5}
, id = 4109, name = 427707, 
normal_drop = {1112}
, num = 9, pic = "StageIcon4", 
pre_para1 = {4108}
, sector = 4, size_row = 7}
, 
[4110] = {combat = 35300, cost_strength_num = 20, deploy_rows = 3, 
exploration_list = {4101, 4102}
, first_reward_ids = __rt_23, 
first_reward_nums = {1150, 3, 5}
, id = 4110, name = 384633, normal_drop = __rt_6, num = 10, pic = "StageIcon4", 
pre_para1 = {4109}
, sector = 4, size_row = 7}
, 
[4201] = {combat = 29100, cost_strength_num = 20, deploy_rows = 3, difficulty = 2, 
exploration_list = {4511, 4512}
, id = 4201, name = 149082, 
normal_drop = {1103, 1003}
, pic = "StageIcon4", pre_para1 = __rt_26, sector = 4, size_row = 7}
, 
[4202] = {combat = 35200, deploy_rows = 3, difficulty = 2, 
exploration_list = {4521, 4522, 4523}
, id = 4202, name = 478599, 
normal_drop = {1106, 1003}
, num = 2, pic = "StageIcon4", 
pre_para1 = {4201}
, sector = 4, size_row = 7}
, 
[4203] = {combat = 36500, deploy_rows = 3, difficulty = 2, 
exploration_list = {4531, 4532, 4533}
, id = 4203, name = 283828, 
normal_drop = {1109, 1003}
, num = 3, pic = "StageIcon4", 
pre_para1 = {4202}
, sector = 4, size_row = 7}
, 
[4204] = {combat = 38200, deploy_rows = 3, difficulty = 2, 
exploration_list = {4541, 4542, 4543}
, id = 4204, name = 89057, 
normal_drop = {1112, 1003}
, num = 4, pic = "StageIcon4", 
pre_para1 = {4203}
, sector = 4, size_row = 7}
, 
[4205] = {combat = 44800, deploy_rows = 3, difficulty = 2, 
exploration_list = {4551, 4552, 4553}
, id = 4205, 
normal_drop = {1115, 1003}
, num = 5, pic = "StageIcon4", 
pre_para1 = {4204}
, sector = 4, size_row = 7}
, 
[4206] = {combat = 44800, deploy_rows = 3, difficulty = 2, 
exploration_list = {4561, 4562, 4563}
, id = 4206, normal_drop = __rt_14, num = 6, pic = "StageIcon4", 
pre_para1 = {4205}
, sector = 4, size_row = 7}
}
local __default_values = {combat = 26000, cost_strength_id = 1007, cost_strength_num = 30, deploy_rows = 2, difficulty = 1, exp_gain = 0, 
exploration_list = {1011}
, first_reward_ids = __rt_12, first_reward_nums = __rt_13, function_extra = __rt_1, id = 1101, introduce = 342860, name = 418574, normal_drop = __rt_5, num = 1, pic = "StageIcon1", pre_condition = __rt_3, pre_para1 = __rt_8, pre_para2 = __rt_1, sector = 1, size_col = 5, size_row = 6}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in (_ENV.pairs)(sector_stage) do
  (_ENV.setmetatable)(v, base)
end
local __rawdata = {__basemetatable = base, difficultyCount = 2, 
sectorDiffDic = {
{
{1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110}
, 
{1201, 1202, 1203, 1204, 1205, 1206}
}
, 
{
{2101, 2102, 2103, 2104, 2105, 2106, 2107, 2108, 2109, 2110}
, 
{2201, 2202, 2203, 2204, 2205, 2206}
}
, 
{
{3101, 3102, 3103, 3104, 3105, 3106, 3107, 3108, 3109, 3110}
, 
{3201, 3202, 3203, 3204, 3205, 3206}
}
, 
{
{4101, 4102, 4103, 4104, 4105, 4106, 4107, 4108, 4109, 4110}
, 
{4201, 4202, 4203, 4204, 4205, 4206}
}
}
, 
sectorIdList = {
{1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1201, 1202, 1203, 1204, 1205, 1206}
, 
{2101, 2102, 2103, 2104, 2105, 2106, 2107, 2108, 2109, 2110, 2201, 2202, 2203, 2204, 2205, 2206}
, 
{3101, 3102, 3103, 3104, 3105, 3106, 3107, 3108, 3109, 3110, 3201, 3202, 3203, 3204, 3205, 3206}
, 
{4101, 4102, 4103, 4104, 4105, 4106, 4107, 4108, 4109, 4110, 4201, 4202, 4203, 4204, 4205, 4206}
}
, 
sectorTotalCountDic = {
{10, 6}
, 
{10, 6}
, 
{10, 6}
, 
{10, 6}
}
}
;
(_ENV.setmetatable)(sector_stage, {__index = __rawdata})
return sector_stage

-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {1003, 5001, 1601}
local __rt_3 = {3}
local __rt_4 = {1102}
local __rt_5 = {5001}
local __rt_6 = {1103}
local __rt_7 = {1003, 5003}
local __rt_8 = {1105}
local __rt_9 = {1106}
local __rt_10 = {1108}
local __rt_11 = {1109}
local __rt_12 = {1002, 1602, 1500}
local __rt_13 = {50, 1, 1}
local __rt_14 = {1004, 1003}
local __rt_15 = {1003, 1601, 5003}
local __rt_16 = {2101}
local __rt_17 = {2105}
local __rt_18 = {1102, 1003}
local __rt_19 = {1105, 1003}
local __rt_20 = {1108, 1003}
local __rt_21 = {1111, 1003}
local __rt_22 = {1114, 1003}
local __rt_23 = {1003, 1601, 5001}
local __rt_24 = {3107}
local __rt_25 = {4101}
local __rt_26 = {4107}
local sector_stage = {
    [1101] = {
        combat = 2000,
        cost_strength_num = 0,
        exp_gain = 1,
        first_reward_ids = {1003, 3001, 1601},
        first_reward_nums = {200, 1, 5},
        introduce = 498176,
        name = 395124,
        normal_drop = __rt_1,
        pre_condition = __rt_1,
        pre_para1 = __rt_1
    },
    [1102] = {
        combat = 2400,
        cost_strength_num = 0,
        exp_gain = 1,
        exploration_list = {1021},
        first_reward_ids = __rt_2,
        first_reward_nums = {220, 2, 5},
        id = 1102,
        introduce = 227018,
        name = 498359,
        normal_drop = __rt_1,
        num = 2,
        pre_para1 = {1101}
    },
    [1103] = {
        combat = 2900,
        cost_strength_num = 0,
        exp_gain = 1,
        exploration_list = {1031},
        first_reward_ids = __rt_2,
        first_reward_nums = {240, 2, 5},
        id = 1103,
        introduce = 255665,
        name = 47263,
        normal_drop = __rt_1,
        num = 3,
        pre_para1 = __rt_4
    },
    [1104] = {
        combat = 3300,
        cost_strength_num = 20,
        exp_gain = 1,
        exploration_list = {1041, 1042},
        first_reward_ids = __rt_2,
        first_reward_nums = {260, 2, 5},
        id = 1104,
        introduce = 206496,
        name = 224855,
        num = 4,
        pre_para1 = __rt_6
    },
    [1105] = {
        combat = 3800,
        cost_strength_num = 20,
        exp_gain = 1,
        exploration_list = {1051, 1052},
        first_reward_ids = {1003, 5003, 5001},
        first_reward_nums = {280, 2, 2},
        id = 1105,
        introduce = 268547,
        name = 244382,
        normal_drop = {1101, 1107},
        num = 5,
        pre_para1 = {1104}
    },
    [1106] = {
        combat = 4000,
        cost_strength_num = 10,
        exploration_list = {1061},
        first_reward_ids = __rt_7,
        first_reward_nums = {300, 5},
        id = 1106,
        introduce = 180589,
        name = 364876,
        normal_drop = {5003},
        num = 6
    },
    [1107] = {
        combat = 6300,
        cost_strength_num = 20,
        exploration_list = {1071, 1073},
        first_reward_ids = __rt_7,
        first_reward_nums = {320, 5},
        id = 1107,
        introduce = 411911,
        name = 108520,
        normal_drop = {1107, 1113},
        num = 7,
        pre_para1 = __rt_9
    },
    [1108] = {
        combat = 6500,
        cost_strength_num = 10,
        exploration_list = {1081},
        first_reward_ids = {1003, 5003, 21403},
        first_reward_nums = {340, 5, 1},
        id = 1108,
        introduce = 392361,
        name = 277554,
        normal_drop = {1104, 1110},
        num = 8,
        pre_para1 = {1107}
    },
    [1109] = {
        combat = 7000,
        exploration_list = {1091, 1092, 1093},
        first_reward_ids = __rt_7,
        first_reward_nums = {360, 5},
        id = 1109,
        introduce = 16526,
        name = 324305,
        normal_drop = {1110, 1104},
        num = 9,
        pre_para1 = __rt_10
    },
    [1110] = {
        combat = 7500,
        cost_strength_num = 20,
        exploration_list = {1101, 1102},
        first_reward_ids = __rt_7,
        first_reward_nums = {380, 5},
        id = 1110,
        introduce = 89797,
        name = 150743,
        normal_drop = {1113, 1101},
        num = 10,
        pre_para1 = __rt_11
    },
    [1201] = {
        combat = 3800,
        cost_strength_num = 20,
        difficulty = 2,
        exp_gain = 1,
        exploration_list = {1511, 1512},
        id = 1201,
        introduce = 427391,
        name = 7614,
        normal_drop = {1101, 1003}
    },
    [1202] = {
        combat = 4100,
        difficulty = 2,
        exp_gain = 1,
        exploration_list = {1521, 1522, 1523},
        id = 1202,
        introduce = 83558,
        name = 44590,
        normal_drop = {1104, 1003},
        num = 2,
        pre_para1 = {1201}
    },
    [1203] = {
        combat = 4300,
        difficulty = 2,
        exp_gain = 1,
        exploration_list = {1531, 1532, 1533},
        id = 1203,
        introduce = 170920,
        name = 31706,
        normal_drop = {1107, 1003},
        num = 3,
        pre_para1 = {1202}
    },
    [1204] = {
        combat = 7100,
        difficulty = 2,
        exp_gain = 1,
        exploration_list = {1541, 1542, 1543},
        id = 1204,
        introduce = 171537,
        name = 55728,
        normal_drop = {1110, 1003},
        num = 4,
        pre_para1 = {1203}
    },
    [1205] = {
        combat = 8500,
        difficulty = 2,
        exp_gain = 1,
        exploration_list = {1551, 1552, 1553},
        id = 1205,
        introduce = 342644,
        name = 265326,
        normal_drop = {1113, 1003},
        num = 5,
        pre_para1 = {1204}
    },
    [1206] = {
        combat = 8400,
        difficulty = 2,
        exp_gain = 1,
        exploration_list = {1561, 1562, 1563},
        id = 1206,
        introduce = 432151,
        name = 500112,
        normal_drop = __rt_14,
        num = 6,
        pre_para1 = {1205}
    },
    [2101] = {
        combat = 7600,
        cost_strength_num = 20,
        exp_gain = 1,
        exploration_list = {2011, 2012},
        first_reward_ids = __rt_15,
        first_reward_nums = {400, 3, 5},
        id = 2101,
        introduce = 283565,
        name = 371209,
        normal_drop = {1601},
        pic = "StageIcon2",
        pre_para1 = {1110},
        sector = 2
    },
    [2102] = {
        combat = 7900,
        cost_strength_num = 20,
        exp_gain = 1,
        exploration_list = {2021, 2022},
        first_reward_ids = __rt_15,
        first_reward_nums = {420, 3, 5},
        id = 2102,
        introduce = 504105,
        name = 360464,
        num = 2,
        pic = "StageIcon2",
        pre_para1 = __rt_16,
        sector = 2
    },
    [2103] = {
        combat = 8000,
        cost_strength_num = 20,
        exp_gain = 1,
        exploration_list = {2031, 2032},
        first_reward_ids = __rt_15,
        first_reward_nums = {440, 3, 5},
        id = 2103,
        introduce = 432169,
        name = 461651,
        normal_drop = {1111, 1108},
        num = 3,
        pic = "StageIcon2",
        pre_para1 = {2102},
        sector = 2
    },
    [2104] = {
        combat = 8700,
        cost_strength_num = 10,
        exp_gain = 1,
        exploration_list = {2041},
        first_reward_ids = __rt_15,
        first_reward_nums = {460, 3, 5},
        id = 2104,
        introduce = 414245,
        name = 472840,
        num = 4,
        pic = "StageIcon2",
        pre_para1 = {2103},
        sector = 2
    },
    [2105] = {
        combat = 9200,
        exp_gain = 1,
        exploration_list = {2051, 2052, 2053},
        first_reward_ids = __rt_15,
        first_reward_nums = {480, 3, 5},
        id = 2105,
        introduce = 323395,
        name = 356066,
        normal_drop = {1102, 1105},
        num = 5,
        pic = "StageIcon2",
        pre_para1 = {2104},
        sector = 2
    },
    [2106] = {
        combat = 9400,
        cost_strength_num = 10,
        exploration_list = {2061},
        first_reward_ids = __rt_15,
        first_reward_nums = {500, 3, 5},
        id = 2106,
        introduce = 224716,
        name = 426043,
        num = 6,
        pic = "StageIcon2",
        pre_para1 = __rt_17,
        sector = 2
    },
    [2107] = {
        combat = 9700,
        cost_strength_num = 10,
        exploration_list = {2071},
        first_reward_ids = __rt_15,
        first_reward_nums = {525, 3, 5},
        id = 2107,
        introduce = 136495,
        name = 1238,
        normal_drop = {1108, 1114},
        num = 7,
        pic = "StageIcon2",
        pre_para1 = {2106},
        sector = 2
    },
    [2108] = {
        combat = 9800,
        exploration_list = {2081, 2082, 2083},
        first_reward_ids = __rt_15,
        first_reward_nums = {550, 3, 5},
        id = 2108,
        introduce = 13079,
        name = 289266,
        num = 8,
        pic = "StageIcon2",
        pre_para1 = {2107},
        sector = 2
    },
    [2109] = {
        combat = 10200,
        cost_strength_num = 10,
        exploration_list = {2091},
        first_reward_ids = __rt_15,
        first_reward_nums = {575, 3, 5},
        id = 2109,
        introduce = 216788,
        name = 508249,
        normal_drop = {1114, 1102},
        num = 9,
        pic = "StageIcon2",
        pre_para1 = {2108},
        sector = 2
    },
    [2110] = {
        combat = 11900,
        cost_strength_num = 10,
        exploration_list = __rt_16,
        first_reward_ids = __rt_15,
        first_reward_nums = {600, 3, 5},
        id = 2110,
        introduce = 483542,
        name = 284342,
        num = 10,
        pic = "StageIcon2",
        pre_para1 = {2109},
        sector = 2
    },
    [2201] = {
        combat = 10100,
        cost_strength_num = 20,
        difficulty = 2,
        exp_gain = 1,
        exploration_list = {2511, 2512},
        id = 2201,
        introduce = 62412,
        name = 393654,
        normal_drop = __rt_18,
        pic = "StageIcon2",
        pre_para1 = __rt_17,
        sector = 2
    },
    [2202] = {
        combat = 11100,
        difficulty = 2,
        exp_gain = 1,
        exploration_list = {2521, 2522, 2523},
        id = 2202,
        introduce = 139128,
        name = 304769,
        normal_drop = __rt_19,
        num = 2,
        pic = "StageIcon2",
        pre_para1 = {2201},
        sector = 2
    },
    [2203] = {
        combat = 13900,
        difficulty = 2,
        exp_gain = 1,
        exploration_list = {2531, 2532, 2533},
        id = 2203,
        introduce = 61395,
        name = 44590,
        normal_drop = __rt_20,
        num = 3,
        pic = "StageIcon2",
        pre_para1 = {2202},
        sector = 2
    },
    [2204] = {
        combat = 15300,
        difficulty = 2,
        exp_gain = 1,
        exploration_list = {2541, 2542, 2543},
        id = 2204,
        introduce = 202595,
        name = 59207,
        normal_drop = __rt_21,
        num = 4,
        pic = "StageIcon2",
        pre_para1 = {2203},
        sector = 2
    },
    [2205] = {
        combat = 15900,
        difficulty = 2,
        exp_gain = 1,
        exploration_list = {2551, 2552, 2553},
        id = 2205,
        introduce = 151104,
        name = 23854,
        normal_drop = __rt_22,
        num = 5,
        pic = "StageIcon2",
        pre_para1 = {2204},
        sector = 2
    },
    [2206] = {
        combat = 21800,
        difficulty = 2,
        exp_gain = 1,
        exploration_list = {2561, 2562, 2563},
        id = 2206,
        introduce = 257005,
        name = 500112,
        normal_drop = __rt_14,
        num = 6,
        pic = "StageIcon2",
        pre_para1 = {2205},
        sector = 2
    },
    [3101] = {
        combat = 12800,
        cost_strength_num = 10,
        deploy_rows = 3,
        exploration_list = {3011},
        first_reward_ids = __rt_23,
        first_reward_nums = {650, 3, 4},
        id = 3101,
        introduce = 61092,
        name = 30116,
        normal_drop = __rt_4,
        pic = "StageIcon3",
        pre_para1 = {2110},
        sector = 3,
        size_row = 7
    },
    [3102] = {
        combat = 14200,
        cost_strength_num = 20,
        deploy_rows = 3,
        exploration_list = {3021, 3022},
        first_reward_ids = __rt_23,
        first_reward_nums = {675, 3, 4},
        id = 3102,
        introduce = 204357,
        name = 297814,
        normal_drop = __rt_8,
        num = 2,
        pic = "StageIcon3",
        pre_para1 = {3101},
        sector = 3,
        size_row = 7
    },
    [3103] = {
        combat = 14700,
        cost_strength_num = 20,
        deploy_rows = 3,
        exploration_list = {3031, 3032},
        first_reward_ids = __rt_23,
        first_reward_nums = {700, 3, 4},
        id = 3103,
        introduce = 365862,
        name = 224849,
        normal_drop = __rt_10,
        num = 3,
        pic = "StageIcon3",
        pre_para1 = {3102},
        sector = 3,
        size_row = 7
    },
    [3104] = {
        combat = 14700,
        cost_strength_num = 10,
        deploy_rows = 3,
        exploration_list = {3041},
        first_reward_ids = __rt_23,
        first_reward_nums = {725, 3, 4},
        id = 3104,
        introduce = 38470,
        name = 45989,
        normal_drop = {1111},
        num = 4,
        pic = "StageIcon3",
        pre_para1 = {3103},
        sector = 3,
        size_row = 7
    },
    [3105] = {
        combat = 18900,
        cost_strength_num = 20,
        deploy_rows = 3,
        exploration_list = {3051, 3052},
        first_reward_ids = __rt_23,
        first_reward_nums = {750, 3, 4},
        id = 3105,
        introduce = 36686,
        name = 247456,
        normal_drop = {1114},
        num = 5,
        pic = "StageIcon3",
        pre_para1 = {3104},
        sector = 3,
        size_row = 7
    },
    [3106] = {
        combat = 20100,
        deploy_rows = 3,
        exploration_list = {3061, 3062, 3063},
        first_reward_ids = __rt_23,
        first_reward_nums = {775, 3, 4},
        id = 3106,
        introduce = 277962,
        name = 342766,
        normal_drop = {1108, 1115},
        num = 6,
        pic = "StageIcon3",
        pre_para1 = {3105},
        sector = 3,
        size_row = 7
    },
    [3107] = {
        combat = 20100,
        cost_strength_num = 20,
        deploy_rows = 3,
        exploration_list = {3071, 3072},
        first_reward_ids = __rt_23,
        first_reward_nums = {800, 3, 4},
        id = 3107,
        introduce = 306260,
        name = 479891,
        normal_drop = {1111, 1103},
        num = 7,
        pic = "StageIcon3",
        pre_para1 = {3106},
        sector = 3,
        size_row = 7
    },
    [3108] = {
        combat = 21600,
        cost_strength_num = 10,
        deploy_rows = 3,
        exploration_list = {3081},
        first_reward_ids = __rt_23,
        first_reward_nums = {825, 3, 4},
        id = 3108,
        introduce = 401386,
        name = 29831,
        normal_drop = {1114, 1106},
        num = 8,
        pic = "StageIcon3",
        pre_para1 = __rt_24,
        sector = 3,
        size_row = 7
    },
    [3109] = {
        deploy_rows = 3,
        exploration_list = {3091, 3092, 3093},
        first_reward_ids = __rt_23,
        first_reward_nums = {850, 3, 4},
        id = 3109,
        introduce = 165739,
        name = 80610,
        normal_drop = {1102, 1109},
        num = 9,
        pic = "StageIcon3",
        pre_para1 = {3108},
        sector = 3,
        size_row = 7
    },
    [3110] = {
        deploy_rows = 3,
        exploration_list = {3101, 3102, 3103},
        first_reward_ids = __rt_23,
        first_reward_nums = {875, 3, 4},
        id = 3110,
        introduce = 66499,
        name = 510912,
        normal_drop = {1105, 1112},
        num = 10,
        pic = "StageIcon3",
        pre_para1 = {3109},
        sector = 3,
        size_row = 7
    },
    [3201] = {
        combat = 20400,
        cost_strength_num = 20,
        deploy_rows = 3,
        difficulty = 2,
        exploration_list = {3511, 3512},
        id = 3201,
        introduce = 70094,
        name = 139829,
        normal_drop = __rt_18,
        pic = "StageIcon3",
        pre_para1 = __rt_24,
        sector = 3,
        size_row = 7
    },
    [3202] = {
        combat = 21800,
        deploy_rows = 3,
        difficulty = 2,
        exploration_list = {3521, 3522, 3523},
        id = 3202,
        introduce = 298189,
        name = 115014,
        normal_drop = __rt_19,
        num = 2,
        pic = "StageIcon3",
        pre_para1 = {3201},
        sector = 3,
        size_row = 7
    },
    [3203] = {
        combat = 23400,
        deploy_rows = 3,
        difficulty = 2,
        exploration_list = {3531, 3532, 3533},
        id = 3203,
        introduce = 20849,
        name = 455194,
        normal_drop = __rt_20,
        num = 3,
        pic = "StageIcon3",
        pre_para1 = {3202},
        sector = 3,
        size_row = 7
    },
    [3204] = {
        combat = 28200,
        deploy_rows = 3,
        difficulty = 2,
        exploration_list = {3541, 3542, 3543},
        id = 3204,
        introduce = 441209,
        name = 508342,
        normal_drop = __rt_21,
        num = 4,
        pic = "StageIcon3",
        pre_para1 = {3203},
        sector = 3,
        size_row = 7
    },
    [3205] = {
        combat = 29100,
        deploy_rows = 3,
        difficulty = 2,
        exploration_list = {3551, 3552, 3553},
        id = 3205,
        introduce = 510180,
        name = 224572,
        normal_drop = __rt_22,
        num = 5,
        pic = "StageIcon3",
        pre_para1 = {3204},
        sector = 3,
        size_row = 7
    },
    [3206] = {
        combat = 35200,
        deploy_rows = 3,
        difficulty = 2,
        exploration_list = {3561, 3562, 3563},
        id = 3206,
        introduce = 486637,
        name = 80491,
        normal_drop = __rt_14,
        num = 6,
        pic = "StageIcon3",
        pre_para1 = {3205},
        sector = 3,
        size_row = 7
    },
    [4101] = {
        cost_strength_num = 10,
        deploy_rows = 3,
        exploration_list = {4011},
        first_reward_ids = __rt_23,
        first_reward_nums = {900, 3, 5},
        id = 4101,
        name = 413011,
        normal_drop = {1103, 1109},
        pic = "StageIcon4",
        pre_para1 = __rt_25,
        sector = 4,
        size_row = 7
    },
    [4102] = {
        combat = 26800,
        cost_strength_num = 20,
        deploy_rows = 3,
        exploration_list = {4021, 4022},
        first_reward_ids = __rt_23,
        first_reward_nums = {925, 3, 5},
        id = 4102,
        name = 218240,
        normal_drop = {1106, 1112},
        num = 2,
        pic = "StageIcon4",
        pre_para1 = __rt_25,
        sector = 4,
        size_row = 7
    },
    [4103] = {
        combat = 26800,
        cost_strength_num = 20,
        deploy_rows = 3,
        exploration_list = {4031, 4032},
        first_reward_ids = __rt_23,
        first_reward_nums = {950, 3, 5},
        id = 4103,
        name = 23469,
        normal_drop = {1109, 1115},
        num = 3,
        pic = "StageIcon4",
        pre_para1 = {4102},
        sector = 4,
        size_row = 7
    },
    [4104] = {
        combat = 32500,
        deploy_rows = 3,
        exploration_list = {4041, 4042, 4043},
        first_reward_ids = __rt_23,
        first_reward_nums = {975, 3, 5},
        id = 4104,
        name = 352986,
        normal_drop = {1112, 1103},
        num = 4,
        pic = "StageIcon4",
        pre_para1 = {4103},
        sector = 4,
        size_row = 7
    },
    [4105] = {
        combat = 32500,
        deploy_rows = 3,
        exploration_list = {4051, 4052, 4053},
        first_reward_ids = __rt_23,
        first_reward_nums = {1000, 3, 5},
        id = 4105,
        name = 158215,
        normal_drop = {1115, 1106},
        num = 5,
        pic = "StageIcon4",
        pre_para1 = {4104},
        sector = 4,
        size_row = 7
    },
    [4106] = {
        combat = 33700,
        cost_strength_num = 20,
        deploy_rows = 3,
        exploration_list = {4061, 4062},
        first_reward_ids = __rt_23,
        first_reward_nums = {1030, 3, 5},
        id = 4106,
        name = 487732,
        normal_drop = __rt_10,
        num = 6,
        pic = "StageIcon4",
        pre_para1 = {4105},
        sector = 4,
        size_row = 7
    },
    [4107] = {
        combat = 33700,
        cost_strength_num = 20,
        deploy_rows = 3,
        exploration_list = {4071, 4072},
        first_reward_ids = __rt_23,
        first_reward_nums = {1060, 3, 5},
        id = 4107,
        name = 292961,
        normal_drop = __rt_9,
        num = 7,
        pic = "StageIcon4",
        pre_para1 = {4106},
        sector = 4,
        size_row = 7
    },
    [4108] = {
        combat = 33700,
        deploy_rows = 3,
        exploration_list = {4081, 4082, 4083},
        first_reward_ids = __rt_23,
        first_reward_nums = {1090, 3, 5},
        id = 4108,
        name = 98190,
        normal_drop = __rt_11,
        num = 8,
        pic = "StageIcon4",
        pre_para1 = __rt_26,
        sector = 4,
        size_row = 7
    },
    [4109] = {
        combat = 35300,
        deploy_rows = 3,
        exploration_list = {4091, 4092, 4093},
        first_reward_ids = __rt_23,
        first_reward_nums = {1120, 3, 5},
        id = 4109,
        name = 427707,
        normal_drop = {1112},
        num = 9,
        pic = "StageIcon4",
        pre_para1 = {4108},
        sector = 4,
        size_row = 7
    },
    [4110] = {
        combat = 35300,
        cost_strength_num = 20,
        deploy_rows = 3,
        exploration_list = {4101, 4102},
        first_reward_ids = __rt_23,
        first_reward_nums = {1150, 3, 5},
        id = 4110,
        name = 384633,
        normal_drop = __rt_6,
        num = 10,
        pic = "StageIcon4",
        pre_para1 = {4109},
        sector = 4,
        size_row = 7
    },
    [4201] = {
        combat = 29100,
        cost_strength_num = 20,
        deploy_rows = 3,
        difficulty = 2,
        exploration_list = {4511, 4512},
        id = 4201,
        name = 149082,
        normal_drop = {1103, 1003},
        pic = "StageIcon4",
        pre_para1 = __rt_26,
        sector = 4,
        size_row = 7
    },
    [4202] = {
        combat = 35200,
        deploy_rows = 3,
        difficulty = 2,
        exploration_list = {4521, 4522, 4523},
        id = 4202,
        name = 478599,
        normal_drop = {1106, 1003},
        num = 2,
        pic = "StageIcon4",
        pre_para1 = {4201},
        sector = 4,
        size_row = 7
    },
    [4203] = {
        combat = 36500,
        deploy_rows = 3,
        difficulty = 2,
        exploration_list = {4531, 4532, 4533},
        id = 4203,
        name = 283828,
        normal_drop = {1109, 1003},
        num = 3,
        pic = "StageIcon4",
        pre_para1 = {4202},
        sector = 4,
        size_row = 7
    },
    [4204] = {
        combat = 38200,
        deploy_rows = 3,
        difficulty = 2,
        exploration_list = {4541, 4542, 4543},
        id = 4204,
        name = 89057,
        normal_drop = {1112, 1003},
        num = 4,
        pic = "StageIcon4",
        pre_para1 = {4203},
        sector = 4,
        size_row = 7
    },
    [4205] = {
        combat = 44800,
        deploy_rows = 3,
        difficulty = 2,
        exploration_list = {4551, 4552, 4553},
        id = 4205,
        normal_drop = {1115, 1003},
        num = 5,
        pic = "StageIcon4",
        pre_para1 = {4204},
        sector = 4,
        size_row = 7
    },
    [4206] = {
        combat = 44800,
        deploy_rows = 3,
        difficulty = 2,
        exploration_list = {4561, 4562, 4563},
        id = 4206,
        normal_drop = __rt_14,
        num = 6,
        pic = "StageIcon4",
        pre_para1 = {4205},
        sector = 4,
        size_row = 7
    }
}
local __default_values = {
    combat = 26000,
    cost_strength_id = 1007,
    cost_strength_num = 30,
    deploy_rows = 2,
    difficulty = 1,
    exp_gain = 0,
    exploration_list = {1011},
    first_reward_ids = __rt_12,
    first_reward_nums = __rt_13,
    function_extra = __rt_1,
    id = 1101,
    introduce = 342860,
    name = 418574,
    normal_drop = __rt_5,
    num = 1,
    pic = "StageIcon1",
    pre_condition = __rt_3,
    pre_para1 = __rt_8,
    pre_para2 = __rt_1,
    sector = 1,
    size_col = 5,
    size_row = 6
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in (_ENV.pairs)(sector_stage) do (_ENV.setmetatable)(v, base) end
local __rawdata = {
    __basemetatable = base,
    difficultyCount = 2,
    sectorDiffDic = {
        {
            {1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110},
            {1201, 1202, 1203, 1204, 1205, 1206}
        }, {
            {2101, 2102, 2103, 2104, 2105, 2106, 2107, 2108, 2109, 2110},
            {2201, 2202, 2203, 2204, 2205, 2206}
        }, {
            {3101, 3102, 3103, 3104, 3105, 3106, 3107, 3108, 3109, 3110},
            {3201, 3202, 3203, 3204, 3205, 3206}
        }, {
            {4101, 4102, 4103, 4104, 4105, 4106, 4107, 4108, 4109, 4110},
            {4201, 4202, 4203, 4204, 4205, 4206}
        }
    },
    sectorIdList = {
        {
            1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1201,
            1202, 1203, 1204, 1205, 1206
        }, {
            2101, 2102, 2103, 2104, 2105, 2106, 2107, 2108, 2109, 2110, 2201,
            2202, 2203, 2204, 2205, 2206
        }, {
            3101, 3102, 3103, 3104, 3105, 3106, 3107, 3108, 3109, 3110, 3201,
            3202, 3203, 3204, 3205, 3206
        }, {
            4101, 4102, 4103, 4104, 4105, 4106, 4107, 4108, 4109, 4110, 4201,
            4202, 4203, 4204, 4205, 4206
        }
    },
    sectorTotalCountDic = {{10, 6}, {10, 6}, {10, 6}, {10, 6}}
};
(_ENV.setmetatable)(sector_stage, {__index = __rawdata})
return sector_stage

