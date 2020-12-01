-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1, 3}
local __rt_2 = {1}
local __rt_3 = {1, 2}
local __rt_4 = {}
local __rt_5 = {1, 1}
local oasis_building = {
[1001] = {
camp_limit = {2}
, 
coord_base = {1, 1, -2}
, height = 60, intro = 328979, name = 420736, name_en = "HEADQUARTERS", size = __rt_1, upgrading_effect = "FXP_Build_18"}
, 
[1002] = {build_id = 1002, 
coord_base = {2, -3, 2}
, height = 23, icon_res = "OasisBuliding_2", intro = 197455, name = 172465, name_en = "ENGINEERING DEPT", size = __rt_3, upgrading_effect = "FXP_Build_7"}
, 
[1003] = {build_id = 1003, 
camp_limit = {1, 2, 3}
, 
coord_base = {2, 0, 3}
, height = 27, icon_res = "OasisBuliding_3", intro = 26078, name = 454930, name_en = "KEY-COLLECTING UNIT", size = __rt_3, upgrading_effect = "FXP_Build_7"}
, 
[1004] = {build_id = 1004, 
coord_base = {2, 3, -4}
, height = 27, icon_res = "OasisBuliding_4", intro = 244728, name = 62357, name_en = "RETRIEVAL TERMINAL", size = __rt_3, upgrading_effect = "FXP_Build_7"}
, 
[1006] = {build_id = 1006, 
coord_base = {3, -2, 3}
, height = 36, icon_res = "OasisBuliding_6", intro = 45024, name = 7946, name_en = "BATTLELAB", size = __rt_1, upgrading_effect = "FXP_Build_18"}
, 
[1009] = {build_id = 1009, 
coord_base = {4, 0, 0}
, height = 36, icon_res = "OasisBuliding_9", intro = 198079, name_en = "HASHRATE CENTER", size = __rt_3, upgrading_effect = "FXP_Build_7"}
, 
[1010] = {build_id = 1010, 
coord_base = {1, -1, 2}
, height = 36, icon_res = "OasisBuliding_10", intro = 241622, name = 31963, name_en = "BIT REPOSITORY", size = __rt_3, upgrading_effect = "FXP_Build_7"}
, 
[1011] = {build_id = 1011, 
coord_base = {6, 0, 0}
, height = 32, icon_res = "OasisBuliding_11", intro = 240733, name = 431198, name_en = "STORAGE", size = __rt_3, upgrading_effect = "FXP_Build_7"}
, 
[1012] = {build_id = 1012, 
coord_base = {7, -1, 0}
, height = 45, icon_res = "OasisBuliding_12", intro = 292398, name = 512101, name_en = "FACTORY", size = __rt_1, system_jump = 10, upgrading_effect = "FXP_Build_18"}
, 
[1013] = {build_id = 1013, 
coord_base = {2, 1, -2}
, height = 45, icon_res = "OasisBuliding_13", intro = 194057, name = 313927, name_en = "OVERCLOCK TOWER", 
size = {3, 4}
, upgrading_effect = "FXP_Build_4"}
, 
[2003] = {build_id = 2003, camp_limit = __rt_4, icon_res = "SectorBuilding_8", intro = 66324, name = 444038, type = 202}
, 
[2004] = {build_id = 2004, camp_limit = __rt_4, icon_res = "SectorBuilding_5", intro = 359819, name = 194658, name_en = 20418, type = 202}
, 
[2007] = {build_id = 2007, camp_limit = __rt_4, icon_res = "SectorBuilding_11", name = 149593, name_en = 215667, type = 202}
, 
[2008] = {build_id = 2008, camp_limit = __rt_4, icon_res = "SectorBuilding_9", intro = 83178, name = 460892, type = 202}
, 
[2011] = {build_id = 2011, camp_limit = __rt_4, icon_res = "SectorBuilding_10", intro = 388173, name = 223012, name_en = 20418, type = 202}
, 
[2012] = {build_id = 2012, camp_limit = __rt_4, icon_res = "SectorBuilding_4", intro = 66324, name = 413526, name_en = 215667, type = 202}
, 
[2013] = {build_id = 2013, camp_limit = __rt_4, icon_res = "SectorBuilding_7", intro = 359819, name = 213245, type = 202}
, 
[2014] = {build_id = 2014, camp_limit = __rt_4, icon_res = "SectorBuilding_12", name = 161518, name_en = 20418, type = 202}
}
local __default_values = {build_id = 1001, camp_id = 2, camp_limit = __rt_2, category = 1, coord_base = __rt_4, enterprise = "42.Lab", height = 1, icon_res = "OasisBuliding_1", intro = 326679, modol_diy = "", name = 145673, name_en = 179971, size = __rt_5, system_jump = 0, type = 101, upgrading_effect = ""}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(oasis_building) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
id_sort_list = {1001, 1002, 1003, 1004, 1006, 1009, 1010, 1011, 1012, 1013, 2003, 2004, 2007, 2008, 2011, 2012, 2013, 2014}
}
setmetatable(oasis_building, {__index = __rawdata})
return oasis_building

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
        intro = 328979,
        name = 420736,
        name_en = "HEADQUARTERS",
        size = __rt_1,
        upgrading_effect = "FXP_Build_18"
    },
    [1002] = {
        build_id = 1002,
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
        name_en = "KEY-COLLECTING UNIT",
        size = __rt_3,
        upgrading_effect = "FXP_Build_7"
    },
    [1004] = {
        build_id = 1004,
        coord_base = {2, 3, -4},
        height = 27,
        icon_res = "OasisBuliding_4",
        intro = 244728,
        name = 62357,
        name_en = "RETRIEVAL TERMINAL",
        size = __rt_3,
        upgrading_effect = "FXP_Build_7"
    },
    [1006] = {
        build_id = 1006,
        coord_base = {3, -2, 3},
        height = 36,
        icon_res = "OasisBuliding_6",
        intro = 45024,
        name = 7946,
        name_en = "BATTLELAB",
        size = __rt_1,
        upgrading_effect = "FXP_Build_18"
    },
    [1009] = {
        build_id = 1009,
        coord_base = {4, 0, 0},
        height = 36,
        icon_res = "OasisBuliding_9",
        intro = 198079,
        name_en = "HASHRATE CENTER",
        size = __rt_3,
        upgrading_effect = "FXP_Build_7"
    },
    [1010] = {
        build_id = 1010,
        coord_base = {1, -1, 2},
        height = 36,
        icon_res = "OasisBuliding_10",
        intro = 241622,
        name = 31963,
        name_en = "BIT REPOSITORY",
        size = __rt_3,
        upgrading_effect = "FXP_Build_7"
    },
    [1011] = {
        build_id = 1011,
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
        coord_base = {2, 1, -2},
        height = 45,
        icon_res = "OasisBuliding_13",
        intro = 194057,
        name = 313927,
        name_en = "OVERCLOCK TOWER",
        size = {3, 4},
        upgrading_effect = "FXP_Build_4"
    },
    [2003] = {
        build_id = 2003,
        camp_limit = __rt_4,
        icon_res = "SectorBuilding_8",
        intro = 66324,
        name = 444038,
        type = 202
    },
    [2004] = {
        build_id = 2004,
        camp_limit = __rt_4,
        icon_res = "SectorBuilding_5",
        intro = 359819,
        name = 194658,
        name_en = 20418,
        type = 202
    },
    [2007] = {
        build_id = 2007,
        camp_limit = __rt_4,
        icon_res = "SectorBuilding_11",
        name = 149593,
        name_en = 215667,
        type = 202
    },
    [2008] = {
        build_id = 2008,
        camp_limit = __rt_4,
        icon_res = "SectorBuilding_9",
        intro = 83178,
        name = 460892,
        type = 202
    },
    [2011] = {
        build_id = 2011,
        camp_limit = __rt_4,
        icon_res = "SectorBuilding_10",
        intro = 388173,
        name = 223012,
        name_en = 20418,
        type = 202
    },
    [2012] = {
        build_id = 2012,
        camp_limit = __rt_4,
        icon_res = "SectorBuilding_4",
        intro = 66324,
        name = 413526,
        name_en = 215667,
        type = 202
    },
    [2013] = {
        build_id = 2013,
        camp_limit = __rt_4,
        icon_res = "SectorBuilding_7",
        intro = 359819,
        name = 213245,
        type = 202
    },
    [2014] = {
        build_id = 2014,
        camp_limit = __rt_4,
        icon_res = "SectorBuilding_12",
        name = 161518,
        name_en = 20418,
        type = 202
    }
}
local __default_values = {
    build_id = 1001,
    camp_id = 2,
    camp_limit = __rt_2,
    category = 1,
    coord_base = __rt_4,
    enterprise = "42.Lab",
    height = 1,
    icon_res = "OasisBuliding_1",
    intro = 326679,
    modol_diy = "",
    name = 145673,
    name_en = 179971,
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
        1001, 1002, 1003, 1004, 1006, 1009, 1010, 1011, 1012, 1013, 2003, 2004,
        2007, 2008, 2011, 2012, 2013, 2014
    }
}
setmetatable(oasis_building, {__index = __rawdata})
return oasis_building

