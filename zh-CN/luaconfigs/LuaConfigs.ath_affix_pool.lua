-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {154, 231, 462, 770}
local __rt_2 = {1; [3] = 2, [4] = 3, [5] = 4}
local __rt_3 = {5, 8, 17, 28}
local __rt_4 = {6, 10, 20, 33}
local __rt_5 = {7, 11, 23, 39}
local __rt_6 = {9, 14, 28, 48}
local __rt_7 = {19, 28, 57, 96}
local __rt_8 = {2, 3, 7, 12}
local __rt_9 = {6, 9, 18, 30}
local __rt_10 = {36, 55, 110, 184}
local __rt_11 = {14, 21, 43, 72}
local __rt_12 = {4, 7, 14, 24}
local ath_affix_pool = {
{affix_para = 2, attribute_num = __rt_1}
, 
{affix_para = 3, id = 2}
, 
{affix_para = 4, attribute_num = __rt_4, id = 3}
, 
{affix_para = 19, attribute_num = __rt_5, id = 4}
, 
{affix_para = 9, attribute_num = __rt_6, id = 5}
, 
{attribute_num = __rt_7, id = 6}
, 
{affix_para = 12, attribute_num = __rt_8, id = 7}
, 
{affix_para = 14, attribute_num = __rt_9, id = 8}
, 
{affix_para = 15, attribute_num = __rt_10, id = 9}
, 
{affix_para = 26, id = 10}
, 
{affix_para = 203, attribute_num = __rt_11, id = 11}
, 
{affix_para = 226, attribute_num = __rt_11, id = 12}
, 
{affix_para = 2, attribute_num = __rt_1, id = 13, pool_id = 2}
, 
{affix_para = 3, id = 14, pool_id = 2}
, 
{affix_para = 4, attribute_num = __rt_4, id = 15, pool_id = 2}
, 
{affix_para = 9, attribute_num = __rt_6, id = 16, pool_id = 2}
, 
{attribute_num = __rt_7, id = 17, pool_id = 2}
, 
{affix_para = 12, attribute_num = __rt_8, id = 18, pool_id = 2}
, 
{affix_para = 14, attribute_num = __rt_9, id = 19, pool_id = 2}
, 
{affix_para = 15, attribute_num = __rt_10, id = 20, pool_id = 2}
, 
{affix_para = 20, attribute_num = __rt_5, id = 21, pool_id = 2}
, 
{affix_para = 26, id = 22, pool_id = 2}
, 
{affix_para = 202, attribute_num = __rt_11, id = 23, pool_id = 2}
, 
{affix_para = 2, attribute_num = __rt_1, id = 24, pool_id = 3}
, 
{affix_para = 3, id = 25, pool_id = 3}
, 
{affix_para = 4, attribute_num = __rt_4, id = 26, pool_id = 3}
, 
{affix_para = 7, attribute_num = __rt_5, id = 27, pool_id = 3}
, 
{affix_para = 9, attribute_num = __rt_6, id = 28, pool_id = 3}
, 
{attribute_num = __rt_7, id = 29, pool_id = 3}
, 
{affix_para = 12, attribute_num = __rt_8, id = 30, pool_id = 3}
, 
{affix_para = 14, attribute_num = __rt_9, id = 31, pool_id = 3}
, 
{affix_para = 15, attribute_num = __rt_10, id = 32, pool_id = 3}
, 
{affix_para = 21, attribute_num = __rt_12, id = 33, pool_id = 3}
, 
{affix_para = 23, attribute_num = __rt_6, id = 34, pool_id = 3}
, 
{affix_para = 26, id = 35, pool_id = 3}
, 
{affix_para = 2, attribute_num = __rt_1, id = 36, pool_id = 4}
, 
{affix_para = 3, id = 37, pool_id = 4}
, 
{affix_para = 4, attribute_num = __rt_4, id = 38, pool_id = 4}
, 
{affix_para = 19, attribute_num = __rt_5, id = 39, pool_id = 4}
, 
{affix_para = 9, attribute_num = __rt_6, id = 40, pool_id = 4}
, 
{attribute_num = __rt_7, id = 41, pool_id = 4}
, 
{affix_para = 12, attribute_num = __rt_8, id = 42, pool_id = 4}
, 
{affix_para = 14, attribute_num = __rt_9, id = 43, pool_id = 4}
, 
{affix_para = 15, attribute_num = __rt_10, id = 44, pool_id = 4}
, 
{affix_para = 26, id = 45, pool_id = 4}
, 
{affix_para = 203, attribute_num = __rt_11, id = 46, pool_id = 4}
, 
{affix_para = 226, attribute_num = __rt_11, id = 47, pool_id = 4}
, 
{affix_para = 2, attribute_num = __rt_1, id = 48, pool_id = 5}
, 
{affix_para = 3, id = 49, pool_id = 5}
, 
{affix_para = 4, attribute_num = __rt_4, id = 50, pool_id = 5}
, 
{affix_para = 9, attribute_num = __rt_6, id = 51, pool_id = 5}
, 
{attribute_num = __rt_7, id = 52, pool_id = 5}
, 
{affix_para = 12, attribute_num = __rt_8, id = 53, pool_id = 5}
, 
{affix_para = 14, attribute_num = __rt_9, id = 54, pool_id = 5}
, 
{affix_para = 15, attribute_num = __rt_10, id = 55, pool_id = 5}
, 
{affix_para = 20, attribute_num = __rt_5, id = 56, pool_id = 5}
, 
{affix_para = 26, id = 57, pool_id = 5}
, 
{affix_para = 202, attribute_num = __rt_11, id = 58, pool_id = 5}
, 
{affix_para = 2, attribute_num = __rt_1, id = 59, pool_id = 6}
, 
{affix_para = 3, id = 60, pool_id = 6}
, 
{affix_para = 4, attribute_num = __rt_4, id = 61, pool_id = 6}
, 
{affix_para = 7, attribute_num = __rt_5, id = 62, pool_id = 6}
, 
{affix_para = 9, attribute_num = __rt_6, id = 63, pool_id = 6}
, 
{attribute_num = __rt_7, id = 64, pool_id = 6}
, 
{affix_para = 12, attribute_num = __rt_8, id = 65, pool_id = 6}
, 
{affix_para = 14, attribute_num = __rt_9, id = 66, pool_id = 6}
, 
{affix_para = 15, attribute_num = __rt_10, id = 67, pool_id = 6}
, 
{affix_para = 21, attribute_num = __rt_12, id = 68, pool_id = 6}
, 
{affix_para = 23, attribute_num = __rt_6, id = 69, pool_id = 6}
, 
{affix_para = 26, id = 70, pool_id = 6}
, 
{affix_para = 2, attribute_num = __rt_1, id = 71, pool_id = 7}
, 
{affix_para = 3, id = 72, pool_id = 7}
, 
{affix_para = 4, attribute_num = __rt_4, id = 73, pool_id = 7}
, 
{affix_para = 19, attribute_num = __rt_5, id = 74, pool_id = 7}
, 
{affix_para = 9, attribute_num = __rt_6, id = 75, pool_id = 7}
, 
{attribute_num = __rt_7, id = 76, pool_id = 7}
, 
{affix_para = 12, attribute_num = __rt_8, id = 77, pool_id = 7}
, 
{affix_para = 14, attribute_num = __rt_9, id = 78, pool_id = 7}
, 
{affix_para = 15, attribute_num = __rt_10, id = 79, pool_id = 7}
, 
{affix_para = 26, id = 80, pool_id = 7}
, 
{affix_para = 203, attribute_num = __rt_11, id = 81, pool_id = 7}
, 
{affix_para = 226, attribute_num = __rt_11, id = 82, pool_id = 7}
, 
{affix_para = 2, attribute_num = __rt_1, id = 83, pool_id = 8}
, 
{affix_para = 3, id = 84, pool_id = 8}
, 
{affix_para = 4, attribute_num = __rt_4, id = 85, pool_id = 8}
, 
{affix_para = 9, attribute_num = __rt_6, id = 86, pool_id = 8}
, 
{attribute_num = __rt_7, id = 87, pool_id = 8}
, 
{affix_para = 12, attribute_num = __rt_8, id = 88, pool_id = 8}
, 
{affix_para = 14, attribute_num = __rt_9, id = 89, pool_id = 8}
, 
{affix_para = 15, attribute_num = __rt_10, id = 90, pool_id = 8}
, 
{affix_para = 20, attribute_num = __rt_5, id = 91, pool_id = 8}
, 
{affix_para = 26, id = 92, pool_id = 8}
, 
{affix_para = 202, attribute_num = __rt_11, id = 93, pool_id = 8}
, 
{affix_para = 2, attribute_num = __rt_1, id = 94, pool_id = 9}
, 
{affix_para = 3, id = 95, pool_id = 9}
, 
{affix_para = 4, attribute_num = __rt_4, id = 96, pool_id = 9}
, 
{affix_para = 7, attribute_num = __rt_5, id = 97, pool_id = 9}
, 
{affix_para = 9, attribute_num = __rt_6, id = 98, pool_id = 9}
, 
{attribute_num = __rt_7, id = 99, pool_id = 9}
, 
{affix_para = 12, attribute_num = __rt_8, id = 100, pool_id = 9}
, 
{affix_para = 14, attribute_num = __rt_9, id = 101, pool_id = 9}
, 
{affix_para = 15, attribute_num = __rt_10, id = 102, pool_id = 9}
, 
{affix_para = 21, attribute_num = __rt_12, id = 103, pool_id = 9}
, 
{affix_para = 23, attribute_num = __rt_6, id = 104, pool_id = 9}
, 
{affix_para = 26, id = 105, pool_id = 9}
}
local __default_values = {affix_para = 10, affix_type = 1, attribute_num = __rt_3, id = 1, pool_id = 1, qualityIndexDic = __rt_2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(ath_affix_pool) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(ath_affix_pool, {__index = __rawdata})
return ath_affix_pool

