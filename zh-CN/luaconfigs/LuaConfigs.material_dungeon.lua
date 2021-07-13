-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local material_dungeon = {
[1400] = {des_info = "", dungeon_icon = "", dungeon_img = 0, frequency_day = 5, name = 18753, name_en = "FRAGMENT RETRIEVAL", task_id = "", ui_type = 1}
, 
[1701] = {des_info = 310956, dungeon_icon = "matDg_bit", dungeon_img = 0, id = 1701, item_icon = "matDg_bit", name = 195943, name_en = "DGC GATHERING", 
resource_top = {1003}
, 
stage_id = {10011, 10012, 10013, 10014, 10015, 10016, 10017, 10018}
}
, 
[1702] = {des_info = 101446, dungeon_icon = "matDg_exp", dungeon_img = 1, id = 1702, item_icon = "matDg_exp", name = 491260, name_en = "MISSION DATA GATHERING", 
resource_top = {1012}
, 
stage_id = {11000, 11001, 11002, 11003, 11004, 11005, 11006, 11007}
}
, 
[1703] = {dungeon_icon = "matDg_ath", dungeon_img = 5, id = 1703, item_icon = "1", name = 37610, name_en = "STANDARD SEARCHING", 
stage_id = {12000, 12001, 12002}
, ui_type = 3}
, 
[1704] = {dungeon_icon = "matDg_ath", dungeon_img = 6, id = 1704, item_icon = "2", name = 173306, name_en = "STANDARD SEARCHING", 
stage_id = {12003, 12004, 12005, 12006}
, ui_type = 3}
, 
[1705] = {click_audio = 4101, des_info = 345390, id = 1705, item_icon = "matDg_limit_1", name = 288620, 
resource_top = {1804, 1809, 1814, 1819, 1824}
, 
stage_id = {12016, 12017, 12018, 12019, 12020, 12021, 12022, 12023}
, stage_type = 1}
, 
[1706] = {click_audio = 4102, des_info = 82827, id = 1706, item_icon = "matDg_limit_2", name = 57827, name_en = 146486, 
resource_top = {1803, 1808, 1813, 1818, 1823}
, 
stage_id = {12024, 12025, 12026, 12027, 12028, 12029, 12030, 12031}
, stage_type = 1}
, 
[1707] = {click_audio = 4103, des_info = 377999, id = 1707, item_icon = "matDg_limit_3", name = 24687, 
resource_top = {1805, 1810, 1815, 1820, 1825}
, 
stage_id = {12032, 12033, 12034, 12035, 12036, 12037, 12038, 12039}
, stage_type = 1}
, 
[1708] = {click_audio = 4104, des_info = 323040, id = 1708, item_icon = "matDg_limit_4", name = 305474, 
resource_top = {1802, 1807, 1812, 1817, 1822}
, 
stage_id = {12040, 12041, 12042, 12043, 12044, 12045, 12046, 12047}
, stage_type = 1}
, 
[1709] = {click_audio = 4105, des_info = 324449, id = 1709, item_icon = "matDg_limit_5", name = 86181, 
resource_top = {1801, 1806, 1811, 1816, 1821}
, 
stage_id = {12048, 12049, 12050, 12051, 12052, 12053, 12054, 12055}
, stage_type = 1}
, 
[1710] = {des_info = 174121, dungeon_icon = "matDg_skill", dungeon_img = 3, id = 1710, item_icon = "matDg_skill", name = 510297, name_en = "SKILL TRAINING", 
resource_top = {1501}
, 
stage_id = {12056, 12057, 12058, 12059, 12060, 12061, 12062, 12063}
}
, 
[1715] = {dungeon_icon = "matDg_ath", dungeon_img = 7, id = 1715, item_icon = "3", name = 177849, name_en = "STANDARD SEARCHING", 
stage_id = {12007, 12008, 12009, 12010, 12011}
, ui_type = 3}
, 
[2000] = {des_info = "", dungeon_icon = "", dungeon_img = 0, id = 2000, name_en = "", task_id = "", ui_type = 0}
}
local __default_values = {click_audio = 0, des_info = 247066, double = 0, dungeon_icon = "matDg_limit", dungeon_img = 4, frequency_day = -1, id = 1400, item_icon = "", name = "", name_en = "POTENTIAL TRAINING", resource_top = __rt_1, stage_id = __rt_1, stage_type = 0, task_id = "10008_10002|10001|0|0", ui_type = 2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(material_dungeon) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
subTitleIdList = {1}
}
setmetatable(material_dungeon, {__index = __rawdata})
return material_dungeon

