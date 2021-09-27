local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormHouseCtrl = class("DormHouseCtrl", DormCtrlBase)
local DormRoomEntity = require("Game.Dorm.Entity.DormRoomEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local DormRoomData = require("Game.Dorm.Data.DormRoomData")
local DormEditHouseData = require("Game.Dorm.Data.DormEditHouseData")
local DormRoomMoveEffect = require("Game.Dorm.Effect.DormRoomMoveEffect")
local CS_DormCameraCtrl = CS.DormCameraController
local cs_MessageCommon = CS.MessageCommon
DormHouseCtrl.ctor = function(self, dormCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.__onHouseClicked = BindCallback(self, self.OnHouseClicked)
  self.__onD2HTimelineComplete = BindCallback(self, self.OnD2HTimelineComplete)
  self.__onH2DTimelineComplete = BindCallback(self, self.OnH2DTimelineComplete)
  self.__onSelectRoomDragStart = BindCallback(self, self.__SelectRoomDragStart)
  self.__onSelectRoomDragEnd = BindCallback(self, self.__SelectRoomDragEnd)
  self.__onSelectRoomDraging = BindCallback(self, self.__SelectRoomDraging)
end

DormHouseCtrl.OnEnterDormScene = function(self)
  -- function num : 0_1 , upvalues : _ENV, DormRoomMoveEffect
  self.__effectHolder = (((CS.UnityEngine).GameObject)("DormEffectHolder")).transform
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.__effectHolder).position = Vector3.zero
  local prefab = ((self.dormCtrl).comRes).selectRoomEffectPrefab
  if not IsNull(prefab) then
    self.selectRoomEffect = prefab:Instantiate(self.__effectHolder)
    ;
    (self.selectRoomEffect):SetActive(false)
  end
  prefab = ((self.dormCtrl).comRes).moveRoomGoEffectPrefab
  do
    if not IsNull(prefab) then
      local go = prefab:Instantiate(self.__effectHolder)
      go:SetActive(false)
      self.moveRoomGoEffect = (DormRoomMoveEffect.New)(go)
    end
    local inAlive = 2
    prefab = ((self.dormCtrl).comRes).moveRoomInEffectPrefab
    self.moveRoomInEffects = {}
    if not IsNull(prefab) then
      for i = 1, inAlive do
        local go = prefab:Instantiate(self.__effectHolder)
        go:SetActive(false)
        local moveRoomInEffect = (DormRoomMoveEffect.New)(go, true)
        ;
        (table.insert)(self.moveRoomInEffects, moveRoomInEffect)
      end
    end
  end
end

DormHouseCtrl.EnterDormHouse = function(self, id)
  -- function num : 0_2 , upvalues : _ENV, CS_DormCameraCtrl
  local curHouse = (((self.dormCtrl).allDormData).houseDic)[id]
  if curHouse == nil or self.curHouse == curHouse then
    return 
  end
  self.curHouse = curHouse
  self.bind = (self.dormCtrl).bind
  ;
  ((self.dormCtrl).dormWindow):InitDormMainUI()
  self._waitShowRoomStateUITimer = TimerManager:StartTimer(1, function()
    -- function num : 0_2_0 , upvalues : self
    self._waitShowRoomStateUITimer = nil
    ;
    ((self.dormCtrl).dormWindow):RefreshDormStateNode()
  end
, nil, true)
  if self.curHouse == nil then
    warn("no one dorm have!!!")
    return 
  end
  if not IsNull(self.dormHolder) then
    DestroyUnityObject((self.dormHolder).gameObject)
  end
  self.dormHolder = (((CS.UnityEngine).GameObject)("DormHolder")).transform
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.dormHolder).position = Vector3.zero
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
  end
  self.resloader = ((CS.ResLoader).Create)()
  local houseType = (self.curHouse):GetRoomHexRange()
  if houseType <= 0 then
    (CS_DormCameraCtrl.Instance):SetDormVirtualCameraTarget((self.bind).dormOneTarget, (self.bind).dormOneTarget)
  else
    ;
    (CS_DormCameraCtrl.Instance):SetDormVirtualCameraTarget((self.bind).dormTarget, (self.bind).dormTarget)
  end
  self:__InitHouseEntity(houseType)
  self:__GetUnlockRoomData()
  ;
  (self.dormCtrl):EmitEnterDormHouse()
  ;
  ((self.dormCtrl).dormWindow):RefreshDormHeroList()
end

DormHouseCtrl.__InitHouseEntity = function(self, houseType)
  -- function num : 0_3 , upvalues : CS_DormCameraCtrl, _ENV, DormUtil
  self.roomEnityDic = {}
  ;
  (CS_DormCameraCtrl.Instance):ClearDormTargetGroup()
  local n = houseType
  for dx = -n, n do
    for dy = (math.max)(-n, -dx - n), (math.min)(n, -dx + n) do
      local dz = -dx - dy
      local spos = (DormUtil.XYToRoomCoord)(dx, dy)
      local roomData = ((self.curHouse).roomDic)[spos]
      self:AddNewRoom(dx, dy, spos, roomData)
    end
  end
end

DormHouseCtrl.GetCurHouseId = function(self)
  -- function num : 0_4
  return (self.curHouse).id
end

DormHouseCtrl.AddNewRoom = function(self, x, y, spos, roomData)
  -- function num : 0_5 , upvalues : DormRoomEntity, CS_DormCameraCtrl
  local roomEntity = (DormRoomEntity.New)()
  roomEntity:InitHouseData(x, y, spos, roomData)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.roomEnityDic)[spos] = roomEntity
  roomEntity:LoadRoomEntity(self.dormHolder, (self.dormCtrl).comRes, self.__onHouseClicked)
  ;
  (CS_DormCameraCtrl.Instance):AddDormTargetGroup(roomEntity.transform)
end

DormHouseCtrl._SetRoomCamRotaton2DoorWall = function(self, roomEntity)
  -- function num : 0_6 , upvalues : CS_DormCameraCtrl
  local wallId = roomEntity:GetDmRoomDoorWallId()
  ;
  (CS_DormCameraCtrl.Instance):SetDmRoomViewRotateHorizontal((wallId - 1) * 90)
end

DormHouseCtrl.OnHouseClicked = function(self, roomEntity, auto2Edit)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon, DormEnum, CS_DormCameraCtrl
  do
    if roomEntity:IsEmptyRoom() then
      local data = self:TryGetRoomLockData(roomEntity.spos)
      if not (string.IsNullOrEmpty)(data.lockStr) then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(data.lockStr)
      end
      return 
    end
    if roomEntity == nil or roomEntity:IsAnyDmFntEntityInLoading() then
      return 
    end
    local state = (self.dormCtrl):GetDormState()
    if state == (DormEnum.eDormState).House then
      if auto2Edit then
        ((self.dormCtrl).roomCtrl):SetAutoEnterRoomEdit()
        UIManager:ShowWindowAsync(UIWindowTypeID.DormRoom, function(window)
    -- function num : 0_7_0
    if window ~= nil then
      window:Hide()
    end
  end
)
      end
      local continueWindow = UIManager:ShowWindow(UIWindowTypeID.ClickContinue)
      continueWindow:InitContinue(nil, nil, nil, nil, false)
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (((self.dormCtrl).bind).roomTarget).position = (roomEntity.transform).position + ((self.dormCtrl).bind).roomTarPosOffset
      ;
      (CS_DormCameraCtrl.Instance):ResetDormRoomView()
      AudioManager:PlayAudioById(1131)
      UIManager:ShowWindowAsync(UIWindowTypeID.SceneChangesMask, function(win)
    -- function num : 0_7_1 , upvalues : CS_DormCameraCtrl, self, roomEntity, _ENV
    if win == nil then
      return 
    end
    win:InitSceneChangesMask(function()
      -- function num : 0_7_1_0 , upvalues : CS_DormCameraCtrl, self, roomEntity, _ENV
      (CS_DormCameraCtrl.Instance):EnableDmCamBrainBlend(false)
      ;
      ((((self.dormCtrl).bind).va_Dorm).gameObject):SetActive(false)
      ;
      ((((self.dormCtrl).bind).va_Room).gameObject):SetActive(true)
      ;
      (((self.dormCtrl).bind).va_Room):MoveToTopOfPrioritySubqueue()
      ;
      ((self.dormCtrl).dormWindow):ShowDmStateNode(false)
      ;
      (self.dormCtrl):EmitEnterDormRoomStart(roomEntity)
      if self.__onD2HTimelineComplete ~= nil then
        (self.__onD2HTimelineComplete)()
      end
      TimerManager:AddLateCommand(function()
        -- function num : 0_7_1_0_0 , upvalues : CS_DormCameraCtrl
        (CS_DormCameraCtrl.Instance):EnableDmCamBrainBlend(true)
      end
)
    end
, function()
      -- function num : 0_7_1_1 , upvalues : self
      ((self.dormCtrl).roomCtrl):ShowDormRoomUI()
    end
)
  end
)
    else
      do
        if state == (DormEnum.eDormState).HouseEdit then
          self.curEditSelectRoom = roomEntity
          -- DECOMPILER ERROR at PC88: Confused about usage of register: R4 in 'UnsetPending'

          if self.selectRoomEffect ~= nil then
            ((self.selectRoomEffect).transform).position = (roomEntity.transform).position
            ;
            (self.selectRoomEffect):SetActive(true)
          end
          local editNode = ((self.dormCtrl).dormWindow):GetDormEditUI()
          editNode:SelectEditRoom(roomEntity)
          editNode:BindRoomMoveAction(self.__onSelectRoomDragStart, self.__onSelectRoomDraging, self.__onSelectRoomDragEnd)
        end
      end
    end
  end
end

DormHouseCtrl.OnEnterDormHouseEditMode = function(self)
  -- function num : 0_8
  self:__SetRoomEditColliderEnable(true)
end

DormHouseCtrl.OnExitDormHouseEditMode = function(self, success)
  -- function num : 0_9
  self:__SetRoomEditColliderEnable(false)
  self:CancelSelectRoom()
end

DormHouseCtrl.OnEnterDormRoomStart = function(self, roomEntity)
  -- function num : 0_10 , upvalues : _ENV
  for _,re in pairs(self.roomEnityDic) do
    if re ~= roomEntity then
      re:StartHideRoom()
    end
  end
end

DormHouseCtrl.OnExitDormRoomStart = function(self, roomEntity)
  -- function num : 0_11 , upvalues : _ENV
  for _,re in pairs(self.roomEnityDic) do
    if re ~= roomEntity then
      re:StartShowRoom()
    end
  end
end

DormHouseCtrl.CancelSelectRoom = function(self)
  -- function num : 0_12
  if self.selectRoomEffect ~= nil then
    (self.selectRoomEffect):SetActive(false)
  end
  self.curEditSelectRoom = nil
end

DormHouseCtrl.__SetRoomEditColliderEnable = function(self, enable)
  -- function num : 0_13 , upvalues : _ENV
  for k,roomEntity in pairs(self.roomEnityDic) do
    roomEntity:SetEditColliderEnable(enable)
  end
end

DormHouseCtrl.__ClearRoomMoveEffects = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (self.moveRoomGoEffect):ClearMoveEffect()
  for _,roomEffect in pairs(self.moveRoomInEffects) do
    roomEffect:ClearMoveEffect()
  end
end

DormHouseCtrl.__SelectRoomDragStart = function(self)
  -- function num : 0_15
  if self.curEditSelectRoom == nil then
    return 
  end
  self.__destChangeRoom = self.curEditSelectRoom
  self:__ClearRoomMoveEffects()
  ;
  ((self.moveRoomGoEffect).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.moveRoomGoEffect).transform).position = ((self.curEditSelectRoom).transform).position
  ;
  (self.moveRoomGoEffect):StartPlayShow()
end

DormHouseCtrl.__SelectRoomDraging = function(self, obj)
  -- function num : 0_16 , upvalues : _ENV
  if IsNull(obj) then
    self.__destChangeRoom = nil
    ;
    ((self.moveRoomInEffects)[1]):StartHideShow()
    return 
  end
  local curRoomEntiy = nil
  for k,roomEntity in pairs(self.roomEnityDic) do
    if roomEntity.gameObject == obj then
      curRoomEntiy = roomEntity
    end
  end
  if self.__destChangeRoom == curRoomEntiy then
    return 
  end
  self.__destChangeRoom = curRoomEntiy
  ;
  ((self.moveRoomInEffects)[1]):StartHideShow()
  if curRoomEntiy == nil or curRoomEntiy == self.curEditSelectRoom then
    return 
  end
  local moveRoomEffect = (table.remove)(self.moveRoomInEffects)
  ;
  (moveRoomEffect.gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (moveRoomEffect.transform).position = ((self.__destChangeRoom).transform).position
  moveRoomEffect:StartPlayShow()
  ;
  (table.insert)(self.moveRoomInEffects, 1, moveRoomEffect)
end

DormHouseCtrl.__SelectRoomDragEnd = function(self, obj)
  -- function num : 0_17 , upvalues : _ENV
  (self.moveRoomGoEffect):StartHideShow()
  ;
  ((self.moveRoomInEffects)[1]):StartHideShow()
  self.__destChangeRoom = nil
  if IsNull(obj) then
    (((self.dormCtrl).dormWindow):GetDormEditUI()):ResetMoveRoomUI()
    return 
  end
  for k,roomEntity in pairs(self.roomEnityDic) do
    -- DECOMPILER ERROR at PC37: Unhandled construct in 'MakeBoolean' P1

    if not roomEntity:IsEmptyRoom() and roomEntity.gameObject == obj and roomEntity ~= self.curEditSelectRoom then
      do
        self:RequestRoomExChange(self.curEditSelectRoom, roomEntity)
        do return  end
        -- DECOMPILER ERROR at PC39: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC39: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  ;
  (((self.dormCtrl).dormWindow):GetDormEditUI()):ResetMoveRoomUI()
end

DormHouseCtrl.RequestRoomExChange = function(self, originRoom, targetRoom)
  -- function num : 0_18
  (((self.dormCtrl).dormWindow):GetDormEditUI()):UnSelectEditRoom(false)
  self:CancelSelectRoom()
  local pos1, pos2 = originRoom.spos, targetRoom.spos
  originRoom:ChangeDormRoomPos(pos2)
  targetRoom:ChangeDormRoomPos(pos1)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.roomEnityDic)[pos2] = originRoom
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.roomEnityDic)[pos1] = targetRoom
  ;
  (self.curHouse):SwapHousePos(pos1, pos2)
  ;
  ((self.dormCtrl).dormNetwork):CS_DORM_RoomExchangePos(self:GetCurHouseId(), pos1, pos2)
end

DormHouseCtrl.RequestCurRoomRename = function(self, completeAction)
  -- function num : 0_19 , upvalues : _ENV
  if self.curEditSelectRoom == nil then
    warn("cur edti room is null to rename")
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRename, function(renameWindow)
    -- function num : 0_19_0 , upvalues : self, _ENV, completeAction
    if renameWindow == nil or self.curEditSelectRoom == nil then
      return 
    end
    renameWindow:InitCommonRename(function(name)
      -- function num : 0_19_0_0 , upvalues : self, _ENV, completeAction
      ((self.dormCtrl).dormNetwork):CS_DORM_RenameRoom(self:GetCurHouseId(), (self.curEditSelectRoom).spos, name, function()
        -- function num : 0_19_0_0_0 , upvalues : self, name, _ENV, completeAction
        if self.curEditSelectRoom ~= nil then
          ((self.curEditSelectRoom).roomData):SetRoomName(name)
        end
        UIManager:DeleteWindow(UIWindowTypeID.CommonRename)
        if completeAction ~= nil then
          completeAction()
        end
      end
)
    end
)
  end
)
end

DormHouseCtrl.ConfirmHouseEdit = function(self)
  -- function num : 0_20
  ((self.dormCtrl).dormNetwork):CS_DORM_HouseEdit(self.editHouseData)
end

DormHouseCtrl.RecvHouseEdit = function(self, success, prefabUpdate)
  -- function num : 0_21
  if success then
    (self.editHouseData):ApplyModifyHouseData(prefabUpdate, (self.dormCtrl).allDormData, self.roomEnityDic)
    ;
    (self.dormCtrl):SetAllBindFntDataDirty()
    ;
    ((self.dormCtrl).dormWindow):RefreshDormHeroList()
    self:ExitDormEditMode(true)
  else
    self:CancelHouseEdit()
  end
  self.editHouseData = nil
  self.curEditSelectRoom = nil
end

DormHouseCtrl.CancelHouseEdit = function(self)
  -- function num : 0_22 , upvalues : _ENV, CS_DormCameraCtrl
  self.editHouseData = nil
  self.curEditSelectRoom = nil
  for spos,roomEntity in pairs(self.roomEnityDic) do
    local roomData = ((self.curHouse).roomDic)[spos]
    if roomData ~= roomEntity.roomData then
      (CS_DormCameraCtrl.Instance):RemoveDormTargetGroup(roomEntity.transform)
      DestroyUnityObject(roomEntity.gameObject)
      self:AddNewRoom(roomEntity.x, roomEntity.y, roomEntity.spos, roomData)
    end
  end
  self:ExitDormEditMode(false)
end

DormHouseCtrl.ExitDormEditMode = function(self, successSave)
  -- function num : 0_23
  self:__ClearRoomMoveEffects()
  ;
  (self.dormCtrl):EmitExitDormHouseEditMode(successSave)
end

DormHouseCtrl.ExitRoom = function(self)
  -- function num : 0_24 , upvalues : _ENV, CS_DormCameraCtrl
  local continueWindow = UIManager:ShowWindow(UIWindowTypeID.ClickContinue)
  continueWindow:InitContinue(nil, nil, nil, nil, false)
  AudioManager:PlayAudioById(1132)
  UIManager:ShowWindowAsync(UIWindowTypeID.SceneChangesMask, function(win)
    -- function num : 0_24_0 , upvalues : CS_DormCameraCtrl, self
    if win == nil then
      return 
    end
    win:InitSceneChangesMask(function()
      -- function num : 0_24_0_0 , upvalues : CS_DormCameraCtrl, self
      (CS_DormCameraCtrl.Instance):EnableDmCamBrainBlend(false)
      ;
      ((((self.dormCtrl).bind).va_Dorm).gameObject):SetActive(true)
      ;
      ((((self.dormCtrl).bind).va_Room).gameObject):SetActive(false)
      ;
      (((self.dormCtrl).bind).va_Dorm):MoveToTopOfPrioritySubqueue()
      ;
      (self.dormCtrl):EmitExitDormRoomStart()
    end
, self.__onH2DTimelineComplete)
  end
)
end

DormHouseCtrl.OnD2HTimelineComplete = function(self, pd)
  -- function num : 0_25 , upvalues : _ENV
  self._houseRoomCo = nil
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  ;
  (UIUtil.SetTopStatus)(self, self.__ClickReturnInRoom)
  ;
  (self.dormCtrl):EmitEnterDormRoomEnd()
end

DormHouseCtrl.__ClickReturnInRoom = function(self)
  -- function num : 0_26 , upvalues : DormEnum
  if (self.dormCtrl).state == (DormEnum.eDormState).Room then
    self:ExitRoom()
  end
end

DormHouseCtrl.OnH2DTimelineComplete = function(self, pd)
  -- function num : 0_27 , upvalues : CS_DormCameraCtrl, _ENV
  self._houseRoomCo = nil
  ;
  ((self.dormCtrl).dormWindow):ShowDmStateNode(true)
  ;
  (CS_DormCameraCtrl.Instance):EnableDmCamBrainBlend(true)
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  ;
  (self.dormCtrl):EmitExitDormRoomEnd()
  ;
  ((self.dormCtrl).dormWindow):RefreshDormHeroList()
  ;
  (CS_DormCameraCtrl.Instance):ResetDormRoomView()
end

DormHouseCtrl.RandEnterNextDormRoom = function(self)
  -- function num : 0_28 , upvalues : _ENV, CS_DormCameraCtrl
  local roomEntity = (self.dormCtrl):GetCurRoomEntity()
  if roomEntity == nil then
    error("[RandEnterNextDormRoom] cur Room is nil,state:" .. tostring((self.dormCtrl):GetDormState()))
    return 
  end
  local count = (self.curHouse):GetRoomCount()
  local index = (math.random)(count - 1)
  local i = 1
  local nextRoomEntity = nil
  for spos,tmpRoom in pairs(self.roomEnityDic) do
    if tmpRoom ~= roomEntity then
      -- DECOMPILER ERROR at PC36: Unhandled construct in 'MakeBoolean' P1

      if not tmpRoom:IsEmptyRoom() and i == index then
        nextRoomEntity = tmpRoom
        break
      end
      i = i + 1
    end
  end
  do
    nextRoomEntity:StartShowRoom()
    ;
    (self.dormCtrl):EmitExitDormRoomStart(true)
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((self.dormCtrl).bind).roomTarget).position = (nextRoomEntity.transform).position + ((self.dormCtrl).bind).roomTarPosOffset
    ;
    (CS_DormCameraCtrl.Instance):ResetDormRoomView()
    ;
    (self.dormCtrl):EmitEnterDormRoomStart(nextRoomEntity)
    ;
    (self.dormCtrl):EmitEnterDormRoomEnd()
  end
end

DormHouseCtrl.GetDmRoomEntityByPos = function(self, pos)
  -- function num : 0_29
  return (self.roomEnityDic)[pos]
end

DormHouseCtrl.__GetUnlockRoomData = function(self)
  -- function num : 0_30 , upvalues : _ENV, DormUtil
  self._lockRoomDic = {}
  local houseType = (self.curHouse):GetRoomHexRange()
  local houseUnlockCfg = (ConfigData.dorm_room_unlock)[(self.curHouse).id]
  if houseUnlockCfg == nil then
    error("Cant get dorm_room_unlock cfg, houseId:" .. tostring((self.curHouse).id))
    return 
  end
  local dic = {}
  local n = houseType
  for dx = -n, n do
    for dy = (math.max)(-n, -dx - n), (math.min)(n, -dx + n) do
      local dz = -dx - dy
      local spos = (DormUtil.XYToRoomCoord)(dx, dy)
      local roomData = ((self.curHouse).roomDic)[spos]
      if roomData == nil then
        local roomEntity = self:GetDmRoomEntityByPos(spos)
        if roomEntity ~= nil then
          local index = (DormUtil.GetRoomIndexByRoomposToxy)(dx, dy)
          local unlockCfg = houseUnlockCfg[index]
          local lockStr = UnlockCenter:GetUnlockElemDes(unlockCfg.unlock_logic, unlockCfg.unlock_para1)
          dic[spos] = {lockStr = lockStr, roomEntity = roomEntity}
        end
      end
    end
  end
  self._lockRoomDic = dic
end

DormHouseCtrl.TryGetRoomLockData = function(self, spos)
  -- function num : 0_31
  return (self._lockRoomDic)[spos]
end

DormHouseCtrl.GetLockRoomDic = function(self)
  -- function num : 0_32
  return self._lockRoomDic
end

DormHouseCtrl.OnDelete = function(self)
  -- function num : 0_33 , upvalues : _ENV
  if self._houseRoomCo ~= nil then
    (TimelineUtil.StopTlCo)(self._houseRoomCo)
    self._houseRoomCo = nil
  end
  for k,v in pairs(self.roomEnityDic) do
    v:OnDelete()
  end
  self:__ClearRoomMoveEffects()
  self.roomEnityDic = nil
  self.dormHolder = nil
  if self._waitShowRoomStateUITimer ~= nil then
    TimerManager:StopTimer(self._waitShowRoomStateUITimer)
    self._waitShowRoomStateUITimer = nil
  end
end

return DormHouseCtrl

