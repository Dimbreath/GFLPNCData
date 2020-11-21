-- params : ...
-- function num : 0 , upvalues : _ENV
local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormHouseCtrl = class("DormHouseCtrl", DormCtrlBase)
local DormRoomEntity = require("Game.Dorm.Entity.DormRoomEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local eDormState = require("Game.Dorm.Enum.eDormState")
local DormRoomData = require("Game.Dorm.Data.DormRoomData")
local DormEditHouseData = require("Game.Dorm.Data.DormEditHouseData")
local CS_DormCameraCtrl = CS.DormCameraController
DormHouseCtrl.ctor = function(self, dormCtrl)
    -- function num : 0_0 , upvalues : _ENV
    self.__onHouseClicked = BindCallback(self, self.OnHouseClicked)
    self.__onD2HTimelineComplete =
        BindCallback(self, self.OnD2HTimelineComplete)
    self.__onH2DTimelineComplete =
        BindCallback(self, self.OnH2DTimelineComplete)
end

DormHouseCtrl.OnEnterDormScene = function(self)
    -- function num : 0_1 , upvalues : _ENV
    if not IsNull(((self.dormCtrl).comRes).selectRoomEffectPrefab) then
        self.selectRoomEffect =
            (((self.dormCtrl).comRes).selectRoomEffectPrefab):Instantiate();
        (self.selectRoomEffect):SetActive(false)
    end
end

DormHouseCtrl.EnterDormHouse = function(self, id)
    -- function num : 0_2 , upvalues : _ENV, CS_DormCameraCtrl
    local curHouse = (((self.dormCtrl).allDormData).houseDic)[id]
    if curHouse == nil or self.curHouse == curHouse then return end
    self.curHouse = curHouse
    self.bind = (self.dormCtrl).bind;
    ((self.dormCtrl).dormWindow):InitDormUIData()
    if self.curHouse == nil then
        warn("no one dorm have!!!")
        return
    end
    if not IsNull(self.dormHolder) then
        DestroyUnityObject((self.dormHolder).gameObject)
    end
    self.dormHolder = (((CS.UnityEngine).GameObject)("DormHolder")).transform -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.dormHolder).position = Vector3.zero
    if self.resloader ~= nil then (self.resloader):Put2Pool() end
    self.resloader = ((CS.ResLoader).Create)()
    local houseType = ((self.curHouse).houseCfg).type
    if houseType <= 0 then
        (CS_DormCameraCtrl.Instance):SetDormVirtualCameraTarget(
            (self.bind).dormOneTarget, (self.bind).dormOneTarget)
    else

        (CS_DormCameraCtrl.Instance):SetDormVirtualCameraTarget(
            (self.bind).dormTarget, (self.bind).dormTarget)
    end
    self:__InitHouseEntity(houseType);
    ((self.dormCtrl).characterCtrl):OnEnterDormHouse();
    ((self.dormCtrl).dormWindow):RefreshDormHeroList()
end

DormHouseCtrl.__InitHouseEntity = function(self, houseType)
    -- function num : 0_3 , upvalues : CS_DormCameraCtrl, _ENV, DormUtil
    self.roomEnityDic = {};
    (CS_DormCameraCtrl.Instance):ClearDormTargetGroup()
    local n = ((self.curHouse).houseCfg).type
    for dx = -n, n do
        for dy = (math.max)(-n, -dx - n), (math.min)(n, -dx + n) do
            local dz = -dx - dy
            local spos = (DormUtil.XYToRoomCoord)(dx, dy)
            local roomData = ((self.curHouse).roomDic)[spos]
            self:AddNewRoom(dx, dy, spos, roomData)
        end
    end
end

DormHouseCtrl.AddNewRoom = function(self, x, y, spos, roomData)
    -- function num : 0_4 , upvalues : DormRoomEntity, _ENV, CS_DormCameraCtrl
    local roomEntity = (DormRoomEntity.New)()
    roomEntity:InitHouseData(x, y, spos, roomData)
    local roomPath = nil
    if roomData ~= nil then
        roomPath = PathConsts:GetDormRoomPath((roomData.roomCfg).prefab)
    else
        roomPath = PathConsts:GetDormRoomPath(
                       (ConfigData.game_config).DormEmptyRoomRes)
    end
    (self.resloader):LoadABAssetAsync(roomPath, function(prefab)
        -- function num : 0_4_0 , upvalues : self, roomEntity, CS_DormCameraCtrl
        local go = prefab:Instantiate(self.dormHolder)
        roomEntity:InitHouseObject(go, self.__onHouseClicked, self.resloader);
        (CS_DormCameraCtrl.Instance):AddDormTargetGroup(go.transform)
    end) -- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'
    ;
    (self.roomEnityDic)[spos] = roomEntity
end

DormHouseCtrl.OnHouseClicked = function(self, roomEntity)
    -- function num : 0_5 , upvalues : eDormState, _ENV
    if roomEntity == nil then return end
    local state = (self.dormCtrl).state
    -- DECOMPILER ERROR at PC14: Unhandled construct in 'MakeBoolean' P1

    if roomEntity.roomData == nil and
        (state == eDormState.House or state == eDormState.HouseEdit) then
        self.curEditSelectRoom = roomEntity
        -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

        if self.selectRoomEffect ~= nil then
            ((self.selectRoomEffect).transform).position =
                (roomEntity.transform).position;
            (self.selectRoomEffect):SetActive(true)
        end
        (self.dormCtrl):EnterDormEditor(function(editWindow)
            -- function num : 0_5_0 , upvalues : _ENV
            editWindow:OpenEditRoomList()
            UIManager:HideWindow(UIWindowTypeID.DormOperate)
        end)
    end
    if state == eDormState.House then
        local continueWindow =
            UIManager:ShowWindow(UIWindowTypeID.ClickContinue)
        continueWindow:InitContinue() -- DECOMPILER ERROR at PC47: Confused about usage of register: R4 in 'UnsetPending'
        ;
        (((self.dormCtrl).bind).roomTarget).position =
            (roomEntity.transform).position;
        (TimelineUtil.Play)(((self.dormCtrl).bind).tl_dormToRoom,
                            self.__onD2HTimelineComplete);
        ((((self.dormCtrl).bind).va_Dorm).gameObject):SetActive(false);
        ((((self.dormCtrl).bind).va_Room).gameObject):SetActive(true);
        (((self.dormCtrl).bind).va_Room):MoveToTopOfPrioritySubqueue();
        ((self.dormCtrl).roomCtrl):SetRoomEntity(roomEntity)
    else
        do
            if state == eDormState.HouseEdit then
                self.curEditSelectRoom = roomEntity
                -- DECOMPILER ERROR at PC91: Confused about usage of register: R3 in 'UnsetPending'

                if self.selectRoomEffect ~= nil then
                    ((self.selectRoomEffect).transform).position =
                        (roomEntity.transform).position;
                    (self.selectRoomEffect):SetActive(true)
                end
                local editWindow = UIManager:GetWindow(UIWindowTypeID.DormEdit)
                if editWindow ~= nil then
                    editWindow:OpenEditRoomList()
                end
                UIManager:ShowWindowAsync(UIWindowTypeID.DormOperate,
                                          function(opWindow)
                    -- function num : 0_5_1 , upvalues : roomEntity, self
                    opWindow:InitDormHouseOperate(
                        (roomEntity.transform).position,
                        (self.editHouseData):IsEmptyOrBpRoom(
                            (self.curEditSelectRoom).spos))
                end)
            end
        end
    end
end

DormHouseCtrl.EnterDormEditMode = function(self)
    -- function num : 0_6 , upvalues : DormEditHouseData
    self.editHouseData = (DormEditHouseData.CreateFormHouseData)(self.curHouse);
    ((self.dormCtrl).characterCtrl):OnEnterDormEditMode()
end

DormHouseCtrl.CancelSelectRoom = function(self)
    -- function num : 0_7 , upvalues : _ENV
    if self.selectRoomEffect ~= nil then
        (self.selectRoomEffect):SetActive(false)
    end
    UIManager:HideWindow(UIWindowTypeID.DormOperate)
end

DormHouseCtrl.ReplaceHouseRoom = function(self, roomId, roomData)
    -- function num : 0_8 , upvalues : _ENV, CS_DormCameraCtrl, DormRoomEntity, DormRoomData
    if self.curEditSelectRoom == nil then return end
    if self.selectRoomEffect ~= nil then
        (self.selectRoomEffect):SetActive(false)
    end
    UIManager:HideWindow(UIWindowTypeID.DormOperate)
    local spos = (self.curEditSelectRoom).spos
    if (self.editHouseData):ContainHouseRoom(spos) == false and
        (self.editHouseData):IsEditRoomLimit() then
        ((CS.MessageCommon).ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.dorm_HouseRoomNumLimt))
        return
    end
    (self.editHouseData):ReplaceHouseRoom(spos, roomId, roomData);
    (CS_DormCameraCtrl.Instance):RemoveDormTargetGroup(
        (self.curEditSelectRoom).transform)
    DestroyUnityObject((self.curEditSelectRoom).gameObject)
    local roomEntity = (DormRoomEntity.New)()
    if roomData == nil then
        roomData = (DormRoomData.CreateNewRoom)(spos, roomId)
    end
    roomEntity:InitHouseData((self.curEditSelectRoom).x,
                             (self.curEditSelectRoom).y, spos, roomData) -- DECOMPILER ERROR at PC74: Confused about usage of register: R5 in 'UnsetPending'
    ;
    (self.roomEnityDic)[(self.curEditSelectRoom).spos] = roomEntity
    local roomCfg = (ConfigData.dorm_room)[roomId]
    local roomPath = PathConsts:GetDormRoomPath(roomCfg.prefab);
    (self.resloader):LoadABAssetAsync(roomPath, function(prefab)
        -- function num : 0_8_0 , upvalues : self, spos, roomEntity, CS_DormCameraCtrl
        if (self.roomEnityDic)[spos] ~= roomEntity then return end
        local go = prefab:Instantiate(self.dormHolder)
        roomEntity:InitHouseObject(go, self.__onHouseClicked, self.resloader);
        (CS_DormCameraCtrl.Instance):AddDormTargetGroup(go.transform)
    end)
end

DormHouseCtrl.RecycleHouseRoom = function(self)
    -- function num : 0_9 , upvalues : CS_DormCameraCtrl, _ENV
    if self.curEditSelectRoom == nil then return end
    if self.selectRoomEffect ~= nil then
        (self.selectRoomEffect):SetActive(false)
    end
    (self.editHouseData):RecycleHouseRoom((self.curEditSelectRoom).spos);
    (CS_DormCameraCtrl.Instance):RemoveDormTargetGroup(
        (self.curEditSelectRoom).transform)
    DestroyUnityObject((self.curEditSelectRoom).gameObject)
    self:AddNewRoom((self.curEditSelectRoom).x, (self.curEditSelectRoom).y,
                    (self.curEditSelectRoom).spos)
    self.curEditSelectRoom = nil
    UIManager:HideWindow(UIWindowTypeID.DormOperate)
    local editWindow = UIManager:GetWindow(UIWindowTypeID.DormEdit)
    if editWindow ~= nil then editWindow:HideEditRoomList() end
end

DormHouseCtrl.ConfirmHouseEdit = function(self)
    -- function num : 0_10 , upvalues : eDormState
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    (self.dormCtrl).state = eDormState.House;
    ((self.dormCtrl).dormNetwork):CS_DORM_HouseEdit(self.editHouseData)
end

DormHouseCtrl.RecvHouseEdit = function(self, success, prefabUpdate)
    -- function num : 0_11
    if success then
        (self.editHouseData):ApplyModifyHouseData(prefabUpdate,
                                                  (self.dormCtrl).allDormData,
                                                  self.roomEnityDic);
        (self.dormCtrl):SetAllBindFntDataDirty();
        ((self.dormCtrl).dormWindow):RefreshDormHeroList();
        ((self.dormCtrl).characterCtrl):OnEixtDormEditMode(true);
        ((self.dormCtrl).dormWindow):Show()
    else
        self:CancelHouseEdit()
    end
    self.editHouseData = nil
    self.curEditSelectRoom = nil
end

DormHouseCtrl.CancelHouseEdit = function(self)
    -- function num : 0_12 , upvalues : eDormState, _ENV, CS_DormCameraCtrl
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    (self.dormCtrl).state = eDormState.House
    self.editHouseData = nil
    self.curEditSelectRoom = nil
    for spos, roomEntity in pairs(self.roomEnityDic) do
        local roomData = ((self.curHouse).roomDic)[spos]
        if roomData ~= roomEntity.roomData then
            (CS_DormCameraCtrl.Instance):RemoveDormTargetGroup(
                roomEntity.transform)
            DestroyUnityObject(roomEntity.gameObject)
            self:AddNewRoom(roomEntity.x, roomEntity.y, roomEntity.spos,
                            roomData)
        end
    end
    ((self.dormCtrl).dormWindow):Show();
    ((self.dormCtrl).characterCtrl):OnEixtDormEditMode(false)
end

DormHouseCtrl.DecomposeHouseRoom = function(self)
    -- function num : 0_13 , upvalues : _ENV
    if self.curEditSelectRoom == nil then return end
    if self.selectRoomEffect ~= nil then
        (self.selectRoomEffect):SetActive(false)
    end
    if (self.editHouseData):IsEmptyOrBpRoom((self.curEditSelectRoom).spos) then
        return
    end
    local roomData = (self.curEditSelectRoom).roomData
    if roomData == nil then return end
    local houseId, param = nil, nil
    local formHouse = false
    if roomData.isPrefab then
        param = roomData.uid
    else
        houseId = (self.curHouse).id
        param = roomData.spos
        formHouse = true
    end
    ((self.dormCtrl).dormNetwork):CS_DORM_RoomDecomposition(houseId, param,
                                                            formHouse)
    UIManager:HideWindow(UIWindowTypeID.DormOperate)
    local editWindow = UIManager:GetWindow(UIWindowTypeID.DormEdit)
    if editWindow ~= nil then editWindow:HideEditRoomList() end
end

DormHouseCtrl.RecvHouseRoomDecompose = function(self, success, prefabUpdate)
    -- function num : 0_14 , upvalues : CS_DormCameraCtrl, _ENV
    if not success then return end
    local roomData = (self.curEditSelectRoom).roomData
    local param = nil
    local formHouse = false
    if roomData.isPrefab then
        param = roomData.uid
    else
        param = roomData.spos
        formHouse = true
    end
    (self.editHouseData):ApplyDecomposeHouseRoom(formHouse, param, prefabUpdate,
                                                 (self.dormCtrl).allDormData);
    (CS_DormCameraCtrl.Instance):RemoveDormTargetGroup(
        (self.curEditSelectRoom).transform)
    DestroyUnityObject((self.curEditSelectRoom).gameObject)
    self:AddNewRoom((self.curEditSelectRoom).x, (self.curEditSelectRoom).y,
                    (self.curEditSelectRoom).spos)
    self.curEditSelectRoom = nil;
    (self.dormCtrl):SetAllBindFntDataDirty();
    ((self.dormCtrl).dormWindow):RefreshDormHeroList()
end

DormHouseCtrl.ExitRoom = function(self)
    -- function num : 0_15 , upvalues : _ENV
    local continueWindow = UIManager:ShowWindow(UIWindowTypeID.ClickContinue)
    continueWindow:InitContinue(nil, nil, nil, nil, false);
    (TimelineUtil.Rewind)(((self.dormCtrl).bind).tl_dormToRoom,
                          self.__onH2DTimelineComplete);
    ((((self.dormCtrl).bind).va_Dorm).gameObject):SetActive(true);
    ((((self.dormCtrl).bind).va_Room).gameObject):SetActive(false);
    (((self.dormCtrl).bind).va_Dorm):MoveToTopOfPrioritySubqueue();
    ((self.dormCtrl).roomCtrl):OnExitDormRoom();
    ((self.dormCtrl).characterCtrl):OnExitRoomMode()
end

DormHouseCtrl.OnD2HTimelineComplete = function(self, pd)
    -- function num : 0_16 , upvalues : eDormState, _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    (self.dormCtrl).state = eDormState.Room
    UIManager:HideWindow(UIWindowTypeID.ClickContinue);
    ((self.dormCtrl).roomCtrl):OnEnterDormRoom()
end

DormHouseCtrl.OnH2DTimelineComplete = function(self, pd)
    -- function num : 0_17 , upvalues : eDormState, _ENV, CS_DormCameraCtrl
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    (self.dormCtrl).state = eDormState.House
    UIManager:HideWindow(UIWindowTypeID.ClickContinue);
    ((self.dormCtrl).dormWindow):RefreshDormHeroList();
    (CS_DormCameraCtrl.Instance):ResetDormRoomView()
end

DormHouseCtrl.OnDelete = function(self)
    -- function num : 0_18
    self.roomEnityDic = nil
    self.dormHolder = nil
end

return DormHouseCtrl

