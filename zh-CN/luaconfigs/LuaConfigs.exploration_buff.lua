-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1}
local __rt_2 = {}
local __rt_3 = {3}
local __rt_4 = {108010}
local exploration_buff = {
[100] = {describe = 208640, icon = "ICON_g_buff_16", 
logic_num = {108009}
, name = 120039, tigger_type = 3}
, 
[101] = {describe = 165058, icon = "ICON_g_buff_17", id = 101, is_onboard = true, logic = 8, 
logic_num = {1003}
, logic_per = 50, name = 512215, tigger_type = 3}
, 
[102] = {describe = 284047, id = 102, is_battleShow = false, is_show = false, logic = 11, logic_num = __rt_1, name = 288393, tigger_type = 3}
, 
[103] = {describe = 375612, id = 103, is_battleShow = false, is_show = false, logic = 12, logic_num = __rt_1, name = 449165, tigger_type = 3}
, 
[104] = {describe = 461077, id = 104, is_battleShow = false, is_show = false, logic = 13, 
logic_num = {1, 50}
, name = 497664, tigger_type = 3}
, 
[105] = {describe = 501670, id = 105, is_battleShow = false, is_show = false, logic = 14, logic_num = __rt_1, name = 158492, tigger_type = 3}
, 
[106] = {describe = 85486, icon = "ICON_g_buff_16", id = 106, 
logic_num = {108007}
, name = 109146, tigger_type = 3}
, 
[107] = {describe = 486620, icon = "ICON_g_buff_16", id = 107, 
logic_num = {108008}
, name = 212675, tigger_type = 3}
, 
[108] = {describe = 413120, icon = "ICON_g_buff_7", id = 108, is_onboard = true, logic = 15, logic_num = __rt_1, name = 255937}
, 
[109] = {describe = 198869, icon = "ICON_g_buff_7", id = 109, is_battleShow = false, is_show = false, logic = 16, logic_num = __rt_1, name = 443794, tigger_type = 3}
, 
[110] = {describe = 370908, icon = "ICON_g_buff_7", id = 110, logic = 17, 
logic_num = {0}
, logic_per = 1, name = 146187, tigger_type = 3}
, 
[111] = {describe = 129444, icon = "ICON_g_buff_7", id = 111, is_show = false, logic = 18, logic_per = 10, name = 388284, tigger_type = 3}
, 
[112] = {describe = 2417, icon = "ICON_g_buff_18", id = 112, is_battleShow = false, is_show = false, logic = 16, 
logic_num = {5}
, name = 188998, tigger_type = 3}
, 
[1001] = {describe = 86809, id = 1001, is_battleShow = false, is_show = false, logic = 19, logic_per = -30, name = 27916, tigger_type = 3}
, 
[1002] = {describe = 284035, id = 1002, is_battleShow = false, is_show = false, logic = 19, logic_per = -50, name = 357433, tigger_type = 3}
, 
[1003] = {describe = 266096, id = 1003, is_battleShow = false, is_show = false, logic = 20, logic_num = __rt_1, name = 134860}
, 
[1004] = {describe = 257333, id = 1004, is_battleShow = false, is_show = false, logic = 21, logic_num = __rt_3, name = 464377, tigger_type = 3}
, 
[1005] = {describe = 311975, id = 1005, is_battleShow = false, is_show = false, logic = 22, logic_per = -30, name = 227158}
, 
[1006] = {describe = 429301, id = 1006, is_battleShow = false, is_show = false, logic = 22, logic_per = -50, name = 32387}
, 
[1007] = {describe = 54016, id = 1007, is_battleShow = false, is_show = false, logic = 23, logic_per = 70, name = 159038, tigger_type = 3}
, 
[1008] = {describe = 62863, id = 1008, is_battleShow = false, is_show = false, logic = 23, logic_per = 80, name = 488555, tigger_type = 3}
, 
[1009] = {describe = 361565, id = 1009, is_battleShow = false, is_show = false, logic = 24, logic_num = __rt_1, name = 238767, tigger_type = 3}
, 
[1010] = {describe = 330187, id = 1010, is_battleShow = false, is_show = false, logic = 24, 
logic_num = {2}
, name = 43996, tigger_type = 3}
, 
[1011] = {describe = 16096, id = 1011, is_battleShow = false, is_show = false, logic = 25, logic_num = __rt_1, name = 517030}
, 
[1012] = {describe = 296066, id = 1012, is_battleShow = false, is_show = false, logic = 26, 
logic_num = {50}
, name = 401634, tigger_type = 3}
, 
[1013] = {describe = 116343, id = 1013, is_battleShow = false, is_show = false, logic = 27, logic_num = __rt_1, name = 23549, tigger_type = 3}
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
[6007] = {icon = "hp-", id = 6007, is_battleShow = false, logic = 4, logic_per = -30, name = 62562, tigger_type = 3}
, 
[6008] = {describe = 387023, icon = "recover", id = 6008, is_battleShow = false, logic = 4, logic_per = 30, name = 285893, tigger_type = 3}
, 
[6009] = {describe = 293392, icon = "recover", id = 6009, is_battleShow = false, logic = 5, logic_per = 80, name = 243035, tigger_type = 3}
, 
[6010] = {describe = 490754, icon = "hp-", id = 6010, is_battleShow = false, logic = 4, logic_per = -10, name = 389624, tigger_type = 3}
, 
[6011] = {describe = 327223, icon = "hp-", id = 6011, is_battleShow = false, logic = 4, logic_per = -20, name = 226093, tigger_type = 3}
, 
[6012] = {describe = 270718, icon = "ICON_g_atn_1", id = 6012, logic_num = __rt_4, name = 75752}
, 
[6013] = {describe = 327223, icon = "hp-", id = 6013, is_battleShow = false, logic = 4, logic_per = -20, name = 226093, tigger_type = 3}
, 
[6014] = {describe = 26266, icon = "recover", id = 6014, is_battleShow = false, logic = 4, logic_per = 20, name = 141539, tigger_type = 3}
, 
[6015] = {icon = "hp-", id = 6015, is_battleShow = false, logic = 4, logic_per = -30, name = 62562, tigger_type = 3}
, 
[6016] = {describe = 161, icon = "hp-", id = 6016, is_battleShow = false, logic = 4, logic_per = -40, name = 423319, tigger_type = 3}
, 
[6017] = {describe = 360918, icon = "hp-", id = 6017, is_battleShow = false, logic = 4, logic_per = -50, name = 259788, tigger_type = 3}
, 
[6018] = {describe = 270718, icon = "ICON_g_atn_1", id = 6018, is_battleShow = false, logic_num = __rt_4, name = 75752}
, 
[6019] = {describe = 465338, icon = "ICON_g_hp_1", id = 6019, is_battleShow = false, 
logic_num = {108011}
, name = 512595}
, 
[7001] = {describe = 34727, icon = "ICON_g_buff_5", id = 7001, logic = 1, logic_per = 30, name = 302907, tigger_type = 2}
, 
[8000] = {describe = 69357, icon = "ICON_g_buff_3", id = 8000, logic = 2, logic_per = 100, name = 340833}
, 
[8001] = {describe = 506448, icon = "ICON_g_buff_16", id = 8001, 
logic_num = {108001}
, name = 511437}
, 
[8002] = {describe = 100045, icon = "attack", id = 8002, is_battleShow = false, 
logic_num = {108002}
, name = 120559}
, 
[8003] = {describe = 440917, icon = "ICON_g_buff_15", id = 8003, logic = 2, logic_per = 300, name = 146154}
, 
[8005] = {describe = 352092, icon = "ICON_g_buff_6", id = 8005, logic = 8, logic_num = __rt_1, logic_per = 100}
, 
[8006] = {describe = 411278, icon = "ICON_g_buff_1", id = 8006, is_onboard = true, logic = 3, logic_num = __rt_3, logic_per = 50, name = 11420}
, 
[8007] = {describe = 502878, icon = "ICON_g_buff_6", id = 8007, is_onboard = true, logic = 8, logic_num = __rt_1, logic_per = 200}
, 
[8008] = {describe = 163223, icon = "ICON_g_buff_6", id = 8008, is_onboard = true, logic = 8, logic_num = __rt_1, logic_per = 100}
, 
[20001] = {describe = 250524, icon = "ICON_xy_1", id = 20001, is_onboard = true, 
logic_num = {20001}
, name = 351144}
, 
[20002] = {describe = 448534, icon = "ICON_xy_2", id = 20002, is_onboard = true, 
logic_num = {20002}
, name = 195958}
, 
[20003] = {describe = 228833, icon = "ICON_xy_3", id = 20003, is_onboard = true, 
logic_num = {20003}
, name = 476326}
, 
[20004] = {describe = 489168, icon = "ICON_xy_4", id = 20004, is_onboard = true, 
logic_num = {20004}
, name = 119410}
, 
[20005] = {describe = 302591, icon = "ICON_xy_5", id = 20005, is_onboard = true, 
logic_num = {20005}
, name = 19033}
, 
[20006] = {describe = 463845, icon = "ICON_xy_6", id = 20006, is_onboard = true, 
logic_num = {20006}
, name = 91553}
, 
[20007] = {describe = 160715, icon = "ICON_xy_7", id = 20007, is_onboard = true, 
logic_num = {20007}
, name = 270754}
, 
[20008] = {describe = 35350, icon = "ICON_xy_8", id = 20008, is_onboard = true, 
logic_num = {20008}
, name = 380502}
, 
[20009] = {describe = 12276, icon = "ICON_xy_9", id = 20009, is_onboard = true, 
logic_num = {20009}
, name = 480518}
, 
[20010] = {describe = 422738, icon = "ICON_xy_10", id = 20010, is_onboard = true, 
logic_num = {20010}
, name = 68914}
, 
[20011] = {describe = 171135, icon = "ICON_xy_11", id = 20011, is_onboard = true, 
logic_num = {20011}
, name = 463864}
, 
[20012] = {describe = 406794, icon = "ICON_xy_12", id = 20012, is_onboard = true, 
logic_num = {20012}
, name = 340128}
, 
[20013] = {describe = 365791, icon = "ICON_xy_13", id = 20013, is_onboard = true, 
logic_num = {20013}
, name = 465710}
, 
[20014] = {describe = 358351, icon = "ICON_xy_14", id = 20014, is_onboard = true, 
logic_num = {20014}
, name = 114692}
, 
[20015] = {describe = 402334, icon = "ICON_xy_15", id = 20015, is_onboard = true, 
logic_num = {20015}
, name = 420197}
, 
[20016] = {describe = 291681, icon = "ICON_xy_16", id = 20016, is_onboard = true, 
logic_num = {20016}
, name = 446478}
, 
[20017] = {describe = 308466, icon = "ICON_xy_17", id = 20017, is_onboard = true, 
logic_num = {20017}
, name = 45501}
, 
[20018] = {describe = 218546, icon = "ICON_xy_18", id = 20018, is_onboard = true, 
logic_num = {20018}
, name = 377177}
, 
[20019] = {describe = 314787, icon = "ICON_xy_19", id = 20019, is_onboard = true, 
logic_num = {20019}
, name = 498986}
, 
[20020] = {describe = 424303, icon = "ICON_xy_20", id = 20020, is_onboard = true, 
logic_num = {20020}
, name = 78969}
, 
[20021] = {describe = 273728, icon = "ICON_xy_21", id = 20021, is_onboard = true, 
logic_num = {20021}
, name = 221615}
, 
[108000] = {describe = 177970, icon = "stronger", id = 108000, is_battleShow = false, is_show = false, 
logic_num = {108000}
, name = 363151}
, 
[108003] = {describe = 506193, icon = "stronger", id = 108003, is_battleShow = false, is_show = false, 
logic_num = {108003}
, name = 352829}
}
local __default_values = {describe = 163692, icon = "hp", id = 100, is_battleShow = true, is_onboard = false, is_show = true, logic = 9, logic_num = __rt_2, logic_per = 0, name = 383303, tigger_type = 1}
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

