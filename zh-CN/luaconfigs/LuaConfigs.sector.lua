-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {3, 3, 3}
local sector = {
{
level_arrange = {1, 1, 1}
, name = 304585, name_en = "ROSSUM", type_name = 499886}
, 
{achievement = 302, 
building = {2021, 2022, 2013}
, id = 2, name = 448601, pic_big = "big_2", pic_small = "small_2", pic_stratery_overview = "techTree_2", scene_icon = "sector_icon_2", type_name = 443872}
, 
{achievement = 303, 
building = {2031, 2032, 2023}
, id = 3, name = 98834, name_en = "HELIOS", pic_big = "big_3", pic_small = "small_3", pic_stratery_overview = "techTree_3", scene_icon = "sector_icon_3", type_name = 177105}
, 
{achievement = 304, 
building = {2041, 2042, 2043}
, id = 4, name = 342588, name_en = "ENIGMA", pic_big = "big_4", pic_small = "small_4", pic_stratery_overview = "techTree_4", scene_icon = "sector_icon_4"}
, 
{achievement = 305, 
building = {2051, 2052, 2053}
, id = 5, name_en = "PIERIDES", pic_big = "big_5", pic_small = "small_5", pic_stratery_overview = "techTree_5", scene_icon = "sector_icon_5", type_name = 449871}
}
local __default_values = {achievement = 301, 
building = {2011, 2012, 2033}
, id = 1, level_arrange = __rt_1, name = 231791, name_en = "CYCLOPES", pic_big = "big_1", pic_small = "small_1", pic_stratery_overview = "techTree_1", scene_icon = "sector_icon_1", type_name = 177026}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(sector) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
id_sort_list = {1, 2, 3, 4, 5}
, maxSectorId = 5}
setmetatable(sector, {__index = __rawdata})
return sector

