-- params : ...
-- function num : 0 , upvalues : _ENV
local eSortMannerType = {Rare = 1, Level = 2, Id = 3, GetOrder = 4, star = 5}
local SortMannerDefine = {
    [eSortMannerType.Rare] = {
        descSort = function(hero1, hero2)
            -- function num : 0_0
            if hero1.rare < hero2.rare then
                return true
            else
                if hero2.level >= hero1.level then
                    do return hero1.rare ~= hero2.rare end
                    do return false end
                    -- DECOMPILER ERROR: 2 unprocessed JMP targets
                end
            end
        end,
        asceSort = function(hero1, hero2)
            -- function num : 0_1
            if hero2.rare < hero1.rare then
                return true
            else
                if hero1.level >= hero2.level then
                    do return hero1.rare ~= hero2.rare end
                    do return false end
                    -- DECOMPILER ERROR: 2 unprocessed JMP targets
                end
            end
        end
    },
    [eSortMannerType.GetOrder] = {
        descSort = function(hero1, hero2)
            -- function num : 0_2
            do return hero2.ts < hero1.ts end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end,
        asceSort = function(hero1, hero2)
            -- function num : 0_3
            do return hero1.ts < hero2.ts end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end
    },
    [eSortMannerType.Level] = {
        descSort = function(hero1, hero2)
            -- function num : 0_4
            do return hero2.level < hero1.level end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end,
        asceSort = function(hero1, hero2)
            -- function num : 0_5
            do return hero1.level < hero2.level end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end
    },
    [eSortMannerType.Id] = {
        descSort = function(hero1, hero2)
            -- function num : 0_6
            do return hero2.dataId < hero1.dataId end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end,
        asceSort = function(hero1, hero2)
            -- function num : 0_7
            do return hero1.dataId < hero2.dataId end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end
    },
    [eSortMannerType.star] = {
        descSort = function(hero1, hero2)
            -- function num : 0_8
            do return hero2.star < hero1.star end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end,
        asceSort = function(hero1, hero2)
            -- function num : 0_9
            do return hero1.star < hero2.star end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end
    }
}
return {eSortMannerType, SortMannerDefine}

