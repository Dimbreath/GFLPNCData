-- params : ...
-- function num : 0 , upvalues : _ENV
local exploration_buff = {
[100] = {describe = 208640, icon = "ICON_g_buff_16", name = 120039}
, 
[101] = {describe = 165058, icon = "ICON_g_buff_17", id = 101, logic = 8, logic_per = 50, name = 512215}
, 
[102] = {describe = 284047, icon = "hp", id = 102, is_show = false, logic = 11, name = 288393}
, 
[103] = {describe = 375612, icon = "hp", id = 103, is_show = false, logic = 12, name = 449165}
, 
[104] = {describe = 461077, icon = "hp", id = 104, is_show = false, logic = 13, name = 497664}
, 
[105] = {describe = 501670, icon = "hp", id = 105, is_show = false, logic = 14, name = 158492}
, 
[106] = {describe = 85486, icon = "ICON_g_buff_16", id = 106, name = 109146}
, 
[107] = {describe = 486620, icon = "ICON_g_buff_16", id = 107, name = 212675}
, 
[108] = {describe = 413120, icon = "ICON_g_buff_7", id = 108, logic = 15, name = 255937, tigger_type = 1}
, 
[109] = {describe = 198869, icon = "ICON_g_buff_7", id = 109, is_show = false, logic = 16, name = 443794}
, 
[110] = {describe = 370908, icon = "ICON_g_buff_7", id = 110, logic = 17, logic_per = 1, name = 146187}
, 
[111] = {describe = 129444, icon = "ICON_g_buff_7", id = 111, is_show = false, logic = 18, logic_per = 10, name = 388284}
, 
[6003] = {describe = 297930, icon = "ICON_g_hp_1", id = 6003, name = 512595}
, 
[6004] = {describe = 41548, icon = "ICON_g_atn_1", id = 6004, name = 75752}
, 
[6005] = {describe = 434297, icon = "ICON_g_def_1", id = 6005, name = 75457}
, 
[6007] = {id = 6007, logic = 4, logic_per = -30, name = 62562}
, 
[6008] = {describe = 387023, icon = "recover", id = 6008, logic = 4, logic_per = 30, name = 285893}
, 
[6009] = {describe = 293392, icon = "recover", id = 6009, logic = 5, logic_per = 80, name = 243035}
, 
[6010] = {describe = 490754, id = 6010, logic = 4, logic_per = -10, name = 389624}
, 
[6011] = {describe = 327223, id = 6011, logic = 4, logic_per = -20, name = 226093}
, 
[6012] = {describe = 270718, icon = "ICON_g_atn_1", id = 6012, name = 75752, tigger_type = 1}
, 
[6013] = {describe = 327223, id = 6013, logic = 4, logic_per = -20, name = 226093}
, 
[6014] = {describe = 26266, icon = "recover", id = 6014, logic = 4, logic_per = 20, name = 141539}
, 
[6015] = {id = 6015, logic = 4, logic_per = -30, name = 62562}
, 
[6016] = {describe = 161, id = 6016, logic = 4, logic_per = -40, name = 423319}
, 
[6017] = {describe = 360918, id = 6017, logic = 4, logic_per = -50, name = 259788}
, 
[6018] = {describe = 270718, icon = "ICON_g_atn_1", id = 6018, name = 75752, tigger_type = 1}
, 
[6019] = {describe = 465338, icon = "ICON_g_hp_1", id = 6019, name = 512595, tigger_type = 1}
, 
[7001] = {describe = 34727, icon = "ICON_g_buff_5", id = 7001, logic = 1, logic_per = 30, name = 302907, tigger_type = 2}
, 
[8000] = {describe = 69357, icon = "ICON_g_buff_3", id = 8000, logic = 2, logic_per = 100, name = 340833, tigger_type = 1}
, 
[8001] = {describe = 506448, icon = "ICON_g_buff_16", id = 8001, name = 511437, tigger_type = 1}
, 
[8002] = {describe = 100045, icon = "attack", id = 8002, name = 120559, tigger_type = 1}
, 
[8003] = {describe = 440917, icon = "ICON_g_buff_15", id = 8003, logic = 2, logic_per = 300, name = 146154, tigger_type = 1}
, 
[8005] = {describe = 352092, icon = "ICON_g_buff_6", id = 8005, logic = 8, logic_per = 100, tigger_type = 1}
, 
[8006] = {describe = 411278, icon = "ICON_g_buff_1", id = 8006, logic = 3, logic_per = 50, name = 11420, tigger_type = 1}
, 
[8007] = {describe = 502878, icon = "ICON_g_buff_6", id = 8007, logic = 8, logic_per = 200, tigger_type = 1}
, 
[8008] = {describe = 163223, icon = "ICON_g_buff_6", id = 8008, logic = 8, logic_per = 100, tigger_type = 1}
, 
[108000] = {describe = 177970, icon = "stronger", id = 108000, is_show = false, name = 363151, tigger_type = 1}
, 
[108003] = {describe = 506193, icon = "stronger", id = 108003, is_show = false, name = 352829, tigger_type = 1}
}
local __default_values = {describe = 163692, icon = "hp-", id = 100, is_show = true, logic = 9, logic_per = 0, name = 383303, tigger_type = 3}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(exploration_buff) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(exploration_buff, {__index = __rawdata})
return exploration_buff

