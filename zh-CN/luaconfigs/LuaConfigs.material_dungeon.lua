-- params : ...
-- function num : 0 , upvalues : _ENV
local material_dungeon = {
[1701] = {des_info = 210674, item_icon = "matDg_bit", name = 332457, name_en = "BITCOIN GATHERING"}
, 
[1702] = {dungeon_img = 1, id = 1702, item_icon = "matDg_exp", name = 491260, name_en = "MISSION DATA GATHERING", 
stage_id = {11000, 11001, 11002, 11003, 11004, 11005}
}
, 
[1703] = {des_info = 247066, dungeon_img = 2, id = 1703, 
stage_id = {12000, 12001, 12002, 12003, 12004, 12005}
}
}
local __default_values = {des_info = 101446, dungeon_img = 0, frequency_day = 3, id = 1701, item_icon = "matDg_ath", name = 105999, name_en = "ALGORITHM GATHERING", 
stage_id = {10011, 10012, 10013, 10014, 10015, 10016}
, task_id = "10008_10002|10001|0|0"}
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

