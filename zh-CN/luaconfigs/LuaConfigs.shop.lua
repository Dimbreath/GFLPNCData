-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local shop = {
[203] = {name = 39628, name_en = "RESIDENT"}
, 
[204] = {id = 204, name = 3429, name_en = "MOBILE", refreshCostId = 1002, 
refreshCostNum = {10, 30, 50}
, 
refresh_times = {1, 2, 5}
, shop_type = 2}
, 
[301] = {id = 301, shop_type = 3}
, 
[403] = {id = 403, name = 54494, name_en = "HUMANOID", shop_type = 4}
}
local __default_values = {id = 203, name = 142872, name_en = "", pre_condition = __rt_1, pre_para1 = __rt_1, pre_para2 = __rt_1, refreshCostId = 0, refreshCostNum = __rt_1, refresh_times = __rt_1, shop_type = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(shop) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
id_sort_list = {203, 204, 301, 403}
}
setmetatable(shop, {__index = __rawdata})
return shop

-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local shop = {
    [203] = {name = 39628, name_en = "RESIDENT"},
    [204] = {
        id = 204,
        name = 3429,
        name_en = "MOBILE",
        refreshCostId = 1002,
        refreshCostNum = {10, 30, 50},
        refresh_times = {1, 2, 5},
        shop_type = 2
    },
    [301] = {id = 301, shop_type = 3},
    [403] = {id = 403, name = 54494, name_en = "HUMANOID", shop_type = 4}
}
local __default_values = {
    id = 203,
    name = 142872,
    name_en = "",
    pre_condition = __rt_1,
    pre_para1 = __rt_1,
    pre_para2 = __rt_1,
    refreshCostId = 0,
    refreshCostNum = __rt_1,
    refresh_times = __rt_1,
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
local __rawdata = {__basemetatable = base, id_sort_list = {203, 204, 301, 403}}
setmetatable(shop, {__index = __rawdata})
return shop

