-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {-1}
local rookie_star = {
{}
}
local __default_values = {bg_path = "", enter_path = "", 
extra_para = {
[2] = {1001}
}
, id = 1, name = 487929, 
phase = {
{name = 53077, para = -1, task = 100100, type = 1}
, 
{name = 382594, para = 1, task = 100200, type = 1}
, 
{name = 187823, para = 2, task = 100300, type = 1}
, 
{name = 517340, para = 3, task = 100400, type = 1}
, 
{name = 322569, para = 4, task = 100500, type = 1}
, 
{name = 127798, para = 5, task = 100600, type = 1}
, 
{name = 457315, para = 6, task = 100700, type = 1}
, 
{name = 262544, para = 7, task = 100800, type = 1}
, 
{name = 67773, para = 8, task = 100900, type = 1}
, 
{name = 62431, para = 9, task = 101000, type = 1}
}
, 
pre_condition = {12}
, pre_para1 = __rt_1, pre_para2 = __rt_1, system_id = 2300}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(rookie_star) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(rookie_star, {__index = __rawdata})
return rookie_star

