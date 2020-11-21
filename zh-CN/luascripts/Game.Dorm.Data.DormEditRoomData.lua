-- params : ...
-- function num : 0 , upvalues : _ENV
local DormEditRoomData = class("DormEditRoomData")
DormEditRoomData.ResetStorateFntData = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.storageFntDic = {}
    local fntItemDic =
        PlayerDataCenter:GetItemDicByType(eItemType.DormFurniture)
    local fntItemList = {}
    for id, v in pairs(fntItemDic) do
        local storageFnt = self:__NewStorateFnt(id, v:GetCount())
        -- DECOMPILER ERROR at PC20: Confused about usage of register: R9 in 'UnsetPending'

        if storageFnt ~= nil then (self.storageFntDic)[id] = storageFnt end
    end
end

DormEditRoomData.InstallFntData = function(self, fntData)
    -- function num : 0_1
    local id = fntData.id
    local storageFnt = (self.storageFntDic)[id]
    if storageFnt ~= nil then
        storageFnt.count = storageFnt.count - 1
        -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

        if storageFnt.count == 0 then (self.storageFntDic)[id] = nil end
    end
end

DormEditRoomData.UninstallFntData = function(self, fntData)
    -- function num : 0_2
    local id = fntData.id
    local storageFnt = (self.storageFntDic)[id]
    if storageFnt == nil then
        storageFnt = self:__NewStorateFnt(id, 1)
        -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

        if storageFnt ~= nil then (self.storageFntDic)[id] = storageFnt end
    else
        storageFnt.count = storageFnt.count + 1
    end
end

DormEditRoomData.OnItemChange = function(self, itemUpdate, resourceData)
    -- function num : 0_3 , upvalues : _ENV
    if resourceData.backpack == nil then return end
    for id, v in pairs((resourceData.backpack).updates) do
        local storageFnt = (self.storageFntDic)[id]
        if storageFnt == nil then
            storageFnt = self:__NewStorateFnt(id, v.count)
            -- DECOMPILER ERROR at PC21: Confused about usage of register: R9 in 'UnsetPending'

            if storageFnt ~= nil then
                (self.storageFntDic)[id] = storageFnt
            end
        else
            storageFnt.count = storageFnt.count + v.count
        end
    end
end

DormEditRoomData.__NewStorateFnt = function(self, id, count)
    -- function num : 0_4 , upvalues : _ENV
    local fntCfg = (ConfigData.dorm_furniture)[id]
    if fntCfg == nil then
        error("Can\'t find dorm_furniture cfg, id = " .. tostring(id))
        return
    end
    local itemCfg = (ConfigData.item)[id]
    if itemCfg == nil then
        error("Can\'t find item cfg, id = " .. tostring(id))
        return
    end
    local fnt = {id = id, fntCfg = fntCfg, itemCfg = itemCfg, count = count}
    return fnt
end

DormEditRoomData.GetFntWarehouseList = function(self)
    -- function num : 0_5 , upvalues : _ENV
    local fntWarehouseList = {}
    for k, v in pairs(self.storageFntDic) do
        (table.insert)(fntWarehouseList, v)
    end
    return fntWarehouseList
end

return DormEditRoomData

