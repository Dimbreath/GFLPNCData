-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {3}
local __rt_3 = {3114}
local oasis_area = {
{lock_prefab = "003_Oasis_001_Ruins_07", 
offset = {86, 19, 12.8}
, pre_condition = __rt_1}
, 
{id = 2, lock_prefab = "003_Oasis_001_Ruins_03", pre_condition = __rt_1}
, 
{id = 3, lock_prefab = "003_Oasis_001_Ruins_06", 
offset = {13.7, -24.2, 115.2}
, 
pre_para1 = {2101}
}
, 
{id = 4, lock_prefab = "003_Oasis_001_Ruins_05", 
offset = {5.11, -13.6, -35.9}
, pre_para1 = __rt_3}
, 
{id = 5, lock_prefab = "003_Oasis_001_Ruins_04", 
offset = {26, -4.3, -88.5}
, pre_para1 = __rt_3}
, 
{id = 6, lock_prefab = "003_Oasis_001_Ruins_02", 
offset = {147.3, 50.2, 3.3}
, pre_condition = __rt_1}
, 
{id = 7, 
offset = {139.7, 43.4, 79.5}
, 
pre_para1 = {3105}
}
}
local __default_values = {dirty_spots = __rt_1, id = 1, lock_prefab = "003_Oasis_001_Ruins_01", 
offset = {117.8, 16.9, -85.79}
, pre_condition = __rt_2, pre_para1 = __rt_1, pre_para2 = __rt_1, size = 4}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(oasis_area) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(oasis_area, {__index = __rawdata})
return oasis_area

