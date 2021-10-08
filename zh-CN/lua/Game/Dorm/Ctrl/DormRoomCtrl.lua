local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormRoomCtrl = class("DormRoomCtrl", DormCtrlBase)
local DormEditRoomData = require("Game.Dorm.Data.DormEditRoomData")
local DormFurnitureData = require("Game.Dorm.Data.DormFurnitureData")
local DormEnum = require("Game.Dorm.DormEnum")
local DormFntBottomEntity = require("Game.Dorm.Entity.DormFntBottomEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local CS_LeanGesture = ((CS.Lean).Touch).LeanGesture
local CS_Physics = CS.PhysicsUtility
local CS_MessageCommon = CS.MessageCommon
local CS_DormCameraController = CS.DormCameraController
local CS_GameObject = (CS.UnityEngine).GameObject
local CS_RenderManager = CS.RenderManager
local CS_UnityUtility = CS.UnityUtility
DormRoomCtrl.ctor = function(self, dormCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
  self.__onFingerSet = BindCallback(self, self.OnFingerSet)
  self.__onFingerUp = BindCallback(self, self.OnFingerUp)
  self.__onGesture = BindCallback(self, self.OnGesture)
  self.__onFingerTap = BindCallback(self, self.OnFingerTap)
  self.__update__handle = BindCallback(self, self.OnUpdate)
  self.__onItemChangeEvent = BindCallback(self, self.OnItemChange)
  self.__onConfirmEditComplete = BindCallback(self, self.ConfirmDormRoomEditComplete)
  self._oldPos = {}
  self._grid = {}
end

DormRoomCtrl.OnEnterDormRoomStart = function(self, roomEntity)
  -- function num : 0_1
  self.roomEntity = roomEntity
end

DormRoomCtrl.OnEnterDormRoomEnd = function(self, roomEntity)
  -- function num : 0_2 , upvalues : CS_LeanTouch, _ENV, DormEditRoomData
  (CS_LeanTouch.OnFingerDown)("+", self.__onFingerDown)
  ;
  (CS_LeanTouch.OnFingerSet)("+", self.__onFingerSet)
  ;
  (CS_LeanTouch.OnFingerUp)("+", self.__onFingerUp)
  ;
  (CS_LeanTouch.OnGesture)("+", self.__onGesture)
  ;
  (CS_LeanTouch.OnFingerTap)("+", self.__onFingerTap)
  UpdateManager:AddUpdate(self.__update__handle)
  TimerManager:AddLateCommand(function()
    -- function num : 0_2_0 , upvalues : self
    self:UpdDmRoomWallVisible()
  end
)
  self.__wallCheckTime = 0
  self.bind = (self.dormCtrl).bind
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemChangeEvent)
  self.editRoomData = (DormEditRoomData.New)()
  ;
  ((self.dormCtrl).dormWindow):RefreshDormHeroList()
end

DormRoomCtrl.ShowDormRoomUI = function(self)
  -- function num : 0_3 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.DormRoom, function(window)
    -- function num : 0_3_0 , upvalues : self, _ENV
    if window == nil then
      return 
    end
    window:InitUIDormRoom(self)
    if self.__autoEnterEditMode then
      self.__autoEnterEditMode = false
      TimerManager:AddLateCommand(function()
      -- function num : 0_3_0_0 , upvalues : self
      self:EnterDormRoomEdit()
    end
)
    end
  end
)
end

DormRoomCtrl.OnExitDormRoomStart = function(self, roomEntity)
  -- function num : 0_4 , upvalues : _ENV, CS_LeanTouch
  if self.roomEntity == nil then
    return 
  end
  ;
  (self.roomEntity):ResetDormRoomWall()
  self.roomEntity = nil
  self.editRoomData = nil
  UIManager:HideWindow(UIWindowTypeID.DormRoom)
  ;
  (CS_LeanTouch.OnFingerDown)("-", self.__onFingerDown)
  ;
  (CS_LeanTouch.OnFingerSet)("-", self.__onFingerSet)
  ;
  (CS_LeanTouch.OnFingerUp)("-", self.__onFingerUp)
  ;
  (CS_LeanTouch.OnGesture)("-", self.__onGesture)
  ;
  (CS_LeanTouch.OnFingerTap)("-", self.__onFingerTap)
  UpdateManager:RemoveUpdate(self.__update__handle)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemChangeEvent)
end

DormRoomCtrl.SetAutoEnterRoomEdit = function(self)
  -- function num : 0_5
  self.__autoEnterEditMode = true
end

DormRoomCtrl.OnFingerDown = function(self, leanFinger)
  -- function num : 0_6 , upvalues : DormEnum, CS_Physics, _ENV
  if (self.dormCtrl).state ~= (DormEnum.eDormState).RoomEdit or leanFinger.IsOverGui then
    return 
  end
  local hits = (CS_Physics.Raycast)((self.bind).camera, 1 << LayerMask.Raycast, true)
  for i = 0, hits.Length - 1 do
    local hitCollider = (hits[i]).collider
    if not IsNull(hitCollider) and (hitCollider.tag == TagConsts.DormFurniture or hitCollider.tag == TagConsts.DormFurnitureCollider) then
      local fntEntity = (self.roomEntity):GetFntByGo(hitCollider.gameObject)
      self:SelectFntEntity(fntEntity)
      self._fingerId = leanFinger.Index
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self._oldPos).x = (fntEntity.fntData).x
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self._oldPos).y = (fntEntity.fntData).y
      self._drag = true
      self._dragOffset = nil
      return 
    end
  end
end

DormRoomCtrl.OnFingerSet = function(self, leanFinger)
  -- function num : 0_7 , upvalues : CS_Physics, _ENV, DormEnum
  if not self._drag or self._selectFntEntity == nil or self._fingerId ~= leanFinger.Index or (leanFinger.ScreenDelta).x == 0 and (leanFinger.ScreenDelta).y == 0 then
    return 
  end
  local hits = (CS_Physics.Raycast)((self.bind).camera, 1 << LayerMask.Raycast)
  for i = 0, hits.Length - 1 do
    local hitCollider = (hits[i]).collider
    if not IsNull(hitCollider) then
      local hitPos = nil
      local fntType = (self._selectFntEntity).type
      local oldWallIndex = nil
      if (fntType == (DormEnum.eDormFntType).WallDecoration or fntType == (DormEnum.eDormFntType).Door) and hitCollider.tag == TagConsts.DormWall then
        local ok, wallIndex, hitWallTransform = (self.roomEntity):IsDmRoomWall(((hits[i]).collider).gameObject)
        if ok then
          local wallHolder = ((self._selectFntEntity).rootTran).parent
          if hitWallTransform ~= wallHolder.parent then
            oldWallIndex = ((self._selectFntEntity).fntData):GetFntParam()
            ;
            (self._selectFntEntity):ChangeDmFntWall(hitWallTransform, wallIndex)
            self:ShowGrid(fntType, wallIndex)
          end
          if not self._dragOffset then
            do
              self._dragOffset = ((self._selectFntEntity).rootTran).position - (hits[i]).point
              hitPos = hitWallTransform:InverseTransformPoint((hits[i]).point + self._dragOffset)
              hitPos.z = 0
              if fntType ~= (DormEnum.eDormFntType).WallDecoration and fntType ~= (DormEnum.eDormFntType).Door and hitCollider.tag == TagConsts.DormFloor then
                if not self._dragOffset then
                  self._dragOffset = ((self._selectFntEntity).rootTran).position - (hits[i]).point
                  hitPos = (((self._selectFntEntity).rootTran).parent):InverseTransformPoint((hits[i]).point + self._dragOffset)
                  hitPos.y = 0
                  do
                    local move, oldX, oldY = (self._selectFntEntity):SetFntEntityPosFromUnity(hitPos)
                    if move then
                      local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
                      if roomWin ~= nil then
                        (roomWin.dmRoomEditNode):DmRoomEditOperateShow(false)
                      end
                      local doorOldFloorAreaList = nil
                      if fntType == (DormEnum.eDormFntType).Door then
                        doorOldFloorAreaList = (self._selectFntEntity):GetFntDoorAreaList(oldX, oldY, oldWallIndex)
                      end
                      local oldAreaList = (self._selectFntEntity):GetFntAreaList(oldX, oldY)
                      ;
                      (self.roomEntity):UpdateFntMap(self._selectFntEntity, false, oldAreaList, oldWallIndex, doorOldFloorAreaList)
                      ;
                      (self.roomEntity):UpdateFntMap(self._selectFntEntity, true)
                      self._edited = true
                    end
                    do break end
                    -- DECOMPILER ERROR at PC187: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC187: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC187: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC187: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC187: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC187: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC187: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC187: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC187: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC187: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC187: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC187: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC187: LeaveBlock: unexpected jumping out IF_STMT

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

DormRoomCtrl.OnFingerUp = function(self, leanFinger)
  -- function num : 0_8 , upvalues : _ENV
  if not self._drag or self._selectFntEntity == nil or self._fingerId ~= leanFinger.Index then
    return 
  end
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    (roomWin.dmRoomEditNode):DmRoomEditSelectFntMode(true)
  end
  self._fingerId = nil
  self._drag = false
end

DormRoomCtrl.OnGesture = function(self, fingerList)
  -- function num : 0_9 , upvalues : CS_LeanGesture, CS_RenderManager, CS_DormCameraController
  if self._drag or fingerList.Count == 0 or (fingerList[0]).StartedOverGui then
    return 
  end
  if ((self.dormCtrl).characterCtrl):IsDragCharacter() then
    return 
  end
  local delta = (CS_LeanGesture.GetScreenDelta)(fingerList) * (CS_RenderManager.Instance).ScreenScaleRatio
  ;
  (CS_DormCameraController.Instance):DormRoomViewRotate(delta)
end

DormRoomCtrl.OnFingerTap = function(self, leanFinger)
  -- function num : 0_10
  if self._selectFntEntity ~= nil and not self._drag and not leanFinger.IsOverGui and not leanFinger.StartedOverGui then
    self:DeselectFntEntity()
  end
end

DormRoomCtrl.OnUpdate = function(self)
  -- function num : 0_11 , upvalues : _ENV, CS_LeanTouch, CS_LeanGesture, CS_DormCameraController
  if not GuideManager.inGuide and not self._drag and not ((self.dormCtrl).characterCtrl):IsDragCharacter() then
    local fingers = (CS_LeanTouch.GetFingers)(true, false)
    local pinch = (CS_LeanGesture.GetPinchScale)(fingers, ((self.dormCtrl).bind).dormRoomWheel) - 1
    ;
    (CS_DormCameraController.Instance):DormRoomViewDistance(-pinch * 3)
  end
  do
    do
      if self._selectFntEntity ~= nil then
        local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
        if roomWin ~= nil then
          ((roomWin.dmRoomEditNode).dmRoomFntOp):UpdDmRoomFntOpPos((self._selectFntEntity):GetFntEntityCenterTrasform())
        end
      end
      self:__RoomWallCheck()
    end
  end
end

DormRoomCtrl.__RoomWallCheck = function(self)
  -- function num : 0_12 , upvalues : _ENV
  self.__wallCheckTime = self.__wallCheckTime - Time.deltaTime
  if self.__wallCheckTime <= 0 then
    self.__wallCheckTime = (ConfigData.buildinConfig).DormRoomWallCheck
    self:UpdDmRoomWallVisible()
  end
end

DormRoomCtrl.UpdDmRoomWallVisible = function(self)
  -- function num : 0_13 , upvalues : CS_UnityUtility, CS_DormCameraController
  local angle = (CS_UnityUtility.GetTargetForwardAngle)((CS_DormCameraController.Instance).transform, (self.roomEntity).transform)
  if angle >= -22.5 and angle < 22.5 then
    (self.roomEntity):Show3Hide1DormRoom(3)
  else
    if angle >= 22.5 and angle < 67.5 then
      (self.roomEntity):Show2Hide2DormRoom(1, 2, 3, 4)
    else
      if angle >= 67.5 and angle < 112.5 then
        (self.roomEntity):Show3Hide1DormRoom(4)
      else
        if angle >= 112.5 and angle < 157.5 then
          (self.roomEntity):Show2Hide2DormRoom(2, 3, 4, 1)
        else
          if angle >= 157.5 or angle < -157.5 then
            (self.roomEntity):Show3Hide1DormRoom(1)
          else
            if angle >= -157.5 and angle < -112.5 then
              (self.roomEntity):Show2Hide2DormRoom(3, 4, 1, 2)
            else
              if angle >= -112.5 and angle < -67.5 then
                (self.roomEntity):Show3Hide1DormRoom(2)
              else
                ;
                (self.roomEntity):Show2Hide2DormRoom(4, 1, 2, 3)
              end
            end
          end
        end
      end
    end
  end
end

DormRoomCtrl.SelectFntEntity = function(self, fntEntity)
  -- function num : 0_14 , upvalues : _ENV, DormUtil, DormEnum
  self._selectFntEntity = fntEntity
  local fntData = fntEntity.fntData
  self:ShowGrid(fntData:GetFntType(), fntData:GetFntParam())
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    local fntName = fntData:GetName()
    local fntType = fntData:GetFntType()
    local showRecycleBtn = fntData:IsDmFntDoor() and not (DormUtil.IsDmRoomDefaultDoorId)(fntData.id)
    local notInWall = fntType ~= (DormEnum.eDormFntType).WallDecoration and fntType ~= (DormEnum.eDormFntType).Door
    ;
    ((roomWin.dmRoomEditNode).dmRoomFntOp):InitDmRoomFntOperate(self, fntName, notInWall, showRecycleBtn)
    ;
    (roomWin.dmRoomEditNode):DmRoomEditSelectFntMode(true)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

DormRoomCtrl.DeselectFntEntity = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if self._selectFntEntity == nil then
    return 
  end
  self._selectFntEntity = nil
  self:HideAllGrid()
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    (roomWin.dmRoomEditNode):DmRoomEditSelectFntMode(false)
  end
  if self.editWindow ~= nil then
    (self.editWindow):UpdateUIDormRoomEdit()
  end
end

DormRoomCtrl.OnDmRoomWallShow = function(self, wallId, isShow)
  -- function num : 0_16 , upvalues : _ENV
  if self._selectFntEntity == nil or ((self._selectFntEntity).fntData):GetFntParam() ~= wallId then
    return 
  end
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    (roomWin.dmRoomEditNode):DmRoomEditOperateShow(isShow, true)
  end
end

DormRoomCtrl.ResetFntEntity = function(self)
  -- function num : 0_17
  if self._selectFntEntity == nil then
    return 
  end
  ;
  (self.roomEntity):ResetDmRoomFntEntity(self._selectFntEntity, true)
end

DormRoomCtrl.OnItemChange = function(self, itemUpdate, resourceData)
  -- function num : 0_18 , upvalues : DormEnum
  if resourceData.backpack == nil then
    return 
  end
  if self.editRoomData ~= nil and (self.dormCtrl).state == (DormEnum.eDormState).RoomEdit then
    (self.editRoomData):OnItemChange(itemUpdate, resourceData)
  end
end

DormRoomCtrl.EnterDormRoomEdit = function(self, resetData)
  -- function num : 0_19 , upvalues : _ENV, CS_DormCameraController
  if resetData == nil then
    resetData = true
  end
  if resetData then
    (self.editRoomData):ResetStorateFntData()
  end
  self._recycledFntDic = {}
  self:TryInitGrid()
  ;
  (self.roomEntity):EnterRoomEditMode((self._grid).floor, (self._grid).wall, self)
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    roomWin:OnDRoomEidtMode(true)
  end
  ;
  (UIUtil.SetTopStatusBtnShow)(false, false)
  ;
  (CS_DormCameraController.Instance):DmRoomEditorEnterTween(true)
  ;
  (self.dormCtrl):EmitEnterDormRoomEditMode(self.roomEntity)
end

DormRoomCtrl.ConfirmDormRoomEdit = function(self)
  -- function num : 0_20 , upvalues : CS_MessageCommon, _ENV
  if not self:HasDmRoomEdited() then
    self:ExitDormRoomEdit()
    return 
  end
  if (self.roomEntity):FntMapOverlap() then
    (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Dorm_FntConfirmEdit))
    return 
  end
  local roomData = (self.roomEntity).roomData
  local wallId = roomData.wallId
  local floorId = roomData.floorId
  local doorData = (roomData.dmRoomDoorData):GetDmFntServerData()
  local houseId = (((self.dormCtrl).houseCtrl).curHouse).id
  local roomPos = (self.roomEntity).spos
  self._newFntDataList = roomData:GetFntDatas()
  ;
  ((self.dormCtrl).dormNetwork):CS_DORM_RoomEdit(houseId, roomPos, self._newFntDataList, wallId, floorId, doorData, self.__onConfirmEditComplete)
end

DormRoomCtrl.ConfirmDormRoomEditComplete = function(self, dataList)
  -- function num : 0_21 , upvalues : _ENV
  if dataList.Count == 0 then
    error("dataList.Count == 0")
    return 
  end
  local success = dataList[0]
  if success then
    ((self.roomEntity).roomData):UpdateRoomFntData(self._newFntDataList, false)
    ;
    ((self.roomEntity).roomData):SaveDmRoomData()
    self:ExitDormRoomEdit(true)
  end
  self._newFntDataList = nil
end

DormRoomCtrl.HasDmRoomEdited = function(self)
  -- function num : 0_22
  return self._edited
end

DormRoomCtrl.ExitDormRoomEdit = function(self, editSuccess, fromTopStates)
  -- function num : 0_23 , upvalues : _ENV, CS_DormCameraController
  if not fromTopStates then
    (UIUtil.PopFromBackStack)()
  end
  ;
  (UIUtil.SetTopStatusBtnShow)(true, true)
  local restore = false
  if self._edited and not editSuccess then
    self:RestoreDormRoomEdit()
    restore = true
  end
  self._edited = false
  self._selectFntEntity = nil
  self.editWindow = nil
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    roomWin:OnDRoomEidtMode(false)
    if restore then
      roomWin:RefreshDormRoomBaseInfo()
    end
  end
  for fntData,fntEntity in pairs(self._recycledFntDic) do
    fntEntity:OnDelete()
  end
  self._recycledFntDic = nil
  self:RecycleAllGrid()
  ;
  (self.roomEntity):ExitRoomEditMode(self, editSuccess)
  ;
  (self.dormCtrl):SetAllBindFntDataDirty()
  ;
  (CS_DormCameraController.Instance):DmRoomEditorEnterTween(false)
  ;
  (self.dormCtrl):EmitExitDormRoomEditMode(self.roomEntity, editSuccess)
end

DormRoomCtrl.RestoreDormRoomEdit = function(self)
  -- function num : 0_24 , upvalues : _ENV
  if not self._edited then
    return 
  end
  local fntObjDic = (self.roomEntity):GetFntObjDic()
  local recycleList = {}
  for go,fntEntity in pairs(fntObjDic) do
    if not (self.roomEntity):IsOriginDmRoomFnt(fntEntity.fntData) then
      (table.insert)(recycleList, fntEntity)
    end
  end
  for k,fntEntity in ipairs(recycleList) do
    self:RecycleFnt(fntEntity)
  end
  ;
  (self.roomEntity):ReinitAllFntEntity()
  self:ResetDmRoomDoor(false, false)
  ;
  (self.roomEntity):InitFntMapData()
  self:ResetDmRoomFloor()
  self:ResetDmRoomWall()
  ;
  (self.editRoomData):ResetStorateFntData()
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    (roomWin.dmRoomEditNode):ReinitDmRoomtEditData()
  end
  self._recycledFntDic = {}
  self._edited = false
end

local _installFloorFntFunc = function(self, fntId)
  -- function num : 0_25 , upvalues : _ENV
  local fntData = self:_NewFntData(fntId)
  fntData:SetFntPos((ConfigData.game_config).HouseGridCount // 2, (ConfigData.game_config).HouseHeightCount // 2)
  fntData:CheckOutMap()
  self:InstallFntConfirm(fntData)
end

local _InstallFntFunc = {[(DormEnum.eDormFntType).FloorDecoration] = _installFloorFntFunc, [(DormEnum.eDormFntType).WallDecoration] = function(self, fntId)
  -- function num : 0_26 , upvalues : _ENV
  local fntData = self:_NewFntData(fntId)
  fntData:SetFntPos((ConfigData.game_config).HouseGridCount // 2, (ConfigData.game_config).HouseHeightCount // 2)
  fntData:CheckOutMap()
  self:InstallFntConfirm(fntData, 1)
end
, [(DormEnum.eDormFntType).Furniture] = _installFloorFntFunc, [(DormEnum.eDormFntType).Wall] = function(self, fntId)
  -- function num : 0_27
  local curId = ((self.roomEntity).roomData).wallId
  if curId == fntId then
    return 
  end
  if fntId == 0 then
    self:ResetDmRoomWall(true)
    return 
  end
  ;
  ((self.roomEntity).roomData):SetDmRoomWall(fntId)
  ;
  (self.roomEntity):ChangeDmRoomWall(fntId)
  ;
  (self.editRoomData):InstallFntData(fntId)
  if curId ~= 0 then
    (self.editRoomData):UninstallFntData(curId)
  end
end
, [(DormEnum.eDormFntType).Floor] = function(self, fntId)
  -- function num : 0_28
  local curId = ((self.roomEntity).roomData).floorId
  if curId == fntId then
    return 
  end
  if fntId == 0 then
    self:ResetDmRoomFloor(true)
    return 
  end
  ;
  ((self.roomEntity).roomData):SetDmRoomFloor(fntId)
  ;
  (self.roomEntity):ChangeDmRoomFloor(fntId)
  ;
  (self.editRoomData):InstallFntData(fntId)
  if curId ~= 0 then
    (self.editRoomData):UninstallFntData(curId)
  end
end
, [(DormEnum.eDormFntType).Door] = function(self, fntId)
  -- function num : 0_29 , upvalues : DormUtil
  local fntData = ((self.roomEntity).roomData).dmRoomDoorData
  local curId = fntData.id
  if not fntData:TryFntDoorDataChangeDoor(fntId) then
    return 
  end
  local doorEntity = (self.roomEntity):GetFntByData(fntData)
  local move, oldX, oldY = doorEntity:SetFntEntityPosFromUnity(doorEntity:GetFntEntityLocalPos(), true)
  if move then
    local doorOldFloorAreaList = doorEntity:GetFntDoorAreaList(oldX, oldY)
    local oldAreaList = doorEntity:GetFntAreaList(oldX, oldY)
    ;
    (self.roomEntity):UpdateFntMap(doorEntity, false, oldAreaList, nil, doorOldFloorAreaList)
    ;
    (self.roomEntity):UpdateFntMap(doorEntity, true)
  end
  do
    if not (DormUtil.IsDmRoomDefaultDoorId)(fntId) then
      (self.editRoomData):InstallFntData(fntId)
    end
    if curId ~= 0 then
      (self.editRoomData):UninstallFntData(curId)
    end
    ;
    (self.roomEntity):ChangeDmRoomDoorGo()
  end
end
}
DormRoomCtrl._NewFntData = function(self, fntId)
  -- function num : 0_30 , upvalues : DormFurnitureData
  local fntData = (DormFurnitureData.New)()
  fntData:InitFntData(fntId, (self.roomEntity).roomData)
  return fntData
end

DormRoomCtrl.InstallFnt = function(self, fntWarehousedata)
  -- function num : 0_31 , upvalues : DormEnum, _InstallFntFunc, _ENV
  if (self.dormCtrl).state ~= (DormEnum.eDormState).Room or (self.dormCtrl).state == (DormEnum.eDormState).RoomEdit then
    do return  end
    local fntId = fntWarehousedata.id
    local fntType = (fntWarehousedata.fntCfg).type
    local installFunc = _InstallFntFunc[fntType]
    if installFunc == nil then
      error((string.format)("unsurpported fntType, fntType:%s, fntId:%s", fntType, fntId))
      return 
    end
    installFunc(self, fntId)
    self._edited = true
  end
end

DormRoomCtrl.InstallFntConfirm = function(self, fntData, param)
  -- function num : 0_32 , upvalues : _ENV
  fntData:SetFntParam(param)
  fntData:RecordOriginalFntData()
  local fntEntity = (self.roomEntity):CreateFntEntity(fntData, true)
  local bottomItem = self:GetFntBottomItem()
  fntEntity:AddFntBottom(bottomItem)
  self:SelectFntEntity(fntEntity)
  ;
  (self.editRoomData):InstallFntData(fntData.id)
  self._edited = true
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    (roomWin.dmRoomEditNode):DmRoomEditSelectFntMode(true)
  end
end

DormRoomCtrl.RecycleFntSelect = function(self)
  -- function num : 0_33 , upvalues : DormEnum, _ENV
  if self._selectFntEntity == nil then
    return 
  end
  local fntData = (self._selectFntEntity).fntData
  if fntData:GetFntType() == (DormEnum.eDormFntType).Door then
    self:ResetDmRoomDoor(true, true)
    local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
    if roomWin ~= nil then
      local fntName = fntData:GetName()
      ;
      ((roomWin.dmRoomEditNode).dmRoomFntOp):InitDmRoomFntOperate(self, fntName, false, false)
    end
  else
    do
      self:RecycleFnt(self._selectFntEntity)
      self:DeselectFntEntity()
      self._edited = true
    end
  end
end

DormRoomCtrl.RecycleFnt = function(self, fntEntity)
  -- function num : 0_34 , upvalues : _ENV
  local fntData = fntEntity.fntData
  if fntData:IsDmFntDoor() then
    warn("Cant recycle fnt door")
    return 
  end
  ;
  (self.editRoomData):UninstallFntData(fntData.id)
  ;
  (self.roomEntity):RemoveFntEntity(fntEntity)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  if (self.roomEntity):IsOriginDmRoomFnt(fntEntity.fntData) then
    (self._recycledFntDic)[fntEntity.fntData] = fntEntity
    ;
    (fntEntity.rootGo):SetActive(false)
  else
    local fntBottomItem = fntEntity:RemoveFntBottom()
    if fntBottomItem ~= nil then
      self:RecycleFntBottomItem(fntBottomItem)
    end
    fntEntity:OnDelete()
  end
end

DormRoomCtrl.ClearAllFnt = function(self)
  -- function num : 0_35 , upvalues : _ENV
  local fntObjDic = (self.roomEntity):GetFntObjDic()
  local recycleList = {}
  for go,fntEntity in pairs(fntObjDic) do
    if not (fntEntity.fntData):IsDmFntDoor() then
      (table.insert)(recycleList, fntEntity)
    end
  end
  for k,fntEntity in ipairs(recycleList) do
    self:RecycleFnt(fntEntity)
  end
  self:ResetDmRoomDoor(true)
  self:ResetDmRoomWall(true)
  self:ResetDmRoomFloor(true)
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    (roomWin.dmRoomEditNode):DmRoomEditSelectFntMode(false)
  end
  self._selectFntEntity = nil
  self._edited = true
end

DormRoomCtrl.ResetDmRoomWall = function(self, isDefault)
  -- function num : 0_36
  local curWallId = ((self.roomEntity).roomData).wallId
  if not isDefault or not 0 then
    local tarWallId = ((self.roomEntity).roomData):GetDmRoomOldWall()
  end
  if curWallId == tarWallId then
    return 
  end
  ;
  ((self.roomEntity).roomData):SetDmRoomWall(tarWallId)
  ;
  (self.roomEntity):ChangeDmRoomWall(tarWallId)
  if curWallId ~= 0 then
    (self.editRoomData):UninstallFntData(curWallId)
  end
end

DormRoomCtrl.ResetDmRoomFloor = function(self, isDefault)
  -- function num : 0_37
  local curFloorId = ((self.roomEntity).roomData).floorId
  if not isDefault or not 0 then
    local tarFloorId = ((self.roomEntity).roomData):GetDmRoomOldFloor()
  end
  if tarFloorId == curFloorId then
    return 
  end
  ;
  ((self.roomEntity).roomData):SetDmRoomFloor(tarFloorId)
  ;
  (self.roomEntity):ChangeDmRoomFloor(tarFloorId)
  if curFloorId ~= 0 then
    (self.editRoomData):UninstallFntData(curFloorId)
  end
end

DormRoomCtrl.ResetDmRoomDoor = function(self, isDefault, onlyGameObject)
  -- function num : 0_38 , upvalues : DormUtil, _ENV, _InstallFntFunc, DormEnum
  local doorData = ((self.roomEntity).roomData).dmRoomDoorData
  local curDoorId = doorData.id
  if not isDefault or not 0 then
    local tarDoorId = ((self.roomEntity).roomData):GetDmRoomOldDoor()
  end
  if curDoorId ~= tarDoorId then
    if (DormUtil.IsDmRoomDefaultDoorId)(tarDoorId) then
      tarDoorId = (ConfigData.game_config).DmRoomDoorDefaultId
    end
    local installFunc = _InstallFntFunc[(DormEnum.eDormFntType).Door]
    installFunc(self, tarDoorId)
  end
  do
    if onlyGameObject then
      return 
    end
    doorData:ResetFntData()
    local doorEntity = (self.roomEntity):GetFntByData(doorData)
    local holder = (self.roomEntity):GetFntHolder((DormEnum.eDormFntType).Door, doorData:GetFntParam())
    doorEntity:ResetFntEntityByData(holder)
  end
end

DormRoomCtrl.RotateFnt = function(self)
  -- function num : 0_39
  if self._selectFntEntity ~= nil then
    (self.roomEntity):UpdateFntMap(self._selectFntEntity, false)
    ;
    (self._selectFntEntity):RotateFntEntity()
    ;
    (self.roomEntity):UpdateFntMap(self._selectFntEntity, true)
  end
end

DormRoomCtrl.TryInitGrid = function(self)
  -- function num : 0_40 , upvalues : _ENV, CS_GameObject
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if IsNull((self._grid).holder) then
    (self._grid).holder = (CS_GameObject("GridHolder")).transform
    ;
    (((self._grid).holder).gameObject):SetActive(false)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._grid).floor = (((self.dormCtrl).comRes).gridFloorPrefab):Instantiate()
    ;
    ((self._grid).floor):SetActive(false)
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._grid).wall = {}
    for i = 1, 4 do
      local go = (((self.dormCtrl).comRes).gridWallPrefab):Instantiate()
      go:SetActive(false)
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._grid).wall)[i] = go
    end
  end
end

DormRoomCtrl.ShowGrid = function(self, fntType, fntParam)
  -- function num : 0_41 , upvalues : _ENV, DormEnum
  if IsNull((self._grid).holder) then
    return 
  end
  self:HideAllGrid()
  self:_ShowGridInternal(fntType, fntParam)
  if fntType == (DormEnum.eDormFntType).Door then
    self:_ShowGridInternal((DormEnum.eDormFntType).Furniture)
  end
end

DormRoomCtrl._ShowGridInternal = function(self, fntType, fntParam)
  -- function num : 0_42 , upvalues : DormEnum
  local gridGo = nil
  if fntType == (DormEnum.eDormFntType).WallDecoration or fntType == (DormEnum.eDormFntType).Door then
    gridGo = ((self._grid).wall)[fntParam]
  else
    gridGo = (self._grid).floor
  end
  gridGo:SetActive(true)
end

DormRoomCtrl.HideAllGrid = function(self)
  -- function num : 0_43 , upvalues : _ENV
  if IsNull((self._grid).holder) then
    return 
  end
  ;
  ((self._grid).floor):SetActive(false)
  for k,go in pairs((self._grid).wall) do
    go:SetActive(false)
  end
end

DormRoomCtrl.RecycleAllGrid = function(self)
  -- function num : 0_44 , upvalues : _ENV
  if IsNull((self._grid).holder) then
    return 
  end
  ;
  (((self._grid).floor).transform):SetParent((self._grid).holder, false)
  for k,go in pairs((self._grid).wall) do
    (go.transform):SetParent((self._grid).holder, false)
  end
end

DormRoomCtrl.GetFntBottomItem = function(self)
  -- function num : 0_45 , upvalues : CS_GameObject, _ENV, DormFntBottomEntity
  if self._fntBottom == nil then
    self._fntBottom = {}
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._fntBottom).pool = {}
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._fntBottom).holder = (CS_GameObject("FntBottom Holder")).transform
    ;
    (((self._fntBottom).holder).gameObject):SetActive(false)
  end
  local item = nil
  if #(self._fntBottom).pool > 0 then
    item = (table.remove)((self._fntBottom).pool, 1)
  else
    item = (DormFntBottomEntity.New)()
    local go = (((self.dormCtrl).comRes).fntBottomPrefab):Instantiate()
    item:InitFntBottomGo(go)
  end
  do
    return item
  end
end

DormRoomCtrl.RecycleFntBottomItem = function(self, item)
  -- function num : 0_46 , upvalues : _ENV
  (table.insert)((self._fntBottom).pool, item)
  ;
  (item.transform):SetParent((self._fntBottom).holder, false)
end

DormRoomCtrl.OnDelete = function(self)
  -- function num : 0_47 , upvalues : _ENV
  UpdateManager:RemoveUpdate(self.__update__handle)
  if self.roomEntity ~= nil then
    self:OnExitDormRoomStart()
  end
end

return DormRoomCtrl

