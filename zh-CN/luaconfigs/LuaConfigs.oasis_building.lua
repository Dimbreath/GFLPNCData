-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1, 3}
local __rt_2 = {1}
local __rt_3 = {1, 2}
local __rt_4 = {}
local __rt_5 = {1, 1}
local oasis_building = {
    [1001] = {
        camp_limit = {2},
        coord_base = {1, 1, -2},
        height = 60,
        icon_res = "OasisBuliding_1",
        intro = 328979,
        name = 420736,
        name_en = "HEADQUARTERS",
        size = __rt_1,
        upgrading_effect = "FXP_Build_18"
    },
    [1002] = {
        build_id = 1002,
        camp_limit = __rt_2,
        coord_base = {2, -3, 2},
        height = 23,
        icon_res = "OasisBuliding_2",
        intro = 197455,
        name = 172465,
        name_en = "ENGINEERING DEPT",
        size = __rt_3,
        upgrading_effect = "FXP_Build_7"
    },
    [1003] = {
        build_id = 1003,
        camp_limit = {1, 2, 3},
        coord_base = {2, 0, 3},
        height = 27,
        icon_res = "OasisBuliding_3",
        intro = 26078,
        name = 454930,
        name_en = "KEY COLLECT-PORT",
        size = __rt_3,
        upgrading_effect = "FXP_Build_7"
    },
    [1004] = {
        build_id = 1004,
        camp_limit = __rt_2,
        coord_base = {2, 3, -4},
        height = 27,
        icon_res = "OasisBuliding_4",
        intro = 244728,
        name = 62357,
        name_en = "RETRIEVAL TERMINAL",
        size = __rt_3,
        upgrading_effect = "FXP_Build_7"
    },
    [1005] = {
        build_id = 1005,
        camp_limit = __rt_2,
        coord_base = {3, 2, -2},
        height = 45,
        icon_res = "OasisBuliding_5",
        intro = 249138,
        name = 143955,
        name_en = "DORMITORY",
        size = __rt_1,
        upgrading_effect = "FXP_Build_18"
    },
    [1006] = {
        build_id = 1006,
        camp_limit = __rt_2,
        coord_base = {3, -2, 3},
        height = 36,
        icon_res = "OasisBuliding_6",
        intro = 45024,
        name = 7946,
        name_en = "BATTLELAB",
        size = __rt_1,
        upgrading_effect = "FXP_Build_18"
    },
    [1007] = {
        build_id = 1007,
        camp_limit = __rt_2,
        coord_base = {3, -2, -2},
        height = 40,
        icon_res = "OasisBuliding_7",
        intro = 321745,
        name = 150716,
        name_en = "LIBRARY",
        size = __rt_3,
        upgrading_effect = "FXP_Build_7"
    },
    [1008] = {
        build_id = 1008,
        camp_limit = {2, 4},
        coord_base = {5, 0, 0},
        height = 36,
        icon_res = "OasisBuliding_8",
        intro = 477847,
        name = 99079,
        name_en = "TRAINING HALL",
        size = __rt_3,
        upgrading_effect = "FXP_Build_7"
    },
    [1009] = {
        build_id = 1009,
        camp_limit = __rt_2,
        coord_base = {4, 0, 0},
        height = 36,
        icon_res = "OasisBuliding_9",
        intro = 154948,
        name = 102542,
        name_en = "HASHRATE CENTER",
        size = __rt_3,
        upgrading_effect = "FXP_Build_7"
    },
    [1010] = {
        build_id = 1010,
        camp_limit = __rt_2,
        coord_base = {1, -1, 2},
        height = 36,
        icon_res = "OasisBuliding_10",
        intro = 241622,
        name = 31963,
        name_en = "BITCOIN BANK",
        size = __rt_3,
        upgrading_effect = "FXP_Build_7"
    },
    [1011] = {
        build_id = 1011,
        camp_limit = __rt_2,
        coord_base = {6, 0, 0},
        height = 32,
        icon_res = "OasisBuliding_11",
        intro = 240733,
        name = 431198,
        name_en = "STORAGE",
        size = __rt_3,
        upgrading_effect = "FXP_Build_7"
    },
    [1012] = {
        build_id = 1012,
        camp_limit = __rt_2,
        coord_base = {7, -1, 0},
        height = 45,
        icon_res = "OasisBuliding_12",
        intro = 292398,
        name = 512101,
        name_en = "FACTORY",
        size = __rt_1,
        system_jump = 10,
        upgrading_effect = "FXP_Build_18"
    },
    [1013] = {
        build_id = 1013,
        camp_limit = __rt_2,
        coord_base = {2, 1, -2},
        height = 45,
        icon_res = "OasisBuliding_13",
        intro = 194057,
        name = 313927,
        name_en = "OVERCLOCK TOWER",
        size = {3, 4},
        upgrading_effect = "FXP_Build_4"
    },
    [2001] = {build_id = 2001, type = 201},
    [2002] = {
        build_id = 2002,
        icon_res = "SectorBuilding_2",
        name = 292490,
        type = 201
    },
    [2003] = {
        build_id = 2003,
        icon_res = "SectorBuilding_3",
        name = 433877,
        type = 202
    },
    [2004] = {
        build_id = 2004,
        icon_res = "SectorBuilding_5",
        name = 194658,
        type = 202
    },
    [2005] = {build_id = 2005, type = 201},
    [2006] = {
        build_id = 2006,
        icon_res = "SectorBuilding_2",
        name = 292490,
        type = 201
    },
    [2007] = {
        build_id = 2007,
        icon_res = "SectorBuilding_6",
        name = 495371,
        type = 202
    },
    [2008] = {
        build_id = 2008,
        icon_res = "SectorBuilding_4",
        name = 413526,
        type = 202
    },
    [2009] = {build_id = 2009, type = 201},
    [2010] = {
        build_id = 2010,
        icon_res = "SectorBuilding_2",
        name = 292490,
        type = 201
    },
    [2011] = {build_id = 2011, name = 433877, type = 202},
    [2012] = {build_id = 2012, name = 194658, type = 202}
}
local __default_values = {
    build_id = 1001,
    camp_id = 2,
    camp_limit = __rt_4,
    category = 1,
    coord_base = __rt_4,
    enterprise = "42.Lab",
    height = 1,
    icon_res = "SectorBuilding_1",
    intro = "",
    modol_diy = "",
    name = 219670,
    name_en = "",
    size = __rt_5,
    system_jump = 0,
    type = 101,
    upgrading_effect = ""
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(oasis_building) do setmetatable(v, base) end
local __rawdata = {
    __basemetatable = base,
    id_sort_list = {
        1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012,
        1013, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011,
        2012
    }
}
setmetatable(oasis_building, {__index = __rawdata})
return oasis_building

