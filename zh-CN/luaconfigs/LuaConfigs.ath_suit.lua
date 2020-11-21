-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {200}
local __rt_2 = {}
local __rt_3 = {14}
local __rt_4 = {100}
local __rt_5 = {5}
local __rt_6 = {25}
local __rt_7 = {60}
local ath_suit = {
    {
        {
            attrIdList = {21},
            attrValueList = __rt_1,
            describe = 38056,
            name = 139582
        }, {describe = 168935, name = 139582, num = 3}
    }, {
        {
            attrIdList = {22},
            attrValueList = __rt_1,
            describe = 493857,
            icon = "suit_02",
            id = 2,
            name = 340881
        }, {describe = 268486, icon = "suit_02", id = 2, name = 340881, num = 3}
    }, {
        {
            attrIdList = {23},
            attrValueList = {80},
            describe = 396198,
            icon = "suit_03",
            id = 3,
            name = 423152
        }, {describe = 292361, icon = "suit_03", id = 3, name = 423152, num = 3}
    }, {
        {
            attrIdList = __rt_3,
            attrValueList = __rt_4,
            describe = 254344,
            icon = "suit_04",
            id = 4,
            name = 301926
        }, {describe = 65583, icon = "suit_04", id = 4, name = 301926, num = 3}
    }, {
        {
            attrIdList = {17},
            attrValueList = {250},
            describe = 120647,
            icon = "suit_05",
            id = 5,
            name = 49418
        }, {describe = 189535, icon = "suit_05", id = 5, name = 49418, num = 3}
    }, {
        {
            attrIdList = __rt_5,
            attrValueList = {90},
            describe = 478375,
            icon = "suit_06",
            id = 6,
            name = 340194
        }, {describe = 461618, icon = "suit_06", id = 6, name = 340194, num = 3}
    }, {
        {
            attrIdList = {20},
            attrValueList = __rt_4,
            describe = 457476,
            icon = "suit_07",
            id = 7,
            name = 504968
        }, {describe = 253591, icon = "suit_07", id = 7, name = 504968, num = 3}
    }, {
        {
            attrIdList = {24},
            attrValueList = __rt_4,
            describe = 272880,
            icon = "suit_08",
            id = 8,
            name = 431605
        }, {describe = 291064, icon = "suit_08", id = 8, name = 431605, num = 3}
    }, {
        {
            attrIdList = __rt_6,
            attrValueList = {50},
            describe = 143895,
            icon = "suit_09",
            id = 9,
            name = 489782
        }, {describe = 336149, icon = "suit_09", id = 9, name = 489782, num = 3}
    }, {
        {
            attrIdList = {19},
            attrValueList = __rt_4,
            describe = 186350,
            icon = "suit_10",
            id = 10
        }, {describe = 134781, icon = "suit_10", id = 10, num = 3}
    }, {
        {
            attrIdList = {202},
            attrValueList = __rt_1,
            describe = 262325,
            icon = "suit_11",
            id = 11,
            name = 147724
        }
    }, {
        {
            attrIdList = {203},
            attrValueList = __rt_1,
            describe = 173378,
            icon = "suit_12",
            id = 12,
            name = 77978
        }
    }, {
        {
            attrIdList = {9},
            attrValueList = __rt_4,
            describe = 227414,
            icon = "suit_13",
            id = 13,
            name = 21460
        }
    }, {
        {
            attrIdList = __rt_6,
            attrValueList = {30},
            describe = 267049,
            icon = "suit_14",
            id = 14,
            name = 360467
        }
    }, {
        {
            attrIdList = __rt_5,
            attrValueList = __rt_7,
            describe = 138818,
            icon = "suit_15",
            id = 15,
            name = 441570
        }
    }, {
        {
            attrIdList = {10},
            attrValueList = {300},
            describe = 78916,
            icon = "suit_16",
            id = 16,
            name = 317420
        }
    }, {
        {
            attrIdList = {204},
            attrValueList = __rt_1,
            describe = 370035,
            icon = "suit_17",
            id = 17,
            name = 171668
        }
    }, {
        {
            attrIdList = __rt_3,
            attrValueList = __rt_7,
            describe = 299995,
            icon = "suit_18",
            id = 18,
            name = 23412
        }
    }, {
        {
            attrIdList = {212},
            attrValueList = __rt_1,
            icon = "suit_19",
            id = 19,
            name = 173758
        }
    }, {
        {
            attrIdList = {7},
            attrValueList = __rt_4,
            describe = 522658,
            icon = "suit_20",
            id = 20,
            name = 520631
        }
    }
}
local __default_values = {
    attrIdList = __rt_2,
    attrValueList = __rt_2,
    describe = 108444,
    icon = "suit_01",
    id = 1,
    name = 104671,
    num = 2
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(ath_suit) do
    for k1, v1 in pairs(v) do setmetatable(v1, base) end
end
local __rawdata = {__basemetatable = base}
setmetatable(ath_suit, {__index = __rawdata})
return ath_suit

