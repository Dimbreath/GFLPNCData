-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {10}
local __rt_2 = {15}
local __rt_3 = {22}
local __rt_4 = {30}
local camp_connection = {
{
[11] = {
para = {2, 10}
, text = 231535}
, 
[12] = {fetters_num = 12, 
para = {4, 20}
, text = 231535}
, 
[13] = {fetters_num = 13, 
para = {6, 30, 2, 10}
, text = 438606}
, 
[14] = {fetters_num = 14, 
para = {8, 40, 2, 20}
, text = 438606}
}
, 
{
[11] = {
para = {5}
, text = 333021}
, 
[12] = {fetters_num = 12, text = 333021}
, 
[13] = {fetters_num = 13, 
para = {15, 3}
, text = 282554}
, 
[14] = {fetters_num = 14, 
para = {20, 4}
, text = 282554}
}
, 
{
[11] = {
para = {10, 10}
, text = 85698}
, 
[12] = {fetters_num = 12, 
para = {15, 18}
, text = 85698}
, 
[13] = {fetters_num = 13, 
para = {22, 25}
, text = 85698}
, 
[14] = {fetters_num = 14, 
para = {30, 40}
, text = 85698}
}
, 
{
[11] = {}
, 
[12] = {fetters_num = 12, para = __rt_2}
, 
[13] = {fetters_num = 13, para = __rt_3}
, 
[14] = {fetters_num = 14, para = __rt_4}
}
, 
{
[11] = {text = 284253}
, 
[12] = {fetters_num = 12, para = __rt_2, text = 284253}
, 
[13] = {fetters_num = 13, para = __rt_3, text = 284253}
, 
[14] = {fetters_num = 14, para = __rt_4, text = 284253}
}
}
local __default_values = {fetters_num = 11, para = __rt_1, text = 189941}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(camp_connection) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base, 
fetterList = {
{11, 12, 13, 14}
, 
{11, 12, 13, 14}
, 
{11, 12, 13, 14}
, 
{11, 12, 13, 14}
, 
{11, 12, 13, 14}
}
}
setmetatable(camp_connection, {__index = __rawdata})
return camp_connection

