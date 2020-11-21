-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {5, 11}
local __rt_2 = {2, 7}
local __rt_3 = {5, 13}
local __rt_4 = {3, 8}
local __rt_5 = {4, 10}
local __rt_6 = {0, 1}
local ath_optimize = {
    {base_section = {18, 44}, base_success = 8000, unit_section = 10},
    {base_section = __rt_1, density = 3, optimize_id = 2, unit_section = 11}, {
        base_section = {4, 11},
        base_success = 4000,
        density = 2,
        optimize_id = 3,
        unit_section = 15
    }, {base_section = __rt_1, density = 1, optimize_id = 4, unit_section = 12},
    {base_section = __rt_2, base_success = 3000, density = 2, optimize_id = 5},
    {base_section = __rt_3, optimize_id = 6},
    {base_section = __rt_2, base_success = 3000, density = 2, optimize_id = 7},
    {base_section = __rt_3, optimize_id = 8, unit_section = 7},
    {base_section = __rt_4, base_success = 3000, optimize_id = 9}, {
        base_section = {1, 3},
        base_success = 3000,
        density = 1,
        optimize_id = 10,
        unit_section = 9
    }, {base_section = __rt_4, base_success = 3000, optimize_id = 11},
    {base_section = {7, 16}, optimize_id = 12, unit_section = 9},
    {base_section = __rt_5, optimize_id = 13, unit_section = 5}, {
        base_section = __rt_2,
        base_success = 3000,
        density = 2,
        optimize_id = 14,
        unit_section = 9
    },
    {base_section = __rt_2, base_success = 3000, density = 4, optimize_id = 15},
    {base_section = __rt_4, density = 3, optimize_id = 16, unit_section = 7},
    {base_section = __rt_4, optimize_id = 17}, {
        base_section = __rt_4,
        base_success = 2000,
        density = 4,
        optimize_id = 18,
        unit_section = 5
    }, {base_section = {1, 4}, optimize_id = 19, unit_section = 2}, {
        base_section = {8, 19},
        base_success = 3000,
        density = 3,
        optimize_id = 20,
        unit_section = 18
    }, {
        base_section = {2, 5},
        base_success = 4000,
        optimize_id = 21,
        unit_section = 2
    }, {density = 3, optimize_id = 22, unit_section = 0},
    {optimize_id = 23, unit_section = 0},
    {density = 8, optimize_id = 24, unit_section = 0},
    {density = 3, optimize_id = 25, unit_section = 0},
    {density = 3, optimize_id = 26, unit_section = 0},
    {base_section = __rt_5, density = 2, optimize_id = 27, unit_section = 14}
}
local __default_values = {
    base_section = __rt_6,
    base_success = 5000,
    density = 5,
    optimize_id = 1,
    unit_section = 4
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(ath_optimize) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(ath_optimize, {__index = __rawdata})
return ath_optimize

