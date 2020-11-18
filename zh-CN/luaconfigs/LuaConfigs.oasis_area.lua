-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {x = -4, y = 4}
local __rt_2 = {x = -3, y = 4}
local __rt_3 = {x = -2, y = 4}
local __rt_4 = {x = -1, y = 4}
local __rt_5 = {x = 0, y = 4}
local __rt_6 = {x = -5, y = 0}
local __rt_7 = {x = -5, y = 1}
local __rt_8 = {x = -5, y = 2}
local __rt_9 = {x = -5, y = 3}
local __rt_10 = {x = -5, y = 4}
local __rt_11 = {x = -5, y = 5}
local __rt_12 = {x = -4, y = -1}
local __rt_13 = {x = 2, y = 3}
local __rt_14 = {x = 3, y = 2}
local __rt_15 = {x = 4, y = 1}
local __rt_16 = {x = 5, y = 0}
local __rt_17 = {x = 4, y = 0}
local __rt_18 = {x = 3, y = 1}
local __rt_19 = {}
local __rt_20 = {x = 3, y = -4}
local oasis_area = {
{
dirty_spots = {
{x = -4, y = 0}
, 
{x = -4, y = 1}
, 
{x = -4, y = 2}
, 
{x = -4, y = 3}
, __rt_1, 
{x = -3, y = 3}
, __rt_2, __rt_3, __rt_4, 
{x = 1, y = 3}
, __rt_5}
, 
offset = {79.51, 19, 15.64}
, size = 5}
, 
{
dirty_spots = {__rt_6, __rt_7, __rt_8, __rt_9, __rt_10, __rt_11, 
{x = -4, y = 5}
, 
{x = -3, y = 5}
, 
{x = -2, y = 5}
, 
{x = -1, y = 5}
, 
{x = 0, y = 5}
, __rt_12, 
{x = -3, y = -2}
, 
{x = -2, y = -3}
, 
{x = -1, y = -4}
, 
{x = 0, y = -5}
, 
{x = 5, y = -5}
, 
{x = 1, y = 4}
, __rt_13, __rt_14, __rt_15, __rt_16}
, id = 2, size = 6}
, 
{
dirty_spots = {
{x = 6, y = -6}
, 
{x = 6, y = -5}
, 
{x = 6, y = -4}
, 
{x = 6, y = -3}
, 
{x = 6, y = -2}
, 
{x = 6, y = -1}
, 
{x = 6, y = 0}
, 
{x = 5, y = -3}
, 
{x = 5, y = -2}
, 
{x = 5, y = -1}
, __rt_16, 
{x = 5, y = 1}
, __rt_17, __rt_15, 
{x = 4, y = 2}
, __rt_18, __rt_14, 
{x = 3, y = 3}
, __rt_13, 
{x = 2, y = 4}
, 
{x = 1, y = 5}
, 
{x = 0, y = 6}
, 
{x = 1, y = -6}
, 
{x = 0, y = -6}
, 
{x = -1, y = -5}
, 
{x = -2, y = -4}
, 
{x = -3, y = -3}
, 
{x = -4, y = -2}
, __rt_12, 
{x = -5, y = -1}
, __rt_6, __rt_7, __rt_8, __rt_9, __rt_10, __rt_11, 
{x = -5, y = 6}
, 
{x = -6, y = 0}
, 
{x = -6, y = 1}
, 
{x = -6, y = 2}
, 
{x = -6, y = 3}
, 
{x = -6, y = 4}
, 
{x = -6, y = 5}
, 
{x = -6, y = 6}
}
, id = 3, 
offset = {26.7, -24, 109.9}
, size = 7}
, 
{id = 4, 
offset = {70.43, 4.05, -53.2}
, size = 2}
, 
{id = 5, 
offset = {25.75, -5.5, -90.65}
}
, 
{id = 6, 
offset = {149.63, 43.65, 3.77}
}
, 
{
dirty_spots = {__rt_1, __rt_2, __rt_3, __rt_4, __rt_5, 
{x = 2, y = 2}
, __rt_18, 
{x = 3, y = 0}
, 
{x = 3, y = -1}
, 
{x = 3, y = -2}
, 
{x = 3, y = -3}
, __rt_20, __rt_17, 
{x = 4, y = -1}
, 
{x = 4, y = -2}
, 
{x = 4, y = -3}
, 
{x = 4, y = -4}
, __rt_20, 
{x = 2, y = -4}
, 
{x = 1, y = -4}
, 
{x = 0, y = -4}
}
, id = 7, 
offset = {142, 41.9, 70.3}
, size = 5}
}
local __default_values = {dirty_spots = __rt_19, id = 1, 
offset = {122, 17.2, -70.36}
, size = 3}
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

