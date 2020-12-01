-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {56, 84, 112, 140}
local __rt_2 = {1; [3] = 2, [4] = 3, [5] = 4}
local __rt_3 = {9, 14, 19, 24}
local __rt_4 = {6, 9, 12, 16}
local __rt_5 = {3, 4, 6, 8}
local __rt_6 = {10, 15, 20, 26}
local __rt_7 = {4, 6, 8, 10}
local __rt_8 = {13, 20, 27, 34}
local ath_affix_pool = {
{affix_para = 2, attribute_num = __rt_1, pool_id = 1}
, 
{affix_para = 202, attribute_num = __rt_3, id = 2, pool_id = 1}
, 
{affix_para = 3, attribute_num = __rt_4, id = 3, pool_id = 1}
, 
{affix_para = 4, id = 4, pool_id = 1}
, 
{affix_para = 204, attribute_num = __rt_6, id = 5, pool_id = 1}
, 
{id = 6, pool_id = 1}
, 
{affix_para = 7, attribute_num = __rt_7, id = 7, pool_id = 1}
, 
{affix_para = 26, attribute_num = __rt_4, id = 8, pool_id = 1}
, 
{affix_para = 2, attribute_num = __rt_1, id = 9, pool_id = 2}
, 
{affix_para = 3, attribute_num = __rt_4, id = 10, pool_id = 2}
, 
{affix_para = 203, attribute_num = __rt_3, id = 11, pool_id = 2}
, 
{affix_para = 4, id = 12, pool_id = 2}
, 
{id = 13, pool_id = 2}
, 
{affix_para = 212, attribute_num = __rt_6, id = 14, pool_id = 2}
, 
{affix_para = 9, attribute_num = __rt_7, id = 15, pool_id = 2}
, 
{affix_para = 10, attribute_num = __rt_8, id = 16, pool_id = 2}
, 
{affix_para = 226, attribute_num = __rt_3, id = 17, pool_id = 2}
, 
{affix_para = 26, attribute_num = __rt_4, id = 18, pool_id = 2}
, 
{affix_para = 2, attribute_num = __rt_1, id = 19}
, 
{affix_para = 202, attribute_num = __rt_3, id = 20}
, 
{affix_para = 3, attribute_num = __rt_4, id = 21}
, 
{affix_para = 203, attribute_num = __rt_3, id = 22}
, 
{affix_para = 4, id = 23}
, 
{id = 24}
, 
{affix_para = 7, attribute_num = __rt_7, id = 25}
, 
{affix_para = 9, attribute_num = __rt_7, id = 26}
, 
{affix_para = 10, attribute_num = __rt_8, id = 27}
, 
{affix_para = 226, attribute_num = __rt_3, id = 28}
, 
{affix_para = 26, attribute_num = __rt_4, id = 29}
}
local __default_values = {affix_para = 12, affix_type = 1, attribute_num = __rt_5, id = 1, pool_id = 3, qualityIndexDic = __rt_2}
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

-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {56, 84, 112, 140}
local __rt_2 = {1, [3] = 2, [4] = 3, [5] = 4}
local __rt_3 = {9, 14, 19, 24}
local __rt_4 = {6, 9, 12, 16}
local __rt_5 = {3, 4, 6, 8}
local __rt_6 = {10, 15, 20, 26}
local __rt_7 = {4, 6, 8, 10}
local __rt_8 = {13, 20, 27, 34}
local ath_affix_pool = {
    {affix_para = 2, attribute_num = __rt_1, pool_id = 1},
    {affix_para = 202, attribute_num = __rt_3, id = 2, pool_id = 1},
    {affix_para = 3, attribute_num = __rt_4, id = 3, pool_id = 1},
    {affix_para = 4, id = 4, pool_id = 1},
    {affix_para = 204, attribute_num = __rt_6, id = 5, pool_id = 1},
    {id = 6, pool_id = 1},
    {affix_para = 7, attribute_num = __rt_7, id = 7, pool_id = 1},
    {affix_para = 26, attribute_num = __rt_4, id = 8, pool_id = 1},
    {affix_para = 2, attribute_num = __rt_1, id = 9, pool_id = 2},
    {affix_para = 3, attribute_num = __rt_4, id = 10, pool_id = 2},
    {affix_para = 203, attribute_num = __rt_3, id = 11, pool_id = 2},
    {affix_para = 4, id = 12, pool_id = 2}, {id = 13, pool_id = 2},
    {affix_para = 212, attribute_num = __rt_6, id = 14, pool_id = 2},
    {affix_para = 9, attribute_num = __rt_7, id = 15, pool_id = 2},
    {affix_para = 10, attribute_num = __rt_8, id = 16, pool_id = 2},
    {affix_para = 226, attribute_num = __rt_3, id = 17, pool_id = 2},
    {affix_para = 26, attribute_num = __rt_4, id = 18, pool_id = 2},
    {affix_para = 2, attribute_num = __rt_1, id = 19},
    {affix_para = 202, attribute_num = __rt_3, id = 20},
    {affix_para = 3, attribute_num = __rt_4, id = 21},
    {affix_para = 203, attribute_num = __rt_3, id = 22},
    {affix_para = 4, id = 23}, {id = 24},
    {affix_para = 7, attribute_num = __rt_7, id = 25},
    {affix_para = 9, attribute_num = __rt_7, id = 26},
    {affix_para = 10, attribute_num = __rt_8, id = 27},
    {affix_para = 226, attribute_num = __rt_3, id = 28},
    {affix_para = 26, attribute_num = __rt_4, id = 29}
}
local __default_values = {
    affix_para = 12,
    affix_type = 1,
    attribute_num = __rt_5,
    id = 1,
    pool_id = 3,
    qualityIndexDic = __rt_2
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(ath_affix_pool) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(ath_affix_pool, {__index = __rawdata})
return ath_affix_pool

