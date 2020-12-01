-- params : ...
-- function num : 0 , upvalues : _ENV
local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormRoomCtrl = class("DormRoomCtrl", DormCtrlBase)
local DormEditRoomData = require("Game.Dorm.Data.DormEditRoomData")
local eDormState = require("Game.Dorm.Enum.eDormState")
local DormFurnitureData = require("Game.Dorm.Data.DormFurnitureData")
local eDormFntType = require("Game.Dorm.Enum.eDormFntType")
local DormFntBottomEntity = require("Game.Dorm.Entity.DormFntBottomEntity")
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local CS_LeanGesture = ((CS.Lean).Touch).LeanGesture
local CS_Physics = CS.PhysicsUtility
local CS_MessageCommon = CS.MessageCommon
local CS_DormCameraController = CS.DormCameraController
local CS_GameObject = (CS.UnityEngine).GameObject
local CS_RenderManager = CS.RenderManager
DormRoomCtrl.ctor = function(self, dormCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
  self.__onFingerSet = BindCallback(self, self.OnFingerSet)
  self.__onFingerUp = BindCallback(self, self.OnFingerUp)
  self.__onGesture = BindCallback(self, self.OnGesture)
  self.__onFingerTap = BindCallback(self, self.OnFingerTap)
  self.__update__handle = BindCallback(self, self.OnUpdate)
  self.__onItemChangeEvent = BindCallback(self, self.OnItemChange)
  self.__InstallFnt = BindCallback(self, self.InstallFnt)
  self.__onConfirmEditComplete = BindCallback(self, self.ConfirmDormRoomEditComplete)
  self._oldPos = {}
  self._grid = {}
end

DormRoomCtrl.SetRoomEntity = function(self, roomEntity)
  -- function num : 0_1
  self.roomEntity = roomEntity
end

DormRoomCtrl.OnEnterDormRoom = function(self)
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
  self.resloader = ((self.dormCtrl).houseCtrl).resloader
  self.bind = (self.dormCtrl).bind
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemChangeEvent)
  self.editRoomData = (DormEditRoomData.New)()
  ;
  ((self.dormCtrl).dormWindow):RefreshDormHeroList()
  ;
  ((self.dormCtrl).characterCtrl):OnEnterRoomMode()
end

DormRoomCtrl.OnFingerDown = function(self, leanFinger)
  -- function num : 0_3 , upvalues : eDormState, CS_Physics, _ENV
  if (self.dormCtrl).state ~= eDormState.RoomEdit or leanFinger.IsOverGui then
    return 
  end
  local hits = (CS_Physics.Raycast)((self.bind).camera, 1 << LayerMask.Raycast, true)
  for i = 0, hits.Length - 1 do
    local hitCollider = (hits[i]).collider
    if not IsNull(hitCollider) and hitCollider.tag == TagConsts.DormFurniture then
      local fntEntity = (self.roomEntity):GetFntByGo(hitCollider.gameObject)
      self:SelectFntEntity(fntEntity)
      self._fingerId = leanFinger.Index
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self._oldPos).x = (fntEntity.fntData).x
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self._oldPos).y = (fntEntity.fntData).y
      self._drag = true
      return 
    end
  end
end

DormRoomCtrl.OnFingerSet = function(self, leanFinger)
  -- function num : 0_4 , upvalues : CS_Physics, _ENV, eDormFntType
  if not self._drag or self._selectFntEntity == nil or self._fingerId ~= leanFinger.Index or (leanFinger.ScreenDelta).x == 0 and (leanFinger.ScreenDelta).y == 0 then
    return 
  end
  local hits = (CS_Physics.Raycast)((self.bind).camera, 1 << LayerMask.Raycast)
  for i = 0, hits.Length - 1 do
    local hitCollider = (hits[i]).collider
    if not IsNull(hitCollider) then
      local hitPos = nil
      local fntType = (self._selectFntEntity).type
      if fntType == eDormFntType.Wall and hitCollider.tag == TagConsts.DormWall then
        local wallHolder = ((self._selectFntEntity).rootTran).parent
        if (hits[i]).transform == wallHolder.parent then
          do
            hitPos = wallHolder:InverseTransformPoint((hits[i]).point - (self._selectFntEntity):GetFntOffset())
            hitPos.z = 0
            if fntType ~= eDormFntType.Wall and hitCollider.tag == TagConsts.DormFloor then
              hitPos = (((self._selectFntEntity).rootTran).parent):InverseTransformPoint((hits[i]).point - (self._selectFntEntity):GetFntOffset())
              hitPos.y = 0
            end
            local move, oldX, oldY = (self._selectFntEntity):SetFntEntityPosFromUnity(hitPos)
            if move then
              UIManager:HideWindow(UIWindowTypeID.DormOperate)
              local oldAreaList = (self._selectFntEntity):GetFntAreaList(oldX, oldY)
              ;
              (self.roomEntity):UpdateFntMap(self._selectFntEntity, false, oldAreaList)
              ;
              (self.roomEntity):UpdateFntMap(self._selectFntEntity, true)
              self._edited = true
            end
            do
              -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

DormRoomCtrl.OnFingerUp = function(self, leanFinger)
  -- function num : 0_5 , upvalues : _ENV, eDormFntType
  if not self._drag or self._selectFntEntity == nil or self._fingerId ~= leanFinger.Index then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.DormOperate, function(opWindow)
    -- function num : 0_5_0 , upvalues : self, eDormFntType
    local notInWall = ((self._selectFntEntity).fntData):GetFntType() ~= eDormFntType.Wall
    opWindow:ShowFntOperate(true, notInWall)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self._fingerId = nil
  self._drag = false
end

DormRoomCtrl.OnGesture = function(self, fingerList)
  -- function num : 0_6 , upvalues : CS_LeanGesture, CS_RenderManager, CS_DormCameraController
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
  -- function num : 0_7
  if self._selectFntEntity ~= nil and not self._drag and not leanFinger.IsOverGui then
    self:DeselectFntEntity()
  end
end

DormRoomCtrl.OnUpdate = function(self)
  -- function num : 0_8 , upvalues : _ENV, CS_LeanTouch, CS_LeanGesture, CS_DormCameraController
  if not GuideManager.inGuide and not self._drag and not ((self.dormCtrl).characterCtrl):IsDragCharacter() then
    local fingers = (CS_LeanTouch.GetFingers)(true, false)
    local pinch = (CS_LeanGesture.GetPinchScale)(fingers, ((self.dormCtrl).bind).dormRoomWheel) - 1
    ;
    (CS_DormCameraController.Instance):DormRoomViewDistance(pinch)
  end
  do
    if self._selectFntEntity ~= nil then
      local oprationWindow = UIManager:GetWindow(UIWindowTypeID.DormOperate)
      if oprationWindow ~= nil then
        oprationWindow:UpdateFntOpPos(((self._selectFntEntity).transform).position)
      end
    end
  end
end

DormRoomCtrl.SelectFntEntity = function(self, fntEntity)
  -- function num : 0_9 , upvalues : _ENV, eDormFntType
  self._selectFntEntity = fntEntity
  local fntData = fntEntity.fntData
  self:ShowGrid(fntData:GetFntType(), fntData:GetFntParam())
  UIManager:ShowWindowAsync(UIWindowTypeID.DormOperate, function(opWindow)
    -- function num : 0_9_0 , upvalues : self, eDormFntType
    if self._selectFntEntity == nil then
      opWindow:Hide()
      return 
    end
    local notInWall = ((self._selectFntEntity).fntData):GetFntType() ~= eDormFntType.Wall
    opWindow:ShowFntOperate(true, notInWall)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

DormRoomCtrl.DeselectFntEntity = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self._selectFntEntity = nil
  self:HideAllGrid()
  UIManager:HideWindow(UIWindowTypeID.DormOperate)
  if self.editWindow ~= nil then
    (self.editWindow):UpdateUIDormRoomEdit()
  end
end

DormRoomCtrl.OnItemChange = function(self, itemUpdate, resourceData)
  -- function num : 0_11 , upvalues : eDormState
  if resourceData.backpack == nil then
    return 
  end
  if self.editRoomData ~= nil and (self.dormCtrl).state == eDormState.RoomEdit then
    (self.editRoomData):OnItemChange(itemUpdate, resourceData)
  end
end

DormRoomCtrl.EnterDormRoomEdit = function(self, resetData)
  -- function num : 0_12 , upvalues : eDormState, _ENV
  if resetData == nil then
    resetData = true
  end
  if resetData then
    (self.editRoomData):ResetStorateFntData()
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.dormCtrl).state = eDormState.RoomEdit
  self:TryInitGrid()
  ;
  (self.roomEntity):EnterRoomEditMode((self._grid).floor, (self._grid).wall, self)
  UIManager:ShowWindowAsync(UIWindowTypeID.DormRoomEdit, function(window)
    -- function num : 0_12_0 , upvalues : self
    if window == nil then
      return 
    end
    self.editWindow = window
    window:InitDormRoomEdit(self)
  end
)
  ;
  ((self.dormCtrl).characterCtrl):OnEnterRoomEditMode((self.roomEntity).spos)
end

DormRoomCtrl.ConfirmDormRoomEdit = function(self)
  -- function num : 0_13 , upvalues : CS_MessageCommon, _ENV
  if (self.roomEntity):FntMapOverlap() then
    (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Dorm_FntConfirmEdit))
    return 
  end
  local houseId = (((self.dormCtrl).houseCtrl).curHouse).id
  local roomPos = (self.roomEntity).spos
  self._newFntDataList = ((self.roomEntity).roomData):GetFntDatas()
  ;
  ((self.dormCtrl).dormNetwork):CS_DORM_RoomEdit(houseId, roomPos, self._newFntDataList, self.__onConfirmEditComplete)
end

DormRoomCtrl.ConfirmDormRoomEditComplete = function(self, dataList)
  -- function num : 0_14
  local success = dataList[0]
  if success then
    ((self.roomEntity).roomData):UpdateRoomFntData(self._newFntDataList, false)
    self:ExitDormRoomEdit(true)
  end
  self._newFntDataList = nil
end

DormRoomCtrl.ExitDormRoomEdit = function(self, editSuccess)
  -- function num : 0_15 , upvalues : eDormState, _ENV
  if not editSuccess then
    editSuccess = false
  end
  if self._edited and not editSuccess then
    self:RestoreDormRoomEdit()
  end
  self._edited = false
  ;
  ((self.dormCtrl).dormWindow):Show()
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.dormCtrl).state = eDormState.Room
  self._selectFntEntity = nil
  UIManager:HideWindow(UIWindowTypeID.DormOperate)
  UIManager:DeleteWindow(UIWindowTypeID.DormRoomEdit)
  self.editWindow = nil
  self:RecycleAllGrid()
  ;
  (self.roomEntity):ExitRoomEditMode(self)
  ;
  (self.dormCtrl):SetAllBindFntDataDirty()
  if (self.dormCtrl).dormWindow ~= nil then
    ((self.dormCtrl).dormWindow):RefreshDormUIState()
    ;
    ((self.dormCtrl).dormWindow):RefreshDormHeroList()
  end
  ;
  ((self.dormCtrl).characterCtrl):OnExitRoomEditMode(editSuccess, (self.roomEntity).spos)
end

DormRoomCtrl.RestoreDormRoomEdit = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local fntObjDic = (self.roomEntity):GetFntObjDic()
  for go,fntEntity in pairs(fntObjDic) do
    fntEntity:OnDelete()
  end
  local oldData = ((self.roomEntity).roomData).data
  ;
  ((self.roomEntity).roomData):UpdateRoomFntData(oldData, true)
  ;
  (self.roomEntity):InitAllFntEntity()
  ;
  (self.editRoomData):ResetStorateFntData()
end

DormRoomCtrl.ShowFntWarehouse = function(self, resetData)
  -- function num : 0_17 , upvalues : _ENV
  if resetData then
    (self.editRoomData):ResetStorateFntData()
  end
  local fntWarehouseList = (self.editRoomData):GetFntWarehouseList()
  UIManager:ShowWindowAsync(UIWindowTypeID.DormWarehouse, function(window)
    -- function num : 0_17_0 , upvalues : _ENV, fntWarehouseList, self
    if window == nil then
      return 
    end
    window:InitDormWareHouse(eItemType.DormFurniture, fntWarehouseList, nil, nil, nil, self.__InstallFnt)
  end
)
end

DormRoomCtrl.InstallFnt = function(self, fntWarehousedata)
  -- function num : 0_18 , upvalues : _ENV, CS_MessageCommon, eDormState, DormFurnitureData, eDormFntType
  local maxCount = (ConfigData.game_config).DormRoomFntMaxCount
  if maxCount <= (self.roomEntity):GetFntCount() then
    (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Dorm_FntMaxCount))
    return 
  end
  if (self.dormCtrl).state == eDormState.Room then
    self:EnterDormRoomEdit(false)
  else
  end
  if (self.dormCtrl).state == eDormState.RoomEdit then
    do return  end
    local fntData = (DormFurnitureData.New)()
    fntData:InitFntData(fntWarehousedata.id, (self.roomEntity).roomData)
    local sizeX = (ConfigData.game_config).HouseGridCount
    local sizeY = (ConfigData.game_config).HouseHeightCount
    local fntType = fntData:GetFntType()
    if fntType == eDormFntType.Wall then
      fntData:SetFntPos(sizeX // 2, sizeY // 2)
      fntData:CheckOutMap()
      ;
      (CS_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(TipContent.Dorm_SelectWall), ConfigData:GetTipContent(TipContent.Dorm_WallId) .. "2", ConfigData:GetTipContent(TipContent.Dorm_WallId) .. "1", function()
    -- function num : 0_18_0 , upvalues : self, fntData
    self:InstallFntConfirm(fntData, 2)
  end
, function()
    -- function num : 0_18_1 , upvalues : self, fntData
    self:InstallFntConfirm(fntData, 1)
  end
)
    else
      fntData:SetFntPos(sizeX // 2, sizeX // 2)
      fntData:CheckOutMap()
      self:InstallFntConfirm(fntData)
    end
  end
end

DormRoomCtrl.InstallFntConfirm = function(self, fntData, param)
  -- function num : 0_19 , upvalues : _ENV
  fntData:SetFntParam(param)
  ;
  (self.roomEntity):CreateFntEntity(fntData, true, function(fntEntity)
    -- function num : 0_19_0 , upvalues : self
    local bottomItem = self:GetFntBottomItem()
    fntEntity:AddFntBottom(bottomItem)
    self:SelectFntEntity(fntEntity)
  end
)
  ;
  (self.editRoomData):InstallFntData(fntData)
  self._edited = true
  UIManager:DeleteWindow(UIWindowTypeID.DormWarehouse)
  if self.editWindow ~= nil then
    (self.editWindow):UpdateUIDormRoomEdit()
  end
end

DormRoomCtrl.RecycleFntSelect = function(self)
  -- function num : 0_20
  if self._selectFntEntity == nil then
    return 
  end
  self:RecycleFnt(self._selectFntEntity)
  self:DeselectFntEntity()
  self._edited = true
end

DormRoomCtrl.RecycleFnt = function(self, fntEntity)
  -- function num : 0_21
  local fntData = fntEntity.fntData
  ;
  (self.editRoomData):UninstallFntData(fntData)
  ;
  (self.roomEntity):RemoveFntEntity(fntEntity)
  local fntBottomItem = fntEntity:RemoveFntBottom()
  if fntBottomItem ~= nil then
    self:RecycleFntBottomItem(fntBottomItem)
  end
  fntEntity:OnDelete()
end

DormRoomCtrl.ClearAllFnt = function(self)
  -- function num : 0_22 , upvalues : _ENV
  local fntObjDic = (self.roomEntity):GetFntObjDic()
  for go,fntEntity in pairs(fntObjDic) do
    self:RecycleFnt(fntEntity)
  end
  UIManager:HideWindow(UIWindowTypeID.DormOperate)
  if self.editWindow ~= nil then
    (self.editWindow):UpdateUIDormRoomEdit()
  end
  self._selectFntEntity = nil
end

DormRoomCtrl.RotateFnt = function(self)
  -- function num : 0_23 , upvalues : _ENV, eDormFntType
  if self._selectFntEntity ~= nil then
    (self.roomEntity):UpdateFntMap(self._selectFntEntity, false)
    ;
    (self._selectFntEntity):RotateFntEntity()
    ;
    (self.roomEntity):UpdateFntMap(self._selectFntEntity, true)
    UIManager:ShowWindowAsync(UIWindowTypeID.DormOperate, function(opWindow)
    -- function num : 0_23_0 , upvalues : self, eDormFntType
    local notInWall = ((self._selectFntEntity).fntData):GetFntType() ~= eDormFntType.Wall
    opWindow:ShowFntOperate(true, notInWall)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
end

DormRoomCtrl.TryInitGrid = function(self)
  -- function num : 0_24 , upvalues : _ENV, CS_GameObject
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
    for i = 1, 2 do
      local go = (((self.dormCtrl).comRes).gridWallPrefab):Instantiate()
      go:SetActive(false)
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._grid).wall)[i] = go
    end
  end
end

DormRoomCtrl.ShowGrid = function(self, fntType, fntParam)
  -- function num : 0_25 , upvalues : _ENV, eDormFntType
  if IsNull((self._grid).holder) then
    return 
  end
  self:HideAllGrid()
  local gridGo = nil
  if fntType == eDormFntType.Wall then
    gridGo = ((self._grid).wall)[fntParam]
  else
    gridGo = (self._grid).floor
  end
  gridGo:SetActive(true)
end

DormRoomCtrl.HideAllGrid = function(self)
  -- function num : 0_26 , upvalues : _ENV
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
  -- function num : 0_27 , upvalues : _ENV
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
  -- function num : 0_28 , upvalues : CS_GameObject, _ENV, DormFntBottomEntity
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
  -- function num : 0_29 , upvalues : _ENV
  (table.insert)((self._fntBottom).pool, item)
  ;
  (item.transform):SetParent((self._fntBottom).holder, false)
end

DormRoomCtrl.OnExitDormRoom = function(self)
  -- function num : 0_30 , upvalues : CS_LeanTouch, _ENV
  self.roomEntity = nil
  self.editRoomData = nil
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

DormRoomCtrl.OnDelete = function(self)
  -- function num : 0_31
  self:OnExitDormRoom()
end

return DormRoomCtrl

-- params : ...
-- function num : 0 , upvalues : _ENV
local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormRoomCtrl = class("DormRoomCtrl", DormCtrlBase)
local DormEditRoomData = require("Game.Dorm.Data.DormEditRoomData")
local eDormState = require("Game.Dorm.Enum.eDormState")
local DormFurnitureData = require("Game.Dorm.Data.DormFurnitureData")
local eDormFntType = require("Game.Dorm.Enum.eDormFntType")
local DormFntBottomEntity = require("Game.Dorm.Entity.DormFntBottomEntity")
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local CS_LeanGesture = ((CS.Lean).Touch).LeanGesture
local CS_Physics = CS.PhysicsUtility
local CS_MessageCommon = CS.MessageCommon
local CS_DormCameraController = CS.DormCameraController
local CS_GameObject = (CS.UnityEngine).GameObject
local CS_RenderManager = CS.RenderManager
DormRoomCtrl.ctor = function(self, dormCtrl)
    -- function num : 0_0 , upvalues : _ENV
    self.__onFingerDown = BindCallback(self, self.OnFingerDown)
    self.__onFingerSet = BindCallback(self, self.OnFingerSet)
    self.__onFingerUp = BindCallback(self, self.OnFingerUp)
    self.__onGesture = BindCallback(self, self.OnGesture)
    self.__onFingerTap = BindCallback(self, self.OnFingerTap)
    self.__update__handle = BindCallback(self, self.OnUpdate)
    self.__onItemChangeEvent = BindCallback(self, self.OnItemChange)
    self.__InstallFnt = BindCallback(self, self.InstallFnt)
    self.__onConfirmEditComplete = BindCallback(self,
                                                self.ConfirmDormRoomEditComplete)
    self._oldPos = {}
    self._grid = {}
end

DormRoomCtrl.SetRoomEntity = function(self, roomEntity)
    -- function num : 0_1
    self.roomEntity = roomEntity
end

DormRoomCtrl.OnEnterDormRoom = function(self)
    -- function num : 0_2 , upvalues : CS_LeanTouch, _ENV, DormEditRoomData
    (CS_LeanTouch.OnFingerDown)("+", self.__onFingerDown);
    (CS_LeanTouch.OnFingerSet)("+", self.__onFingerSet);
    (CS_LeanTouch.OnFingerUp)("+", self.__onFingerUp);
    (CS_LeanTouch.OnGesture)("+", self.__onGesture);
    (CS_LeanTouch.OnFingerTap)("+", self.__onFingerTap)
    UpdateManager:AddUpdate(self.__update__handle)
    self.resloader = ((self.dormCtrl).houseCtrl).resloader
    self.bind = (self.dormCtrl).bind
    MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemChangeEvent)
    self.editRoomData = (DormEditRoomData.New)();
    ((self.dormCtrl).dormWindow):RefreshDormHeroList();
    ((self.dormCtrl).characterCtrl):OnEnterRoomMode()
end

DormRoomCtrl.OnFingerDown = function(self, leanFinger)
    -- function num : 0_3 , upvalues : eDormState, CS_Physics, _ENV
    if (self.dormCtrl).state ~= eDormState.RoomEdit or leanFinger.IsOverGui then
        return
    end
    local hits = (CS_Physics.Raycast)((self.bind).camera,
                                      1 << LayerMask.Raycast, true)
    for i = 0, hits.Length - 1 do
        local hitCollider = (hits[i]).collider
        if not IsNull(hitCollider) and hitCollider.tag ==
            TagConsts.DormFurniture then
            local fntEntity = (self.roomEntity):GetFntByGo(
                                  hitCollider.gameObject)
            self:SelectFntEntity(fntEntity)
            self._fingerId = leanFinger.Index -- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'
            ;
            (self._oldPos).x = (fntEntity.fntData).x -- DECOMPILER ERROR at PC50: Confused about usage of register: R9 in 'UnsetPending'
            ;
            (self._oldPos).y = (fntEntity.fntData).y
            self._drag = true
            return
        end
    end
end

DormRoomCtrl.OnFingerSet = function(self, leanFinger)
    -- function num : 0_4 , upvalues : CS_Physics, _ENV, eDormFntType
    if not self._drag or self._selectFntEntity == nil or self._fingerId ~=
        leanFinger.Index or (leanFinger.ScreenDelta).x == 0 and
        (leanFinger.ScreenDelta).y == 0 then return end
    local hits =
        (CS_Physics.Raycast)((self.bind).camera, 1 << LayerMask.Raycast)
    for i = 0, hits.Length - 1 do
        local hitCollider = (hits[i]).collider
        if not IsNull(hitCollider) then
            local hitPos = nil
            local fntType = (self._selectFntEntity).type
            if fntType == eDormFntType.Wall and hitCollider.tag ==
                TagConsts.DormWall then
                local wallHolder = ((self._selectFntEntity).rootTran).parent
                if (hits[i]).transform == wallHolder.parent then
                    do
                        hitPos = wallHolder:InverseTransformPoint(
                                     (hits[i]).point -
                                         (self._selectFntEntity):GetFntOffset())
                        hitPos.z = 0
                        if fntType ~= eDormFntType.Wall and hitCollider.tag ==
                            TagConsts.DormFloor then
                            hitPos =
                                (((self._selectFntEntity).rootTran).parent):InverseTransformPoint(
                                    (hits[i]).point -
                                        (self._selectFntEntity):GetFntOffset())
                            hitPos.y = 0
                        end
                        local move, oldX, oldY =
                            (self._selectFntEntity):SetFntEntityPosFromUnity(
                                hitPos)
                        if move then
                            UIManager:HideWindow(UIWindowTypeID.DormOperate)
                            local oldAreaList =
                                (self._selectFntEntity):GetFntAreaList(oldX,
                                                                       oldY);
                            (self.roomEntity):UpdateFntMap(
                                self._selectFntEntity, false, oldAreaList);
                            (self.roomEntity):UpdateFntMap(
                                self._selectFntEntity, true)
                            self._edited = true
                        end
                        do
                            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_STMT

                        end
                    end
                end
            end
        end
    end
end

DormRoomCtrl.OnFingerUp = function(self, leanFinger)
    -- function num : 0_5 , upvalues : _ENV, eDormFntType
    if not self._drag or self._selectFntEntity == nil or self._fingerId ~=
        leanFinger.Index then return end
    UIManager:ShowWindowAsync(UIWindowTypeID.DormOperate, function(opWindow)
        -- function num : 0_5_0 , upvalues : self, eDormFntType
        local notInWall = ((self._selectFntEntity).fntData):GetFntType() ~=
                              eDormFntType.Wall
        opWindow:ShowFntOperate(true, notInWall)
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
    self._fingerId = nil
    self._drag = false
end

DormRoomCtrl.OnGesture = function(self, fingerList)
    -- function num : 0_6 , upvalues : CS_LeanGesture, CS_RenderManager, CS_DormCameraController
    if self._drag or fingerList.Count == 0 or (fingerList[0]).StartedOverGui then
        return
    end
    if ((self.dormCtrl).characterCtrl):IsDragCharacter() then return end
    local delta = (CS_LeanGesture.GetScreenDelta)(fingerList) *
                      (CS_RenderManager.Instance).ScreenScaleRatio;
    (CS_DormCameraController.Instance):DormRoomViewRotate(delta)
end

DormRoomCtrl.OnFingerTap = function(self, leanFinger)
    -- function num : 0_7
    if self._selectFntEntity ~= nil and not self._drag and
        not leanFinger.IsOverGui then self:DeselectFntEntity() end
end

DormRoomCtrl.OnUpdate = function(self)
    -- function num : 0_8 , upvalues : _ENV, CS_LeanTouch, CS_LeanGesture, CS_DormCameraController
    if not GuideManager.inGuide and not self._drag and
        not ((self.dormCtrl).characterCtrl):IsDragCharacter() then
        local fingers = (CS_LeanTouch.GetFingers)(true, false)
        local pinch = (CS_LeanGesture.GetPinchScale)(fingers,
                                                     ((self.dormCtrl).bind).dormRoomWheel) -
                          1;
        (CS_DormCameraController.Instance):DormRoomViewDistance(pinch)
    end
    do
        if self._selectFntEntity ~= nil then
            local oprationWindow = UIManager:GetWindow(
                                       UIWindowTypeID.DormOperate)
            if oprationWindow ~= nil then
                oprationWindow:UpdateFntOpPos(
                    ((self._selectFntEntity).transform).position)
            end
        end
    end
end

DormRoomCtrl.SelectFntEntity = function(self, fntEntity)
    -- function num : 0_9 , upvalues : _ENV, eDormFntType
    self._selectFntEntity = fntEntity
    local fntData = fntEntity.fntData
    self:ShowGrid(fntData:GetFntType(), fntData:GetFntParam())
    UIManager:ShowWindowAsync(UIWindowTypeID.DormOperate, function(opWindow)
        -- function num : 0_9_0 , upvalues : self, eDormFntType
        if self._selectFntEntity == nil then
            opWindow:Hide()
            return
        end
        local notInWall = ((self._selectFntEntity).fntData):GetFntType() ~=
                              eDormFntType.Wall
        opWindow:ShowFntOperate(true, notInWall)
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
end

DormRoomCtrl.DeselectFntEntity = function(self)
    -- function num : 0_10 , upvalues : _ENV
    self._selectFntEntity = nil
    self:HideAllGrid()
    UIManager:HideWindow(UIWindowTypeID.DormOperate)
    if self.editWindow ~= nil then (self.editWindow):UpdateUIDormRoomEdit() end
end

DormRoomCtrl.OnItemChange = function(self, itemUpdate, resourceData)
    -- function num : 0_11 , upvalues : eDormState
    if resourceData.backpack == nil then return end
    if self.editRoomData ~= nil and (self.dormCtrl).state == eDormState.RoomEdit then
        (self.editRoomData):OnItemChange(itemUpdate, resourceData)
    end
end

DormRoomCtrl.EnterDormRoomEdit = function(self, resetData)
    -- function num : 0_12 , upvalues : eDormState, _ENV
    if resetData == nil then resetData = true end
    if resetData then (self.editRoomData):ResetStorateFntData() end -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'
    
    (self.dormCtrl).state = eDormState.RoomEdit
    self:TryInitGrid();
    (self.roomEntity):EnterRoomEditMode((self._grid).floor, (self._grid).wall,
                                        self)
    UIManager:ShowWindowAsync(UIWindowTypeID.DormRoomEdit, function(window)
        -- function num : 0_12_0 , upvalues : self
        if window == nil then return end
        self.editWindow = window
        window:InitDormRoomEdit(self)
    end);
    ((self.dormCtrl).characterCtrl):OnEnterRoomEditMode((self.roomEntity).spos)
end

DormRoomCtrl.ConfirmDormRoomEdit = function(self)
    -- function num : 0_13 , upvalues : CS_MessageCommon, _ENV
    if (self.roomEntity):FntMapOverlap() then
        (CS_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Dorm_FntConfirmEdit))
        return
    end
    local houseId = (((self.dormCtrl).houseCtrl).curHouse).id
    local roomPos = (self.roomEntity).spos
    self._newFntDataList = ((self.roomEntity).roomData):GetFntDatas();
    ((self.dormCtrl).dormNetwork):CS_DORM_RoomEdit(houseId, roomPos,
                                                   self._newFntDataList,
                                                   self.__onConfirmEditComplete)
end

DormRoomCtrl.ConfirmDormRoomEditComplete =
    function(self, dataList)
        -- function num : 0_14
        local success = dataList[0]
        if success then
            ((self.roomEntity).roomData):UpdateRoomFntData(self._newFntDataList,
                                                           false)
            self:ExitDormRoomEdit(true)
        end
        self._newFntDataList = nil
    end

DormRoomCtrl.ExitDormRoomEdit = function(self, editSuccess)
    -- function num : 0_15 , upvalues : eDormState, _ENV
    if not editSuccess then editSuccess = false end
    if self._edited and not editSuccess then self:RestoreDormRoomEdit() end
    self._edited = false;
    ((self.dormCtrl).dormWindow):Show() -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (self.dormCtrl).state = eDormState.Room
    self._selectFntEntity = nil
    UIManager:HideWindow(UIWindowTypeID.DormOperate)
    UIManager:DeleteWindow(UIWindowTypeID.DormRoomEdit)
    self.editWindow = nil
    self:RecycleAllGrid();
    (self.roomEntity):ExitRoomEditMode(self);
    (self.dormCtrl):SetAllBindFntDataDirty()
    if (self.dormCtrl).dormWindow ~= nil then
        ((self.dormCtrl).dormWindow):RefreshDormUIState();
        ((self.dormCtrl).dormWindow):RefreshDormHeroList()
    end
    ((self.dormCtrl).characterCtrl):OnExitRoomEditMode(editSuccess,
                                                       (self.roomEntity).spos)
end

DormRoomCtrl.RestoreDormRoomEdit = function(self)
    -- function num : 0_16 , upvalues : _ENV
    local fntObjDic = (self.roomEntity):GetFntObjDic()
    for go, fntEntity in pairs(fntObjDic) do fntEntity:OnDelete() end
    local oldData = ((self.roomEntity).roomData).data;
    ((self.roomEntity).roomData):UpdateRoomFntData(oldData, true);
    (self.roomEntity):InitAllFntEntity();
    (self.editRoomData):ResetStorateFntData()
end

DormRoomCtrl.ShowFntWarehouse = function(self, resetData)
    -- function num : 0_17 , upvalues : _ENV
    if resetData then (self.editRoomData):ResetStorateFntData() end
    local fntWarehouseList = (self.editRoomData):GetFntWarehouseList()
    UIManager:ShowWindowAsync(UIWindowTypeID.DormWarehouse, function(window)
        -- function num : 0_17_0 , upvalues : _ENV, fntWarehouseList, self
        if window == nil then return end
        window:InitDormWareHouse(eItemType.DormFurniture, fntWarehouseList, nil,
                                 nil, nil, self.__InstallFnt)
    end)
end

DormRoomCtrl.InstallFnt = function(self, fntWarehousedata)
    -- function num : 0_18 , upvalues : _ENV, CS_MessageCommon, eDormState, DormFurnitureData, eDormFntType
    local maxCount = (ConfigData.game_config).DormRoomFntMaxCount
    if maxCount <= (self.roomEntity):GetFntCount() then
        (CS_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Dorm_FntMaxCount))
        return
    end
    if (self.dormCtrl).state == eDormState.Room then
        self:EnterDormRoomEdit(false)
    else
    end
    if (self.dormCtrl).state == eDormState.RoomEdit then
        do return end
        local fntData = (DormFurnitureData.New)()
        fntData:InitFntData(fntWarehousedata.id, (self.roomEntity).roomData)
        local sizeX = (ConfigData.game_config).HouseGridCount
        local sizeY = (ConfigData.game_config).HouseHeightCount
        local fntType = fntData:GetFntType()
        if fntType == eDormFntType.Wall then
            fntData:SetFntPos(sizeX // 2, sizeY // 2)
            fntData:CheckOutMap();
            (CS_MessageCommon.ShowMessageBox)(
                ConfigData:GetTipContent(TipContent.Dorm_SelectWall),
                ConfigData:GetTipContent(TipContent.Dorm_WallId) .. "2",
                ConfigData:GetTipContent(TipContent.Dorm_WallId) .. "1",
                function()
                    -- function num : 0_18_0 , upvalues : self, fntData
                    self:InstallFntConfirm(fntData, 2)
                end, function()
                    -- function num : 0_18_1 , upvalues : self, fntData
                    self:InstallFntConfirm(fntData, 1)
                end)
        else
            fntData:SetFntPos(sizeX // 2, sizeX // 2)
            fntData:CheckOutMap()
            self:InstallFntConfirm(fntData)
        end
    end
end

DormRoomCtrl.InstallFntConfirm = function(self, fntData, param)
    -- function num : 0_19 , upvalues : _ENV
    fntData:SetFntParam(param);
    (self.roomEntity):CreateFntEntity(fntData, true, function(fntEntity)
        -- function num : 0_19_0 , upvalues : self
        local bottomItem = self:GetFntBottomItem()
        fntEntity:AddFntBottom(bottomItem)
        self:SelectFntEntity(fntEntity)
    end);
    (self.editRoomData):InstallFntData(fntData)
    self._edited = true
    UIManager:DeleteWindow(UIWindowTypeID.DormWarehouse)
    if self.editWindow ~= nil then (self.editWindow):UpdateUIDormRoomEdit() end
end

DormRoomCtrl.RecycleFntSelect = function(self)
    -- function num : 0_20
    if self._selectFntEntity == nil then return end
    self:RecycleFnt(self._selectFntEntity)
    self:DeselectFntEntity()
    self._edited = true
end

DormRoomCtrl.RecycleFnt = function(self, fntEntity)
    -- function num : 0_21
    local fntData = fntEntity.fntData;
    (self.editRoomData):UninstallFntData(fntData);
    (self.roomEntity):RemoveFntEntity(fntEntity)
    local fntBottomItem = fntEntity:RemoveFntBottom()
    if fntBottomItem ~= nil then self:RecycleFntBottomItem(fntBottomItem) end
    fntEntity:OnDelete()
end

DormRoomCtrl.ClearAllFnt = function(self)
    -- function num : 0_22 , upvalues : _ENV
    local fntObjDic = (self.roomEntity):GetFntObjDic()
    for go, fntEntity in pairs(fntObjDic) do self:RecycleFnt(fntEntity) end
    UIManager:HideWindow(UIWindowTypeID.DormOperate)
    if self.editWindow ~= nil then (self.editWindow):UpdateUIDormRoomEdit() end
    self._selectFntEntity = nil
end

DormRoomCtrl.RotateFnt = function(self)
    -- function num : 0_23 , upvalues : _ENV, eDormFntType
    if self._selectFntEntity ~= nil then
        (self.roomEntity):UpdateFntMap(self._selectFntEntity, false);
        (self._selectFntEntity):RotateFntEntity();
        (self.roomEntity):UpdateFntMap(self._selectFntEntity, true)
        UIManager:ShowWindowAsync(UIWindowTypeID.DormOperate, function(opWindow)
            -- function num : 0_23_0 , upvalues : self, eDormFntType
            local notInWall = ((self._selectFntEntity).fntData):GetFntType() ~=
                                  eDormFntType.Wall
            opWindow:ShowFntOperate(true, notInWall)
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end)
    end
end

DormRoomCtrl.TryInitGrid = function(self)
    -- function num : 0_24 , upvalues : _ENV, CS_GameObject
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    if IsNull((self._grid).holder) then
        (self._grid).holder = (CS_GameObject("GridHolder")).transform;
        (((self._grid).holder).gameObject):SetActive(false) -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'
        ;
        (self._grid).floor =
            (((self.dormCtrl).comRes).gridFloorPrefab):Instantiate();
        ((self._grid).floor):SetActive(false) -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'
        ;
        (self._grid).wall = {}
        for i = 1, 2 do
            local go = (((self.dormCtrl).comRes).gridWallPrefab):Instantiate()
            go:SetActive(false) -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'
            ;
            ((self._grid).wall)[i] = go
        end
    end
end

DormRoomCtrl.ShowGrid = function(self, fntType, fntParam)
    -- function num : 0_25 , upvalues : _ENV, eDormFntType
    if IsNull((self._grid).holder) then return end
    self:HideAllGrid()
    local gridGo = nil
    if fntType == eDormFntType.Wall then
        gridGo = ((self._grid).wall)[fntParam]
    else
        gridGo = (self._grid).floor
    end
    gridGo:SetActive(true)
end

DormRoomCtrl.HideAllGrid = function(self)
    -- function num : 0_26 , upvalues : _ENV
    if IsNull((self._grid).holder) then return end
    ((self._grid).floor):SetActive(false)
    for k, go in pairs((self._grid).wall) do go:SetActive(false) end
end

DormRoomCtrl.RecycleAllGrid = function(self)
    -- function num : 0_27 , upvalues : _ENV
    if IsNull((self._grid).holder) then return end
    (((self._grid).floor).transform):SetParent((self._grid).holder, false)
    for k, go in pairs((self._grid).wall) do
        (go.transform):SetParent((self._grid).holder, false)
    end
end

DormRoomCtrl.GetFntBottomItem = function(self)
    -- function num : 0_28 , upvalues : CS_GameObject, _ENV, DormFntBottomEntity
    if self._fntBottom == nil then
        self._fntBottom = {} -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'
        ;
        (self._fntBottom).pool = {} -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'
        ;
        (self._fntBottom).holder = (CS_GameObject("FntBottom Holder")).transform;
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
    do return item end
end

DormRoomCtrl.RecycleFntBottomItem = function(self, item)
    -- function num : 0_29 , upvalues : _ENV
    (table.insert)((self._fntBottom).pool, item);
    (item.transform):SetParent((self._fntBottom).holder, false)
end

DormRoomCtrl.OnExitDormRoom = function(self)
    -- function num : 0_30 , upvalues : CS_LeanTouch, _ENV
    self.roomEntity = nil
    self.editRoomData = nil;
    (CS_LeanTouch.OnFingerDown)("-", self.__onFingerDown);
    (CS_LeanTouch.OnFingerSet)("-", self.__onFingerSet);
    (CS_LeanTouch.OnFingerUp)("-", self.__onFingerUp);
    (CS_LeanTouch.OnGesture)("-", self.__onGesture);
    (CS_LeanTouch.OnFingerTap)("-", self.__onFingerTap)
    UpdateManager:RemoveUpdate(self.__update__handle)
    MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemChangeEvent)
end

DormRoomCtrl.OnDelete = function(self)
    -- function num : 0_31
    self:OnExitDormRoom()
end

return DormRoomCtrl

