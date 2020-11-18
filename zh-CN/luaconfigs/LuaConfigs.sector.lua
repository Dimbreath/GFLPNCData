-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1, 1, 1}
local sector = {
{name_en = "ROSSUM", type_name = 499886}
, 
{achievement = 302, audio_id = 3004, 
building = {2005, 2006, 2007, 2008}
, id = 2, 
level_arrange = {3, 3, 3}
, name = 448601, pic_big = "big_2", pic_small = "small_2", type_name = 443872}
, 
{achievement = 303, 
building = {2009, 2010, 2011, 2012}
, id = 3, name = 98834, name_en = "HELIOS", pic_big = "big_3", pic_small = "small_3"}
}
local __default_values = {achievement = 301, audio_id = 3003, 
building = {2001, 2002, 2003, 2004}
, id = 1, level_arrange = __rt_1, name = 304585, name_en = "CYCLOPES", pic_big = "big_1", pic_small = "small_1", type_name = 332445}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(sector) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
id_sort_list = {1, 2, 3}
}
setmetatable(sector, {__index = __rawdata})
return sector

