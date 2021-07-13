-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {1}
local __rt_3 = {10}
local __rt_4 = {-30}
local __rt_5 = {-50}
local __rt_6 = {3}
local __rt_7 = {80}
local __rt_8 = {2}
local __rt_9 = {50}
local __rt_10 = {30}
local __rt_11 = {-20}
local __rt_12 = {108010}
local __rt_13 = {1, 100}
local __rt_14 = {1, 20}
local exploration_buff = {
[100] = {describe = 208640, icon = "ICON_g_buff_16", is_onboard = false, 
logic_num = {108009}
, name = 120039, tigger_type = 3}
, 
[101] = {describe = 111244, icon = "ICON_g_buff_17", id = 101, logic = 8, logic_num = __rt_2, 
logic_per = {1003, 50}
, name = 212241, tigger_type = 3}
, 
[102] = {describe = 284047, id = 102, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 11, logic_num = __rt_2, name = 288393, tigger_type = 3}
, 
[103] = {describe = 375612, id = 103, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 12, logic_num = __rt_2, name = 449165, tigger_type = 3}
, 
[104] = {describe = 461077, id = 104, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 13, 
logic_num = {1, 50}
, name = 497664, tigger_type = 3}
, 
[105] = {describe = 501670, id = 105, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 14, logic_num = __rt_2, name = 158492, tigger_type = 3}
, 
[106] = {describe = 85486, icon = "ICON_g_buff_16", id = 106, is_onboard = false, 
logic_num = {108007}
, name = 109146, tigger_type = 3}
, 
[107] = {describe = 486620, icon = "ICON_g_buff_16", id = 107, is_onboard = false, 
logic_num = {108008}
, name = 212675, tigger_type = 3}
, 
[108] = {describe = 413120, icon = "ICON_g_buff_7", id = 108, logic = 15, logic_num = __rt_2, name = 255937}
, 
[109] = {describe = 198869, icon = "ICON_g_buff_7", id = 109, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 16, logic_num = __rt_2, name = 443794, tigger_type = 3}
, 
[110] = {describe = 370908, icon = "ICON_g_buff_7", id = 110, is_onboard = false, logic = 17, 
logic_num = {0}
, logic_per = __rt_2, name = 146187, tigger_type = 3}
, 
[111] = {describe = 129444, icon = "ICON_g_buff_19", id = 111, is_listshow = false, is_onboard = false, is_show = false, logic = 18, logic_per = __rt_3, name = 388284, tigger_type = 3}
, 
[112] = {describe = 2417, icon = "ICON_g_buff_18", id = 112, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 16, 
logic_num = {5}
, name = 188998, tigger_type = 3}
, 
[1001] = {describe = 86809, id = 1001, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 19, logic_per = __rt_4, name = 27916, tigger_type = 3}
, 
[1002] = {describe = 284035, id = 1002, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 19, logic_per = __rt_5, name = 357433, tigger_type = 3}
, 
[1003] = {describe = 266096, id = 1003, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 20, logic_num = __rt_2, name = 134860}
, 
[1004] = {describe = 257333, id = 1004, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 21, logic_num = __rt_6, name = 464377, tigger_type = 3}
, 
[1005] = {describe = 311975, id = 1005, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 22, logic_per = __rt_4, name = 227158}
, 
[1006] = {describe = 429301, id = 1006, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 22, logic_per = __rt_5, name = 32387}
, 
[1007] = {describe = 54016, id = 1007, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 23, 
logic_per = {70}
, name = 159038, tigger_type = 3}
, 
[1008] = {describe = 62863, id = 1008, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 23, logic_per = __rt_7, name = 488555, tigger_type = 3}
, 
[1009] = {describe = 361565, id = 1009, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 24, logic_num = __rt_2, name = 238767, tigger_type = 3}
, 
[1010] = {describe = 330187, id = 1010, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 24, logic_num = __rt_8, name = 43996, tigger_type = 3}
, 
[1011] = {describe = 16096, id = 1011, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 25, logic_num = __rt_2, name = 517030}
, 
[1012] = {describe = 296066, id = 1012, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 26, logic_num = __rt_9, name = 401634, tigger_type = 3}
, 
[1013] = {describe = 116343, id = 1013, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 27, logic_num = __rt_2, name = 23549, tigger_type = 3}
, 
[6003] = {describe = 297930, icon = "ICON_g_hp_1", id = 6003, is_onboard = false, 
logic_num = {108004}
, name = 512595, tigger_type = 3}
, 
[6004] = {describe = 41548, icon = "ICON_g_atn_1", id = 6004, is_onboard = false, 
logic_num = {108005}
, name = 75752, tigger_type = 3}
, 
[6005] = {describe = 434297, icon = "ICON_g_def_1", id = 6005, is_onboard = false, 
logic_num = {108006}
, name = 75457, tigger_type = 3}
, 
[6007] = {icon = "hp-", id = 6007, is_battleShow = false, is_onboard = false, logic = 4, logic_per = __rt_4, name = 62562, tigger_type = 3}
, 
[6008] = {describe = 387023, icon = "recover", id = 6008, is_battleShow = false, is_onboard = false, logic = 4, logic_per = __rt_10, name = 285893, tigger_type = 3}
, 
[6009] = {describe = 293392, icon = "recover", id = 6009, is_battleShow = false, is_onboard = false, logic = 5, logic_per = __rt_7, name = 243035, tigger_type = 3}
, 
[6010] = {describe = 490754, icon = "hp-", id = 6010, is_battleShow = false, is_onboard = false, logic = 4, 
logic_per = {-10}
, name = 389624, tigger_type = 3}
, 
[6011] = {describe = 327223, icon = "hp-", id = 6011, is_battleShow = false, is_onboard = false, logic = 4, logic_per = __rt_11, name = 226093, tigger_type = 3}
, 
[6012] = {describe = 270718, icon = "ICON_g_atn_1", id = 6012, is_onboard = false, logic_num = __rt_12, name = 75752}
, 
[6013] = {describe = 327223, icon = "hp-", id = 6013, is_battleShow = false, is_onboard = false, logic = 4, logic_per = __rt_11, name = 226093, tigger_type = 3}
, 
[6014] = {describe = 26266, icon = "recover", id = 6014, is_battleShow = false, is_onboard = false, logic = 4, 
logic_per = {20}
, name = 141539, tigger_type = 3}
, 
[6015] = {icon = "hp-", id = 6015, is_battleShow = false, is_onboard = false, logic = 4, logic_per = __rt_4, name = 62562, tigger_type = 3}
, 
[6016] = {describe = 161, icon = "hp-", id = 6016, is_battleShow = false, is_onboard = false, logic = 4, 
logic_per = {-40}
, name = 423319, tigger_type = 3}
, 
[6017] = {describe = 360918, icon = "hp-", id = 6017, is_battleShow = false, is_onboard = false, logic = 4, logic_per = __rt_5, name = 259788, tigger_type = 3}
, 
[6018] = {describe = 270718, icon = "ICON_g_atn_1", id = 6018, is_battleShow = false, is_onboard = false, logic_num = __rt_12, name = 75752}
, 
[6019] = {describe = 465338, icon = "ICON_g_hp_1", id = 6019, is_battleShow = false, is_onboard = false, 
logic_num = {108011}
, name = 512595}
, 
[7001] = {describe = 34727, icon = "ICON_g_buff_5", id = 7001, is_onboard = false, logic = 1, logic_per = __rt_10, name = 302907, tigger_type = 2}
, 
[8000] = {describe = 69357, icon = "ICON_g_buff_3", id = 8000, is_onboard = false, logic = 2, 
logic_per = {100}
, name = 340833}
, 
[8001] = {describe = 506448, icon = "ICON_g_buff_16", id = 8001, is_onboard = false, 
logic_num = {108001}
, name = 511437}
, 
[8002] = {describe = 100045, icon = "attack", id = 8002, is_battleShow = false, is_onboard = false, 
logic_num = {108002}
, name = 120559}
, 
[8003] = {describe = 440917, icon = "ICON_g_buff_15", id = 8003, is_onboard = false, logic = 2, 
logic_per = {300}
, name = 146154}
, 
[8005] = {describe = 352092, icon = "ICON_g_buff_6", id = 8005, is_onboard = false, logic = 8, logic_num = __rt_8, logic_per = __rt_13}
, 
[8006] = {describe = 411278, icon = "ICON_g_buff_1", id = 8006, logic = 3, logic_num = __rt_6, logic_per = __rt_9, name = 11420}
, 
[8007] = {describe = 502878, icon = "ICON_g_buff_6", id = 8007, logic = 8, logic_num = __rt_8, 
logic_per = {1, 200}
}
, 
[8008] = {describe = 163223, icon = "ICON_g_buff_6", id = 8008, logic = 8, logic_num = __rt_8, logic_per = __rt_13}
, 
[20001] = {describe = 250524, icon = "ICON_xy_1", id = 20001, 
logic_num = {20001}
, name = 351144}
, 
[20002] = {describe = 142537, icon = "ICON_xy_2", id = 20002, 
logic_num = {20002}
, name = 195958}
, 
[20003] = {describe = 145992, icon = "ICON_xy_3", id = 20003, 
logic_num = {20003}
, name = 476326}
, 
[20004] = {describe = 54551, icon = "ICON_xy_4", id = 20004, 
logic_num = {20004}
, name = 119410}
, 
[20005] = {describe = 440224, icon = "ICON_xy_5", id = 20005, 
logic_num = {20005}
, name = 19033}
, 
[20006] = {describe = 298373, icon = "ICON_xy_6", id = 20006, 
logic_num = {20006}
, name = 91553}
, 
[20007] = {describe = 199168, icon = "ICON_xy_7", id = 20007, 
logic_num = {20007}
, name = 270754}
, 
[20008] = {describe = 412117, icon = "ICON_xy_8", id = 20008, 
logic_num = {20008}
, name = 380502}
, 
[20009] = {describe = 356593, icon = "ICON_xy_9", id = 20009, 
logic_num = {20009}
, name = 480518}
, 
[20010] = {describe = 242767, icon = "ICON_xy_10", id = 20010, 
logic_num = {20010}
, name = 68914}
, 
[20011] = {describe = 109388, icon = "ICON_xy_11", id = 20011, 
logic_num = {20011}
, name = 463864}
, 
[20012] = {describe = 406794, icon = "ICON_xy_12", id = 20012, 
logic_num = {20012}
, name = 340128}
, 
[20013] = {describe = 109846, icon = "ICON_xy_13", id = 20013, 
logic_num = {20013}
, name = 465710}
, 
[20014] = {describe = 208384, icon = "ICON_xy_14", id = 20014, 
logic_num = {20014}
, name = 114692}
, 
[20015] = {describe = 456843, icon = "ICON_xy_15", id = 20015, 
logic_num = {20015}
, name = 420197}
, 
[20016] = {describe = 251908, icon = "ICON_xy_16", id = 20016, 
logic_num = {20016}
, name = 446478}
, 
[20017] = {describe = 56915, icon = "ICON_xy_17", id = 20017, 
logic_num = {20017}
, name = 45501}
, 
[20018] = {describe = 218546, icon = "ICON_xy_18", id = 20018, 
logic_num = {20018}
, name = 377177}
, 
[20019] = {describe = 314787, icon = "ICON_xy_19", id = 20019, 
logic_num = {20019}
, name = 498986}
, 
[20020] = {describe = 424303, icon = "ICON_xy_20", id = 20020, 
logic_num = {20020}
, name = 78969}
, 
[20021] = {describe = 273728, icon = "ICON_xy_21", id = 20021, 
logic_num = {20021}
, name = 221615}
, 
[20022] = {describe = 264060, icon = "ICON_xy_22", id = 20022, 
logic_num = {20022}
, name = 396237}
, 
[20023] = {describe = 131587, icon = "ICON_xy_23", id = 20023, 
logic_num = {20023}
, name = 483339}
, 
[20024] = {describe = 396220, icon = "ICON_xy_24", id = 20024, 
logic_num = {20024}
, name = 508954}
, 
[20025] = {describe = 185863, icon = "ICON_xy_25", id = 20025, 
logic_num = {20025}
, name = 393628}
, 
[20026] = {describe = 343244, icon = "ICON_xy_26", id = 20026, 
logic_num = {20026}
, name = 293108}
, 
[20027] = {describe = 125443, icon = "ICON_xy_27", id = 20027, 
logic_num = {20027}
, name = 273054}
, 
[20028] = {describe = 441693, icon = "ICON_xy_28", id = 20028, 
logic_num = {20028}
, name = 425833}
, 
[20029] = {describe = 401158, icon = "ICON_xy_29", id = 20029, 
logic_num = {20029}
, name = 104954}
, 
[20030] = {describe = 286773, icon = "ICON_xy_30", id = 20030, 
logic_num = {20030}
, name = 274433}
, 
[20031] = {describe = 71063, icon = "ICON_root_31", id = 20031, 
logic_num = {20031}
, name = 86711}
, 
[20032] = {describe = 469240, icon = "ICON_root_32", id = 20032, 
logic_num = {20032}
, name = 17085}
, 
[20033] = {describe = 9487, icon = "ICON_root_33", id = 20033, 
logic_num = {20033}
, name = 114134}
, 
[20034] = {describe = 49673, icon = "ICON_root_34", id = 20034, 
logic_num = {20034}
, name = 11768}
, 
[20035] = {describe = 502431, icon = "ICON_root_35", id = 20035, 
logic_num = {20035}
, name = 57336}
, 
[20036] = {describe = 91216, icon = "ICON_root_36", id = 20036, 
logic_num = {20036}
, name = 28333}
, 
[20037] = {describe = 477471, icon = "ICON_root_37", id = 20037, 
logic_num = {20037}
, name = 444554}
, 
[20038] = {describe = 163531, icon = "ICON_root_38", id = 20038, 
logic_num = {20038}
, name = 487003}
, 
[20039] = {describe = 380366, icon = "ICON_root_39", id = 20039, 
logic_num = {20039}
, name = 68151}
, 
[20040] = {describe = 373110, icon = "ICON_root_40", id = 20040, 
logic_num = {20040}
, name = 306796}
, 
[20041] = {describe = 373637, icon = "ICON_root_41", id = 20041, 
logic_num = {20041}
, name = 57336}
, 
[20042] = {describe = 127301, icon = "ICON_root_42", id = 20042, 
logic_num = {20042}
, name = 444554}
, 
[20043] = {describe = 2929, icon = "ICON_root_43", id = 20043, 
logic_num = {20043}
, name = 364477}
, 
[20044] = {describe = 53462, icon = "ICON_root_44", id = 20044, 
logic_num = {20044}
, name = 257551}
, 
[20045] = {describe = 505387, icon = "ICON_root_45", id = 20045, 
logic_num = {20045}
, name = 439530}
, 
[20046] = {describe = 388515, icon = "ICON_root_46", id = 20046, 
logic_num = {20046}
, name = 182585}
, 
[20047] = {describe = 106367, icon = "ICON_root_47", id = 20047, 
logic_num = {20047}
, name = 269299}
, 
[20048] = {describe = 332244, icon = "ICON_root_48", id = 20048, 
logic_num = {20048}
, name = 408092}
, 
[20049] = {describe = 186644, icon = "ICON_root_49", id = 20049, 
logic_num = {20049}
, name = 56843}
, 
[20050] = {describe = 464334, icon = "ICON_root_50", id = 20050, 
logic_num = {20050}
, name = 350937}
, 
[20051] = {describe = 208938, icon = "ICON_root_51", id = 20051, 
logic_num = {20051}
, name = 497517}
, 
[20052] = {describe = 197177, icon = "ICON_xy_52", id = 20052, 
logic_num = {20052, 20053}
, name = 399698}
, 
[20053] = {describe = 29615, icon = "ICON_xy_53", id = 20053, 
logic_num = {20054, 20055}
, name = 105865}
, 
[20056] = {describe = 85245, icon = "ICON_xy_1", id = 20056, 
logic_num = {20056}
, name = 166413}
, 
[20057] = {describe = 189475, icon = "ICON_4T_2", id = 20057, 
logic_num = {20057}
, name = 127079}
, 
[20058] = {describe = 483416, icon = "ICON_4T_3", id = 20058, 
logic_num = {20058}
, name = 64710}
, 
[20059] = {describe = 161775, icon = "ICON_4T_1", id = 20059, 
logic_num = {20059}
, name = 45160}
, 
[20060] = {describe = 501503, icon = "ICON_4T_4", id = 20060, 
logic_num = {20060}
, name = 431937}
, 
[20061] = {describe = 75687, icon = "ICON_4T_5", id = 20061, 
logic_num = {20061}
, name = 384218}
, 
[20062] = {describe = 334777, icon = "ICON_4T_6", id = 20062, 
logic_num = {20062}
, name = 274481}
, 
[20063] = {describe = 453990, icon = "ICON_4T_7", id = 20063, 
logic_num = {20063, 20064}
, name = 220563}
, 
[20065] = {describe = 74439, icon = "ICON_4T_8", id = 20065, 
logic_num = {20065, 20066}
, name = 388496}
, 
[20067] = {describe = 93997, icon = "ICON_4T_9", id = 20067, 
logic_num = {20067}
, name = 256410}
, 
[20068] = {describe = 173077, icon = "ICON_4T_10", id = 20068, logic = 8, logic_num = __rt_2, logic_per = __rt_14, name = 243160}
, 
[20069] = {describe = 393920, icon = "ICON_4T_11", id = 20069, logic = 36, 
logic_num = {20077, 20070}
, name = 277943, tigger_type = 3}
, 
[20070] = {describe = 291469, icon = "recover", id = 20070, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 5, logic_per = __rt_3, name = 467890, tigger_type = 3}
, 
[20071] = {describe = 340896, icon = "maxhp+", id = 20071, is_battleShow = false, is_listshow = false, is_onboard = false, 
logic_num = {20071}
, name = 340896, tigger_type = 3}
, 
[20072] = {describe = 504427, icon = "maxhp+", id = 20072, is_battleShow = false, is_listshow = false, is_onboard = false, 
logic_num = {20072}
, name = 504427, tigger_type = 3}
, 
[20073] = {describe = 29409, icon = "maxhp-", id = 20073, is_battleShow = false, is_listshow = false, is_onboard = false, 
logic_num = {20073}
, name = 29409, tigger_type = 3}
, 
[20074] = {describe = 390166, icon = "maxhp-", id = 20074, is_battleShow = false, is_listshow = false, is_onboard = false, 
logic_num = {20074}
, name = 390166, tigger_type = 3}
, 
[20075] = {describe = 143373, icon = "maxhp-", id = 20075, is_battleShow = false, is_listshow = false, is_onboard = false, 
logic_num = {20075}
, name = 143373, tigger_type = 3}
, 
[20076] = {describe = 406200, icon = "recover", id = 20076, is_battleShow = false, is_onboard = false, logic = 4, 
logic_per = {15}
, name = 305070, tigger_type = 3}
, 
[20077] = {describe = 235222, icon = "ICON_4T_10", id = 20077, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, logic = 8, logic_num = __rt_2, logic_per = __rt_14, name = 15063}
, 
[108000] = {describe = 177970, icon = "stronger", id = 108000, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, 
logic_num = {108000}
, name = 363151}
, 
[108003] = {describe = 506193, icon = "stronger", id = 108003, is_battleShow = false, is_listshow = false, is_onboard = false, is_show = false, 
logic_num = {108003}
, name = 352829}
}
local __default_values = {describe = 163692, icon = "hp", id = 100, is_battleShow = true, is_listshow = true, is_onboard = true, is_show = true, logic = 9, logic_num = __rt_1, logic_per = __rt_1, name = 383303, tigger_type = 1}
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

