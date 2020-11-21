-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {5}
local __rt_2 = {1}
local __rt_3 = {1006}
local __rt_4 = {1002}
local __rt_5 = {100}
local active = {
    {
        {rewardIds = {1007}, rewardNums = {50}},
        {id = 2, rewardIds = {5003}, rewardNums = __rt_1},
        {id = 3, rewardIds = {1506}, rewardNums = __rt_2},
        {id = 4, rewardIds = __rt_3, rewardNums = {20}}, {id = 5}
    }, {
        {activeId = 8, rewardIds = {6002}, rewardNums = {2}, type = 2},
        {
            activeId = 8,
            id = 2,
            rewardIds = {5007},
            rewardNums = __rt_2,
            type = 2
        },
        {
            activeId = 8,
            id = 3,
            rewardIds = {5005},
            rewardNums = __rt_1,
            type = 2
        }, {activeId = 8, id = 4, rewardIds = __rt_3, type = 2},
        {activeId = 8, id = 5, rewardNums = {300}, type = 2}
    }
}
local __default_values = {
    activeId = 7,
    activeNum = 20,
    id = 1,
    rewardIds = __rt_4,
    rewardNums = __rt_5,
    type = 1
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(active) do for k1, v1 in pairs(v) do setmetatable(v1, base) end end
local __rawdata = {__basemetatable = base}
setmetatable(active, {__index = __rawdata})
return active

