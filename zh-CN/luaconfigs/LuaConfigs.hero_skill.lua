-- params : ...
-- function num : 0 , upvalues : _ENV
local hero_skill = {
    [2] = {consume_id = 2, id = 2, lv = 1, para = 2},
    [3] = {id = 3, lv = 1, para = 3},
    [4] = {consume_id = 2, id = 4, lv = 1, para = 4},
    [5] = {consume_id = 2, id = 5, lv = 1, para = 5},
    [6] = {consume_id = 2, id = 6, lv = 1, para = 6},
    [7] = {id = 7, lv = 1, para = 7},
    [8] = {consume_id = 2, id = 8, lv = 1, para = 8},
    [9] = {id = 9, lv = 1, para = 9},
    [10] = {lv = 1},
    [11] = {consume_id = 4, id = 11, lv = 1, para = 11},
    [12] = {consume_id = 5, id = 12, lv = 1, para = 12},
    [13] = {id = 13, lv = 1, para = 13},
    [14] = {consume_id = 5, id = 14, lv = 1, para = 14},
    [15] = {consume_id = 4, id = 15, lv = 1, para = 15},
    [16] = {consume_id = 2, id = 16, lv = 1, para = 16},
    [17] = {consume_id = 5, id = 17, lv = 1, para = 17},
    [301] = {id = 301, para = 301},
    [302] = {id = 302, para = 302},
    [303] = {id = 303, para = 303},
    [304] = {id = 304, para = 304},
    [305] = {id = 305, para = 305},
    [306] = {id = 306, para = 306},
    [307] = {id = 307, para = 307},
    [308] = {id = 308, para = 308},
    [309] = {id = 309, para = 309},
    [310] = {id = 310, para = 310},
    [311] = {id = 311, para = 311},
    [1022] = {id = 1022, open_star = 6, para = 1022},
    [1023] = {consume_id = 2, id = 1023, para = 1023},
    [1025] = {consume_id = 2, id = 1025, para = 1025},
    [1026] = {consume_id = 2, id = 1026, open_star = 5, para = 1026},
    [1027] = {id = 1027, open_star = 5, para = 1027},
    [1028] = {id = 1028, para = 1028},
    [1030] = {consume_id = 2, id = 1030, para = 1030},
    [1031] = {consume_id = 2, id = 1031, open_star = 5, para = 1031},
    [1032] = {consume_id = 2, id = 1032, open_star = 5, para = 1032},
    [1033] = {consume_id = 2, id = 1033, para = 1033},
    [1034] = {id = 1034, open_star = 5, para = 1034},
    [1035] = {id = 1035, para = 1035},
    [1036] = {consume_id = 2, id = 1036, para = 1036},
    [1037] = {consume_id = 2, id = 1037, open_star = 5, para = 1037},
    [1038] = {consume_id = 2, id = 1038, open_star = 5, para = 1038},
    [1039] = {consume_id = 2, id = 1039, para = 1039},
    [1040] = {id = 1040, open_star = 5, para = 1040},
    [1041] = {id = 1041, para = 1041},
    [1042] = {id = 1042, open_star = 5, para = 1042},
    [1043] = {id = 1043, para = 1043},
    [1044] = {consume_id = 4, id = 1044, open_star = 5, para = 1044},
    [1045] = {consume_id = 4, id = 1045, para = 1045},
    [1046] = {consume_id = 5, id = 1046, open_star = 5, para = 1046},
    [1047] = {consume_id = 5, id = 1047, para = 1047},
    [1048] = {id = 1048, open_star = 5, para = 1048},
    [1049] = {id = 1049, para = 1049},
    [1050] = {consume_id = 5, id = 1050, open_star = 5, para = 1050},
    [1051] = {consume_id = 5, id = 1051, para = 1051},
    [1054] = {consume_id = 2, id = 1054, open_star = 5, para = 1054},
    [1055] = {consume_id = 2, id = 1055, para = 1055},
    [1056] = {consume_id = 5, id = 1056, open_star = 5, para = 1056},
    [1057] = {consume_id = 5, id = 1057, para = 1057},
    [1058] = {id = 1058, open_star = 6, para = 1058},
    [1059] = {consume_id = 2, id = 1059, open_star = 6, para = 1059},
    [1060] = {consume_id = 2, id = 1060, open_star = 6, para = 1060},
    [1061] = {id = 1061, open_star = 6, para = 1061},
    [1062] = {consume_id = 2, id = 1062, open_star = 6, para = 1062},
    [1063] = {consume_id = 4, id = 1063, open_star = 5, para = 1063},
    [1064] = {consume_id = 4, id = 1064, para = 1064},
    [1065] = {consume_id = 2, id = 1065, open_star = 6, para = 1065},
    [20002] = {consume_id = 4, id = 20002, lv = 1, para = 20002, type = 2}
}
local __default_values = {
    consume_id = 1,
    id = 10,
    lv = 10,
    open_star = 1,
    para = 10,
    type = 1
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(hero_skill) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(hero_skill, {__index = __rawdata})
return hero_skill

