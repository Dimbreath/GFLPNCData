-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1}
local __rt_2 = {}
local __rt_3 = {12, 8}
local __rt_4 = {60000}
local __rt_5 = {60001}
local __rt_6 = {5, 8}
local __rt_7 = {2, 5, 8}
local __rt_8 = {10}
local __rt_9 = {4}
local __rt_10 = {502, 200201, 200202}
local __rt_11 = {6}
local __rt_12 = {512, 201201, 201202}
local __rt_13 = {9, 4}
local __rt_14 = {2, 3}
local __rt_15 = {7}
local __rt_16 = {8, 2}
local __rt_17 = {509, 200901, 200902, 200903}
local __rt_18 = {12, 6}
local __rt_19 = {510, 200901, 201002, 201001, 201003}
local __rt_20 = {12, 4}
local __rt_21 = {519, 201901, 201902, 201903, 201904}
local __rt_22 = {520, 202001, 202002, 202003}
local __rt_23 = {532, 203201, 203202, 203203}
local __rt_24 = {201903, 201904}
local __rt_25 = {202003}
local monster = {
[100] = {career = 1, 
enemy_skill = {70000}
, info = 89415, isShowInfoBar = false, move_spd = 0, name = 53962, src_id = 3008}
, 
[101] = {career = 1, 
enemy_skill = {70001}
, id = 101, info = 89415, isShowInfoBar = false, move_spd = 0, name = 53962, src_id = 3008}
, 
[102] = {career = 4, 
enemy_skill = {519, 201901, 201902, 201905, 201906}
, id = 102, info = 24116, intensity = 4, monster_tag = __rt_3, move_spd = 180, name = 445870, src_id = 2019}
, 
[1000] = {career = 1, contain_action = false, id = 1000, info = 363958, intensity = 0, isShowInfoBar = false, isShowStateBar = false, move_spd = 0, name = 224477, range = 10, src_id = 3001}
, 
[1001] = {contain_action = false, enemy_skill = __rt_5, id = 1001, info = 303651, intensity = 0, isShowInfoBar = false, move_spd = 0, name = 456952, range = 10, src_id = 3002}
, 
[1002] = {career = 1, contain_action = false, id = 1002, info = 521099, intensity = 0, isShowInfoBar = false, isShowStateBar = false, move_spd = 0, name = 281147, range = 10, src_id = 3005}
, 
[1003] = {career = 1, contain_action = false, 
enemy_skill = {60002}
, id = 1003, info = 363915, intensity = 0, isShowInfoBar = false, move_spd = 0, name = 132468, range = 10, src_id = 3006}
, 
[1004] = {career = 1, contain_action = false, id = 1004, info = 363958, intensity = 0, isShowInfoBar = false, isShowStateBar = false, move_spd = 0, name = 224477, range = 10, src_id = 3003}
, 
[1005] = {contain_action = false, enemy_skill = __rt_5, id = 1005, info = 303651, intensity = 0, isShowInfoBar = false, move_spd = 0, name = 456952, range = 10, src_id = 3004}
, 
[20000] = {career = 1, 
enemy_skill = {508, 200802}
, id = 20000, info = 164695, intensity = 2, monster_tag = __rt_6, name = 343530, src_id = 2008}
, 
[20001] = {career = 1, 
enemy_skill = {508, 200801, 200802}
, id = 20001, info = 421258, intensity = 2, monster_tag = __rt_6, name = 343530, src_id = 2008}
, 
[20002] = {career = 1, 
enemy_skill = {505, 200501, 200502, 200503}
, id = 20002, info = 488094, intensity = 3, monster_tag = __rt_7, name = 335946, src_id = 2005}
, 
[20003] = {career = 1, 
enemy_skill = {511, 201101, 201103}
, id = 20003, info = 7919, move_spd = 300, name = 28620, src_id = 2011}
, 
[20004] = {
enemy_skill = {502, 200201, 200205}
, id = 20004, info = 301484, monster_tag = __rt_8, move_spd = 300, name = 522987, range = 2, src_id = 2002}
, 
[20005] = {career = 3, 
enemy_skill = {507, 200701, 200702}
, id = 20005, info = 80477, monster_tag = __rt_9, move_spd = 225, name = 43724, src_id = 2007}
, 
[20006] = {career = 1, 
enemy_skill = {511, 201101, 201102}
, id = 20006, info = 58161, move_spd = 300, name = 368858, src_id = 2016}
, 
[20007] = {enemy_skill = __rt_10, id = 20007, info = 840, monster_tag = __rt_11, name = 251695, range = 2, src_id = 2002}
, 
[20008] = {camp = 3, enemy_skill = __rt_12, id = 20008, info = 44055, intensity = 2, monster_tag = __rt_13, name = 269303, range = 3, src_id = 2012}
, 
[20009] = {camp = 3, enemy_skill = __rt_12, id = 20009, info = 474186, intensity = 2, monster_tag = __rt_13, name = 269303, range = 3, src_id = 2012}
, 
[20010] = {career = 3, 
enemy_skill = {507, 200302, 200701}
, id = 20010, info = 112153, monster_tag = __rt_9, move_spd = 225, name = 272858, src_id = 2015}
, 
[20011] = {career = 3, 
enemy_skill = {504, 200401, 200402, 200403}
, id = 20011, info = 95134, intensity = 3, 
monster_tag = {2, 8, 4}
, move_spd = 300, name = 146640, src_id = 2004}
, 
[20012] = {career = 4, 
enemy_skill = {503, 200301}
, id = 20012, info = 451925, intensity = 2, monster_tag = __rt_14, move_spd = 300, name = 397185}
, 
[20013] = {career = 4, 
enemy_skill = {503, 200301, 200303}
, id = 20013, info = 95641, intensity = 2, monster_tag = __rt_14, move_spd = 300, name = 397185}
, 
[20014] = {career = 4, 
enemy_skill = {501, 200102, 200103}
, id = 20014, info = 48053, monster_tag = __rt_14, move_spd = 300, name = 105666, src_id = 2001}
, 
[20015] = {career = 4, 
enemy_skill = {501, 200101, 200102}
, id = 20015, info = 56680, monster_tag = __rt_14, move_spd = 300, name = 124780, src_id = 2013}
, 
[20016] = {career = 5, 
enemy_skill = {506, 200602, 200603}
, id = 20016, info = 140524, monster_tag = __rt_15, move_spd = 300, name = 431524, range = 10, src_id = 2006}
, 
[20017] = {career = 5, 
enemy_skill = {506, 200601, 200602}
, id = 20017, info = 243719, monster_tag = __rt_15, move_spd = 300, name = 434466, range = 10, src_id = 2017}
, 
[20018] = {career = 4, 
enemy_skill = {503, 200301, 200302, 200303}
, id = 20018, info = 451925, intensity = 4, monster_tag = __rt_14, move_spd = 300, name = 285033}
, 
[20019] = {career = 3, 
enemy_skill = {507}
, id = 20019, info = 170294, monster_tag = __rt_8, move_spd = 225, name = 43724, src_id = 2007}
, 
[20020] = {career = 1, 
enemy_skill = {508, 200801, 200803}
, id = 20020, info = 164695, intensity = 4, monster_tag = __rt_6, name = 343530, src_id = 2008}
, 
[20021] = {enemy_skill = __rt_10, id = 20021, info = 408605, monster_tag = __rt_16, move_spd = 300, name = 251695, range = 2, src_id = 2014}
, 
[20022] = {career = 1, 
enemy_skill = {511}
, id = 20022, info = 281033, monster_tag = __rt_8, move_spd = 300, name = 28620, src_id = 2011}
, 
[20023] = {camp = 3, 
enemy_skill = {512}
, id = 20023, info = 44055, intensity = 2, monster_tag = __rt_8, name = 269303, range = 3, src_id = 2012}
, 
[20024] = {career = 4, 
enemy_skill = {503}
, id = 20024, info = 451925, intensity = 2, monster_tag = __rt_8, move_spd = 300, name = 397185}
, 
[20025] = {career = 4, 
enemy_skill = {501}
, id = 20025, info = 173571, monster_tag = __rt_8, move_spd = 300, name = 105666, src_id = 2001}
, 
[20026] = {career = 1, 
enemy_skill = {508}
, id = 20026, info = 164695, intensity = 2, monster_tag = __rt_8, name = 343530, src_id = 2008}
, 
[20027] = {career = 3, 
enemy_skill = {507, 200701}
, id = 20027, info = 170294, monster_tag = __rt_9, move_spd = 225, name = 43724, src_id = 2007}
, 
[20028] = {career = 3, enemy_skill = __rt_17, id = 20028, info = 74560, intensity = 4, monster_tag = __rt_18, move_spd = 225, name = 139436, src_id = 2009}
, 
[20029] = {career = 3, 
enemy_skill = {510, 200901, 201002, 201001, 200903}
, id = 20029, info = 506745, intensity = 4, monster_tag = __rt_18, move_spd = 225, name = 345371, src_id = 2010}
, 
[20030] = {career = 3, enemy_skill = __rt_19, id = 20030, info = 314397, intensity = 4, monster_tag = __rt_20, move_spd = 225, name = 155250, src_id = 2010}
, 
[20031] = {career = 3, 
enemy_skill = {509, 201001, 201003}
, id = 20031, info = 302435, intensity = 4, monster_tag = __rt_20, move_spd = 225, name = 482270, src_id = 2010}
, 
[20032] = {career = 3, 
enemy_skill = {201801}
, id = 20032, info = 467586, intensity = 2, 
monster_tag = {11}
, move_spd = 225, name = 379096, src_id = 2018}
, 
[20033] = {career = 4, enemy_skill = __rt_21, id = 20033, info = 24116, intensity = 4, monster_tag = __rt_3, move_spd = 180, name = 445870, src_id = 2019}
, 
[20034] = {enemy_skill = __rt_22, id = 20034, intensity = 4, monster_tag = __rt_18, move_spd = 120, range = 10, src_id = 2020}
, 
[20035] = {career = 3, 
enemy_skill = {521, 202101, 202102, 202103}
, id = 20035, info = 480582, intensity = 4, monster_tag = __rt_2, name = 116192, src_id = 2021}
, 
[20036] = {career = 4, 
enemy_skill = {522, 202201, 202202, 202203}
, id = 20036, info = 422318, intensity = 3, 
monster_tag = {12, 11}
, name = 186977, src_id = 2022}
, 
[20037] = {career = 5, 
enemy_skill = {523, 202301, 202302, 202303}
, id = 20037, info = 34732, intensity = 3, 
monster_tag = {12, 7, 13}
, name = 115752, range = 2, src_id = 2023}
, 
[20038] = {career = 3, 
enemy_skill = {524, 202401, 202402}
, id = 20038, info = 437188, intensity = 2, 
monster_tag = {13}
, move_spd = 225, name = 100537, src_id = 2024}
, 
[20039] = {career = 3, 
enemy_skill = {525, 202501, 202502}
, id = 20039, info = 185142, intensity = 2, monster_tag = __rt_11, move_spd = 225, name = 201005, src_id = 2025}
, 
[20040] = {
enemy_skill = {526, 202601, 202602, 202603}
, id = 20040, info = 128640, intensity = 3, monster_tag = __rt_11, move_spd = 90, name = 100975, range = 10, src_id = 2026}
, 
[20041] = {camp = 2, career = 4, 
enemy_skill = {529, 202901}
, id = 20041, info = 31782, monster_tag = __rt_9, move_spd = 225, name = 242499, src_id = 2029}
, 
[20042] = {camp = 2, career = 1, 
enemy_skill = {530, 203001}
, id = 20042, info = 202329, name = 311710, src_id = 2030}
, 
[20043] = {camp = 2, career = 4, 
enemy_skill = {531, 203101, 203102}
, id = 20043, info = 314228, intensity = 2, monster_tag = __rt_11, move_spd = 225, name = 128665, src_id = 2031}
, 
[20044] = {camp = 2, enemy_skill = __rt_23, id = 20044, info = 359836, intensity = 3, monster_tag = __rt_18, move_spd = 90, name = 77751, range = 10, src_id = 2032}
, 
[20045] = {
enemy_skill = {520, 202001, 202002, 202003, 202004}
, id = 20045, intensity = 4, monster_tag = __rt_18, move_spd = 120, range = 10, src_id = 2020}
, 
[20046] = {
enemy_skill = {536, 203601, 203603}
, id = 20046, info = 22144, monster_tag = __rt_9, move_spd = 75, name = 343055, range = 10, src_id = 2036}
, 
[20047] = {career = 5, 
enemy_skill = {535, 203501, 203502}
, id = 20047, info = 83629, intensity = 2, monster_tag = __rt_15, name = 437235, range = 10, src_id = 2035}
, 
[20048] = {
enemy_skill = {536, 203601, 203602}
, id = 20048, info = 41138, monster_tag = __rt_9, move_spd = 75, name = 471995, range = 10, src_id = 2038}
, 
[20049] = {camp = 2, 
enemy_skill = {502, 200203}
, id = 20049, info = 147620, monster_tag = __rt_16, move_spd = 300, name = 55283, range = 5, src_id = 2039}
, 
[30000] = {blood_bar_num = 1, career = 1, 
enemy_skill = {505, 300001, 300002, 300003, 200001}
, id = 30000, info = 488094, intensity = 3, monster_tag = __rt_7, name = 498732, src_id = 2005}
, 
[30001] = {blood_bar_num = 1, career = 3, enemy_skill = __rt_17, id = 30001, info = 74560, intensity = 4, monster_tag = __rt_18, move_spd = 225, name = 139436, 
skill_array = {200903, 200902}
, src_id = 2009}
, 
[30002] = {blood_bar_num = 1, career = 3, enemy_skill = __rt_19, id = 30002, info = 314397, intensity = 4, monster_tag = __rt_20, move_spd = 225, name = 155250, 
skill_array = {201003, 201002}
, src_id = 2010}
, 
[30003] = {blood_bar_num = 1, career = 4, enemy_skill = __rt_21, id = 30003, info = 24116, intensity = 4, monster_tag = __rt_3, move_spd = 180, name = 445870, skill_array = __rt_24, src_id = 2019}
, 
[30004] = {blood_bar_num = 1, enemy_skill = __rt_22, id = 30004, intensity = 4, monster_tag = __rt_18, move_spd = 120, range = 10, skill_array = __rt_25, src_id = 2020}
, 
[30005] = {blood_bar_num = 1, camp = 2, enemy_skill = __rt_23, id = 30005, info = 65533, intensity = 3, monster_tag = __rt_18, move_spd = 90, name = 77751, range = 10, src_id = 2032}
, 
[40000] = {blood_bar_num = 1, career = 1, 
enemy_skill = {70002}
, id = 40000, info = 367696, move_spd = 0, name = 192338, src_id = 3009}
, 
[40001] = {blood_bar_num = 1, career = 1, 
enemy_skill = {70003}
, id = 40001, info = 267422, move_spd = 0, name = 188984, src_id = 3010}
, 
[40002] = {career = 3, 
enemy_skill = {525, 70004}
, id = 40002, info = 192263, intensity = 2, monster_tag = __rt_11, move_spd = 225, name = 235669, src_id = 2025}
, 
[99999] = {
enemy_skill = {502, 200204}
, id = 99999, info = 408605, monster_tag = __rt_16, name = 503272, range = 5, src_id = 2014}
, 
[300030] = {blood_bar_num = 1, career = 4, 
enemy_skill = {519, 2019010, 201902, 201903, 201904}
, id = 300030, info = 24116, intensity = 4, monster_tag = __rt_3, move_spd = 180, name = 445870, skill_array = __rt_24, src_id = 2019}
, 
[300040] = {blood_bar_num = 1, 
enemy_skill = {520, 2020010, 202002, 202003}
, id = 300040, intensity = 4, monster_tag = __rt_18, move_spd = 120, range = 10, skill_array = __rt_25, src_id = 2020}
}
local __default_values = {blood_bar_num = 0, camp = 1, career = 2, contain_action = true, enemy_skill = __rt_4, id = 100, info = 194294, intensity = 1, isShowInfoBar = true, isShowStateBar = true, monster_tag = __rt_1, move_spd = 150, name = 20386, range = 1, skill_array = __rt_2, src_id = 2003}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in (_ENV.pairs)(monster) do
  (_ENV.setmetatable)(v, base)
end
local __rawdata = {__basemetatable = base}
;
(_ENV.setmetatable)(monster, {__index = __rawdata})
return monster

