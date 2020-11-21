-- params : ...
-- function num : 0 , upvalues : _ENV
local DormEditHouseData = class("DormEditHouseData")
local DormRoomData = require("Game.Dorm.Data.DormRoomData")
local EditHouseState = {Empty = 0, OldRoom = 1, NewRoom = 2, PrefabRoom = 3}
DormEditHouseData.ctor = function(self)
    -- function num : 0_0
end

DormEditHouseData.InitEditHouse = function(self, houseData)
    -- function num : 0_1 , upvalues : _ENV, EditHouseState
    self.houseId = houseData.id
    self.houseData = houseData
    self.room_limit = houseData:GetRoomLimit()
    self.editState = {}
    setmetatable(self.editState, {
        __index = function(tab, key)
            -- function num : 0_1_0
            return 0
        end
    })
    self.posResult = {}
    for spos, roomData in pairs((self.houseData).roomDic) do
        -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

        (self.posResult)[spos] = {store = false, param = spos} -- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'
        ;
        (self.editState)[spos] = EditHouseState.OldRoom
    end
    self.oldStoreRoom = {}
    self.newRoom = {}
    self.newRoomCount = {}
    self.installPrefab = {}
end

DormEditHouseData.__RecycleOldRoom = function(self, spos)
    -- function num : 0_2 , upvalues : EditHouseState, _ENV
    local posState = (self.editState)[spos]
    if posState == EditHouseState.OldRoom then
        for oldPos, v in pairs(self.posResult) do
            if v.param == spos then
                v.store = true -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'
                ;
                (self.oldStoreRoom)[oldPos] = ((self.houseData).roomDic)[oldPos]
                break
            end
        end
    else
        do
            if posState == EditHouseState.NewRoom then
                local oldRoomId = (self.newRoom)[spos]
                -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

                if oldRoomId ~= nil then
                    (self.newRoom)[spos] = nil -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'
                    ;
                    (self.newRoomCount)[oldRoomId] =
                        (self.newRoomCount)[oldRoomId] and
                            (self.newRoomCount)[oldRoomId] - 1 or 0
                end
            else
                do
                    if posState == EditHouseState.PrefabRoom then
                        for k, v in pairs(self.installPrefab) do
                            -- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

                            if v == spos then
                                (self.installPrefab)[k] = nil
                                break
                            end
                        end
                    end
                    do
                        -- DECOMPILER ERROR at PC60: Confused about usage of register: R3 in 'UnsetPending'


                        (self.editState)[spos] = EditHouseState.Empty
                    end
                end
            end
        end
    end
end

DormEditHouseData.ReplaceHouseRoom = function(self, spos, roomId, roomData)
    -- function num : 0_3 , upvalues : EditHouseState
    self:__RecycleOldRoom(spos)
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

    if roomData ~= nil then
        if roomData.isPrefab then
            (self.editState)[spos] = EditHouseState.PrefabRoom -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'
            ;
            (self.installPrefab)[roomData.uid] = spos
        else
            -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'


            (self.editState)[spos] = EditHouseState.OldRoom -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((self.posResult)[roomData.spos]).param = spos -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((self.posResult)[roomData.spos]).store = false -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'
            ;
            (self.oldStoreRoom)[roomData.spos] = nil
        end
    else
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'


        (self.editState)[spos] = EditHouseState.NewRoom -- DECOMPILER ERROR at PC34: Confused about usage of register: R4 in 'UnsetPending'
        ;
        (self.newRoom)[spos] = roomId -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'
        ;
        (self.newRoomCount)[roomId] = (self.newRoomCount)[roomId] and
                                          (self.newRoomCount)[roomId] + 1 or 1
    end
end

DormEditHouseData.RecycleHouseRoom = function(self, spos)
    -- function num : 0_4
    self:__RecycleOldRoom(spos)
end

DormEditHouseData.ApplyModifyHouseData =
    function(self, prefabUpdate, allDormData, roomEntityDic)
        -- function num : 0_5 , upvalues : _ENV, DormRoomData
        for spos, v in pairs(self.posResult) do
            if v.store then
                (self.houseData):RemoveHouseRoom(spos)
            else

                (((self.houseData).roomDic)[spos]):ChangePos(v.param)
            end
        end
        for spos, roomId in pairs(self.newRoom) do
            local roomEntity = roomEntityDic[spos]
            if roomEntity ~= nil and roomEntity.roomData ~= nil then
                (self.houseData):AddHouseRoom(roomEntity.roomData)
            else
                local roomData = (DormRoomData.CreateNewRoom)(spos, roomId);
                (self.houseData):AddHouseRoom(roomData)
            end
        end
        for uid, spos in pairs(self.installPrefab) do
            local roomData = (allDormData.prefabDic)[uid]
            roomData:ChangePos(spos);
            (self.houseData):AddHouseRoom(roomData)
        end
        self.editState = nil
        self:__UpdatePrefab(prefabUpdate, allDormData)
    end

DormEditHouseData.ApplyDecomposeHouseRoom =
    function(self, formHouse, param, prefabUpdate, allDormData)
        -- function num : 0_6
        if formHouse then
            local curPos = ((self.posResult)[param]).param -- DECOMPILER ERROR at PC6: Confused about usage of register: R6 in 'UnsetPending'
            ;
            (self.editState)[curPos] = nil -- DECOMPILER ERROR at PC8: Confused about usage of register: R6 in 'UnsetPending'
            ;
            (self.posResult)[param] = nil
        else
            do
                do
                    local spos = (self.installPrefab)[param]
                    -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

                    if spos ~= nil then
                        (self.editState)[spos] = nil
                    end -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'
                    
                    (self.installPrefab)[param] = nil
                    self:__UpdatePrefab(prefabUpdate, allDormData)
                end
            end
        end
    end

DormEditHouseData.__UpdatePrefab = function(self, prefabUpdate, allDormData)
    -- function num : 0_7 , upvalues : _ENV
    if prefabUpdate == nil then return end
    for uid, _ in pairs(prefabUpdate.prefabDelete) do
        allDormData:RemovePrefabRoom(uid)
    end
    for uid, room in pairs(prefabUpdate.prefabUpdate) do
        allDormData:UpdatePrefabRoom(uid, room)
    end
end

DormEditHouseData.ContainHouseRoom = function(self, spos)
    -- function num : 0_8 , upvalues : EditHouseState
    do return (self.editState)[spos] ~= EditHouseState.Empty end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormEditHouseData.IsEmptyOrBpRoom = function(self, spos)
    -- function num : 0_9 , upvalues : EditHouseState
    do
        return (self.editState)[spos] == EditHouseState.Empty or
                   (self.editState)[spos] == EditHouseState.NewRoom
    end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormEditHouseData.GetDeployRoomCount = function(self)
    -- function num : 0_10 , upvalues : _ENV, EditHouseState
    local count = 0
    for k, v in pairs(self.editState) do
        if v ~= EditHouseState.Empty then count = count + 1 end
    end
    return count
end

DormEditHouseData.IsEditRoomLimit = function(self)
    -- function num : 0_11
    local count = self:GetDeployRoomCount()
    do return self.room_limit <= count end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormEditHouseData.CreateFormHouseData = function(houseData)
    -- function num : 0_12 , upvalues : DormEditHouseData
    local editHosueData = (DormEditHouseData.New)()
    editHosueData:InitEditHouse(houseData)
    return editHosueData
end

return DormEditHouseData

