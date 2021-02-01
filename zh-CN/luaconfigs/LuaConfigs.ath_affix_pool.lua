-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {86, 173, 346, 867}
local __rt_2 = {1; [3] = 2, [4] = 3, [5] = 4}
local __rt_3 = {4, 8, 16, 40}
local __rt_4 = {2, 4, 8, 22}
local __rt_5 = {1, 2, 4, 11}
local __rt_6 = {2, 5, 11, 28}
local __rt_7 = {3, 7, 14, 35}
local __rt_8 = {4, 8, 17, 43}
local __rt_9 = {24, 49, 99, 247}
local __rt_10 = {3, 6, 12, 32}
local __rt_11 = {6, 13, 26, 67}
local __rt_12 = {1, 3, 7, 18}
local ath_affix_pool = {
{affix_para = 2, attribute_num = __rt_1}
, 
{affix_para = 3, attribute_num = __rt_3, id = 2}
, 
{affix_para = 4, id = 3}
, 
{affix_para = 5, attribute_num = __rt_5, id = 4}
, 
{affix_para = 7, attribute_num = __rt_6, id = 5}
, 
{affix_para = 9, attribute_num = __rt_7, id = 6}
, 
{attribute_num = __rt_8, id = 7}
, 
{affix_para = 12, id = 8}
, 
{affix_para = 14, id = 9}
, 
{affix_para = 15, attribute_num = __rt_9, id = 10}
, 
{affix_para = 20, id = 11}
, 
{affix_para = 21, attribute_num = __rt_10, id = 12}
, 
{affix_para = 26, attribute_num = __rt_3, id = 13}
, 
{affix_para = 203, attribute_num = __rt_11, id = 14}
, 
{affix_para = 226, attribute_num = __rt_11, id = 15}
, 
{affix_para = 2, attribute_num = __rt_1, id = 16, pool_id = 2}
, 
{affix_para = 3, attribute_num = __rt_3, id = 17, pool_id = 2}
, 
{affix_para = 4, id = 18, pool_id = 2}
, 
{affix_para = 5, attribute_num = __rt_5, id = 19, pool_id = 2}
, 
{affix_para = 7, attribute_num = __rt_6, id = 20, pool_id = 2}
, 
{affix_para = 9, attribute_num = __rt_7, id = 21, pool_id = 2}
, 
{attribute_num = __rt_8, id = 22, pool_id = 2}
, 
{affix_para = 12, id = 23, pool_id = 2}
, 
{affix_para = 14, id = 24, pool_id = 2}
, 
{affix_para = 15, attribute_num = __rt_9, id = 25, pool_id = 2}
, 
{affix_para = 20, id = 26, pool_id = 2}
, 
{affix_para = 21, attribute_num = __rt_10, id = 27, pool_id = 2}
, 
{affix_para = 26, attribute_num = __rt_3, id = 28, pool_id = 2}
, 
{affix_para = 202, attribute_num = __rt_11, id = 29, pool_id = 2}
, 
{affix_para = 2, attribute_num = __rt_1, id = 30, pool_id = 3}
, 
{affix_para = 3, attribute_num = __rt_3, id = 31, pool_id = 3}
, 
{affix_para = 4, id = 32, pool_id = 3}
, 
{affix_para = 5, attribute_num = __rt_5, id = 33, pool_id = 3}
, 
{affix_para = 7, attribute_num = __rt_6, id = 34, pool_id = 3}
, 
{affix_para = 9, attribute_num = __rt_7, id = 35, pool_id = 3}
, 
{attribute_num = __rt_8, id = 36, pool_id = 3}
, 
{affix_para = 12, id = 37, pool_id = 3}
, 
{affix_para = 14, id = 38, pool_id = 3}
, 
{affix_para = 15, attribute_num = __rt_9, id = 39, pool_id = 3}
, 
{affix_para = 20, id = 40, pool_id = 3}
, 
{affix_para = 21, attribute_num = __rt_10, id = 41, pool_id = 3}
, 
{affix_para = 23, attribute_num = __rt_12, id = 42, pool_id = 3}
, 
{affix_para = 26, attribute_num = __rt_3, id = 43, pool_id = 3}
, 
{affix_para = 2, attribute_num = __rt_1, id = 44, pool_id = 4}
, 
{affix_para = 3, attribute_num = __rt_3, id = 45, pool_id = 4}
, 
{affix_para = 4, id = 46, pool_id = 4}
, 
{affix_para = 5, attribute_num = __rt_5, id = 47, pool_id = 4}
, 
{affix_para = 7, attribute_num = __rt_6, id = 48, pool_id = 4}
, 
{affix_para = 9, attribute_num = __rt_7, id = 49, pool_id = 4}
, 
{attribute_num = __rt_8, id = 50, pool_id = 4}
, 
{affix_para = 12, id = 51, pool_id = 4}
, 
{affix_para = 14, id = 52, pool_id = 4}
, 
{affix_para = 15, attribute_num = __rt_9, id = 53, pool_id = 4}
, 
{affix_para = 20, id = 54, pool_id = 4}
, 
{affix_para = 21, attribute_num = __rt_10, id = 55, pool_id = 4}
, 
{affix_para = 26, attribute_num = __rt_3, id = 56, pool_id = 4}
, 
{affix_para = 203, attribute_num = __rt_11, id = 57, pool_id = 4}
, 
{affix_para = 226, attribute_num = __rt_11, id = 58, pool_id = 4}
, 
{affix_para = 2, attribute_num = __rt_1, id = 59, pool_id = 5}
, 
{affix_para = 3, attribute_num = __rt_3, id = 60, pool_id = 5}
, 
{affix_para = 4, id = 61, pool_id = 5}
, 
{affix_para = 5, attribute_num = __rt_5, id = 62, pool_id = 5}
, 
{affix_para = 7, attribute_num = __rt_6, id = 63, pool_id = 5}
, 
{affix_para = 9, attribute_num = __rt_7, id = 64, pool_id = 5}
, 
{attribute_num = __rt_8, id = 65, pool_id = 5}
, 
{affix_para = 12, id = 66, pool_id = 5}
, 
{affix_para = 14, id = 67, pool_id = 5}
, 
{affix_para = 15, attribute_num = __rt_9, id = 68, pool_id = 5}
, 
{affix_para = 20, id = 69, pool_id = 5}
, 
{affix_para = 21, attribute_num = __rt_10, id = 70, pool_id = 5}
, 
{affix_para = 26, attribute_num = __rt_3, id = 71, pool_id = 5}
, 
{affix_para = 202, attribute_num = __rt_11, id = 72, pool_id = 5}
, 
{affix_para = 2, attribute_num = __rt_1, id = 73, pool_id = 6}
, 
{affix_para = 3, attribute_num = __rt_3, id = 74, pool_id = 6}
, 
{affix_para = 4, id = 75, pool_id = 6}
, 
{affix_para = 5, attribute_num = __rt_5, id = 76, pool_id = 6}
, 
{affix_para = 7, attribute_num = __rt_6, id = 77, pool_id = 6}
, 
{affix_para = 9, attribute_num = __rt_7, id = 78, pool_id = 6}
, 
{attribute_num = __rt_8, id = 79, pool_id = 6}
, 
{affix_para = 12, id = 80, pool_id = 6}
, 
{affix_para = 14, id = 81, pool_id = 6}
, 
{affix_para = 15, attribute_num = __rt_9, id = 82, pool_id = 6}
, 
{affix_para = 20, id = 83, pool_id = 6}
, 
{affix_para = 21, attribute_num = __rt_10, id = 84, pool_id = 6}
, 
{affix_para = 23, attribute_num = __rt_12, id = 85, pool_id = 6}
, 
{affix_para = 26, attribute_num = __rt_3, id = 86, pool_id = 6}
, 
{affix_para = 2, attribute_num = __rt_1, id = 87, pool_id = 7}
, 
{affix_para = 3, attribute_num = __rt_3, id = 88, pool_id = 7}
, 
{affix_para = 4, id = 89, pool_id = 7}
, 
{affix_para = 5, attribute_num = __rt_5, id = 90, pool_id = 7}
, 
{affix_para = 7, attribute_num = __rt_6, id = 91, pool_id = 7}
, 
{affix_para = 9, attribute_num = __rt_7, id = 92, pool_id = 7}
, 
{attribute_num = __rt_8, id = 93, pool_id = 7}
, 
{affix_para = 12, id = 94, pool_id = 7}
, 
{affix_para = 14, id = 95, pool_id = 7}
, 
{affix_para = 15, attribute_num = __rt_9, id = 96, pool_id = 7}
, 
{affix_para = 20, id = 97, pool_id = 7}
, 
{affix_para = 21, attribute_num = __rt_10, id = 98, pool_id = 7}
, 
{affix_para = 26, attribute_num = __rt_3, id = 99, pool_id = 7}
, 
{affix_para = 203, attribute_num = __rt_11, id = 100, pool_id = 7}
, 
{affix_para = 226, attribute_num = __rt_11, id = 101, pool_id = 7}
, 
{affix_para = 2, attribute_num = __rt_1, id = 102, pool_id = 8}
, 
{affix_para = 3, attribute_num = __rt_3, id = 103, pool_id = 8}
, 
{affix_para = 4, id = 104, pool_id = 8}
, 
{affix_para = 5, attribute_num = __rt_5, id = 105, pool_id = 8}
, 
{affix_para = 7, attribute_num = __rt_6, id = 106, pool_id = 8}
, 
{affix_para = 9, attribute_num = __rt_7, id = 107, pool_id = 8}
, 
{attribute_num = __rt_8, id = 108, pool_id = 8}
, 
{affix_para = 12, id = 109, pool_id = 8}
, 
{affix_para = 14, id = 110, pool_id = 8}
, 
{affix_para = 15, attribute_num = __rt_9, id = 111, pool_id = 8}
, 
{affix_para = 20, id = 112, pool_id = 8}
, 
{affix_para = 21, attribute_num = __rt_10, id = 113, pool_id = 8}
, 
{affix_para = 26, attribute_num = __rt_3, id = 114, pool_id = 8}
, 
{affix_para = 202, attribute_num = __rt_11, id = 115, pool_id = 8}
, 
{affix_para = 2, attribute_num = __rt_1, id = 116, pool_id = 9}
, 
{affix_para = 3, attribute_num = __rt_3, id = 117, pool_id = 9}
, 
{affix_para = 4, id = 118, pool_id = 9}
, 
{affix_para = 5, attribute_num = __rt_5, id = 119, pool_id = 9}
, 
{affix_para = 7, attribute_num = __rt_6, id = 120, pool_id = 9}
, 
{affix_para = 9, attribute_num = __rt_7, id = 121, pool_id = 9}
, 
{attribute_num = __rt_8, id = 122, pool_id = 9}
, 
{affix_para = 12, id = 123, pool_id = 9}
, 
{affix_para = 14, id = 124, pool_id = 9}
, 
{affix_para = 15, attribute_num = __rt_9, id = 125, pool_id = 9}
, 
{affix_para = 20, id = 126, pool_id = 9}
, 
{affix_para = 21, attribute_num = __rt_10, id = 127, pool_id = 9}
, 
{affix_para = 23, attribute_num = __rt_12, id = 128, pool_id = 9}
, 
{affix_para = 26, attribute_num = __rt_3, id = 129, pool_id = 9}
}
local __default_values = {affix_para = 10, affix_type = 1, attribute_num = __rt_4, id = 1, pool_id = 1, qualityIndexDic = __rt_2}
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

