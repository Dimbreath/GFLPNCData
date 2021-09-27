local __rt_1 = {}
local __rt_2 = {1001}
local __rt_3 = {1}
local __rt_4 = {2}
local __rt_5 = {4}
local __rt_6 = {5}
local banner_tv = {
{
[0] = {jump_id = 0, type_id = 1}
}
, 
{
{extra_id = 1, jump_arg = __rt_2, jump_id = 102}
, 
{extra_id = 2, 
jump_arg = {1701}
, jump_id = 103}
, 
{extra_id = 3, 
jump_arg = {1703}
, jump_id = 104}
, 
{extra_id = 4, jump_arg = __rt_3, jump_id = 107}
, 
{extra_id = 5, jump_arg = __rt_4, jump_id = 107}
, 
{extra_id = 6, 
jump_arg = {3}
, jump_id = 107}
, 
{extra_id = 7, jump_arg = __rt_5, jump_id = 107}
, 
{extra_id = 8, jump_arg = __rt_6, jump_id = 107}
, 
{extra_id = 9, jump_id = 21}
, 
{extra_id = 10, jump_id = 22}
, 
{extra_id = 11, jump_id = 0}
; 
[0] = {jump_id = 107}
}
, 
{
[0] = {jump_id = 9, type_id = 3}
}
, 
{
[0] = {jump_id = 7, type_id = 4}
}
, 
{
{extra_id = 1, jump_arg = __rt_3, type_id = 5}
, 
{extra_id = 2, jump_arg = __rt_4, type_id = 5}
, 
{extra_id = 3, 
jump_arg = {7}
, type_id = 5}
, 
{extra_id = 4, jump_arg = __rt_5, type_id = 5}
, 
{extra_id = 5, jump_arg = __rt_6, type_id = 5}
, 
{extra_id = 6, 
jump_arg = {6}
, type_id = 5}
; 
[0] = {type_id = 5}
}
, 
{
[0] = {jump_id = 10, type_id = 6}
}
, 
{
[0] = {jump_id = 23, type_id = 7}
}
, 
{
{extra_id = 1, 
jump_arg = {203}
, jump_id = 105, type_id = 8}
, 
{extra_id = 2, 
jump_arg = {204}
, jump_id = 105, type_id = 8}
, 
{extra_id = 3, 
jump_arg = {403}
, jump_id = 105, type_id = 8}
, 
{extra_id = 4, 
jump_arg = {901}
, jump_id = 24, type_id = 8}
, 
{extra_id = 5, 
jump_arg = {901, 0, 501}
, jump_id = 24, type_id = 8}
, 
{extra_id = 6, 
jump_arg = {701}
, jump_id = 105, type_id = 8}
; 
[0] = {jump_id = 105, type_id = 8}
}
, 
{
[0] = {jump_id = 110, type_id = 9}
}
, 
{
{extra_id = 1, jump_arg = __rt_3, jump_id = 106, type_id = 10}
, 
{extra_id = 2, jump_arg = __rt_5, jump_id = 106, type_id = 10}
; 
[0] = {jump_id = 106, type_id = 10}
}
, 
{
[0] = {jump_id = 0, type_id = 11}
}
, 
{
[0] = {jump_id = 0, type_id = 12}
}
, 
{
[0] = {
jump_arg = {999999}
, jump_id = 109, type_id = 13}
}
, 
{
{extra_id = 1, 
jump_arg = {2001}
, jump_id = 109, type_id = 14}
, 
{extra_id = 2, jump_arg = __rt_2, jump_id = 109, type_id = 14}
, 
{extra_id = 3, 
jump_arg = {1002}
, jump_id = 109, type_id = 14}
, 
{extra_id = 4, 
jump_arg = {4001}
, jump_id = 109, type_id = 14}
; 
[0] = {jump_id = 109, type_id = 14}
}
; 
[0] = {
[0] = {jump_id = 0, type_id = 0}
}
}
local __default_values = {extra_id = 0, jump_arg = __rt_1, jump_id = 108, type_id = 2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(banner_tv) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(banner_tv, {__index = __rawdata})
return banner_tv

