-- params : ...
-- function num : 0 , upvalues : _ENV
local AthTableUtil = {}
AthTableUtil.GetAthGridIdList = function(athData, pos, sizeX)
    -- function num : 0_0 , upvalues : _ENV
    local athSize = athData:GetAthSize()
    local gridIdList = {pos}
    if athSize == 2 then
        local gridId = pos + sizeX;
        (table.insert)(gridIdList, gridId)
    else
        do
            if athSize == 4 then
                for i = 0, 1 do
                    local gridId = nil
                    if i ~= 0 then
                        gridId = pos + i;
                        (table.insert)(gridIdList, gridId)
                    end
                    gridId = pos + i + sizeX;
                    (table.insert)(gridIdList, gridId)
                end
            else
                do
                    if athSize == 8 then
                        for i = 0, 1 do
                            for j = 0, 3 do
                                if i ~= 0 or j ~= 0 then
                                    local gridId = pos + i + sizeX * j;
                                    (table.insert)(gridIdList, gridId)
                                end
                            end
                        end
                    end
                    do return gridIdList end
                end
            end
        end
    end
end

return AthTableUtil

