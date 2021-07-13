-- params : ...
-- function num : 0 , upvalues : _ENV
local audio = {
[5] = {id = 5, name = "But_Common_Click"}
, 
[7] = {id = 7, name = "Show_CharacterBorn", sheet = 17}
, 
[8] = {id = 8, name = "Atk_Anna_01", sheet = 2}
, 
[9] = {id = 9, name = "Atk_Fresnel_01", sheet = 7}
, 
[10] = {name = "Atk_Croque_01", sheet = 5}
, 
[11] = {id = 11, name = "Atk_Persicaria_01", sheet = 14}
, 
[12] = {id = 12, name = "Atk_Sol_01", sheet = 16}
, 
[13] = {id = 13, name = "Atk_Sol_02", sheet = 16}
, 
[14] = {id = 14, name = "Atk_Sol_03", sheet = 16}
, 
[15] = {id = 15, name = "Atk_Sol_04", sheet = 16}
, 
[16] = {id = 16, name = "Atk_Simo_01", sheet = 15}
, 
[17] = {id = 17, name = "Atk_Chi_01", sheet = 4, type = 3}
, 
[18] = {id = 18, name = "Atk_Maimai_01", sheet = 13}
, 
[19] = {id = 19, name = "Atk_Xin_01", sheet = 28}
, 
[20] = {id = 20, name = "Atk_Xin_02", sheet = 28}
, 
[21] = {id = 21, name = "Atk_Patience_01", sheet = 24}
, 
[22] = {id = 22, name = "Atk_Raider_01", sheet = 26}
, 
[23] = {id = 23, name = "Atk_Refactorer_01", sheet = 17}
, 
[24] = {id = 24, name = "Atk_Chong_01", sheet = 19}
, 
[25] = {id = 25, name = "Atk_Chong_02", sheet = 19}
, 
[26] = {id = 26, name = "Atk_Gangyi_01", sheet = 21}
, 
[27] = {id = 27, name = "Atk_Defender_01", sheet = 20}
, 
[28] = {id = 28, name = "Atk_Purger_01", sheet = 25}
, 
[29] = {id = 29, name = "Skill_Anna_01", sheet = 2}
, 
[30] = {id = 30, name = "Skill_Fresnel_01", sheet = 7, type = 3}
, 
[31] = {id = 31, name = "Skill_Fresnel_02", sheet = 7}
, 
[32] = {id = 32, name = "Skill_Fresnel_Passive", sheet = 7}
, 
[33] = {id = 33, name = "Skill_Croque_01", sheet = 5}
, 
[34] = {id = 34, name = "Skill_Croque_01_Loop", sheet = 5, type = 3}
, 
[35] = {id = 35, name = "Skill_Croque_01_Hit", sheet = 5}
, 
[36] = {id = 36, name = "Skill_Persicaria_01", sheet = 14}
, 
[37] = {id = 37, name = "Skill_Common_Healing", sheet = 17}
, 
[38] = {id = 38, name = "Skill_Sol_01", sheet = 16}
, 
[39] = {id = 39, name = "Skill_Sol_Passive", sheet = 16}
, 
[40] = {id = 40, name = "Skill_Simo_01", sheet = 15}
, 
[41] = {id = 41, name = "Skill_Simo_02", sheet = 15}
, 
[42] = {id = 42, name = "Skill_Chi_01", sheet = 4}
, 
[43] = {id = 43, name = "Skill_Chi_Ex", sheet = 4}
, 
[44] = {id = 44, name = "Skill_Chi_Ex_Hit", sheet = 4}
, 
[45] = {id = 45, name = "Skill_Common_ExCast", sheet = 17}
, 
[46] = {id = 46, name = "Skill_Maimai_01_BS", sheet = 13}
, 
[47] = {id = 47, name = "Skill_Maimai_01", sheet = 13, type = 3}
, 
[48] = {id = 48, name = "Skill_Xin_01", sheet = 28}
, 
[49] = {id = 49, name = "Skill_Patience_01_BS", sheet = 24}
, 
[50] = {id = 50, name = "Skill_Patience_01_Cast", sheet = 24}
, 
[51] = {id = 51, name = "Skill_Raider_01_Cast", sheet = 26}
, 
[52] = {id = 52, name = "Skill_Raider_01_Hit", sheet = 26}
, 
[53] = {id = 53, name = "Skill_Chong_01", sheet = 19}
, 
[54] = {id = 54, name = "Skill_Gangyi_01", sheet = 21}
, 
[55] = {id = 55, name = "Skill_Defender_01", sheet = 20}
, 
[56] = {id = 56, name = "Skill_Purger_01", sheet = 25}
, 
[57] = {id = 57, name = "Atk_Banxsy_01", sheet = 3}
, 
[58] = {id = 58, name = "Atk_Jessie_01", sheet = 11}
, 
[59] = {id = 59, name = "Atk_Jessie_02", sheet = 11}
, 
[60] = {id = 60, name = "Atk_Gin_01", sheet = 8}
, 
[61] = {id = 61, name = "Atk_Evelyn_01", sheet = 6}
, 
[62] = {id = 62, name = "Atk_Evelyn_02", sheet = 6}
, 
[63] = {id = 63, name = "Atk_Groove_01", sheet = 9}
, 
[64] = {id = 64, sheet = 18}
, 
[65] = {id = 65, name = "Atk_Guardian_01", sheet = 22}
, 
[66] = {id = 66, name = "Atk_Guardian_02", sheet = 22}
, 
[67] = {id = 67, name = "Atk_Mala_01", sheet = 23}
, 
[68] = {id = 68, name = "Atk_Mala_02", sheet = 23}
, 
[69] = {id = 69, name = "Atk_Mala_03", sheet = 23}
, 
[70] = {id = 70, name = "Skill_Jessie_01_Start", sheet = 11}
, 
[71] = {id = 71, name = "Skill_Jessie_01_End", sheet = 11}
, 
[72] = {id = 72, name = "Skill_Gin_01_Start", sheet = 8}
, 
[73] = {id = 73, name = "Skill_Gin_01_Loop", sheet = 8, type = 3}
, 
[74] = {id = 74, name = "Skill_Evelyn_01_Start", sheet = 6}
, 
[75] = {id = 75, name = "Skill_Evelyn_Passive", sheet = 6}
, 
[76] = {id = 76, name = "Skill_Groove_01_Start", sheet = 9}
, 
[77] = {id = 77, name = "Skill_Groove_Loop_Passive", sheet = 9}
, 
[78] = {id = 78, name = "Skill_Abstinence_01_Start", sheet = 18}
, 
[79] = {id = 79, name = "Skill_Abstinence_01_Loop", sheet = 18, type = 3}
, 
[80] = {id = 80, name = "Skill_Abstinence_01_Debuff", sheet = 18}
, 
[81] = {id = 81, name = "Skill_Abstinence_01_Hit", sheet = 18}
, 
[82] = {id = 82, name = "Skill_Guardian_01_Start", sheet = 22}
, 
[83] = {id = 83, name = "Skill_Guardian_01_Loop", sheet = 22, type = 3}
, 
[84] = {id = 84, name = "Skill_Mala_01_Start", sheet = 23}
, 
[85] = {id = 85, name = "Skill_Mala_01_Cast", sheet = 23, type = 3}
, 
[86] = {id = 86, name = "Skill_Mala_01_Hit", sheet = 23}
, 
[87] = {id = 87, name = "Skill_Mala_02_Start", sheet = 23}
, 
[88] = {id = 88, name = "Skill_Mala_02_Loop", sheet = 23, type = 3}
, 
[89] = {id = 89, name = "Skill_Mala_Passive_Start", sheet = 23}
, 
[90] = {id = 90, name = "Skill_Mala_Passive_End", sheet = 23}
, 
[91] = {id = 91, name = "Skill_Refactorer_01_Start", sheet = 27}
, 
[92] = {id = 92, name = "Skill_Refactorer_01_Loop", sheet = 27, type = 3}
, 
[93] = {id = 93, name = "Skill_Anna_Ex_Start", sheet = 2}
, 
[94] = {id = 94, name = "Skill_Anna_Ex_Cast", sheet = 2}
, 
[95] = {id = 95, name = "Skill_Anna_Ex_End", sheet = 2}
, 
[96] = {id = 96, name = "Skill_Anna_Ex_Hit", sheet = 2}
, 
[97] = {id = 97, name = "Skill_Croque_Ex_Start", sheet = 5}
, 
[98] = {id = 98, name = "Skill_Croque_Ex_Cast", sheet = 5}
, 
[99] = {id = 99, name = "Skill_Corque_Ex_End", sheet = 5}
, 
[100] = {id = 100, name = "Skill_Persicaria_Ex_Start", sheet = 14}
, 
[101] = {id = 101, name = "Skill_Persicaria_Ex_Cast", sheet = 14}
, 
[102] = {id = 102, name = "Skill_Persicaria_Ex_End", sheet = 14}
, 
[103] = {id = 103, name = "Skill_Sol_Ex_Start", sheet = 16}
, 
[104] = {id = 104, name = "Skill_Sol_Ex_Cast", sheet = 16}
, 
[105] = {id = 105, name = "Skill_Sol_Ex_End", sheet = 16}
, 
[106] = {id = 106, name = "Skill_Banxsy_Passive", sheet = 3}
, 
[107] = {id = 107, name = "Skill_Banxsy_01_Cast", sheet = 3}
, 
[108] = {id = 108, name = "Skill_Banxsy_01_Hit", sheet = 3}
, 
[109] = {id = 109, name = "Skill_Banxsy_01_End", sheet = 3}
, 
[110] = {id = 110, name = "Atk_Gin_Heal", sheet = 8}
, 
[111] = {id = 111, name = "Atk_Lam_01", sheet = 12}
, 
[112] = {id = 112, name = "Atk_Lam_02", sheet = 12}
, 
[113] = {id = 113, name = "Skill_Lam_01_Start", sheet = 12}
, 
[114] = {id = 114, name = "Skill_Lam_Ex_Start", sheet = 12}
, 
[115] = {id = 115, name = "Skill_Lam_Ex_Cast", sheet = 12}
, 
[116] = {id = 116, name = "Skill_Lam_Ex_End", sheet = 12}
, 
[117] = {id = 117, name = "Skill_Hubble_Ex_Start", sheet = 10}
, 
[118] = {id = 118, name = "Skill_Hubble_Ex_Cast", sheet = 10}
, 
[119] = {id = 119, name = "Skill_Hubble_Ex_Hit", sheet = 10}
, 
[120] = {id = 120, name = "SupSkill_Cannon_1", sheet = 31}
, 
[121] = {id = 121, name = "SupSkill_Cannon_1_Hit", sheet = 31}
, 
[122] = {id = 122, name = "SupSkill_Cannon_2", sheet = 31}
, 
[123] = {id = 123, name = "SupSkill_Cannon_2_Hit", sheet = 31}
, 
[124] = {id = 124, name = "SupSkill_Cannon_3", sheet = 31}
, 
[125] = {id = 125, name = "SupSkill_Cannon_3_Hit", sheet = 31}
, 
[126] = {id = 126, name = "SupSkill_Cannon_4", sheet = 31}
, 
[127] = {id = 127, name = "SupSkill_Cannon_4_Hit", sheet = 31}
, 
[128] = {id = 128, name = "SupSkill_Cannon_4_chain", sheet = 31}
, 
[129] = {id = 129, name = "SupSkill_Missile_1", sheet = 32}
, 
[130] = {id = 130, name = "SupSkill_Missile_1_Hit", sheet = 32}
, 
[131] = {id = 131, name = "SupSkill_Missile_2", sheet = 32}
, 
[132] = {id = 132, name = "SupSkill_Missile_2_Hit", sheet = 32}
, 
[133] = {id = 133, name = "SupSkill_Missile_3", sheet = 32}
, 
[134] = {id = 134, name = "SupSkill_Missile_3_Hit", sheet = 32}
, 
[135] = {id = 135, name = "SupSkill_Missile_4", sheet = 32}
, 
[136] = {id = 136, name = "SupSkill_Missile_4_Hit", sheet = 32}
, 
[137] = {id = 137, name = "SupSkill_Missile_4_Hit_2D", sheet = 32}
, 
[138] = {id = 138, name = "SupSkill_Block_1", sheet = 30}
, 
[139] = {id = 139, name = "SupSkill_Block_1_Hit", sheet = 30, type = 3}
, 
[140] = {id = 140, name = "SupSkill_Block_2", sheet = 30}
, 
[141] = {id = 141, name = "SupSkill_Block_2_Hit", sheet = 30, type = 3}
, 
[142] = {id = 142, name = "SupSkill_Block_3", sheet = 30}
, 
[143] = {id = 143, name = "SupSkill_Block_3_Hit", sheet = 30, type = 3}
, 
[144] = {id = 144, name = "SupSkill_Block_4", sheet = 30}
, 
[145] = {id = 145, name = "SupSkill_Block_4_Hit", sheet = 30, type = 3}
, 
[999] = {id = 999, name = "Common_Impact", sheet = 17}
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
[1053] = {id = 1053, name = "But_Empty"}
, 
[1054] = {id = 1054, name = "Menu_Module_Select_Click"}
, 
[1055] = {id = 1055, name = "But_Item_Check"}
, 
[1056] = {id = 1056, name = "But_Email_Click"}
, 
[1057] = {id = 1057, name = "But_Email_Delete"}
, 
[1058] = {id = 1058, name = "Fb_Chara_Select"}
, 
[1059] = {id = 1059, name = "Fb_Chara_Select_Battle"}
, 
[1060] = {id = 1060, name = "Menu_Tap_Select"}
, 
[1061] = {id = 1061, name = "Fb_Chara_Intro"}
, 
[1062] = {id = 1062, name = "Fb_Chara_Next"}
, 
[1063] = {id = 1063, name = "Fb_Chara_Slide"}
, 
[1064] = {id = 1064, name = "But_Amount_Increase"}
, 
[1065] = {id = 1065, name = "But_Amount_decrease"}
, 
[1066] = {id = 1066, name = "Fb_Property_Panel"}
, 
[1067] = {id = 1067, name = "Fb_Battle_Panel_Open"}
, 
[1068] = {id = 1068, name = "Fb_Battle_Panel_close"}
, 
[1069] = {id = 1069, name = "Menu_Down_Tap_Open"}
, 
[1070] = {id = 1070, name = "Fb_Shopping_Panel_Open"}
, 
[1071] = {id = 1071, name = "Fb_Shopping_Panel_Close"}
, 
[1072] = {id = 1072, name = "Fb_Item_Intro"}
, 
[1073] = {id = 1073, name = "Fb_Switch_Transfer"}
, 
[1074] = {id = 1074, name = "Fb_Algorithm_Up"}
, 
[1075] = {id = 1075, name = "Fb_Skill_Up"}
, 
[1076] = {id = 1076, name = "Fb_Power_Up"}
, 
[1077] = {id = 1077, name = "Fb_Edit_Open"}
, 
[1078] = {id = 1078, name = "Fb_Edit_Close"}
, 
[1079] = {id = 1079, name = "BT_Monster_Intro"}
, 
[1080] = {id = 1080, name = "BT_Chara_Intro"}
, 
[1081] = {id = 1081, name = "BT_Pause"}
, 
[1082] = {id = 1082, name = "BT_Go_Back"}
, 
[1083] = {id = 1083, name = "BT_Go_On"}
, 
[1084] = {id = 1084, name = "BT_Again"}
, 
[1085] = {id = 1085, name = "BT_Cancel_Release"}
, 
[1086] = {id = 1086, name = "Menu_Module_Select_Slide"}
, 
[1087] = {id = 1087, name = "But_Locking_Modular_Click"}
, 
[1088] = {id = 1088, name = "Menu_Setting_Panel_Open"}
, 
[1089] = {id = 1089, name = "Menu_Setting_Panel_Close"}
, 
[1090] = {id = 1090, name = "But_Resources_Get"}
, 
[1091] = {id = 1091, name = "But_Building_Click"}
, 
[1101] = {id = 1101, name = "But_Back"}
, 
[1102] = {id = 1102, name = "But_Cancel"}
, 
[1103] = {id = 1103, name = "But_Confirm"}
, 
[1104] = {id = 1104, name = "But_Observe_Click"}
, 
[1105] = {id = 1105, name = "Fb_MainSytem_Back_Open"}
, 
[1106] = {id = 1106, name = "Fb_MainSytem_Back_Close"}
, 
[1107] = {id = 1107, name = "Fb_ErrorFix_Open"}
, 
[1108] = {id = 1108, name = "Fb_ErrorFix_Close"}
, 
[1109] = {id = 1109, name = "Fb_CharUp_List"}
, 
[1110] = {id = 1110, name = "Fb_CharUp_star"}
, 
[1111] = {id = 1111, name = "Fb_Chara_skin"}
, 
[1112] = {id = 1112, name = "Menu_Explore"}
, 
[1113] = {id = 1113, name = "Fb_Gacha_scan_line"}
, 
[1114] = {id = 1114, name = "Fb_Gacha_result_10"}
, 
[1115] = {id = 1115, name = "Fb_Gacha_result_1"}
, 
[1116] = {id = 1116, name = "Fb_Reward_star"}
, 
[1117] = {id = 1117, name = "BT_square_move"}
, 
[1118] = {id = 1118, name = "BT_Win_Camera_whoosh"}
, 
[2000] = {id = 2000, name = "Sce_Sector_Stage1Level1", sheet = 1}
, 
[3000] = {id = 3000, name = "Mus_Home_Oasis", sheet = 29, type = 1}
, 
[3001] = {id = 3001, name = "Mus_Home_Sector", sheet = 29, type = 1}
, 
[3002] = {id = 3002, name = "Mus_Home", sheet = 29, type = 1}
, 
[3003] = {id = 3003, name = "Mus_Factory", sheet = 29, type = 1}
, 
[3005] = {id = 3005, name = "Mus_Story_Relax", sheet = 29, type = 1}
, 
[3006] = {id = 3006, name = "Mus_Story_Funny", sheet = 29, type = 1}
, 
[3007] = {id = 3007, name = "Mus_Story_BattleTension", sheet = 29, type = 1}
, 
[3008] = {id = 3008, name = "Mus_Story_Purifier", sheet = 29, type = 1}
, 
[3009] = {id = 3009, name = "Mus_Victory", sheet = 29, type = 1}
, 
[3010] = {id = 3010, name = "Mus_Defeat", sheet = 29, type = 1}
, 
[3101] = {id = 3101, name = "Mus_Sector", sheet = 29, type = 1}
, 
[3102] = {id = 3102, name = "Mus_Sector_2", sheet = 29, type = 1}
, 
[3103] = {id = 3103, name = "Mus_Sector_3", sheet = 29, type = 1}
, 
[3104] = {id = 3104, name = "Mus_Sector_4", sheet = 29, type = 1}
, 
[3105] = {id = 3105, name = "Mus_Sector_5", sheet = 29, type = 1}
, 
[4000] = {id = 4000, name = "Fb_CharCo_42LAB"}
, 
[4001] = {id = 4001, name = "Fb_CharCo_UCL"}
, 
[4002] = {id = 4002, name = "Fb_CharCo_UAS"}
, 
[4003] = {id = 4003, name = "Fb_CharCo_CM"}
, 
[4004] = {id = 4004, name = "Fb_CharCo_SHI"}
, 
[4100] = {id = 4100, name = "But_Char_select_all"}
, 
[4101] = {id = 4101, name = "But_Char_select_guard"}
, 
[4102] = {id = 4102, name = "But_Char_select_shot"}
, 
[4103] = {id = 4103, name = "But_Char_select_flight"}
, 
[4104] = {id = 4104, name = "But_Char_select_special"}
, 
[4105] = {id = 4105, name = "But_Char_select_heal"}
}
local __default_values = {id = 10, name = "Atk_Abstinence_01", sheet = 33, type = 2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in (_ENV.pairs)(audio) do
  (_ENV.setmetatable)(v, base)
end
local __rawdata = {__basemetatable = base, 
sheetList = {"Ambience", "Chara_Anna", "Chara_Banxsy", "Chara_Chi", "Chara_Croque", "Chara_Evelyn", "Chara_Fresnel", "Chara_Gin", "Chara_Groove", "Chara_Hubble", "Chara_Jessie", "Chara_Lam", "Chara_Maimai", "Chara_Persicaria", "Chara_Simo", "Chara_Sol", "Common_Skill", "Mon_Abstinence", "Mon_Chong", "Mon_Defender", "Mon_Gangyi", "Mon_Guardian", "Mon_Mala", "Mon_Patience", "Mon_Purger", "Mon_Raider", "Mon_Refactorer", "Mon_Xin", "Music", "SupSkill_Block", "SupSkill_Cannon", "SupSkill_Missile", "UI"}
}
;
(_ENV.setmetatable)(audio, {__index = __rawdata})
return audio

