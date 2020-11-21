-- params : ...
-- function num : 0 , upvalues : _ENV
CommonUtil = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

CommonUtil.SplitStrToNumber = function(str, pattern)
    -- function num : 0_0 , upvalues : _ENV
    local list = (string.split)(str, pattern)
    for k, v in ipairs(list) do list[k] = tonumber(v) end
    return list
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

CommonUtil.SplitStrToString = function(str, pattern)
    -- function num : 0_1 , upvalues : _ENV
    local list = (string.split)(str, pattern)
    for k, v in ipairs(list) do list[k] = v end
    return list
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

CommonUtil.SplitStrToDoubleNumber = function(str, p1, p2)
    -- function num : 0_2 , upvalues : _ENV
    local list = (string.split)(str, p1)
    local list1 = {}
    local list2 = {}
    for k, v in ipairs(list) do
        local tmpList = (string.split)(v, p2)
        if #tmpList >= 2 then
            (table.insert)(list1, tonumber(tmpList[1]));
            (table.insert)(list2, tonumber(tmpList[2]))
        end
    end
    return list1, list2
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

CommonUtil.SplitStrToDic = function(str, p1, p2, KeyAction, valueAction)
    -- function num : 0_3 , upvalues : _ENV
    local list = (string.split)(str, p1)
    local dic = {}
    for k, v in ipairs(list) do
        local tmpList = (string.split)(v, p2)
        if #tmpList >= 2 then
            if not KeyAction or not KeyAction(tmpList[1]) then
                local key = tmpList[1]
            end
            if not valueAction or not valueAction(tmpList[2]) then
                local value = tmpList[2]
            end
            dic[key] = value
        end
    end
    return dic
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

CommonUtil.NewFullList = function(len, content)
    -- function num : 0_4
    local list = {}
    for i = 1, len do list[i] = content end
    return list
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

CommonUtil.UInt32Max = 4294967295
-- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

CommonUtil.Int32Max = 2147483647
-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

CommonUtil.UInt16Max = 65535
-- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

CommonUtil.Int16Max = 32767
-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

CommonUtil.Int64Max = math.maxinteger

