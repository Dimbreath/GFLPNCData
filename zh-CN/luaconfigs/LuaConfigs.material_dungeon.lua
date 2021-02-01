-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local material_dungeon = {
[1400] = {dungeon_icon = "", dungeon_img = 0, frequency_day = 5, name = 18753, name_en = "FRAGMENT RETRIEVAL", task_id = "", ui_type = 1}
, 
[1701] = {des_info = 419064, dungeon_icon = "matDg_bit", dungeon_img = 0, id = 1701, item_icon = "matDg_bit", name = 18587, name_en = "BIT GATHERING", 
resource_top = {1003}
, 
stage_id = {10011, 10012, 10013, 10014, 10015, 10016}
}
, 
[1702] = {des_info = 101446, dungeon_icon = "matDg_exp", dungeon_img = 1, id = 1702, item_icon = "matDg_exp", name = 491260, name_en = "MISSION DATA GATHERING", 
resource_top = {5001, 5002, 5007}
, 
stage_id = {11000, 11001, 11002, 11003, 11004, 11005}
}
, 
[1703] = {des_info = 247066, dungeon_icon = "matDg_ath", dungeon_img = 2, id = 1703, item_icon = "matDg_ath", name = 82201, name_en = "STANDARD SEARCHING", 
stage_id = {12000, 12001, 12002, 12003, 12004, 12005, 12006, 12007}
, ui_type = 3}
, 
[1705] = {des_info = 345390, dungeon_img = 4, id = 1705, item_icon = "matDg_limit_1", name = 288620, name_en = "POTENTIAL TRAINING", 
resource_top = {1804, 1809, 1814, 1819, 1824}
, 
stage_id = {12016, 12017, 12018, 12019, 12020, 12021, 12022, 12023}
, stage_type = 1}
, 
[1706] = {des_info = 82827, dungeon_img = 4, id = 1706, item_icon = "matDg_limit_2", name = 57827, name_en = 146486, 
resource_top = {1803, 1808, 1813, 1818, 1823}
, 
stage_id = {12024, 12025, 12026, 12027, 12028, 12029, 12030, 12031}
, stage_type = 1}
, 
[1707] = {des_info = 377999, dungeon_img = 4, id = 1707, item_icon = "matDg_limit_3", name = 24687, name_en = "POTENTIAL TRAINING", 
resource_top = {1805, 1810, 1815, 1820, 1825}
, 
stage_id = {12032, 12033, 12034, 12035, 12036, 12037, 12038, 12039}
, stage_type = 1}
, 
[1708] = {des_info = 323040, dungeon_img = 4, id = 1708, item_icon = "matDg_limit_4", name = 305474, name_en = "POTENTIAL TRAINING", 
resource_top = {1802, 1807, 1812, 1817, 1822}
, 
stage_id = {12040, 12041, 12042, 12043, 12044, 12045, 12046, 12047}
, stage_type = 1}
, 
[1709] = {des_info = 324449, dungeon_img = 4, id = 1709, item_icon = "matDg_limit_5", name = 86181, name_en = "POTENTIAL TRAINING", 
resource_top = {1801, 1806, 1811, 1816, 1821}
, 
stage_id = {12048, 12049, 12050, 12051, 12052, 12053, 12054, 12055}
, stage_type = 1}
, 
[1710] = {des_info = 493997, dungeon_icon = "matDg_skill", id = 1710, item_icon = "matDg_skill_1", name = 386136, 
resource_top = {1504, 1509, 1514, 1519}
, 
stage_id = {12056, 12057, 12058, 12059, 12060, 12061, 12062, 12063}
, stage_type = 2}
, 
[1711] = {des_info = 362226, dungeon_icon = "matDg_skill", id = 1711, item_icon = "matDg_skill_2", name = 155343, 
resource_top = {1503, 1508, 1513, 1518}
, 
stage_id = {12064, 12065, 12066, 12067, 12068, 12069, 12070, 12071}
, stage_type = 2}
, 
[1712] = {des_info = 22, dungeon_icon = "matDg_skill", id = 1712, item_icon = "matDg_skill_3", name = 122203, 
resource_top = {1505, 1510, 1515, 1520}
, 
stage_id = {12072, 12073, 12074, 12075, 12076, 12077, 12078, 12079}
, stage_type = 2}
, 
[1713] = {des_info = 307183, dungeon_icon = "matDg_skill", id = 1713, item_icon = "matDg_skill_4", name = 402990, 
resource_top = {1502, 1507, 1512, 1517}
, 
stage_id = {12080, 12081, 12082, 12083, 12084, 12085, 12086, 12087}
, stage_type = 2}
, 
[1714] = {des_info = 23928, dungeon_icon = "matDg_skill", id = 1714, item_icon = "matDg_skill_5", name = 183697, 
resource_top = {1501, 1506, 1511, 1516}
, 
stage_id = {12088, 12089, 12090, 12091, 12092, 12093, 12094, 12095}
, stage_type = 2}
, 
[2000] = {dungeon_icon = "", dungeon_img = 0, id = 2000, name_en = "", task_id = "", ui_type = 0}
}
local __default_values = {des_info = "", double = 0, dungeon_icon = "matDg_limit", dungeon_img = 3, frequency_day = -1, id = 1400, item_icon = "", name = "", name_en = "SKILL TRAINING", resource_top = __rt_1, stage_id = __rt_1, stage_type = 0, task_id = "10008_10002|10001|0|0", ui_type = 2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(material_dungeon) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
subTitleIdList = {1, 2}
}
setmetatable(material_dungeon, {__index = __rawdata})
return material_dungeon

