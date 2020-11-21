-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1003, 5003}
local __rt_2 = {countList = {500, 1}}
local __rt_3 = {}
local __rt_4 = {countList = {2000, 10}}
local __rt_5 = {countList = {5000, 25}}
local __rt_6 = {10000, 55, 1}
local __rt_7 = {1003, 5003, 1502}
local __rt_8 = {30000, 70, 1}
local __rt_9 = {50000, 80, 1}
local __rt_10 = {100000, 90, 1}
local __rt_11 = {150000, 100, 1}
local __rt_12 = {}
local __rt_13 = {countList = __rt_12, itemIdList = __rt_12}
local __rt_14 = {1003, 5003, 1501}
local __rt_15 = {1003, 5003, 1505}
local __rt_16 = {1003, 5003, 1503}
local __rt_17 = {1003, 5003, 1504}
local hero_skill_level = {
    {
        __rt_2, __rt_3, __rt_4, __rt_5,
        {countList = __rt_6, itemIdList = __rt_7},
        {countList = __rt_8, itemIdList = __rt_7},
        {countList = __rt_9, itemIdList = __rt_7},
        {countList = __rt_10, itemIdList = __rt_7},
        {countList = __rt_11, itemIdList = __rt_7}, __rt_13
    }, {
        __rt_2, __rt_3, __rt_4, __rt_5,
        {countList = __rt_6, itemIdList = __rt_14},
        {countList = __rt_8, itemIdList = __rt_14},
        {countList = __rt_9, itemIdList = __rt_14},
        {countList = __rt_10, itemIdList = __rt_14},
        {countList = __rt_11, itemIdList = __rt_14},
        {countList = {}, itemIdList = {}}
    }, {
        __rt_2, __rt_3, __rt_4, __rt_5,
        {countList = __rt_6, itemIdList = __rt_15},
        {countList = __rt_8, itemIdList = __rt_15},
        {countList = __rt_9, itemIdList = __rt_15},
        {countList = __rt_10, itemIdList = __rt_15},
        {countList = __rt_11, itemIdList = __rt_15},
        {countList = {}, itemIdList = {}}
    }, {
        __rt_2, __rt_3, __rt_4, __rt_5,
        {countList = __rt_6, itemIdList = __rt_16},
        {countList = __rt_8, itemIdList = __rt_16},
        {countList = __rt_9, itemIdList = __rt_16},
        {countList = __rt_10, itemIdList = __rt_16},
        {countList = __rt_11, itemIdList = __rt_16},
        {countList = {}, itemIdList = {}}
    }, {
        __rt_2, __rt_3, __rt_4, __rt_5,
        {countList = __rt_6, itemIdList = __rt_17},
        {countList = __rt_8, itemIdList = __rt_17},
        {countList = __rt_9, itemIdList = __rt_17},
        {countList = __rt_10, itemIdList = __rt_17},
        {countList = __rt_11, itemIdList = __rt_17},
        {countList = {}, itemIdList = {}}
    }
}
local __default_values = {countList = {1000, 4}, itemIdList = __rt_1}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(hero_skill_level) do
    for k1, v1 in pairs(v) do setmetatable(v1, base) end
end
local __rawdata = {
    __basemetatable = base,
    allSkillUpItemIdList = {1003, 5003, 1502, 1501, 1505, 1503, 1504}
}
setmetatable(hero_skill_level, {__index = __rawdata})
return hero_skill_level

