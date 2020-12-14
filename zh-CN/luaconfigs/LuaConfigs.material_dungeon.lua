-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local material_dungeon = {
[1400] = {frequency_day = 5, name = 18753, name_en = "FRAGMENT RETRIEVAL", task_id = "", ui_type = 1}
, 
[1701] = {des_info = 419064, frequency_day = 2, id = 1701, item_icon = "matDg_bit", name = 18587, name_en = "BIT GATHERING", 
stage_id = {10011, 10012, 10013, 10014, 10015, 10016}
}
, 
[1702] = {des_info = 101446, dungeon_img = 1, frequency_day = 2, id = 1702, item_icon = "matDg_exp", name = 491260, name_en = "MISSION DATA GATHERING", 
stage_id = {11000, 11001, 11002, 11003, 11004, 11005}
}
, 
[1703] = {des_info = 247066, double = 2, dungeon_img = 2, id = 1703, item_icon = "matDg_ath", name = 82201, name_en = "STANDARD SEARCHING", 
stage_id = {12000, 12001, 12002, 12003, 12004, 12005, 12006, 12007}
, ui_type = 3}
, 
[1704] = {des_info = 247066, double = 999, dungeon_img = 2, id = 1704, item_icon = "matDg_ath", name = 358968, name_en = 396960, 
stage_id = {12008, 12009, 12010, 12011, 12012, 12013, 12014, 12015}
, ui_type = 3}
, 
[2000] = {id = 2000, task_id = "", ui_type = 0}
}
local __default_values = {des_info = "", double = 0, dungeon_img = 0, frequency_day = -1, id = 1400, item_icon = "", name = "", name_en = "", stage_id = __rt_1, task_id = "10008_10002|10001|0|0", ui_type = 2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(material_dungeon) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(material_dungeon, {__index = __rawdata})
return material_dungeon

