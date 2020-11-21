-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationMapCtrl = class("ExplorationMapCtrl", ExplorationCtrlBase)
local UIEpYTrack = require("Game.Exploration.MapUI.UIEpYTrack")
local UIEpETrack = require("Game.Exploration.MapUI.UIEpETrack")
local UIEpSingleTrack = require("Game.Exploration.MapUI.UIEpSingleTrack")
local UIEpRoom = require("Game.Exploration.MapUI.UIEpRoom")
local UIEpStartRoom = require("Game.Exploration.MapUI.UIEpStartRoom")
local UIEpRoomInterface = require("Game.Exploration.MapUI.UIEpRoomInterface")
local UIEpPlayerPos = require("Game.Exploration.MapUI.UIEpPlayerPos")
local EpRoomEntity = require("Game.Exploration.Entity.EpRoomEntity")
local CS_GameObject = (CS.UnityEngine).GameObject
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local RoomScale = 0.5
local RoomIntervalOffsetY = 100
local RoomIntervalOffsetX = 570
local BossRoomScale = RoomScale * 1.3
local RegionIntervalOffsetX = 800
ExplorationMapCtrl.ctor = function(self, epCtrl)
    -- function num : 0_0 , upvalues : _ENV
    self.resloader = ((CS.ResLoader).Create)()
    self.viewPosition = (Vector3.New)()
    self.mapRect = {minPoint = (Vector2.New)(), maxPoint = (Vector2.New)()}
    self.roomDic = {}
    self.nextRoomList = {}
    self.__onEpPlayerMoveComplete =
        BindCallback(self, self.OnPlayerMoveComplete)
    MsgCenter:AddListener(eMsgEventId.OnEpPlayerMoveComplete,
                          self.__onEpPlayerMoveComplete)
    self.__OnEpPlayerFightPowerChang = BindCallback(self,
                                                    self.OnEpPlayerFightPowerChang)
    MsgCenter:AddListener(eMsgEventId.OnEpPlayerFightPowerChang,
                          self.__OnEpPlayerFightPowerChang)
    self.__onEpOpStateChanged = BindCallback(self, self.OnEpOpStateChanged)
    MsgCenter:AddListener(eMsgEventId.OnEpOpStateChanged,
                          self.__onEpOpStateChanged)
end

ExplorationMapCtrl.GenMap = function(self, mapData, curRoomData)
    -- function num : 0_1 , upvalues : CS_GameObject, _ENV, RoomScale, BossRoomScale, RoomIntervalOffsetX, RoomIntervalOffsetY, RegionIntervalOffsetX, ExplorationEnum, UIEpRoom, EpRoomEntity, UIEpRoomInterface, UIEpYTrack, UIEpSingleTrack, UIEpPlayerPos
    self.mapData = mapData
    self.roomRoot = ((CS_GameObject.Find)("RoomMap")).transform
    self.bind = {};
    (UIUtil.LuaUIBindingTable)(self.roomRoot, self.bind)
    self:__InitViewPosition((self.roomRoot).position);
    (((self.bind).moveTween).onComplete):AddListener(
        BindCallback(self, self.__OnMoveTweenComplete))
    local roomUIPrefabWait = (self.resloader):LoadABAssetAsyncAwait(
                                 PathConsts:GetUIPrefabPath("EpRoom/UI_EpRoom"));
    (coroutine.yield)(roomUIPrefabWait)
    local roomUIPrefab = roomUIPrefabWait.Result
    local roomInterfacePrefabWait = (self.resloader):LoadABAssetAsyncAwait(
                                        PathConsts:GetUIPrefabPath(
                                            "EpRoom/UI_EpRoomInterface"));
    (coroutine.yield)(roomInterfacePrefabWait)
    local roomInterfacePrefab = roomInterfacePrefabWait.Result
    local bossWarnLinePrefabWait = (self.resloader):LoadABAssetAsyncAwait(
                                       PathConsts:GetUIPrefabPath(
                                           "EpRoom/UI_EpWarnLine"));
    (coroutine.yield)(bossWarnLinePrefabWait)
    local bossWarnLinePrefab = bossWarnLinePrefabWait.Result
    local roomYTrackPrefabWait = (self.resloader):LoadABAssetAsyncAwait(
                                     PathConsts:GetUIPrefabPath(
                                         "EpRoom/UI_EpYTrack"));
    (coroutine.yield)(roomYTrackPrefabWait)
    local roomYTrackPrefab = roomYTrackPrefabWait.Result
    local playerPosPrefabWait = (self.resloader):LoadABAssetAsyncAwait(
                                    PathConsts:GetUIPrefabPath(
                                        "EpRoom/UI_EpPlayerPos"));
    (coroutine.yield)(playerPosPrefabWait)
    local playerPosPrefab = playerPosPrefabWait.Result
    local roomSingleTrackPrefabWait = (self.resloader):LoadABAssetAsyncAwait(
                                          PathConsts:GetUIPrefabPath(
                                              "EpRoom/UI_EpSingleTrack"));
    (coroutine.yield)(roomSingleTrackPrefabWait)
    local roomSingleTrackPrefab = roomSingleTrackPrefabWait.Result
    self.roomDic = {}
    self.bossWarnLine = nil
    self.roomTrackDic = {}
    self.roomStateDic = {}
    local scale = RoomScale
    local bossScale = BossRoomScale
    local offsetX = RoomIntervalOffsetX * scale
    local offsetY = RoomIntervalOffsetY * scale
    local regionOffsetX = RegionIntervalOffsetX * scale
    local centorYPos = mapData.centerPosY * 2 * offsetY
    local roomSizeDelta = (roomUIPrefab.transform).sizeDelta * scale
    local interfaceBind = {};
    (UIUtil.LuaUIBindingTable)(roomInterfacePrefab.transform, interfaceBind)
    local interfaceSize = ((interfaceBind.img_Left).transform).sizeDelta * scale
    local yTrackOffsetX = roomSizeDelta.x / 2 + interfaceSize.x
    local yTrackTrunkSizeX = (offsetX - interfaceSize.x * 2 - roomSizeDelta.x -
                                 offsetY) / scale
    local yTrackForkLength = offsetY * (math.sqrt)(2) / scale
    local singleTrackTrunkSizeX = (offsetX - yTrackOffsetX * 2) / scale / 2
    local bossTrackOffsetX = yTrackOffsetX / scale * bossScale
    local bossRoomExtraX = bossTrackOffsetX - yTrackOffsetX
    self:__GenStartRoom(scale, offsetY)
    local roomVisibleEvent = BindCallback(self, self.OnRoomVisible)
    local roomPosX = offsetX
    for i = 1, mapData.maxMapColNumber do
        local roomMapRow = (mapData.roomMap)[i]
        local mapColType = mapData:GetMapColType(i)
        for k2, room in pairs(roomMapRow) do
            local pos = nil
            if mapColType.trackType ==
                (ExplorationEnum.eTrackLineType).NormalETrack or
                mapColType.trackType ==
                (ExplorationEnum.eTrackLineType).SingleTrack or
                mapColType.trackType ==
                (ExplorationEnum.eTrackLineType).EndTrack then
                pos = (Vector3.New)(roomPosX, centorYPos, 0)
            else
                if room:IsMaxWidthCol() then
                    pos = (Vector3.New)(roomPosX, room.y * offsetY * 2, 0)
                else
                    pos = (Vector3.New)(roomPosX,
                                        room.y * offsetY * 2 + offsetY, 0)
                end
            end
            local objScale = scale
            local isBossRoom = room:GetRoomType() ==
                                   (ExplorationEnum.eRoomType).boss
            if isBossRoom then
                objScale = bossScale
                pos.x = pos.x + bossRoomExtraX
                roomPosX = pos.x + bossRoomExtraX
            end
            local roomPos = (Vector3.New)(pos.x, pos.y, pos.z)
            local roomUIObj = roomUIPrefab:Instantiate((self.bind).roomHolder) -- DECOMPILER ERROR at PC254: Confused about usage of register: R48 in 'UnsetPending'
            ;
            (roomUIObj.transform).localScale =
                (roomUIObj.transform).localScale * objScale -- DECOMPILER ERROR at PC256: Confused about usage of register: R48 in 'UnsetPending'
            ;
            (roomUIObj.transform).localPosition = roomPos
            local uiRoom = (UIEpRoom.New)()
            uiRoom:Init(roomUIObj)
            uiRoom:InitRoomUI(room)
            local roomEntity = (EpRoomEntity.New)()
            roomEntity:InitEpRoom(uiRoom, room, roomVisibleEvent) -- DECOMPILER ERROR at PC274: Confused about usage of register: R50 in 'UnsetPending'
            ;
            (self.roomDic)[room.position] = roomEntity
            local interfaceObj = roomInterfacePrefab:Instantiate(
                                     (self.bind).interfaceHolder) -- DECOMPILER ERROR at PC283: Confused about usage of register: R51 in 'UnsetPending'
            ;
            (interfaceObj.transform).localScale =
                (interfaceObj.transform).localScale * objScale -- DECOMPILER ERROR at PC285: Confused about usage of register: R51 in 'UnsetPending'
            ;
            (interfaceObj.transform).localPosition = roomPos
            local roomInterface = (UIEpRoomInterface.New)()
            roomInterface:Init(interfaceObj)
            roomInterface:InitRoomInterface(room)
            roomEntity:InitEpRoomInterface(roomInterface)
            if mapColType.trackType ==
                (ExplorationEnum.eTrackLineType).NormalYTrack then
                local trackPos = (Vector3.New)(roomPos.x + yTrackOffsetX,
                                               roomPos.y, roomPos.z)
                local roomTrackObj = roomYTrackPrefab:Instantiate(
                                         (self.bind).yTrackHolder) -- DECOMPILER ERROR at PC317: Confused about usage of register: R54 in 'UnsetPending'
                ;
                (roomTrackObj.transform).localScale =
                    (roomTrackObj.transform).localScale * scale -- DECOMPILER ERROR at PC319: Confused about usage of register: R54 in 'UnsetPending'
                ;
                (roomTrackObj.transform).localPosition = trackPos
                local roomTrack = (UIEpYTrack.New)()
                roomTrack:Init(roomTrackObj)
                roomTrack:InitEpYTrack(room, yTrackTrunkSizeX, yTrackForkLength) -- DECOMPILER ERROR at PC332: Confused about usage of register: R55 in 'UnsetPending'
                ;
                (self.roomTrackDic)[room.position] = roomTrack
            end
            if mapColType.trackType ==
                (ExplorationEnum.eTrackLineType).SingleTrack then
                local singleTrackYOffset = yTrackOffsetX
                if isBossRoom then
                    singleTrackYOffset = bossTrackOffsetX
                end
                local trackPos = (Vector3.New)(roomPos.x + singleTrackYOffset,
                                               roomPos.y, roomPos.z)
                local roomTrackObj = roomSingleTrackPrefab:Instantiate(
                                         (self.bind).eTrackHolder) -- DECOMPILER ERROR at PC357: Confused about usage of register: R55 in 'UnsetPending'
                ;
                (roomTrackObj.transform).localScale =
                    (roomTrackObj.transform).localScale * scale -- DECOMPILER ERROR at PC359: Confused about usage of register: R55 in 'UnsetPending'
                ;
                (roomTrackObj.transform).localPosition = trackPos
                local roomTrack = (UIEpSingleTrack.New)()
                roomTrack:Init(roomTrackObj)
                roomTrack:InitEpSingleTrack(room, singleTrackTrunkSizeX) -- DECOMPILER ERROR at PC371: Confused about usage of register: R56 in 'UnsetPending'
                ;
                (self.roomTrackDic)[room.position] = roomTrack
            end
            if mapColType.trackType ==
                (ExplorationEnum.eTrackLineType).ReverseETrack and
                self.bossWarnLine == nil then
                local warningLinePos = (Vector3.New)(
                                           roomPos.x + regionOffsetX / 2,
                                           centorYPos, roomPos.z)
                local bossWarnLine = bossWarnLinePrefab:Instantiate(
                                         (self.bind).otherHolder) -- DECOMPILER ERROR at PC393: Confused about usage of register: R54 in 'UnsetPending'
                ;
                (bossWarnLine.transform).localPosition = warningLinePos -- DECOMPILER ERROR at PC398: Confused about usage of register: R54 in 'UnsetPending'
                ;
                (bossWarnLine.transform).localScale =
                    (bossWarnLine.transform).localScale * scale
                self.bossWarnLine = bossWarnLine
            end
            roomEntity:UpdateRoomVisible()
        end
        if mapColType.trackType ==
            (ExplorationEnum.eTrackLineType).ReverseETrack then
            roomPosX = roomPosX + regionOffsetX
        else
            roomPosX = roomPosX + offsetX
        end
    end
    self:__GenMapSpecialETrack(scale, bossScale, roomSizeDelta, interfaceSize,
                               offsetX, offsetY, regionOffsetX)
    local playerObject = playerPosPrefab:Instantiate((self.bind).otherHolder) -- DECOMPILER ERROR at PC430: Confused about usage of register: R33 in 'UnsetPending'
    ;
    (playerObject.transform).localScale =
        (playerObject.transform).localScale * scale
    local playerPosItem = (UIEpPlayerPos.New)()
    playerPosItem:Init(playerObject)
    self.playerPosItem = playerPosItem;
    (coroutine.yield)()
    self:RefreshMapShowState(
        (ExplorationManager:GetDynPlayer()):GetOperatorDetail(), curRoomData)
    local playerPower = ((self.epCtrl).dynPlayer):GetCacheFightPower()
    self.nextRoomList = curRoomData:GetNextRoom()
    for k, v in pairs(self.nextRoomList) do
        self:ShowFightingPower(v, playerPower)
    end
    self.lastRoomEntity = (self.roomDic)[curRoomData.position]
    -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

ExplorationMapCtrl.__GenStartRoom = function(self, scale, offsetY)
    -- function num : 0_2 , upvalues : _ENV, UIEpStartRoom, EpRoomEntity
    local mapData = self.mapData
    local startRoomUIPrefab = (self.resloader):LoadABAsset(
                                  PathConsts:GetUIPrefabPath(
                                      "EpRoom/UI_EpStartRoom"))
    local startRoomData = mapData:GetStartRoom()
    local yPos = mapData.centerPosY * 2 * offsetY
    local pos = (Vector3.New)(0, yPos, 0)
    local startRoomUIObj =
        startRoomUIPrefab:Instantiate((self.bind).otherHolder) -- DECOMPILER ERROR at PC24: Confused about usage of register: R9 in 'UnsetPending'
    ;
    (startRoomUIObj.transform).localPosition = pos -- DECOMPILER ERROR at PC29: Confused about usage of register: R9 in 'UnsetPending'
    ;
    (startRoomUIObj.transform).localScale =
        (startRoomUIObj.transform).localScale * scale
    local uiRoom = (UIEpStartRoom.New)()
    uiRoom:Init(startRoomUIObj)
    uiRoom:InitRoomUI(startRoomData)
    local roomEntity = (EpRoomEntity.New)()
    roomEntity:InitEpRoom(uiRoom, startRoomData,
                          BindCallback(self, self.OnRoomVisible)) -- DECOMPILER ERROR at PC50: Confused about usage of register: R11 in 'UnsetPending'
    ;
    (self.roomDic)[startRoomData.position] = roomEntity
end

ExplorationMapCtrl.__GenSpecialTrackLine =
    function(self)
        -- function num : 0_3
    end

ExplorationMapCtrl.__GenMapSpecialETrack =
    function(self, scale, bossScale, roomSizeDelta, interfaceSize, offsetX,
             offsetY, regionOffsetX)
        -- function num : 0_4 , upvalues : _ENV, ExplorationEnum, UIEpETrack
        local mapData = self.mapData
        local bossInterfaceSize = interfaceSize / scale * bossScale
        local bossRoomSizeDelta = roomSizeDelta / scale * bossScale
        local normalRoomHalfSizeX = interfaceSize.x + roomSizeDelta.x / 2
        local bossRoomHalfSizeX = bossInterfaceSize.x + bossRoomSizeDelta.x / 2
        local roomETrackPrefabWait = (self.resloader):LoadABAssetAsyncAwait(
                                         PathConsts:GetUIPrefabPath(
                                             "EpRoom/UI_EpETrack"));
        (coroutine.yield)(roomETrackPrefabWait)
        local roomETrackPrefab = roomETrackPrefabWait.Result
        for i = 0, #mapData.mapColTypeList - 1 do
            local mapColType = (mapData.mapColTypeList)[i]
            if mapColType.trackType ==
                (ExplorationEnum.eTrackLineType).NormalETrack then
                local tmpRoomTrackObj = roomETrackPrefab:Instantiate(
                                            (self.bind).eTrackHolder)
                local tmpRoomData = mapData:GetRoomByXY(i, 0)
                local tmpScale = scale
                local tmpRoomHalfSizeX = normalRoomHalfSizeX
                if tmpRoomData:GetRoomType() == (ExplorationEnum.eRoomType).boss then
                    tmpScale = bossScale
                    tmpRoomHalfSizeX = bossRoomHalfSizeX
                end
                local tmpRoomEntity = (self.roomDic)[tmpRoomData.position]
                local tmpRoomUI = tmpRoomEntity:GetUIRoom()
                local roomPos = (tmpRoomUI.transform).localPosition
                local tmpRoomSizeDelta = tmpRoomUI:GetRoomSize() * tmpScale
                local startTrackPos = (Vector3.New)(
                                          roomPos.x + tmpRoomSizeDelta.x / 2,
                                          roomPos.y, roomPos.z) -- DECOMPILER ERROR at PC79: Confused about usage of register: R29 in 'UnsetPending'
                ;
                (tmpRoomTrackObj.transform).localScale =
                    (tmpRoomTrackObj.transform).localScale * tmpScale -- DECOMPILER ERROR at PC81: Confused about usage of register: R29 in 'UnsetPending'
                ;
                (tmpRoomTrackObj.transform).localPosition = startTrackPos
                local trackLength = (offsetX - tmpRoomSizeDelta.x / 2 -
                                        tmpRoomHalfSizeX) / tmpScale
                local tmpRoomTrack = (UIEpETrack.New)()
                tmpRoomTrack:Init(tmpRoomTrackObj)
                tmpRoomTrack:InitRoomNormalETrack(tmpRoomData, self,
                                                  trackLength, offsetY) -- DECOMPILER ERROR at PC100: Confused about usage of register: R31 in 'UnsetPending'
                ;
                (self.roomTrackDic)[tmpRoomData.position] = tmpRoomTrack
            else
                do
                    if mapColType.trackType ==
                        (ExplorationEnum.eTrackLineType).ReverseETrack then
                        local tmpRoomTrackObj =
                            roomETrackPrefab:Instantiate(
                                (self.bind).eTrackHolder)
                        local tmpRoomData = mapData:GetRoomByXY(i + 1, 0)
                        local tmpScale = scale
                        local tmpRoomHalfSizeX = normalRoomHalfSizeX
                        if tmpRoomData:GetRoomType() ==
                            (ExplorationEnum.eRoomType).boss then
                            tmpScale = bossScale
                            tmpRoomHalfSizeX = bossRoomHalfSizeX
                        end
                        local tmpRoomEntity =
                            (self.roomDic)[tmpRoomData.position]
                        local tmpRoomUI = tmpRoomEntity:GetUIRoom()
                        local roomPos = (tmpRoomUI.transform).localPosition
                        local tmpRoomSizeDelta =
                            tmpRoomUI:GetRoomSize() * tmpScale
                        local tmpTrackPos =
                            (Vector3.New)(roomPos.x - tmpRoomHalfSizeX,
                                          roomPos.y, roomPos.z) -- DECOMPILER ERROR at PC146: Confused about usage of register: R29 in 'UnsetPending'
                        ;
                        (tmpRoomTrackObj.transform).localScale =
                            (tmpRoomTrackObj.transform).localScale * scale -- DECOMPILER ERROR at PC148: Confused about usage of register: R29 in 'UnsetPending'
                        ;
                        (tmpRoomTrackObj.transform).localPosition = tmpTrackPos
                        local tmpCurRoomHalfSizeX = tmpRoomHalfSizeX
                        if mapData:GetRoomByXY(i, 0) ==
                            (ExplorationEnum.eRoomType).boss then
                            tmpCurRoomHalfSizeX = bossRoomHalfSizeX
                        end
                        local trackLength =
                            (regionOffsetX - normalRoomHalfSizeX -
                                normalRoomHalfSizeX) / scale
                        local tmpRoomTrack = (UIEpETrack.New)()
                        tmpRoomTrack:Init(tmpRoomTrackObj)
                        tmpRoomTrack:InitRoomReverseETrack(tmpRoomData, self,
                                                           trackLength, offsetY)
                        for k, room in pairs((mapData.roomMap)[i]) do
                            -- DECOMPILER ERROR at PC180: Confused about usage of register: R37 in 'UnsetPending'

                            (self.roomTrackDic)[room.position] = tmpRoomTrack
                        end
                    end
                    do
                        -- DECOMPILER ERROR at PC183: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC183: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC183: LeaveBlock: unexpected jumping out IF_STMT

                    end
                end
            end
        end
    end

ExplorationMapCtrl.OnEpOpStateChanged = function(self, opDetail)
    -- function num : 0_5 , upvalues : _ENV
    local curRoomData = (self.epCtrl):GetCurrentRoomData()
    self:ClearPassedRoomData(opDetail, curRoomData)
    if opDetail.state ==
        proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
        local playerPower = ((self.epCtrl).dynPlayer):GetCacheFightPower()
        self.nextRoomList = curRoomData:GetNextRoom()
        for k, tmpRoomData in pairs(self.nextRoomList) do
            self:ShowFightingPower(tmpRoomData, playerPower)
            local visible = tmpRoomData:GetVisible()
            if visible == false then
                tmpRoomData:SetVisible(true)
                local roomEntity = (self.roomDic)[tmpRoomData.position]
                roomEntity:UpdateRoomVisible()
                self:RefreshRoomLineVisible(tmpRoomData)
            end
        end
    end
end

ExplorationMapCtrl.RefreshMapShowState =
    function(self, opDetail, curRoomData, withTween, tweenCallback)
        -- function num : 0_6 , upvalues : _ENV, ExplorationEnum, BossRoomScale
        local roomStateDic = {}
        for _, v in ipairs(opDetail.path) do
            roomStateDic[v] = (ExplorationEnum.eRoomTypeState).Complete
        end
        local curUIRoom = self:GetRoomUI(curRoomData.position)
        self:RecursionRoomData(curRoomData, roomStateDic)
        if opDetail.state ~=
            proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
            roomStateDic[curRoomData.position] =
                (ExplorationEnum.eRoomTypeState).CurrentStay;
            (self.playerPosItem):SetPlayerPos((curUIRoom.transform).position)
            if withTween then
                (self.playerPosItem):ShowPlayerPosLarge(true, true,
                                                        tweenCallback)
            else

                (self.playerPosItem):ShowPlayerPosLarge(true)
            end
        else
            local trackItem = self:__GetRoomTrackItem(curRoomData)
            if trackItem ~= nil then
                local crossPos = trackItem:GetTrackCrossingPos();
                (self.playerPosItem):SetPlayerPos(crossPos)
                if withTween then
                    (self.playerPosItem):ShowPlayerPosSmall(true, true,
                                                            tweenCallback)
                else

                    (self.playerPosItem):ShowPlayerPosSmall(true)
                end
            else
                do

                    (self.playerPosItem):SetPlayerPos(
                        (curUIRoom.transform).position)
                    if withTween then
                        (self.playerPosItem):ShowPlayerPosLarge(true, true,
                                                                tweenCallback)
                    else

                        (self.playerPosItem):ShowPlayerPosLarge(true)
                    end
                    local nextRoomList = curRoomData:GetNextRoom()
                    for _, tmpNextRoom in pairs(nextRoomList) do
                        roomStateDic[tmpNextRoom.position] =
                            (ExplorationEnum.eRoomTypeState).AbleChoose
                    end
                    do
                        -- DECOMPILER ERROR at PC110: Confused about usage of register: R7 in 'UnsetPending'

                        if curRoomData:IsBossRoom() then
                            ((self.playerPosItem).transform).localScale =
                                Vector3.one * BossRoomScale
                        end
                        if withTween then
                            ((self.epCtrl).sceneCtrl):RefreshBattleToMapLine()
                        end
                        for position, v in pairs(self.roomDic) do
                            if roomStateDic[position] == nil then
                                roomStateDic[position] =
                                    (ExplorationEnum.eRoomTypeState).UnReachable
                            end
                        end
                        for position, state in pairs(roomStateDic) do
                            if (self.roomStateDic)[position] ~= state then
                                local roomEntity = self:GetRoomEntity(R14_PC139) -- DECOMPILER ERROR at PC142: Overwrote pending register: R14 in 'AssignReg'
                                ;
                                (roomEntity:GetUIRoom()):ChangeUIState(
                                    R15_PC145, withTween)
                                -- DECOMPILER ERROR at PC146: Overwrote pending register: R14 in 'AssignReg'

                                self:RefreshRoomInterfaceAndLine(R15_PC145,
                                                                 R16_PC150,
                                                                 roomStateDic)
                            end
                        end
                        self.roomStateDic = roomStateDic
                    end
                end
            end
        end
    end

ExplorationMapCtrl.__GetRoomTrackItem = function(self, roomData)
    -- function num : 0_7
    local trackItem = (self.roomTrackDic)[roomData.position]
    return trackItem
end

ExplorationMapCtrl.PlayerPosItemMove2NextPos =
    function(self, callback)
        -- function num : 0_8 , upvalues : _ENV
        local completeFunc = function()
            -- function num : 0_8_0 , upvalues : self, callback
            local curRoomData = (self.epCtrl):GetCurrentRoomData()
            local opDetail = ((self.epCtrl).dynPlayer):GetOperatorDetail()
            self:RefreshMapShowState(opDetail, curRoomData, true, callback)
        end

        if (self.playerPosItem):PlayerPosIsShowSmall() then
            (self.playerPosItem):ShowPlayerPosSmall(false, true, completeFunc)
        else
            if (self.playerPosItem):PlayerPosIsShowLarge() then
                (self.playerPosItem):ShowPlayerPosLarge(false, true,
                                                        completeFunc)
            else
                error("PlayerPosItem\'t state error")
            end
        end
    end

ExplorationMapCtrl.ClearPassedRoomData =
    function(self, opDetail, curRoomData)
        -- function num : 0_9 , upvalues : _ENV
        if opDetail.state ~=
            proto_object_ExplorationCurGridState.ExplorationCurGridState_Secleted then
            return
        end
        local curRow = curRoomData.x - 1
        local lastRowRoomDic = ((self.mapData).roomMap)[curRow]
        if lastRowRoomDic == nil then return end
        for k, roomData in pairs(lastRowRoomDic) do
            roomData:ClearEpRoomData()
        end
    end

ExplorationMapCtrl.RefreshRoomInterfaceAndLine =
    function(self, roomEntity, state, roomStateDic)
        -- function num : 0_10 , upvalues : ExplorationEnum
        local roomInterface = roomEntity:GetRoomInterface()
        if state == (ExplorationEnum.eRoomTypeState).Complete then
            if roomInterface ~= nil then
                roomInterface:SetAllInterfacePass(true,
                                                  (self.bind).pathPassColor)
            end
            self:__SetRoomLineLeftPass(roomEntity, true, roomStateDic)
            self:__SetRoomLineRightPass(roomEntity, true, roomStateDic)
        else
            if state == (ExplorationEnum.eRoomTypeState).CurrentStay then
                if roomInterface ~= nil then
                    roomInterface:SetInterfaceLeftPass(true,
                                                       (self.bind).pathPassColor)
                    roomInterface:SetInterfaceRightPass(false)
                end
                self:__SetRoomLineLeftPass(roomEntity, true, roomStateDic)
                self:__SetRoomLineRightPass(roomEntity, false, roomStateDic)
            else
                if roomInterface ~= nil then
                    roomInterface:SetAllInterfacePass(false)
                end
                self:__SetRoomLineLeftPass(roomEntity, false, roomStateDic)
                self:__SetRoomLineRightPass(roomEntity, false, roomStateDic)
            end
        end
        if roomInterface ~= nil then
            if state == (ExplorationEnum.eRoomTypeState).UnReachable then
                roomInterface:SetRoomUIAlpha(ExplorationEnum.UnReachableAlpha)
            else
                roomInterface:SetRoomUIAlpha(1)
            end
        end
    end

ExplorationMapCtrl.RefreshRoomLineVisible =
    function(self, roomData)
        -- function num : 0_11 , upvalues : ExplorationEnum, _ENV
        local roomType = roomData:GetRoomType()
        do
            if roomType == (ExplorationEnum.eRoomType).start then
                local trackItem = (self.roomTrackDic)[roomData.position]
                trackItem:SetTrunkLineActive()
                return
            end
            local trackItem = (self.roomTrackDic)[roomData.position]
            local colTrackType = (self.mapData):GetMapColTrackType(roomData.x)
            if colTrackType == (ExplorationEnum.eTrackLineType).ReverseETrack then
                local trackItem = (self.roomTrackDic)[roomData.position]
                trackItem:SetForkLineActive(roomData, self)
            else
                do
                    do
                        if colTrackType ==
                            (ExplorationEnum.eTrackLineType).NormalETrack then
                            local trackItem =
                                (self.roomTrackDic)[roomData.position]
                            trackItem:SetTrunkLineActive()
                        else
                        end
                        do
                            if colTrackType ~=
                                (ExplorationEnum.eTrackLineType).SingleTrack or
                                colTrackType ==
                                (ExplorationEnum.eTrackLineType).NormalYTrack then
                                local trackItem =
                                    (self.roomTrackDic)[roomData.position]
                                if trackItem ~= nil then
                                    trackItem:SetTrunkLineActive()
                                end
                            end
                            local lastColTrackType =
                                (self.mapData):GetMapColTrackType(roomData.x - 1)
                            if lastColTrackType ==
                                (ExplorationEnum.eTrackLineType).ReverseETrack then
                                local lastRoom =
                                    (self.mapData):GetOneRoomByX(roomData.x - 1)
                                local trackItem =
                                    (self.roomTrackDic)[lastRoom.position]
                                trackItem:SetTrunkLineActive()
                            else
                                do
                                    if lastColTrackType ==
                                        (ExplorationEnum.eTrackLineType).NormalETrack then
                                        local lastRoom =
                                            (self.mapData):GetRoomByXY(
                                                roomData.x - 1, 0)
                                        local trackItem =
                                            (self.roomTrackDic)[lastRoom.position]
                                        trackItem:SetForkLineActive(roomData,
                                                                    self)
                                    else
                                        do
                                            if lastColTrackType ==
                                                (ExplorationEnum.eTrackLineType).SingleTrack then
                                                local lastRoom =
                                                    (self.mapData):GetRoomByXY(
                                                        roomData.x - 1, 0)
                                                local trackItem =
                                                    (self.roomTrackDic)[lastRoom.position]
                                                trackItem:SetTrunkLineActive(
                                                    roomData)
                                            else
                                                do
                                                    if lastColTrackType ==
                                                        (ExplorationEnum.eTrackLineType).NormalYTrack then
                                                        local lastRoomList =
                                                            roomData:GetLastRoom()
                                                        for _, tmpRoomData in
                                                            pairs(lastRoomList) do
                                                            local trackItem =
                                                                (self.roomTrackDic)[tmpRoomData.position]
                                                            if trackItem ~= nil then
                                                                trackItem:SetForkLineActive(
                                                                    roomData,
                                                                    self)
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

ExplorationMapCtrl.__SetRoomLineLeftPass =
    function(self, roomEntity, isPass, roomStateDic)
        -- function num : 0_12 , upvalues : ExplorationEnum, _ENV
        local roomData = roomEntity:GetRoomData()
        local roomType = roomData:GetRoomType()
        if roomType == (ExplorationEnum.eRoomType).start then return end
        local lastColTrackType = (self.mapData):GetMapColTrackType(
                                     roomData.x - 1)
        if lastColTrackType == (ExplorationEnum.eTrackLineType).ReverseETrack then
            local lastRoom = (self.mapData):GetOneRoomByX(roomData.x - 1)
            local trackItem = (self.roomTrackDic)[lastRoom.position]
            trackItem:SetTrunkLinePass(isPass, (self.bind).pathPassColor,
                                       (self.bind).linePassHeight)
        else
            do
                if lastColTrackType ==
                    (ExplorationEnum.eTrackLineType).NormalETrack then
                    local lastRoom = (self.mapData):GetRoomByXY(roomData.x - 1,
                                                                0)
                    local trackItem = (self.roomTrackDic)[lastRoom.position]
                    trackItem:SetForkLinePass(roomData, self, isPass,
                                              (self.bind).pathPassColor,
                                              (self.bind).linePassHeight)
                else
                    do
                        if lastColTrackType ==
                            (ExplorationEnum.eTrackLineType).SingleTrack then
                            local lastRoom =
                                (self.mapData):GetRoomByXY(roomData.x - 1, 0)
                            local trackItem =
                                (self.roomTrackDic)[lastRoom.position]
                            trackItem:SetForkLinePass(roomData, self, isPass,
                                                      (self.bind).pathPassColor,
                                                      (self.bind).linePassHeight)
                        else
                            do
                                if lastColTrackType ==
                                    (ExplorationEnum.eTrackLineType).NormalYTrack then
                                    local lastRoomList = roomData:GetLastRoom()
                                    for _, tmpRoomData in pairs(lastRoomList) do
                                        local trackItem =
                                            (self.roomTrackDic)[tmpRoomData.position]
                                        if trackItem ~= nil then
                                            if roomStateDic[tmpRoomData.position] ==
                                                (ExplorationEnum.eRoomTypeState).Complete and
                                                isPass then
                                                trackItem:SetForkLinePass(
                                                    roomData, self, true,
                                                    (self.bind).pathPassColor,
                                                    (self.bind).linePassHeight)
                                            else
                                                trackItem:SetForkLinePass(
                                                    roomData, self, false,
                                                    (self.bind).pathPassColor,
                                                    (self.bind).linePassHeight)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

ExplorationMapCtrl.__SetRoomLineRightPass =
    function(self, roomEntity, isPass, roomStateDic)
        -- function num : 0_13 , upvalues : ExplorationEnum
        local roomData = roomEntity:GetRoomData()
        local roomType = roomData:GetRoomType()
        if roomData.x == (self.mapData).maxMapColNumber then return end
        local colTrackType = (self.mapData):GetMapColTrackType(roomData.x)
        if colTrackType == (ExplorationEnum.eTrackLineType).ReverseETrack then
            local trackItem = (self.roomTrackDic)[roomData.position]
            trackItem:SetForkLinePass(roomData, self, isPass,
                                      (self.bind).pathPassColor,
                                      (self.bind).linePassHeight)
        else
            do
                if colTrackType == (ExplorationEnum.eTrackLineType).NormalETrack then
                    local trackItem = (self.roomTrackDic)[roomData.position]
                    trackItem:SetTrunkLinePass(isPass,
                                               (self.bind).pathPassColor,
                                               (self.bind).linePassHeight)
                else
                    do
                        if colTrackType ==
                            (ExplorationEnum.eTrackLineType).SingleTrack then
                            local trackItem =
                                (self.roomTrackDic)[roomData.position]
                            trackItem:SetTrunkLinePass(isPass,
                                                       (self.bind).pathPassColor,
                                                       (self.bind).linePassHeight)
                        else
                            do
                                if colTrackType ==
                                    (ExplorationEnum.eTrackLineType).NormalYTrack then
                                    local trackItem =
                                        (self.roomTrackDic)[roomData.position]
                                    if trackItem ~= nil then
                                        trackItem:SetTrunkLinePass(isPass,
                                                                   (self.bind).pathPassColor,
                                                                   (self.bind).linePassHeight)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

ExplorationMapCtrl.RecursionRoomData = function(self, curRoomData, roomStateDic)
    -- function num : 0_14 , upvalues : _ENV, ExplorationEnum
    local nextRoomList = curRoomData:GetNextRoom()
    if #nextRoomList == 0 then return end
    for _, roomData in ipairs(nextRoomList) do
        roomStateDic[roomData.position] = (ExplorationEnum.eRoomTypeState).None
        self:RecursionRoomData(roomData, roomStateDic)
    end
end

ExplorationMapCtrl.GetPlayerPosItem = function(self)
    -- function num : 0_15
    return self.playerPosItem
end

ExplorationMapCtrl.GetRoomUI = function(self, position)
    -- function num : 0_16
    if self.roomDic == nil or (self.roomDic)[position] == nil then return nil end
    return ((self.roomDic)[position]):GetUIRoom()
end

ExplorationMapCtrl.GetRoomEntityPos = function(self, roomData)
    -- function num : 0_17
    local roomEntity = self:GetRoomEntity(roomData.position)
    return roomEntity:GetRoomEntityPos()
end

ExplorationMapCtrl.GetRoomEntityLocalPos =
    function(self, roomData)
        -- function num : 0_18
        local roomEntity = self:GetRoomEntity(roomData.position)
        return roomEntity:GetRoomEntityLocalPos()
    end

ExplorationMapCtrl.GetRoomEntity = function(self, position)
    -- function num : 0_19 , upvalues : _ENV
    local roomEntity = (self.roomDic)[position]
    if roomEntity ~= nil then
        return roomEntity
    else
        error("Can\'t find roomEntity, position = " .. tostring(position))
    end
end

ExplorationMapCtrl.GetRoomRoot = function(self)
    -- function num : 0_20
    return self.roomRoot
end

ExplorationMapCtrl.__InitViewPosition = function(self, position)
    -- function num : 0_21 , upvalues : _ENV
    self.viewPosition = position
    self.mapRect = {
        minPoint = (Vector2.New)(position.x, position.z),
        maxPoint = (Vector2.New)(position.x, position.z)
    }
end

ExplorationMapCtrl.GetViewPosition = function(self)
    -- function num : 0_22
    return self.viewPosition
end

ExplorationMapCtrl.SetViewPosition = function(self, position, force)
    -- function num : 0_23 , upvalues : _ENV
    self.viewPosition = position
    do
        if not force then
            local limit = (self.bind).limitAreaOffset -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'
            ;
            (self.viewPosition).x = (math.clamp)(position.x,
                                                 ((self.mapRect).minPoint).x -
                                                     limit,
                                                 ((self.mapRect).maxPoint).x +
                                                     limit) -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'
            ;
            (self.viewPosition).z = (math.clamp)(position.z,
                                                 ((self.mapRect).minPoint).y -
                                                     limit,
                                                 ((self.mapRect).maxPoint).y +
                                                     limit)
        end
        return self:GetViewPosition()
    end
end

ExplorationMapCtrl.OffsetMapRect = function(self, offset, viewPos)
    -- function num : 0_24
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

    ((self.mapRect).minPoint).x = offset.x + ((self.mapRect).minPoint).x -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.mapRect).minPoint).y = offset.z + ((self.mapRect).minPoint).y -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.mapRect).maxPoint).x = offset.x + ((self.mapRect).maxPoint).x -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.mapRect).maxPoint).y = offset.z + ((self.mapRect).maxPoint).y
    self:__UpdateBackgroundSize()
    self:SetViewPosition(viewPos, true)
end

ExplorationMapCtrl.OnPlayerMoveComplete =
    function(self, curRoomData)
        -- function num : 0_25
    end

ExplorationMapCtrl.OnRoomVisible = function(self, roomPos)
    -- function num : 0_26
    local minPoint = (self.mapRect).minPoint
    local maxPoint = (self.mapRect).maxPoint
    if roomPos.x < minPoint.x then
        minPoint.x = roomPos.x
    else
        if maxPoint.x < roomPos.x then maxPoint.x = roomPos.x end
    end
    if roomPos.z < minPoint.y then
        minPoint.y = roomPos.z
    else
        if maxPoint.y < roomPos.z then maxPoint.y = roomPos.z end
    end
    self:__UpdateBackgroundSize()
end

ExplorationMapCtrl.__UpdateBackgroundSize =
    function(self)
        -- function num : 0_27 , upvalues : _ENV
        local parent = ((self.bind).background).parent
        local minPoint = (self.mapRect).minPoint
        local maxPoint = (self.mapRect).maxPoint
        local localMinPoint = parent:InverseTransformPoint(
                                  (Vector3.New)(minPoint.x, 0, minPoint.y))
        local localMaxPoint = parent:InverseTransformPoint(
                                  (Vector3.New)(maxPoint.x, 0, maxPoint.y))
        local localSizeVector3 = localMaxPoint - localMinPoint
        localSizeVector3.x = (math.abs)(localSizeVector3.x)
        localSizeVector3.y = (math.abs)(localSizeVector3.y)
        local sizeX = localSizeVector3.x + (self.bind).bgSizeExtra
        local sizeY = localSizeVector3.y + (self.bind).bgSizeExtra
        local size = ((self.bind).background).sizeDelta
        if size.x ~= sizeX or size.y ~= sizeY then
            size.x = sizeX
            size.y = sizeY -- DECOMPILER ERROR at PC55: Confused about usage of register: R10 in 'UnsetPending'
            ;
            ((self.bind).background).sizeDelta = size
        end
        local pos = ((self.bind).background).localPosition
        local newPos = localSizeVector3 / 2
        if pos.x ~= newPos.x or pos.y ~= newPos.y then
            newPos.z = pos.z -- DECOMPILER ERROR at PC72: Confused about usage of register: R12 in 'UnsetPending'
            ;
            ((self.bind).background).localPosition = newPos
        end
    end

ExplorationMapCtrl.OnEpPlayerFightPowerChang =
    function(self)
        -- function num : 0_28 , upvalues : _ENV
        local curRoom = (self.epCtrl):GetCurrentRoomData()
        local playerPower = ((self.epCtrl).dynPlayer):GetCacheFightPower()
        local nextRooms = curRoom:GetNextRoom()
        for k, v in pairs(nextRooms) do
            self:ShowFightingPower(v, playerPower)
        end
    end

ExplorationMapCtrl.ShowFightingPower = function(self, roomData, playerPower)
    -- function num : 0_29
    local roomUI = self:GetRoomUI(roomData.position)
    local monsterList = roomData:GetMonsterList()
    if roomData:IsBattleRoom() and roomUI ~= nil and monsterList ~= nil and
        #monsterList > 0 then
        local power = roomData:GetTotalFightingPower()
        roomUI:RefreshBattleFightingPower(power, playerPower)
    end
end

ExplorationMapCtrl.EpMapTween = function(self, targetPos, completeFunc)
    -- function num : 0_30
    self.moveTweenCompleteFunc = completeFunc;
    (((self.bind).moveTween).tween):ChangeStartValue(
        (self.roomRoot).localPosition);
    (((self.bind).moveTween).tween):ChangeEndValue(targetPos);
    ((self.bind).moveTween):DORestart() -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.bind).canvasGroup).alpha = 1;
    ((self.bind).fadeTween):DORestartById("fade")
end

ExplorationMapCtrl.__OnMoveTweenComplete =
    function(self)
        -- function num : 0_31
        if self.moveTweenCompleteFunc ~= nil then
            (self.moveTweenCompleteFunc)()
        end
    end

ExplorationMapCtrl.PauseEpMapTween = function(self)
    -- function num : 0_32
    ((self.bind).moveTween):DOPause();
    ((self.bind).fadeTween):DOPause()
end

ExplorationMapCtrl.EpMapFadeTweenBack = function(self)
    -- function num : 0_33
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.bind).canvasGroup).alpha = 0;
    ((self.bind).fadeTween):DORestartById("show")
end

ExplorationMapCtrl.HideMapCavas = function(self)
    -- function num : 0_34
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.bind).canvasGroup).alpha = 0
end

ExplorationMapCtrl.HideMapCavasWithoutBg =
    function(self)
        -- function num : 0_35
        -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

        ((self.bind).roomCanvas).alpha = 0
    end

ExplorationMapCtrl.OnDelete = function(self)
    -- function num : 0_36 , upvalues : _ENV
    MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerMoveComplete,
                             self.__onEpPlayerMoveComplete)
    MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerFightPowerChang,
                             self.__OnEpPlayerFightPowerChang)
    MsgCenter:RemoveListener(eMsgEventId.OnEpOpStateChanged,
                             self.__onEpOpStateChanged)
    for k, v in pairs(self.roomDic) do v:OnDelete() end
    (self.playerPosItem):Delete()
    if self.resloader ~= nil then
        (self.resloader):Put2Pool()
        self.resloader = nil
    end
end

return ExplorationMapCtrl

