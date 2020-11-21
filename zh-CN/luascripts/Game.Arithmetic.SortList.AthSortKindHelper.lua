-- params : ...
-- function num : 0 , upvalues : _ENV
local eSortKindType = {quality = 1, chronological = 2, mainAttr = 3}
local SortKindFunc = {
    [eSortKindType.quality] = function(theSelf)
        -- function num : 0_0
        return function(a, b)
            -- function num : 0_0_0 , upvalues : theSelf
            local aBind = a.bindInfo ~= nil
            local bBind = b.bindInfo ~= nil
            local aSpaceOk, bSpaceOk = nil, nil
            if a.size > theSelf.space then
                aSpaceOk = theSelf.space == nil
                bSpaceOk = b.size <= theSelf.space
                if aSpaceOk == bSpaceOk then
                    if a.quality == b.quality then
                        if b:GetAthDensity() >= a:GetAthDensity() then
                            do return aBind ~= bBind end
                            do
                                return b.quality < a.quality
                            end
                            do return aSpaceOk end
                            do return bBind end
                            -- DECOMPILER ERROR: 11 unprocessed JMP targets
                        end
                    end
                end
            end
        end

    end,
    [eSortKindType.chronological] = function(theSelf)
        -- function num : 0_1
        return function(a, b)
            -- function num : 0_1_0 , upvalues : theSelf
            local aBind = a.bindInfo ~= nil
            local bBind = b.bindInfo ~= nil
            local aSpaceOk, bSpaceOk = nil, nil
            if a.size > theSelf.space then
                aSpaceOk = theSelf.space == nil
                bSpaceOk = b.size <= theSelf.space
                if aSpaceOk == bSpaceOk then
                    if a.timeStemp == b.timeStemp then
                        if a.quality == b.quality then
                            if b:GetAthDensity() >= a:GetAthDensity() then
                                do
                                    return aBind ~= bBind
                                end
                                do
                                    return b.quality < a.quality
                                end
                                do
                                    return b.timeStemp < a.timeStemp
                                end
                                do
                                    return aSpaceOk
                                end
                                do return bBind end
                                -- DECOMPILER ERROR: 13 unprocessed JMP targets
                            end
                        end
                    end
                end
            end
        end

    end,
    [eSortKindType.mainAttr] = function(theSelf, mainAttrId)
        -- function num : 0_2
        return function(a, b)
            -- function num : 0_2_0 , upvalues : theSelf, mainAttrId
            local aBind = a.bindInfo ~= nil
            local bBind = b.bindInfo ~= nil
            local aSpaceOk, bSpaceOk = nil, nil
            if a.size > theSelf.space then
                aSpaceOk = theSelf.space == nil
                bSpaceOk = b.size <= theSelf.space
                local aHaveMainAttr = a:IsHaveThisAttr(mainAttrId)
                local bHaveMainAttr = b:IsHaveThisAttr(mainAttrId)
                local aHaveViceAttr = a:IsHaveThisViceAttr(mainAttrId)
                local bHaveViceAttr = b:IsHaveThisViceAttr(mainAttrId)
                if aSpaceOk == bSpaceOk then
                    if aHaveMainAttr == bHaveMainAttr then
                        if aHaveViceAttr == bHaveViceAttr then
                            if a.quality == b.quality then
                                if b:GetAthDensity() >= a:GetAthDensity() then
                                    do
                                        return aBind ~= bBind
                                    end
                                    do
                                        return b.quality < a.quality
                                    end
                                    do
                                        return aHaveViceAttr
                                    end
                                    do
                                        return aHaveMainAttr
                                    end
                                    do
                                        return aSpaceOk
                                    end
                                    do
                                        return bBind
                                    end
                                    -- DECOMPILER ERROR: 13 unprocessed JMP targets
                                end
                            end
                        end
                    end
                end
            end
        end

    end
}
local FliterKindFunc = {
    [eSortKindType.mainAttr] = function(mainAttrId)
        -- function num : 0_3
        return function(athData)
            -- function num : 0_3_0 , upvalues : mainAttrId
            if athData:IsHaveThisAttr(mainAttrId) or
                athData:IsHaveThisViceAttr(mainAttrId) then
                return true
            end
            return false
        end

    end
}
local M = {eSortKindType, SortKindFunc, FliterKindFunc}
return M

