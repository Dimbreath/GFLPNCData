-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {20002}
local __rt_2 = {3}
local __rt_3 = {}
local __rt_4 = {2}
local __rt_5 = {1, 1}
local factory = {
    {consumeNums = {1}, cycle = 10, name = 476526, productId = 5001},
    {id = 2, name = 275412, pre_para1 = {1102}, productId = 20004}, {
        consumeIds = {20004},
        cycle = 2,
        id = 3,
        name = 160626,
        pre_para1 = {1103},
        productId = 20006
    }, {consumeIds = {20001}, id = 4, pre_para1 = {1104}}, {
        consumeIds = {20004, 20001},
        consumeNums = __rt_5,
        cycle = 10,
        id = 5,
        name = 436762,
        pre_para1 = {1105},
        productId = 5002
    }, {
        consumeIds = {20006, 20003},
        consumeNums = __rt_5,
        cycle = 15,
        id = 6,
        name = 347150,
        pre_para1 = {2101},
        productId = 3001
    }, {
        consumeIds = {20003},
        cycle = 2,
        id = 7,
        name = 518832,
        pre_para1 = {2102},
        productId = 20005
    }, {
        consumeIds = {20005, 20006},
        consumeNums = __rt_5,
        cycle = 20,
        id = 8,
        name = 291666,
        pre_para1 = {2103},
        productId = 5003
    }
}
local __default_values = {
    consumeIds = __rt_1,
    consumeNums = __rt_4,
    cycle = 1,
    description = "",
    id = 1,
    name = 109330,
    pre_condition = __rt_2,
    pre_para1 = {1101},
    pre_para2 = __rt_3,
    productId = 20003,
    productNum = 1
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(factory) do setmetatable(v, base) end
local __rawdata = {
    __basemetatable = base,
    id_sort_list = {1, 2, 3, 4, 5, 6, 7, 8},
    res_list = {
        3001, 5001, 5002, 5003, 20001, 20002, 20003, 20004, 20005, 20006
    }
}
setmetatable(factory, {__index = __rawdata})
return factory

