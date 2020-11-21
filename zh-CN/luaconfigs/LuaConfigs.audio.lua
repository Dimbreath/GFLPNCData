-- params : ...
-- function num : 0 , upvalues : _ENV
local audio = {
    [5] = {id = 5, name = "But_Common_Click"},
    [7] = {id = 7, name = "Show_CharacterBorn", sheet = 2},
    [8] = {id = 8, sheet = 3},
    [9] = {id = 9, name = "Atk_Fresnel_01", sheet = 4},
    [10] = {name = "Atk_Croque_01", sheet = 5},
    [11] = {id = 11, name = "Atk_Persicaria_01", sheet = 6},
    [12] = {id = 12, name = "Atk_Sol_01", sheet = 7},
    [13] = {id = 13, name = "Atk_Sol_02", sheet = 7},
    [14] = {id = 14, name = "Atk_Sol_03", sheet = 7},
    [15] = {id = 15, name = "Atk_Sol_04", sheet = 7},
    [16] = {id = 16, name = "Atk_Simo_01", sheet = 8},
    [17] = {id = 17, name = "Atk_Chi_01", sheet = 9, type = 3},
    [18] = {id = 18, name = "Atk_Maimai_01", sheet = 10},
    [19] = {id = 19, name = "Atk_Xin_01", sheet = 11},
    [20] = {id = 20, name = "Atk_Xin_02", sheet = 11},
    [21] = {id = 21, name = "Atk_Patience_01", sheet = 12},
    [22] = {id = 22, name = "Atk_Raider_01", sheet = 13},
    [23] = {id = 23, name = "Atk_Refactorer_01", sheet = 2},
    [24] = {id = 24, name = "Atk_Chong_01", sheet = 14},
    [25] = {id = 25, name = "Atk_Chong_02", sheet = 14},
    [26] = {id = 26, name = "Atk_Gangyi_01", sheet = 15},
    [27] = {id = 27, name = "Atk_Defender_01", sheet = 16},
    [28] = {id = 28, name = "Atk_Purger_01", sheet = 17},
    [29] = {id = 29, name = "Skill_Anna_01", sheet = 3},
    [30] = {id = 30, name = "Skill_Fresnel_01", sheet = 4, type = 3},
    [31] = {id = 31, name = "Skill_Fresnel_02", sheet = 4},
    [32] = {id = 32, name = "Skill_Fresnel_Passive", sheet = 4},
    [33] = {id = 33, name = "Skill_Croque_01", sheet = 5},
    [34] = {id = 34, name = "Skill_Croque_01_Loop", sheet = 5, type = 3},
    [35] = {id = 35, name = "Skill_Croque_01_Hit", sheet = 5},
    [36] = {id = 36, name = "Skill_Persicaria_01", sheet = 6},
    [37] = {id = 37, name = "Skill_Common_Healing", sheet = 2},
    [38] = {id = 38, name = "Skill_Sol_01", sheet = 7},
    [39] = {id = 39, name = "Skill_Sol_Passive", sheet = 7},
    [40] = {id = 40, name = "Skill_Simo_01", sheet = 8},
    [41] = {id = 41, name = "Skill_Simo_02", sheet = 8},
    [42] = {id = 42, name = "Skill_Chi_01", sheet = 9, type = 3},
    [43] = {id = 43, name = "Skill_Chi_Ex", sheet = 9},
    [44] = {id = 44, name = "Skill_Chi_Ex_Hit", sheet = 9},
    [45] = {id = 45, name = "Skill_Common_ExCast", sheet = 2},
    [46] = {id = 46, name = "Skill_Maimai_01_BS", sheet = 10},
    [47] = {id = 47, name = "Skill_Maimai_01", sheet = 10, type = 3},
    [48] = {id = 48, name = "Skill_Xin_01", sheet = 11},
    [49] = {id = 49, name = "Skill_Patience_01_BS", sheet = 12},
    [50] = {id = 50, name = "Skill_Patience_01_Cast", sheet = 12},
    [51] = {id = 51, name = "Skill_Raider_01_Cast", sheet = 13},
    [52] = {id = 52, name = "Skill_Raider_01_Hit", sheet = 13},
    [53] = {id = 53, name = "Skill_Chong_01", sheet = 14},
    [54] = {id = 54, name = "Skill_Gangyi_01", sheet = 15},
    [55] = {id = 55, name = "Skill_Defender_01", sheet = 16},
    [56] = {id = 56, name = "Skill_Purger_01", sheet = 17},
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
    [1027] = {id = 1027, name = "Fb_StageSelect"},
    [1028] = {id = 1028, name = "Fb_NextFloor"},
    [1029] = {id = 1029, name = "Fb_Reward"},
    [2000] = {id = 2000, name = "Sce_Sector_Stage1Level1", sheet = 19},
    [3000] = {id = 3000, name = "Mus_Home_Oasis", sheet = 18, type = 1},
    [3001] = {id = 3001, name = "Mus_Home_Sector", sheet = 18, type = 1},
    [3002] = {id = 3002, name = "Mus_Home", sheet = 18, type = 1},
    [3003] = {id = 3003, name = "Mus_Sector", sheet = 18, type = 1},
    [3004] = {id = 3004, name = "Mus_Sector_2", sheet = 18, type = 1},
    [3005] = {id = 3005, name = "Mus_Story_Relax", sheet = 18, type = 1},
    [3006] = {id = 3006, name = "Mus_Story_Funny", sheet = 18, type = 1},
    [3007] = {id = 3007, name = "Mus_Story_BattleTension", sheet = 18, type = 1},
    [3008] = {id = 3008, name = "Mus_Story_Purifier", sheet = 18, type = 1}
}
local __default_values = {id = 10, name = "Atk_Anna_01", sheet = 1, type = 2}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(audio) do setmetatable(v, base) end
local __rawdata = {
    __basemetatable = base,
    sheetList = {
        "UI", "Common_Skill", "Chara_Anna", "Chara_Fresnel", "Chara_Croque",
        "Chara_Persicaria", "Chara_Sol", "Chara_Simo", "Chara_Chi",
        "Chara_Maimai", "Mon_Xin", "Mon_Patience", "Mon_Raider", "Mon_Chong",
        "Mon_Gangyi", "Mon_Defender", "Mon_Purger", "Music", "Ambience"
    }
}
setmetatable(audio, {__index = __rawdata})
return audio

