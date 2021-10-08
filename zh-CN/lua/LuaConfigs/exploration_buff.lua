local __rt_1 = {}
local __rt_2 = {1}
local __rt_3 = {10}
local __rt_4 = {-30}
local __rt_5 = {-50}
local __rt_6 = {80}
local __rt_7 = {2}
local __rt_8 = {50}
local __rt_9 = {10070}
local __rt_10 = {30}
local __rt_11 = {-20}
local __rt_12 = {108010}
local __rt_13 = {1, 100}
local __rt_14 = {3}
local __rt_15 = {1, 20}
local __rt_16 = {1, 10}
local __rt_17 = {20101}
local __rt_18 = {20102}
local exploration_buff = {
[100] = {describe = 208640, icon = "ICON_g_buff_16", 
logic_num = {108009}
, name = 120039, tigger_type = 3}
, 
[101] = {describe = 111244, icon = "ICON_g_buff_17", id = 101, is_onboard = true, logic = 8, logic_num = __rt_2, 
logic_per = {1003, 50}
, name = 212241, tigger_type = 3}
, 
[102] = {describe = 284047, icon = "hp", id = 102, is_battleShow = false, is_listshow = false, logic = 11, logic_num = __rt_2, name = 288393, tigger_type = 3}
, 
[103] = {describe = 375612, icon = "hp", id = 103, is_battleShow = false, is_listshow = false, logic = 12, logic_num = __rt_2, name = 449165, tigger_type = 3}
, 
[104] = {describe = 461077, icon = "hp", id = 104, is_battleShow = false, is_listshow = false, logic = 13, 
logic_num = {1, 50}
, name = 497664, tigger_type = 3}
, 
[105] = {describe = 501670, icon = "hp", id = 105, is_battleShow = false, is_listshow = false, logic = 14, logic_num = __rt_2, name = 158492, tigger_type = 3}
, 
[106] = {describe = 85486, icon = "ICON_g_buff_16", id = 106, 
logic_num = {108007}
, name = 109146, tigger_type = 3}
, 
[107] = {describe = 486620, icon = "ICON_g_buff_16", id = 107, 
logic_num = {108008}
, name = 212675, tigger_type = 3}
, 
[108] = {describe = 413120, icon = "ICON_g_buff_7", id = 108, is_onboard = true, logic = 15, logic_num = __rt_2, name = 255937}
, 
[109] = {describe = 198869, icon = "ICON_g_buff_7", id = 109, is_battleShow = false, is_listshow = false, logic = 16, logic_num = __rt_2, name = 443794, tigger_type = 3}
, 
[110] = {describe = 370908, icon = "ICON_g_buff_7", id = 110, logic = 17, 
logic_num = {0}
, logic_per = __rt_2, name = 146187, tigger_type = 3}
, 
[111] = {describe = 129444, icon = "ICON_g_buff_19", id = 111, is_listshow = false, logic = 18, logic_per = __rt_3, name = 388284, tigger_type = 3}
, 
[112] = {describe = 2417, icon = "ICON_g_buff_18", id = 112, is_battleShow = false, is_listshow = false, logic = 16, 
logic_num = {5}
, name = 188998, tigger_type = 3}
, 
[113] = {describe = 246400, icon = "hp", id = 113, is_battleShow = false, is_listshow = false, logic = 13, 
logic_num = {1, 80}
, name = 497664, tigger_type = 3}
, 
[1001] = {describe = 86809, icon = "hp", id = 1001, is_battleShow = false, is_listshow = false, logic = 19, logic_per = __rt_4, name = 27916, tigger_type = 3}
, 
[1002] = {describe = 284035, icon = "hp", id = 1002, is_battleShow = false, is_listshow = false, logic = 19, logic_per = __rt_5, name = 357433, tigger_type = 3}
, 
[1003] = {describe = 266096, icon = "hp", id = 1003, is_battleShow = false, is_listshow = false, logic = 20, logic_num = __rt_2, name = 134860}
, 
[1004] = {describe = 257333, icon = "hp", id = 1004, is_battleShow = false, is_listshow = false, logic = 21, logic_num = __rt_2, name = 464377}
, 
[1005] = {describe = 311975, icon = "hp", id = 1005, is_battleShow = false, is_listshow = false, logic = 22, logic_per = __rt_4, name = 227158}
, 
[1006] = {describe = 429301, icon = "hp", id = 1006, is_battleShow = false, is_listshow = false, logic = 22, logic_per = __rt_5, name = 32387}
, 
[1007] = {describe = 54016, icon = "hp", id = 1007, is_battleShow = false, is_listshow = false, logic = 23, 
logic_per = {70}
, name = 159038, tigger_type = 3}
, 
[1008] = {describe = 62863, icon = "hp", id = 1008, is_battleShow = false, is_listshow = false, logic = 23, logic_per = __rt_6, name = 488555, tigger_type = 3}
, 
[1009] = {describe = 361565, icon = "hp", id = 1009, is_battleShow = false, is_listshow = false, logic = 24, logic_num = __rt_2, name = 238767, tigger_type = 3}
, 
[1010] = {describe = 330187, icon = "hp", id = 1010, is_battleShow = false, is_listshow = false, logic = 24, logic_num = __rt_7, name = 43996, tigger_type = 3}
, 
[1011] = {describe = 16096, icon = "hp", id = 1011, is_battleShow = false, is_listshow = false, logic = 25, logic_num = __rt_2, name = 517030}
, 
[1012] = {describe = 296066, icon = "hp", id = 1012, is_battleShow = false, is_listshow = false, logic = 26, logic_num = __rt_8, name = 401634, tigger_type = 3}
, 
[1013] = {describe = 116343, icon = "hp", id = 1013, is_battleShow = false, is_listshow = false, logic = 27, logic_num = __rt_2, name = 23549, tigger_type = 3}
, 
[1014] = {describe = 285925, icon = "ICON_xy_31", id = 1014, is_battleShow = false, logic_num = __rt_9, name = 196906}
, 
[1015] = {describe = 223276, icon = "ICON_xy_33", id = 1015, is_battleShow = false, logic_num = __rt_9, name = 96509}
, 
[1016] = {describe = 418328, icon = "ICON_xy_32", id = 1016, is_battleShow = false, logic_num = __rt_9, name = 126143}
, 
[1017] = {describe = 447064, icon = "ICON_xy_34", id = 1017, is_battleShow = false, logic_num = __rt_9, name = 254478}
, 
[6003] = {describe = 297930, icon = "ICON_g_hp_1", id = 6003, 
logic_num = {108004}
, name = 512595, tigger_type = 3}
, 
[6004] = {describe = 41548, icon = "ICON_g_atn_1", id = 6004, 
logic_num = {108005}
, name = 75752, tigger_type = 3}
, 
[6005] = {describe = 434297, icon = "ICON_g_def_1", id = 6005, 
logic_num = {108006}
, name = 75457, tigger_type = 3}
, 
[6007] = {describe = 163692, icon = "hp-", id = 6007, is_battleShow = false, logic = 4, logic_per = __rt_4, name = 62562, tigger_type = 3}
, 
[6008] = {describe = 387023, icon = "recover", id = 6008, is_battleShow = false, logic = 4, logic_per = __rt_10, name = 285893, tigger_type = 3}
, 
[6009] = {describe = 293392, icon = "recover", id = 6009, is_battleShow = false, logic = 5, logic_per = __rt_6, name = 243035, tigger_type = 3}
, 
[6010] = {describe = 490754, icon = "hp-", id = 6010, is_battleShow = false, logic = 4, 
logic_per = {-10}
, name = 389624, tigger_type = 3}
, 
[6011] = {describe = 327223, icon = "hp-", id = 6011, is_battleShow = false, logic = 4, logic_per = __rt_11, name = 226093, tigger_type = 3}
, 
[6012] = {describe = 270718, icon = "ICON_g_atn_1", id = 6012, logic_num = __rt_12, name = 75752}
, 
[6013] = {describe = 327223, icon = "hp-", id = 6013, is_battleShow = false, logic = 4, logic_per = __rt_11, name = 226093, tigger_type = 3}
, 
[6014] = {describe = 26266, icon = "recover", id = 6014, is_battleShow = false, logic = 4, 
logic_per = {20}
, name = 141539, tigger_type = 3}
, 
[6015] = {describe = 163692, icon = "hp-", id = 6015, is_battleShow = false, logic = 4, logic_per = __rt_4, name = 62562, tigger_type = 3}
, 
[6016] = {describe = 161, icon = "hp-", id = 6016, is_battleShow = false, logic = 4, 
logic_per = {-40}
, name = 423319, tigger_type = 3}
, 
[6017] = {describe = 360918, icon = "hp-", id = 6017, is_battleShow = false, logic = 4, logic_per = __rt_5, name = 259788, tigger_type = 3}
, 
[6018] = {describe = 270718, icon = "ICON_g_atn_1", id = 6018, is_battleShow = false, logic_num = __rt_12, name = 75752}
, 
[6019] = {describe = 465338, icon = "ICON_g_hp_1", id = 6019, is_battleShow = false, 
logic_num = {108011}
, name = 512595}
, 
[7001] = {describe = 34727, icon = "ICON_g_buff_5", id = 7001, logic = 1, logic_per = __rt_10, name = 302907, tigger_type = 2}
, 
[8000] = {describe = 69357, icon = "ICON_g_buff_3", id = 8000, logic = 2, 
logic_per = {100}
, name = 340833}
, 
[8001] = {describe = 506448, icon = "ICON_g_buff_16", id = 8001, 
logic_num = {108001}
, name = 511437}
, 
[8002] = {describe = 100045, icon = "attack", id = 8002, is_battleShow = false, 
logic_num = {108002}
, name = 120559}
, 
[8003] = {describe = 440917, icon = "ICON_g_buff_15", id = 8003, logic = 2, 
logic_per = {300}
, name = 146154}
, 
[8005] = {describe = 505475, icon = "ICON_g_buff_6", id = 8005, logic = 8, logic_num = __rt_7, logic_per = __rt_13, name = 332859}
, 
[8006] = {describe = 306182, icon = "ICON_g_buff_1", id = 8006, is_onboard = true, logic = 3, logic_num = __rt_14, logic_per = __rt_8, name = 11420}
, 
[8007] = {describe = 502878, icon = "ICON_g_buff_6", id = 8007, is_onboard = true, logic = 8, logic_num = __rt_7, 
logic_per = {1, 200}
, name = 332859}
, 
[8008] = {describe = 163223, icon = "ICON_g_buff_6", id = 8008, is_onboard = true, logic = 8, logic_num = __rt_7, logic_per = __rt_13, name = 332859}
, 
[20001] = {describe = 250524, icon = "ICON_xy_1", id = 20001, is_onboard = true, 
logic_num = {20001}
, name = 351144}
, 
[20002] = {describe = 142537, icon = "ICON_xy_2", id = 20002, is_onboard = true, 
logic_num = {20002}
, name = 195958}
, 
[20003] = {buff_type = 1, describe = 145992, icon = "ICON_xy_3", id = 20003, is_onboard = true, 
logic_num = {20003}
, name = 476326}
, 
[20004] = {buff_type = 1, describe = 260138, icon = "ICON_xy_4", id = 20004, is_onboard = true, 
logic_num = {20004}
, name = 119410}
, 
[20005] = {buff_type = 1, describe = 440224, icon = "ICON_xy_5", id = 20005, is_onboard = true, 
logic_num = {20005}
, name = 19033}
, 
[20006] = {buff_type = 1, describe = 298373, icon = "ICON_xy_6", id = 20006, is_onboard = true, 
logic_num = {20006}
, name = 91553}
, 
[20007] = {buff_type = 1, describe = 199168, icon = "ICON_xy_7", id = 20007, is_onboard = true, 
logic_num = {20007}
, name = 270754}
, 
[20008] = {describe = 412117, icon = "ICON_xy_8", id = 20008, is_onboard = true, 
logic_num = {20008}
, name = 380502}
, 
[20009] = {describe = 356593, icon = "ICON_xy_9", id = 20009, is_onboard = true, 
logic_num = {20009}
, name = 480518}
, 
[20010] = {describe = 242767, icon = "ICON_xy_10", id = 20010, is_onboard = true, 
logic_num = {20010}
, name = 116240}
, 
[20011] = {describe = 109388, icon = "ICON_xy_11", id = 20011, is_onboard = true, 
logic_num = {20011}
, name = 17624}
, 
[20012] = {describe = 406794, icon = "ICON_xy_12", id = 20012, is_onboard = true, 
logic_num = {20012}
, name = 492476}
, 
[20013] = {describe = 109846, icon = "ICON_xy_13", id = 20013, is_onboard = true, 
logic_num = {20013}
, name = 322960}
, 
[20014] = {buff_type = 2, describe = 456681, icon = "ICON_xy_14", id = 20014, is_onboard = true, 
logic_num = {20014}
, name = 16706}
, 
[20015] = {buff_type = 2, describe = 456843, icon = "ICON_xy_15", id = 20015, is_onboard = true, 
logic_num = {20015}
, name = 420197}
, 
[20016] = {buff_type = 2, describe = 251908, icon = "ICON_xy_16", id = 20016, is_onboard = true, 
logic_num = {20016}
, name = 446478}
, 
[20017] = {buff_type = 2, describe = 56915, icon = "ICON_xy_17", id = 20017, is_onboard = true, 
logic_num = {20017}
, name = 45501}
, 
[20018] = {buff_type = 2, describe = 218546, icon = "ICON_xy_18", id = 20018, is_onboard = true, 
logic_num = {20018}
, name = 377177}
, 
[20019] = {buff_type = 2, describe = 314787, icon = "ICON_xy_19", id = 20019, is_onboard = true, 
logic_num = {20019}
, name = 498986}
, 
[20020] = {buff_type = 2, describe = 424303, icon = "ICON_xy_20", id = 20020, is_onboard = true, 
logic_num = {20020}
, name = 78969}
, 
[20021] = {buff_type = 2, describe = 108290, icon = "ICON_xy_21", id = 20021, is_onboard = true, 
logic_num = {20021}
, name = 221615}
, 
[20022] = {buff_type = 2, describe = 297755, icon = "ICON_xy_22", id = 20022, is_onboard = true, 
logic_num = {20022}
, name = 396237}
, 
[20023] = {buff_type = 2, describe = 165282, icon = "ICON_xy_23", id = 20023, is_onboard = true, 
logic_num = {20023}
, name = 483339}
, 
[20024] = {buff_type = 2, describe = 396220, icon = "ICON_xy_24", id = 20024, is_onboard = true, 
logic_num = {20024}
, name = 508954}
, 
[20025] = {buff_type = 2, describe = 185863, icon = "ICON_xy_25", id = 20025, is_onboard = true, 
logic_num = {20025}
, name = 393628}
, 
[20026] = {buff_type = 2, describe = 343244, icon = "ICON_xy_26", id = 20026, is_onboard = true, 
logic_num = {20026}
, name = 293108}
, 
[20027] = {buff_type = 2, describe = 125443, icon = "ICON_xy_27", id = 20027, is_onboard = true, 
logic_num = {20027}
, name = 273054}
, 
[20028] = {buff_type = 2, describe = 441693, icon = "ICON_xy_28", id = 20028, is_onboard = true, 
logic_num = {20028}
, name = 425833}
, 
[20029] = {buff_type = 2, describe = 401158, icon = "ICON_xy_29", id = 20029, is_onboard = true, 
logic_num = {20029}
, name = 104954}
, 
[20030] = {buff_type = 2, describe = 286773, icon = "ICON_xy_30", id = 20030, is_onboard = true, 
logic_num = {20030}
, name = 274433}
, 
[20031] = {buff_type = 2, describe = 71063, icon = "ICON_root_31", id = 20031, is_onboard = true, 
logic_num = {20031}
, name = 86711}
, 
[20032] = {buff_type = 2, describe = 469240, icon = "ICON_root_32", id = 20032, is_onboard = true, 
logic_num = {20032}
, name = 17085}
, 
[20033] = {buff_type = 2, describe = 9487, icon = "ICON_root_33", id = 20033, is_onboard = true, 
logic_num = {20033}
, name = 114134}
, 
[20034] = {buff_type = 2, describe = 49673, id = 20034, is_onboard = true, 
logic_num = {20034}
}
, 
[20035] = {buff_type = 2, describe = 37687, icon = "ICON_root_35", id = 20035, is_onboard = true, 
logic_num = {20035}
, name = 57336}
, 
[20036] = {buff_type = 2, describe = 317848, icon = "ICON_root_36", id = 20036, is_onboard = true, 
logic_num = {20036}
, name = 28333}
, 
[20037] = {buff_type = 2, describe = 265911, icon = "ICON_root_37", id = 20037, is_onboard = true, 
logic_num = {20037}
, name = 444554}
, 
[20038] = {buff_type = 2, describe = 271267, icon = "ICON_root_38", id = 20038, is_onboard = true, 
logic_num = {20038}
, name = 487003}
, 
[20039] = {describe = 405540, icon = "ICON_root_39", id = 20039, is_onboard = true, 
logic_num = {20039}
, name = 68151}
, 
[20040] = {describe = 450860, icon = "ICON_root_40", id = 20040, is_onboard = true, 
logic_num = {20040}
, name = 306796}
, 
[20041] = {buff_type = 2, describe = 37687, icon = "ICON_root_41", id = 20041, is_onboard = true, 
logic_num = {20041}
, name = 57336}
, 
[20042] = {buff_type = 2, describe = 265911, icon = "ICON_root_42", id = 20042, is_onboard = true, 
logic_num = {20042}
, name = 444554}
, 
[20043] = {buff_type = 1, describe = 497918, icon = "ICON_root_43", id = 20043, is_onboard = true, 
logic_num = {20043}
, name = 364477}
, 
[20044] = {buff_type = 2, describe = 399170, icon = "ICON_root_44", id = 20044, is_onboard = true, 
logic_num = {20044}
, name = 257551}
, 
[20045] = {buff_type = 2, describe = 321618, icon = "ICON_root_45", id = 20045, is_onboard = true, 
logic_num = {20045}
, name = 439530}
, 
[20046] = {buff_type = 2, describe = 241013, icon = "ICON_root_46", id = 20046, is_onboard = true, 
logic_num = {20046}
, name = 182585}
, 
[20047] = {buff_type = 2, describe = 330900, icon = "ICON_root_47", id = 20047, is_onboard = true, 
logic_num = {20047}
, name = 269299}
, 
[20048] = {buff_type = 2, describe = 412378, icon = "ICON_root_48", id = 20048, is_onboard = true, 
logic_num = {20048}
, name = 408092}
, 
[20049] = {buff_type = 2, describe = 263278, icon = "ICON_root_49", id = 20049, is_onboard = true, 
logic_num = {20049}
, name = 56843}
, 
[20050] = {buff_type = 2, describe = 197324, icon = "ICON_root_50", id = 20050, is_onboard = true, 
logic_num = {20050}
, name = 350937}
, 
[20051] = {buff_type = 2, describe = 418484, icon = "ICON_root_51", id = 20051, is_onboard = true, 
logic_num = {20051}
, name = 497517}
, 
[20052] = {buff_type = 2, describe = 197177, icon = "ICON_xy_52", id = 20052, is_onboard = true, 
logic_num = {20052, 20053}
, name = 418210}
, 
[20053] = {buff_type = 2, describe = 29615, icon = "ICON_xy_53", id = 20053, is_onboard = true, 
logic_num = {20054, 20055}
, name = 185065}
, 
[20056] = {buff_type = 1, describe = 450151, icon = "ICON_xy_1", id = 20056, is_onboard = true, 
logic_num = {20056}
, name = 166413}
, 
[20057] = {buff_type = 1, describe = 189475, icon = "ICON_4T_2", id = 20057, is_onboard = true, 
logic_num = {20057}
, name = 127079}
, 
[20058] = {buff_type = 1, describe = 243643, icon = "ICON_4T_3", id = 20058, is_onboard = true, 
logic_num = {20058}
, name = 64710}
, 
[20059] = {buff_type = 1, describe = 161775, icon = "ICON_4T_1", id = 20059, is_onboard = true, 
logic_num = {20059}
, name = 45160}
, 
[20060] = {describe = 501503, icon = "ICON_4T_4", id = 20060, is_onboard = true, 
logic_num = {20060}
, name = 134323}
, 
[20061] = {describe = 75687, icon = "ICON_4T_5", id = 20061, is_onboard = true, 
logic_num = {20061}
, name = 384218}
, 
[20062] = {describe = 334777, icon = "ICON_4T_6", id = 20062, is_onboard = true, 
logic_num = {20062}
, name = 274481}
, 
[20063] = {describe = 453990, icon = "ICON_4T_7", id = 20063, is_onboard = true, 
logic_num = {20063, 20064}
, name = 220563}
, 
[20065] = {describe = 74439, icon = "ICON_4T_8", id = 20065, is_onboard = true, 
logic_num = {20065, 20066}
, name = 388496}
, 
[20067] = {buff_type = 1, describe = 93997, icon = "ICON_4T_9", id = 20067, is_onboard = true, 
logic_num = {20067}
, name = 256410}
, 
[20068] = {buff_type = 1, describe = 173077, icon = "ICON_4T_10", id = 20068, is_onboard = true, logic = 8, logic_num = __rt_2, logic_per = __rt_15, name = 253781}
, 
[20069] = {buff_type = 1, describe = 393920, icon = "ICON_4T_11", id = 20069, is_onboard = true, logic = 36, 
logic_num = {20077, 20070}
, name = 320482}
, 
[20070] = {describe = 291469, icon = "recover", id = 20070, is_battleShow = false, is_listshow = false, logic = 5, logic_per = __rt_3, name = 467890}
, 
[20071] = {describe = 340896, icon = "maxhp+", id = 20071, is_battleShow = false, is_listshow = false, 
logic_num = {20071}
, name = 340896, tigger_type = 3}
, 
[20072] = {describe = 504427, icon = "maxhp+", id = 20072, is_battleShow = false, is_listshow = false, 
logic_num = {20072}
, name = 504427, tigger_type = 3}
, 
[20073] = {describe = 29409, icon = "maxhp-", id = 20073, is_battleShow = false, is_listshow = false, 
logic_num = {20073}
, name = 29409, tigger_type = 3}
, 
[20074] = {describe = 390166, icon = "maxhp-", id = 20074, is_battleShow = false, is_listshow = false, 
logic_num = {20074}
, name = 390166, tigger_type = 3}
, 
[20075] = {describe = 143373, icon = "maxhp-", id = 20075, is_battleShow = false, is_listshow = false, 
logic_num = {20075}
, name = 143373, tigger_type = 3}
, 
[20076] = {describe = 406200, icon = "recover", id = 20076, is_battleShow = false, logic = 4, 
logic_per = {15}
, name = 305070, tigger_type = 3}
, 
[20077] = {buff_type = 1, describe = 235222, icon = "ICON_4T_10", id = 20077, is_battleShow = false, is_listshow = false, logic = 8, logic_num = __rt_2, logic_per = __rt_15, name = 15063}
, 
[20078] = {describe = 49673, id = 20078, is_battleShow = false, is_listshow = false, 
logic_num = {20078}
}
, 
[20079] = {buff_type = 1, describe = 74764, id = 20079, is_battleShow = false, is_listshow = false, 
logic_num = {20079}
}
, 
[20080] = {id = 20080, is_battleShow = false, is_listshow = false, 
logic_num = {20080}
, name = 455807}
, 
[20081] = {id = 20081, is_battleShow = false, is_listshow = false, 
logic_num = {20081}
, name = 361431}
, 
[20082] = {id = 20082, is_battleShow = false, is_listshow = false, 
logic_num = {20082}
, name = 459953}
, 
[20083] = {id = 20083, is_battleShow = false, is_listshow = false, 
logic_num = {20083}
, name = 14905}
, 
[20084] = {id = 20084, is_battleShow = false, is_listshow = false, 
logic_num = {20084}
, name = 114763}
, 
[20085] = {id = 20085, is_battleShow = false, is_listshow = false, 
logic_num = {20085}
, name = 246173}
, 
[20086] = {id = 20086, is_battleShow = false, is_listshow = false, 
logic_num = {20086}
, name = 246173}
, 
[20087] = {id = 20087, is_battleShow = false, is_listshow = false, 
logic_num = {20087}
, name = 309687}
, 
[20088] = {id = 20088, is_battleShow = false, is_listshow = false, 
logic_num = {20088}
, name = 493113}
, 
[20089] = {id = 20089, is_battleShow = false, is_listshow = false, 
logic_num = {20089}
, name = 124460}
, 
[20090] = {id = 20090, is_battleShow = false, is_listshow = false, 
logic_num = {20090}
, name = 124460}
, 
[20091] = {id = 20091, is_battleShow = false, is_listshow = false, 
logic_num = {20091}
, name = 124460}
, 
[20092] = {describe = 453048, icon = "ICON_root_54", id = 20092, is_battleShow = false, is_listshow = false, 
logic_num = {20092}
, name = 471255}
, 
[20093] = {describe = 502795, id = 20093, is_battleShow = false, is_listshow = false, 
logic_num = {20093}
, name = 493120}
, 
[20094] = {describe = 502795, id = 20094, is_battleShow = false, is_listshow = false, 
logic_num = {20094}
, name = 450291}
, 
[20095] = {describe = 502795, id = 20095, is_battleShow = false, is_listshow = false, 
logic_num = {20095}
, name = 412120}
, 
[20096] = {describe = 502795, id = 20096, is_battleShow = false, is_listshow = false, 
logic_num = {20096}
, name = 121188}
, 
[20097] = {describe = 437269, id = 20097, is_battleShow = false, is_listshow = false, 
logic_num = {20097}
, name = 77739}
, 
[20098] = {buff_type = 2, describe = 506824, icon = "ICON_xiajian", id = 20098, is_onboard = true, logic = 31, 
logic_num = {4}
, name = 508342, tigger_type = 3}
, 
[20099] = {buff_type = 2, describe = 134271, icon = "ICON_boxue", id = 20099, is_onboard = true, logic = 30, logic_num = __rt_16, 
logic_per = {6010}
, name = 376343, tigger_type = 3}
, 
[20100] = {buff_type = 1, describe = 276715, icon = "ICON_moneyp", id = 20100, is_onboard = true, logic = 28, logic_num = __rt_13, name = 270611, tigger_type = 3}
, 
[20101] = {describe = 289585, icon = "ICON_xy_1", id = 20101, is_battleShow = false, is_listshow = false, logic_num = __rt_17, name = 289585, tigger_type = 3}
, 
[20102] = {describe = 4867, icon = "ICON_xy_1", id = 20102, is_battleShow = false, is_listshow = false, logic_num = __rt_18, name = 4867, tigger_type = 3}
, 
[20103] = {buff_type = 1, describe = 169861, icon = "ICON_moneyap", id = 20103, is_onboard = true, logic = 39, logic_num = __rt_16, logic_per = __rt_17, name = 355620, tigger_type = 3}
, 
[20104] = {buff_type = 2, describe = 492293, icon = "ICON_moneySD", id = 20104, is_onboard = true, logic = 39, logic_num = __rt_16, logic_per = __rt_18, name = 286055, tigger_type = 3}
, 
[20105] = {buff_type = 1, describe = 381195, icon = "ICON_cross", id = 20105, is_onboard = true, logic = 27, logic_num = __rt_14, name = 407746, tigger_type = 3}
, 
[20106] = {describe = 385586, icon = "ICON_xy_1", id = 20106, is_battleShow = false, is_listshow = false, 
logic_num = {20106}
, name = 385586}
, 
[20107] = {describe = 262276, icon = "ICON_xy_1", id = 20107, is_battleShow = false, is_listshow = false, 
logic_num = {20107}
, name = 262276}
, 
[20108] = {describe = 402689, id = 20108, is_battleShow = false, is_listshow = false, 
logic_num = {20108}
, name = 402689}
, 
[20109] = {buff_type = 1, describe = 18416, icon = "ICON_superpasika", id = 20109, 
logic_num = {20109}
, name = 511426}
, 
[20110] = {describe = 103029, id = 20110, is_battleShow = false, is_listshow = false, 
logic_num = {20110}
, name = 103029}
, 
[20111] = {describe = 4675, id = 20111, is_battleShow = false, is_listshow = false, 
logic_num = {20111}
, name = 161792}
, 
[20112] = {describe = 433762, icon = "ICON_xy_35", id = 20112, is_onboard = true, 
logic_num = {20112}
, name = 347389}
, 
[20113] = {describe = 196247, icon = "ICON_xy_36", id = 20113, is_onboard = true, 
logic_num = {20113}
, name = 389271}
, 
[20115] = {describe = 213133, id = 20115, is_battleShow = false, is_listshow = false, 
logic_num = {20115}
, name = 213133}
, 
[20116] = {describe = 377257, icon = "ICON_xy_39", id = 20116, is_onboard = true, 
logic_num = {20116}
, name = 517621}
, 
[108000] = {describe = 177970, icon = "stronger", id = 108000, is_battleShow = false, is_listshow = false, 
logic_num = {108000}
, name = 363151}
, 
[108003] = {describe = 506193, icon = "stronger", id = 108003, is_battleShow = false, is_listshow = false, 
logic_num = {108003}
, name = 352829}
}
local __default_values = {buff_type = 0, describe = 294856, icon = "ICON_root_34", id = 100, is_battleShow = true, is_listshow = true, is_onboard = false, logic = 9, logic_num = __rt_1, logic_per = __rt_1, name = 11768, tigger_type = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in (_ENV.pairs)(exploration_buff) do
  (_ENV.setmetatable)(v, base)
end
local __rawdata = {__basemetatable = base}
;
(_ENV.setmetatable)(exploration_buff, {__index = __rawdata})
return exploration_buff

