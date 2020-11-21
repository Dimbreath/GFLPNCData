-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1}
local __rt_2 = {100}
local __rt_3 = {}
local __rt_4 = {10, 30, 50}
local __rt_5 = {2, 4, 8}
local shop = {
    [101] = {name = 158420, name_en = "CHONGZHI"},
    [201] = {
        id = 201,
        name = 44696,
        name_en = "COMPETITIVE",
        refreshCostId = 1002,
        refreshCostNum = __rt_4,
        refresh_times = __rt_5,
        shop_type = 2
    },
    [202] = {
        id = 202,
        refreshCostId = 1002,
        refreshCostNum = __rt_4,
        refresh_times = __rt_5,
        shop_type = 2
    },
    [203] = {
        id = 203,
        name = 39628,
        name_en = "RESIDENT",
        pre_condition = __rt_3,
        pre_para1 = __rt_3
    },
    [204] = {
        id = 204,
        name = 3429,
        name_en = "MOBILE",
        pre_condition = __rt_3,
        pre_para1 = __rt_3,
        refreshCostId = 1002,
        refreshCostNum = __rt_4,
        refresh_times = {1, 2, 5},
        shop_type = 2
    },
    [301] = {
        id = 301,
        name = 142872,
        name_en = "",
        pre_condition = __rt_3,
        pre_para1 = __rt_3,
        shop_type = 3
    },
    [401] = {id = 401, name = 522741, name_en = "ROOM"},
    [402] = {id = 402, name = 273538, name_en = "FURNITURE"},
    [403] = {
        id = 403,
        pre_condition = __rt_3,
        pre_para1 = __rt_3,
        shop_type = 4
    }
}
local __default_values = {
    id = 101,
    name = 54494,
    name_en = "HUMANOID",
    pre_condition = __rt_1,
    pre_para1 = __rt_2,
    pre_para2 = __rt_3,
    refreshCostId = 0,
    refreshCostNum = __rt_3,
    refresh_times = __rt_3,
    shop_type = 1
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(shop) do setmetatable(v, base) end
local __rawdata = {
    __basemetatable = base,
    id_sort_list = {101, 201, 202, 203, 204, 301, 401, 402, 403}
}
setmetatable(shop, {__index = __rawdata})
return shop

