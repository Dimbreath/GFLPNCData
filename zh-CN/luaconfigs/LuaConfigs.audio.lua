-- params : ...
-- function num : 0 , upvalues : _ENV
local audio = {
[5] = {id = 5, name = "But_Common_Click"}
, 
[7] = {id = 7, name = "Show_CharacterBorn", sheet = 7}
, 
[8] = {id = 8, name = "Atk_Anna_01", sheet = 3}
, 
[9] = {id = 9, name = "Atk_Fresnel_01", sheet = 4}
, 
[10] = {name = "Atk_Croque_01", sheet = 2}
, 
[11] = {id = 11, name = "Atk_Persicaria_01", sheet = 6}
, 
[12] = {id = 12, name = "Atk_Sol_01", sheet = 8}
, 
[13] = {id = 13, name = "Atk_Sol_02", sheet = 8}
, 
[14] = {id = 14, name = "Atk_Sol_03", sheet = 8}
, 
[15] = {id = 15, name = "Atk_Sol_04", sheet = 8}
, 
[16] = {id = 16, name = "Atk_Simo_01", sheet = 9}
, 
[17] = {id = 17, name = "Atk_Chi_01", sheet = 10, type = 3}
, 
[18] = {id = 18, name = "Atk_Maimai_01", sheet = 11}
, 
[19] = {id = 19, name = "Atk_Xin_01", sheet = 12}
, 
[20] = {id = 20, name = "Atk_Xin_02", sheet = 12}
, 
[21] = {id = 21, name = "Atk_Patience_01", sheet = 13}
, 
[22] = {id = 22, name = "Atk_Raider_01", sheet = 14}
, 
[23] = {id = 23, name = "Atk_Refactorer_01", sheet = 7}
, 
[24] = {id = 24, name = "Atk_Chong_01", sheet = 15}
, 
[25] = {id = 25, name = "Atk_Chong_02", sheet = 15}
, 
[26] = {id = 26, name = "Atk_Gangyi_01", sheet = 16}
, 
[27] = {id = 27, name = "Atk_Defender_01", sheet = 17}
, 
[28] = {id = 28, name = "Atk_Purger_01", sheet = 18}
, 
[29] = {id = 29, name = "Skill_Anna_01", sheet = 3}
, 
[30] = {id = 30, name = "Skill_Fresnel_01", sheet = 4, type = 3}
, 
[31] = {id = 31, name = "Skill_Fresnel_02", sheet = 4}
, 
[32] = {id = 32, name = "Skill_Fresnel_Passive", sheet = 4}
, 
[33] = {id = 33, name = "Skill_Croque_01", sheet = 2}
, 
[34] = {id = 34, name = "Skill_Croque_01_Loop", sheet = 2, type = 3}
, 
[35] = {id = 35, name = "Skill_Croque_01_Hit", sheet = 2}
, 
[36] = {id = 36, name = "Skill_Persicaria_01", sheet = 6}
, 
[37] = {id = 37, name = "Skill_Common_Healing", sheet = 7}
, 
[38] = {id = 38, name = "Skill_Sol_01", sheet = 8}
, 
[39] = {id = 39, name = "Skill_Sol_Passive", sheet = 8}
, 
[40] = {id = 40, name = "Skill_Simo_01", sheet = 9}
, 
[41] = {id = 41, name = "Skill_Simo_02", sheet = 9}
, 
[42] = {id = 42, name = "Skill_Chi_01", sheet = 10, type = 3}
, 
[43] = {id = 43, name = "Skill_Chi_Ex", sheet = 10}
, 
[44] = {id = 44, name = "Skill_Chi_Ex_Hit", sheet = 10}
, 
[45] = {id = 45, name = "Skill_Common_ExCast", sheet = 7}
, 
[46] = {id = 46, name = "Skill_Maimai_01_BS", sheet = 11}
, 
[47] = {id = 47, name = "Skill_Maimai_01", sheet = 11, type = 3}
, 
[48] = {id = 48, name = "Skill_Xin_01", sheet = 12}
, 
[49] = {id = 49, name = "Skill_Patience_01_BS", sheet = 13}
, 
[50] = {id = 50, name = "Skill_Patience_01_Cast", sheet = 13}
, 
[51] = {id = 51, name = "Skill_Raider_01_Cast", sheet = 14}
, 
[52] = {id = 52, name = "Skill_Raider_01_Hit", sheet = 14}
, 
[53] = {id = 53, name = "Skill_Chong_01", sheet = 15}
, 
[54] = {id = 54, name = "Skill_Gangyi_01", sheet = 16}
, 
[55] = {id = 55, name = "Skill_Defender_01", sheet = 17}
, 
[56] = {id = 56, name = "Skill_Purger_01", sheet = 18}
, 
[57] = {id = 57, name = "Atk_Banxsy_01", sheet = 19}
, 
[58] = {id = 58, name = "Atk_Jessie_01", sheet = 20}
, 
[59] = {id = 59, name = "Atk_Jessie_02", sheet = 20}
, 
[60] = {id = 60, name = "Atk_Gin_01", sheet = 21}
, 
[61] = {id = 61, name = "Atk_Evelyn_01", sheet = 22}
, 
[62] = {id = 62, name = "Atk_Evelyn_02", sheet = 22}
, 
[63] = {id = 63, name = "Atk_Groove_01", sheet = 23}
, 
[64] = {id = 64, sheet = 24}
, 
[65] = {id = 65, name = "Atk_Guardian_01", sheet = 25}
, 
[66] = {id = 66, name = "Atk_Guardian_02", sheet = 25}
, 
[67] = {id = 67, name = "Atk_Mala_01", sheet = 26}
, 
[68] = {id = 68, name = "Atk_Mala_02", sheet = 26}
, 
[69] = {id = 69, name = "Atk_Mala_03", sheet = 26}
, 
[70] = {id = 70, name = "Skill_Jessie_01_Start", sheet = 20}
, 
[71] = {id = 71, name = "Skill_Jessie_01_End", sheet = 20}
, 
[72] = {id = 72, name = "Skill_Gin_01_Start", sheet = 21}
, 
[73] = {id = 73, name = "Skill_Gin_01_Loop", sheet = 21, type = 3}
, 
[74] = {id = 74, name = "Skill_Evelyn_01_Start", sheet = 22}
, 
[75] = {id = 75, name = "Skill_Evelyn_Passive", sheet = 22}
, 
[76] = {id = 76, name = "Skill_Groove_01_Start", sheet = 23}
, 
[77] = {id = 77, name = "Skill_Groove_Loop_Passive", sheet = 23, type = 3}
, 
[78] = {id = 78, name = "Skill_Abstinence_01_Start", sheet = 24}
, 
[79] = {id = 79, name = "Skill_Abstinence_01_Loop", sheet = 24, type = 3}
, 
[80] = {id = 80, name = "Skill_Abstinence_01_Debuff", sheet = 24}
, 
[81] = {id = 81, name = "Skill_Abstinence_01_Hit", sheet = 24}
, 
[82] = {id = 82, name = "Skill_Guardian_01_Start", sheet = 25}
, 
[83] = {id = 83, name = "Skill_Guardian_01_Loop", sheet = 25, type = 3}
, 
[84] = {id = 84, name = "Skill_Mala_01_Start", sheet = 26}
, 
[85] = {id = 85, name = "Skill_Mala_01_Cast", sheet = 26, type = 3}
, 
[86] = {id = 86, name = "Skill_Mala_01_Hit", sheet = 26}
, 
[87] = {id = 87, name = "Skill_Mala_02_Start", sheet = 26}
, 
[88] = {id = 88, name = "Skill_Mala_02_Loop", sheet = 26, type = 3}
, 
[89] = {id = 89, name = "Skill_Mala_Passive_Start", sheet = 26}
, 
[90] = {id = 90, name = "Skill_Mala_Passive_End", sheet = 26}
, 
[91] = {id = 91, name = "Skill_Refactorer_01_Start", sheet = 27}
, 
[92] = {id = 92, name = "Skill_Refactorer_01_Loop", sheet = 27, type = 3}
, 
[93] = {id = 93, name = "Skill_Anna_Ex_Start", sheet = 3}
, 
[94] = {id = 94, name = "Skill_Anna_Ex_Cast", sheet = 3}
, 
[95] = {id = 95, name = "Skill_Anna_Ex_End", sheet = 3}
, 
[96] = {id = 96, name = "Skill_Anna_Ex_Hit", sheet = 3}
, 
[97] = {id = 97, name = "Skill_Croque_Ex_Start", sheet = 2}
, 
[98] = {id = 98, name = "Skill_Croque_Ex_Cast", sheet = 2}
, 
[99] = {id = 99, name = "Skill_Corque_Ex_End", sheet = 2}
, 
[100] = {id = 100, name = "Skill_Persicaria_Ex_Start", sheet = 6}
, 
[101] = {id = 101, name = "Skill_Persicaria_Ex_Cast", sheet = 6}
, 
[102] = {id = 102, name = "Skill_Persicaria_Ex_End", sheet = 6}
, 
[103] = {id = 103, name = "Skill_Sol_Ex_Start", sheet = 8}
, 
[104] = {id = 104, name = "Skill_Sol_Ex_Cast", sheet = 8}
, 
[105] = {id = 105, name = "Skill_Sol_Ex_End", sheet = 8}
, 
[106] = {id = 106, name = "Skill_Banxsy_Passive", sheet = 19}
, 
[107] = {id = 107, name = "Skill_Banxsy_01_Cast", sheet = 19}
, 
[108] = {id = 108, name = "Skill_Banxsy_01_Hit", sheet = 19}
, 
[109] = {id = 109, name = "Skill_Banxsy_01_End", sheet = 19}
, 
[110] = {id = 110, name = "Atk_Gin_Heal", sheet = 21}
, 
[111] = {id = 111, name = "Atk_Lam_01", sheet = 28}
, 
[112] = {id = 112, name = "Atk_Lam_02", sheet = 28}
, 
[113] = {id = 113, name = "Skill_Lam_01_Start", sheet = 28}
, 
[114] = {id = 114, name = "Skill_Lam_Ex_Start", sheet = 28}
, 
[115] = {id = 115, name = "Skill_Lam_Ex_Cast", sheet = 28}
, 
[116] = {id = 116, name = "Skill_Lam_Ex_End", sheet = 28}
, 
[117] = {id = 117, name = "Skill_Hubble_Ex_Start", sheet = 29}
, 
[118] = {id = 118, name = "Skill_Hubble_Ex_Cast", sheet = 29}
, 
[119] = {id = 119, name = "Skill_Hubble_Ex_Hit", sheet = 29}
, 
[1000] = {id = 1000, name = "But_CombatStart"}
, 
[1001] = {id = 1001, name = "But_Function"}
, 
[1002] = {id = 1002, name = "But_IntoTheRoom"}
, 
[1003] = {id = 1003, name = "Menu_Victory"}
, 
[1004] = {id = 1004, name = "Menu_Defeat"}
, 
[1005] = {id = 1005, name = "Fb_ExSkillReadiness_01"}
, 
[1006] = {id = 1006, name = "Fb_ExSkillReadiness_02"}
, 
[1007] = {id = 1007, name = "Fb_CachePointChange"}
, 
[1008] = {id = 1008, name = "Fb_Common_Erro"}
, 
[1009] = {id = 1009, name = "Fb_FunctionGet"}
, 
[1010] = {id = 1010, name = "Fb_Healing"}
, 
[1011] = {id = 1011, name = "But_ListOpen"}
, 
[1012] = {id = 1012, name = "But_ListClose"}
, 
[1013] = {id = 1013, name = "Fb_BuildingUpgraded"}
, 
[1014] = {id = 1014, name = "Fb_BuildingUpgrading"}
, 
[1015] = {id = 1015, name = "Fb_BuildingUpgrading_Random"}
, 
[1016] = {id = 1016, name = "Menu_IntoOasis"}
, 
[1017] = {id = 1017, name = "Menu_BackMenu"}
, 
[1018] = {id = 1018, name = "Fb_PickUp"}
, 
[1019] = {id = 1019, name = "Fb_PutDown"}
, 
[1020] = {id = 1020, name = "Fb_CharGet_1"}
, 
[1021] = {id = 1021, name = "Fb_CharGet_2"}
, 
[1022] = {id = 1022, name = "Fb_CharGet_3"}
, 
[1023] = {id = 1023, name = "Fb_LevelUp"}
, 
[1024] = {id = 1024, name = "Fb_CharUp"}
, 
[1025] = {id = 1025, name = "Fb_FunctionDebuff"}
, 
[1026] = {id = 1026, name = "Fb_Relive"}
, 
[1028] = {id = 1028, name = "Fb_NextFloor"}
, 
[1029] = {id = 1029, name = "Fb_Reward"}
, 
[1030] = {id = 1030, name = "Fb_ALGO_Equip"}
, 
[1031] = {id = 1031, name = "Fb_ALGO_PickUp"}
, 
[1032] = {id = 1032, name = "Fb_ALGO_Remove"}
, 
[1033] = {id = 1033, name = "Fb_StageSelect_Open"}
, 
[1034] = {id = 1034, name = "Fb_StageSelect_Close"}
, 
[1035] = {id = 1035, name = "Fb_StorySelect_Open"}
, 
[1036] = {id = 1036, name = "Fb_StorySelect_Close"}
, 
[1037] = {id = 1037, name = "Fb_EndlessMode_Wheel"}
, 
[1038] = {id = 1038, name = "Fb_EndlessMode_Click"}
, 
[1039] = {id = 1039, name = "But_Store_Refresh"}
, 
[1040] = {id = 1040, name = "Fb_FunctionDiscard"}
, 
[1041] = {id = 1041, name = "But_Gacha_switch"}
, 
[1042] = {id = 1042, name = "But_Gacha_click"}
, 
[1043] = {id = 1043, name = "Fb_CharGet_0"}
, 
[1044] = {id = 1044, name = "Fb_Gacha_scan_down"}
, 
[1045] = {id = 1045, name = "Fb_Gacha_scan_circle_B"}
, 
[1046] = {id = 1046, name = "Fb_Gacha_scan_circle_P"}
, 
[1047] = {id = 1047, name = "Fb_Gacha_scan_circle_O"}
, 
[1048] = {id = 1048, name = "Fb_Gacha_scan_light_B"}
, 
[1049] = {id = 1049, name = "Fb_Gacha_scan_light_P"}
, 
[1050] = {id = 1050, name = "Fb_Gacha_scan_light_O"}
, 
[1051] = {id = 1051, name = "Fb_Gacha_scan_tower_up"}
, 
[1052] = {id = 1052, name = "Fb_Gacha_scan_tower_down"}
, 
[2000] = {id = 2000, name = "Sce_Sector_Stage1Level1", sheet = 30}
, 
[3000] = {id = 3000, name = "Mus_Home_Oasis", sheet = 5, type = 1}
, 
[3001] = {id = 3001, name = "Mus_Home_Sector", sheet = 5, type = 1}
, 
[3002] = {id = 3002, name = "Mus_Home", sheet = 5, type = 1}
, 
[3005] = {id = 3005, name = "Mus_Story_Relax", sheet = 5, type = 1}
, 
[3006] = {id = 3006, name = "Mus_Story_Funny", sheet = 5, type = 1}
, 
[3007] = {id = 3007, name = "Mus_Story_BattleTension", sheet = 5, type = 1}
, 
[3008] = {id = 3008, name = "Mus_Story_Purifier", sheet = 5, type = 1}
, 
[3009] = {id = 3009, name = "Mus_Victory", sheet = 5, type = 1}
, 
[3010] = {id = 3010, name = "Mus_Defeat", sheet = 5, type = 1}
, 
[3101] = {id = 3101, name = "Mus_Sector", sheet = 5, type = 1}
, 
[3102] = {id = 3102, name = "Mus_Sector_2", sheet = 5, type = 1}
, 
[3103] = {id = 3103, name = "Mus_Sector_3", sheet = 5, type = 1}
, 
[3104] = {id = 3104, name = "Mus_Sector_4", sheet = 5, type = 1}
, 
[3105] = {id = 3105, name = "Mus_Sector_5", sheet = 5, type = 1}
}
local __default_values = {id = 10, name = "Atk_Abstinence_01", sheet = 1, type = 2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in (_ENV.pairs)(audio) do
  (_ENV.setmetatable)(v, base)
end
local __rawdata = {__basemetatable = base, 
sheetList = {"UI", "Chara_Croque", "Chara_Anna", "Chara_Fresnel", "Music", "Chara_Persicaria", "Common_Skill", "Chara_Sol", "Chara_Simo", "Chara_Chi", "Chara_Maimai", "Mon_Xin", "Mon_Patience", "Mon_Raider", "Mon_Chong", "Mon_Gangyi", "Mon_Defender", "Mon_Purger", "Chara_Banxsy", "Chara_Jessie", "Chara_Gin", "Chara_Evelyn", "Chara_Groove", "Mon_Abstinence", "Mon_Guardian", "Mon_Mala", "Mon_Refactorer", "Chara_Lam", "Chara_Hubble", "Ambience"}
}
;
(_ENV.setmetatable)(audio, {__index = __rawdata})
return audio

-- params : ...
-- function num : 0 , upvalues : _ENV
local audio = {
    [5] = {id = 5, name = "But_Common_Click"},
    [7] = {id = 7, name = "Show_CharacterBorn", sheet = 7},
    [8] = {id = 8, name = "Atk_Anna_01", sheet = 3},
    [9] = {id = 9, name = "Atk_Fresnel_01", sheet = 4},
    [10] = {name = "Atk_Croque_01", sheet = 2},
    [11] = {id = 11, name = "Atk_Persicaria_01", sheet = 6},
    [12] = {id = 12, name = "Atk_Sol_01", sheet = 8},
    [13] = {id = 13, name = "Atk_Sol_02", sheet = 8},
    [14] = {id = 14, name = "Atk_Sol_03", sheet = 8},
    [15] = {id = 15, name = "Atk_Sol_04", sheet = 8},
    [16] = {id = 16, name = "Atk_Simo_01", sheet = 9},
    [17] = {id = 17, name = "Atk_Chi_01", sheet = 10, type = 3},
    [18] = {id = 18, name = "Atk_Maimai_01", sheet = 11},
    [19] = {id = 19, name = "Atk_Xin_01", sheet = 12},
    [20] = {id = 20, name = "Atk_Xin_02", sheet = 12},
    [21] = {id = 21, name = "Atk_Patience_01", sheet = 13},
    [22] = {id = 22, name = "Atk_Raider_01", sheet = 14},
    [23] = {id = 23, name = "Atk_Refactorer_01", sheet = 7},
    [24] = {id = 24, name = "Atk_Chong_01", sheet = 15},
    [25] = {id = 25, name = "Atk_Chong_02", sheet = 15},
    [26] = {id = 26, name = "Atk_Gangyi_01", sheet = 16},
    [27] = {id = 27, name = "Atk_Defender_01", sheet = 17},
    [28] = {id = 28, name = "Atk_Purger_01", sheet = 18},
    [29] = {id = 29, name = "Skill_Anna_01", sheet = 3},
    [30] = {id = 30, name = "Skill_Fresnel_01", sheet = 4, type = 3},
    [31] = {id = 31, name = "Skill_Fresnel_02", sheet = 4},
    [32] = {id = 32, name = "Skill_Fresnel_Passive", sheet = 4},
    [33] = {id = 33, name = "Skill_Croque_01", sheet = 2},
    [34] = {id = 34, name = "Skill_Croque_01_Loop", sheet = 2, type = 3},
    [35] = {id = 35, name = "Skill_Croque_01_Hit", sheet = 2},
    [36] = {id = 36, name = "Skill_Persicaria_01", sheet = 6},
    [37] = {id = 37, name = "Skill_Common_Healing", sheet = 7},
    [38] = {id = 38, name = "Skill_Sol_01", sheet = 8},
    [39] = {id = 39, name = "Skill_Sol_Passive", sheet = 8},
    [40] = {id = 40, name = "Skill_Simo_01", sheet = 9},
    [41] = {id = 41, name = "Skill_Simo_02", sheet = 9},
    [42] = {id = 42, name = "Skill_Chi_01", sheet = 10, type = 3},
    [43] = {id = 43, name = "Skill_Chi_Ex", sheet = 10},
    [44] = {id = 44, name = "Skill_Chi_Ex_Hit", sheet = 10},
    [45] = {id = 45, name = "Skill_Common_ExCast", sheet = 7},
    [46] = {id = 46, name = "Skill_Maimai_01_BS", sheet = 11},
    [47] = {id = 47, name = "Skill_Maimai_01", sheet = 11, type = 3},
    [48] = {id = 48, name = "Skill_Xin_01", sheet = 12},
    [49] = {id = 49, name = "Skill_Patience_01_BS", sheet = 13},
    [50] = {id = 50, name = "Skill_Patience_01_Cast", sheet = 13},
    [51] = {id = 51, name = "Skill_Raider_01_Cast", sheet = 14},
    [52] = {id = 52, name = "Skill_Raider_01_Hit", sheet = 14},
    [53] = {id = 53, name = "Skill_Chong_01", sheet = 15},
    [54] = {id = 54, name = "Skill_Gangyi_01", sheet = 16},
    [55] = {id = 55, name = "Skill_Defender_01", sheet = 17},
    [56] = {id = 56, name = "Skill_Purger_01", sheet = 18},
    [57] = {id = 57, name = "Atk_Banxsy_01", sheet = 19},
    [58] = {id = 58, name = "Atk_Jessie_01", sheet = 20},
    [59] = {id = 59, name = "Atk_Jessie_02", sheet = 20},
    [60] = {id = 60, name = "Atk_Gin_01", sheet = 21},
    [61] = {id = 61, name = "Atk_Evelyn_01", sheet = 22},
    [62] = {id = 62, name = "Atk_Evelyn_02", sheet = 22},
    [63] = {id = 63, name = "Atk_Groove_01", sheet = 23},
    [64] = {id = 64, sheet = 24},
    [65] = {id = 65, name = "Atk_Guardian_01", sheet = 25},
    [66] = {id = 66, name = "Atk_Guardian_02", sheet = 25},
    [67] = {id = 67, name = "Atk_Mala_01", sheet = 26},
    [68] = {id = 68, name = "Atk_Mala_02", sheet = 26},
    [69] = {id = 69, name = "Atk_Mala_03", sheet = 26},
    [70] = {id = 70, name = "Skill_Jessie_01_Start", sheet = 20},
    [71] = {id = 71, name = "Skill_Jessie_01_End", sheet = 20},
    [72] = {id = 72, name = "Skill_Gin_01_Start", sheet = 21},
    [73] = {id = 73, name = "Skill_Gin_01_Loop", sheet = 21, type = 3},
    [74] = {id = 74, name = "Skill_Evelyn_01_Start", sheet = 22},
    [75] = {id = 75, name = "Skill_Evelyn_Passive", sheet = 22},
    [76] = {id = 76, name = "Skill_Groove_01_Start", sheet = 23},
    [77] = {id = 77, name = "Skill_Groove_Loop_Passive", sheet = 23, type = 3},
    [78] = {id = 78, name = "Skill_Abstinence_01_Start", sheet = 24},
    [79] = {id = 79, name = "Skill_Abstinence_01_Loop", sheet = 24, type = 3},
    [80] = {id = 80, name = "Skill_Abstinence_01_Debuff", sheet = 24},
    [81] = {id = 81, name = "Skill_Abstinence_01_Hit", sheet = 24},
    [82] = {id = 82, name = "Skill_Guardian_01_Start", sheet = 25},
    [83] = {id = 83, name = "Skill_Guardian_01_Loop", sheet = 25, type = 3},
    [84] = {id = 84, name = "Skill_Mala_01_Start", sheet = 26},
    [85] = {id = 85, name = "Skill_Mala_01_Cast", sheet = 26, type = 3},
    [86] = {id = 86, name = "Skill_Mala_01_Hit", sheet = 26},
    [87] = {id = 87, name = "Skill_Mala_02_Start", sheet = 26},
    [88] = {id = 88, name = "Skill_Mala_02_Loop", sheet = 26, type = 3},
    [89] = {id = 89, name = "Skill_Mala_Passive_Start", sheet = 26},
    [90] = {id = 90, name = "Skill_Mala_Passive_End", sheet = 26},
    [91] = {id = 91, name = "Skill_Refactorer_01_Start", sheet = 27},
    [92] = {id = 92, name = "Skill_Refactorer_01_Loop", sheet = 27, type = 3},
    [93] = {id = 93, name = "Skill_Anna_Ex_Start", sheet = 3},
    [94] = {id = 94, name = "Skill_Anna_Ex_Cast", sheet = 3},
    [95] = {id = 95, name = "Skill_Anna_Ex_End", sheet = 3},
    [96] = {id = 96, name = "Skill_Anna_Ex_Hit", sheet = 3},
    [97] = {id = 97, name = "Skill_Croque_Ex_Start", sheet = 2},
    [98] = {id = 98, name = "Skill_Croque_Ex_Cast", sheet = 2},
    [99] = {id = 99, name = "Skill_Corque_Ex_End", sheet = 2},
    [100] = {id = 100, name = "Skill_Persicaria_Ex_Start", sheet = 6},
    [101] = {id = 101, name = "Skill_Persicaria_Ex_Cast", sheet = 6},
    [102] = {id = 102, name = "Skill_Persicaria_Ex_End", sheet = 6},
    [103] = {id = 103, name = "Skill_Sol_Ex_Start", sheet = 8},
    [104] = {id = 104, name = "Skill_Sol_Ex_Cast", sheet = 8},
    [105] = {id = 105, name = "Skill_Sol_Ex_End", sheet = 8},
    [106] = {id = 106, name = "Skill_Banxsy_Passive", sheet = 19},
    [107] = {id = 107, name = "Skill_Banxsy_01_Cast", sheet = 19},
    [108] = {id = 108, name = "Skill_Banxsy_01_Hit", sheet = 19},
    [109] = {id = 109, name = "Skill_Banxsy_01_End", sheet = 19},
    [110] = {id = 110, name = "Atk_Gin_Heal", sheet = 21},
    [111] = {id = 111, name = "Atk_Lam_01", sheet = 28},
    [112] = {id = 112, name = "Atk_Lam_02", sheet = 28},
    [113] = {id = 113, name = "Skill_Lam_01_Start", sheet = 28},
    [114] = {id = 114, name = "Skill_Lam_Ex_Start", sheet = 28},
    [115] = {id = 115, name = "Skill_Lam_Ex_Cast", sheet = 28},
    [116] = {id = 116, name = "Skill_Lam_Ex_End", sheet = 28},
    [117] = {id = 117, name = "Skill_Hubble_Ex_Start", sheet = 29},
    [118] = {id = 118, name = "Skill_Hubble_Ex_Cast", sheet = 29},
    [119] = {id = 119, name = "Skill_Hubble_Ex_Hit", sheet = 29},
    [1000] = {id = 1000, name = "But_CombatStart"},
    [1001] = {id = 1001, name = "But_Function"},
    [1002] = {id = 1002, name = "But_IntoTheRoom"},
    [1003] = {id = 1003, name = "Menu_Victory"},
    [1004] = {id = 1004, name = "Menu_Defeat"},
    [1005] = {id = 1005, name = "Fb_ExSkillReadiness_01"},
    [1006] = {id = 1006, name = "Fb_ExSkillReadiness_02"},
    [1007] = {id = 1007, name = "Fb_CachePointChange"},
    [1008] = {id = 1008, name = "Fb_Common_Erro"},
    [1009] = {id = 1009, name = "Fb_FunctionGet"},
    [1010] = {id = 1010, name = "Fb_Healing"},
    [1011] = {id = 1011, name = "But_ListOpen"},
    [1012] = {id = 1012, name = "But_ListClose"},
    [1013] = {id = 1013, name = "Fb_BuildingUpgraded"},
    [1014] = {id = 1014, name = "Fb_BuildingUpgrading"},
    [1015] = {id = 1015, name = "Fb_BuildingUpgrading_Random"},
    [1016] = {id = 1016, name = "Menu_IntoOasis"},
    [1017] = {id = 1017, name = "Menu_BackMenu"},
    [1018] = {id = 1018, name = "Fb_PickUp"},
    [1019] = {id = 1019, name = "Fb_PutDown"},
    [1020] = {id = 1020, name = "Fb_CharGet_1"},
    [1021] = {id = 1021, name = "Fb_CharGet_2"},
    [1022] = {id = 1022, name = "Fb_CharGet_3"},
    [1023] = {id = 1023, name = "Fb_LevelUp"},
    [1024] = {id = 1024, name = "Fb_CharUp"},
    [1025] = {id = 1025, name = "Fb_FunctionDebuff"},
    [1026] = {id = 1026, name = "Fb_Relive"},
    [1028] = {id = 1028, name = "Fb_NextFloor"},
    [1029] = {id = 1029, name = "Fb_Reward"},
    [1030] = {id = 1030, name = "Fb_ALGO_Equip"},
    [1031] = {id = 1031, name = "Fb_ALGO_PickUp"},
    [1032] = {id = 1032, name = "Fb_ALGO_Remove"},
    [1033] = {id = 1033, name = "Fb_StageSelect_Open"},
    [1034] = {id = 1034, name = "Fb_StageSelect_Close"},
    [1035] = {id = 1035, name = "Fb_StorySelect_Open"},
    [1036] = {id = 1036, name = "Fb_StorySelect_Close"},
    [1037] = {id = 1037, name = "Fb_EndlessMode_Wheel"},
    [1038] = {id = 1038, name = "Fb_EndlessMode_Click"},
    [1039] = {id = 1039, name = "But_Store_Refresh"},
    [1040] = {id = 1040, name = "Fb_FunctionDiscard"},
    [1041] = {id = 1041, name = "But_Gacha_switch"},
    [1042] = {id = 1042, name = "But_Gacha_click"},
    [1043] = {id = 1043, name = "Fb_CharGet_0"},
    [1044] = {id = 1044, name = "Fb_Gacha_scan_down"},
    [1045] = {id = 1045, name = "Fb_Gacha_scan_circle_B"},
    [1046] = {id = 1046, name = "Fb_Gacha_scan_circle_P"},
    [1047] = {id = 1047, name = "Fb_Gacha_scan_circle_O"},
    [1048] = {id = 1048, name = "Fb_Gacha_scan_light_B"},
    [1049] = {id = 1049, name = "Fb_Gacha_scan_light_P"},
    [1050] = {id = 1050, name = "Fb_Gacha_scan_light_O"},
    [1051] = {id = 1051, name = "Fb_Gacha_scan_tower_up"},
    [1052] = {id = 1052, name = "Fb_Gacha_scan_tower_down"},
    [2000] = {id = 2000, name = "Sce_Sector_Stage1Level1", sheet = 30},
    [3000] = {id = 3000, name = "Mus_Home_Oasis", sheet = 5, type = 1},
    [3001] = {id = 3001, name = "Mus_Home_Sector", sheet = 5, type = 1},
    [3002] = {id = 3002, name = "Mus_Home", sheet = 5, type = 1},
    [3005] = {id = 3005, name = "Mus_Story_Relax", sheet = 5, type = 1},
    [3006] = {id = 3006, name = "Mus_Story_Funny", sheet = 5, type = 1},
    [3007] = {id = 3007, name = "Mus_Story_BattleTension", sheet = 5, type = 1},
    [3008] = {id = 3008, name = "Mus_Story_Purifier", sheet = 5, type = 1},
    [3009] = {id = 3009, name = "Mus_Victory", sheet = 5, type = 1},
    [3010] = {id = 3010, name = "Mus_Defeat", sheet = 5, type = 1},
    [3101] = {id = 3101, name = "Mus_Sector", sheet = 5, type = 1},
    [3102] = {id = 3102, name = "Mus_Sector_2", sheet = 5, type = 1},
    [3103] = {id = 3103, name = "Mus_Sector_3", sheet = 5, type = 1},
    [3104] = {id = 3104, name = "Mus_Sector_4", sheet = 5, type = 1},
    [3105] = {id = 3105, name = "Mus_Sector_5", sheet = 5, type = 1}
}
local __default_values = {
    id = 10,
    name = "Atk_Abstinence_01",
    sheet = 1,
    type = 2
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in (_ENV.pairs)(audio) do (_ENV.setmetatable)(v, base) end
local __rawdata = {
    __basemetatable = base,
    sheetList = {
        "UI", "Chara_Croque", "Chara_Anna", "Chara_Fresnel", "Music",
        "Chara_Persicaria", "Common_Skill", "Chara_Sol", "Chara_Simo",
        "Chara_Chi", "Chara_Maimai", "Mon_Xin", "Mon_Patience", "Mon_Raider",
        "Mon_Chong", "Mon_Gangyi", "Mon_Defender", "Mon_Purger", "Chara_Banxsy",
        "Chara_Jessie", "Chara_Gin", "Chara_Evelyn", "Chara_Groove",
        "Mon_Abstinence", "Mon_Guardian", "Mon_Mala", "Mon_Refactorer",
        "Chara_Lam", "Chara_Hubble", "Ambience"
    }
};
(_ENV.setmetatable)(audio, {__index = __rawdata})
return audio

