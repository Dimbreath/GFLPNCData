-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {4}
local __rt_3 = {1004}
local __rt_4 = {3}
local __rt_5 = {5}
local gashapon_buildfree_pool = {
{item_reward = 2021, type = 201}
, 
{id = 2, item_reward = 2023, type = 201}
, 
{id = 3, item_reward = 2035, type = 201}
, 
{id = 4, item_reward = 2010, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_4, type = 201}
, 
{id = 5, item_reward = 2013, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_4, type = 201}
, 
{id = 6, item_reward = 2017, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_2, type = 201}
, 
{id = 7, item_reward = 2020, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_2, type = 201}
, 
{id = 8, item_reward = 2016, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_5, type = 201}
, 
{id = 9, item_reward = 2008, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_5, type = 201}
, 
{id = 10, item_reward = 2501, type = 202}
, 
{id = 11, item_reward = 2502, type = 202}
, 
{id = 12, item_reward = 2503, type = 202}
, 
{id = 13, item_reward = 2504, type = 202}
, 
{id = 14, item_reward = 2505, type = 202}
, 
{id = 15, item_reward = 2506, type = 202}
, 
{id = 16, item_reward = 2507, type = 202}
, 
{id = 17, item_reward = 2508, type = 202}
, 
{id = 18, item_reward = 2509, type = 202}
, 
{id = 19, item_reward = 2510, type = 202}
, 
{id = 20, item_reward = 2512, type = 202}
, 
{id = 21, item_reward = 2513, type = 202}
, 
{id = 22, item_reward = 2516, type = 202}
, 
{id = 23, item_reward = 2517, type = 202}
, 
{id = 24, item_reward = 2520, type = 202}
, 
{id = 25, item_reward = 2521, type = 202}
, 
{id = 26, item_reward = 2523, type = 202}
, 
{id = 27, item_reward = 2527, type = 202}
, 
{id = 28, item_reward = 2531, type = 202}
, 
{id = 29, item_reward = 2534, type = 202}
, 
{id = 30, item_reward = 2535, type = 202}
, 
{id = 31, item_reward = 2536, type = 202}
, 
{id = 32, item_reward = 2537, type = 202}
, 
{id = 33, item_reward = 2538, type = 202}
, 
{id = 34, item_reward = 2539, type = 202}
, 
{id = 35, item_reward = 5001}
, 
{id = 36, item_reward = 5002}
, 
{id = 37, item_reward = 5007}
, 
{id = 38}
, 
{id = 39, item_reward = 1102}
, 
{id = 40, item_reward = 1103}
, 
{id = 41, item_reward = 1104}
, 
{id = 42, item_reward = 1105}
, 
{id = 43, item_reward = 1106}
, 
{id = 44, item_reward = 1107}
, 
{id = 45, item_reward = 1108}
, 
{id = 46, item_reward = 1109}
, 
{id = 47, item_reward = 1110}
, 
{id = 48, item_reward = 1111}
, 
{id = 49, item_reward = 1112}
, 
{id = 50, item_reward = 1113}
, 
{id = 51, item_reward = 1114}
, 
{id = 52, item_reward = 1115}
, 
{id = 53, item_reward = 3100}
, 
{id = 54, item_reward = 3101}
, 
{id = 55, item_reward = 3102}
, 
{id = 56, item_reward = 3103}
, 
{id = 57, item_reward = 3104}
, 
{id = 58, item_reward = 3105}
, 
{id = 59, item_reward = 3106}
, 
{id = 60, item_reward = 3107}
, 
{id = 61, item_reward = 3108}
, 
{id = 62, item_reward = 3109}
, 
{id = 63, item_reward = 3110}
, 
{id = 64, item_reward = 3111}
, 
{id = 65, item_reward = 3112}
, 
{id = 66, item_reward = 3113}
, 
{id = 67, item_reward = 3114}
, 
{id = 68, item_reward = 1601}
}
local __default_values = {id = 1, item_reward = 1101, pre_condition = __rt_1, pre_para1 = __rt_1, pre_para2 = __rt_1, type = 203}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(gashapon_buildfree_pool) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
rewardTypeDic = {
[201] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
, 
[202] = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34}
, 
[203] = {35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68}
}
}
setmetatable(gashapon_buildfree_pool, {__index = __rawdata})
return gashapon_buildfree_pool

-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {4}
local __rt_3 = {1004}
local __rt_4 = {3}
local __rt_5 = {5}
local gashapon_buildfree_pool = {
    {item_reward = 2021, type = 201}, {id = 2, item_reward = 2023, type = 201},
    {id = 3, item_reward = 2035, type = 201}, {
        id = 4,
        item_reward = 2010,
        pre_condition = __rt_2,
        pre_para1 = __rt_3,
        pre_para2 = __rt_4,
        type = 201
    }, {
        id = 5,
        item_reward = 2013,
        pre_condition = __rt_2,
        pre_para1 = __rt_3,
        pre_para2 = __rt_4,
        type = 201
    }, {
        id = 6,
        item_reward = 2017,
        pre_condition = __rt_2,
        pre_para1 = __rt_3,
        pre_para2 = __rt_2,
        type = 201
    }, {
        id = 7,
        item_reward = 2020,
        pre_condition = __rt_2,
        pre_para1 = __rt_3,
        pre_para2 = __rt_2,
        type = 201
    }, {
        id = 8,
        item_reward = 2016,
        pre_condition = __rt_2,
        pre_para1 = __rt_3,
        pre_para2 = __rt_5,
        type = 201
    }, {
        id = 9,
        item_reward = 2008,
        pre_condition = __rt_2,
        pre_para1 = __rt_3,
        pre_para2 = __rt_5,
        type = 201
    }, {id = 10, item_reward = 2501, type = 202},
    {id = 11, item_reward = 2502, type = 202},
    {id = 12, item_reward = 2503, type = 202},
    {id = 13, item_reward = 2504, type = 202},
    {id = 14, item_reward = 2505, type = 202},
    {id = 15, item_reward = 2506, type = 202},
    {id = 16, item_reward = 2507, type = 202},
    {id = 17, item_reward = 2508, type = 202},
    {id = 18, item_reward = 2509, type = 202},
    {id = 19, item_reward = 2510, type = 202},
    {id = 20, item_reward = 2512, type = 202},
    {id = 21, item_reward = 2513, type = 202},
    {id = 22, item_reward = 2516, type = 202},
    {id = 23, item_reward = 2517, type = 202},
    {id = 24, item_reward = 2520, type = 202},
    {id = 25, item_reward = 2521, type = 202},
    {id = 26, item_reward = 2523, type = 202},
    {id = 27, item_reward = 2527, type = 202},
    {id = 28, item_reward = 2531, type = 202},
    {id = 29, item_reward = 2534, type = 202},
    {id = 30, item_reward = 2535, type = 202},
    {id = 31, item_reward = 2536, type = 202},
    {id = 32, item_reward = 2537, type = 202},
    {id = 33, item_reward = 2538, type = 202},
    {id = 34, item_reward = 2539, type = 202}, {id = 35, item_reward = 5001},
    {id = 36, item_reward = 5002}, {id = 37, item_reward = 5007}, {id = 38},
    {id = 39, item_reward = 1102}, {id = 40, item_reward = 1103},
    {id = 41, item_reward = 1104}, {id = 42, item_reward = 1105},
    {id = 43, item_reward = 1106}, {id = 44, item_reward = 1107},
    {id = 45, item_reward = 1108}, {id = 46, item_reward = 1109},
    {id = 47, item_reward = 1110}, {id = 48, item_reward = 1111},
    {id = 49, item_reward = 1112}, {id = 50, item_reward = 1113},
    {id = 51, item_reward = 1114}, {id = 52, item_reward = 1115},
    {id = 53, item_reward = 3100}, {id = 54, item_reward = 3101},
    {id = 55, item_reward = 3102}, {id = 56, item_reward = 3103},
    {id = 57, item_reward = 3104}, {id = 58, item_reward = 3105},
    {id = 59, item_reward = 3106}, {id = 60, item_reward = 3107},
    {id = 61, item_reward = 3108}, {id = 62, item_reward = 3109},
    {id = 63, item_reward = 3110}, {id = 64, item_reward = 3111},
    {id = 65, item_reward = 3112}, {id = 66, item_reward = 3113},
    {id = 67, item_reward = 3114}, {id = 68, item_reward = 1601}
}
local __default_values = {
    id = 1,
    item_reward = 1101,
    pre_condition = __rt_1,
    pre_para1 = __rt_1,
    pre_para2 = __rt_1,
    type = 203
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(gashapon_buildfree_pool) do setmetatable(v, base) end
local __rawdata = {
    __basemetatable = base,
    rewardTypeDic = {
        [201] = {1, 2, 3, 4, 5, 6, 7, 8, 9},
        [202] = {
            10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26,
            27, 28, 29, 30, 31, 32, 33, 34
        },
        [203] = {
            35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
            52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68
        }
    }
}
setmetatable(gashapon_buildfree_pool, {__index = __rawdata})
return gashapon_buildfree_pool

