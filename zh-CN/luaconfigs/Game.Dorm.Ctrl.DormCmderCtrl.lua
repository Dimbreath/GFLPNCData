-- params : ...
-- function num : 0 , upvalues : _ENV
local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormCmderCtrl = class("DormCtrlBase", DormCtrlBase)
local CmderRoomMove = {
[16711936] = {16843008, 16777471}
, 
[16777471] = {16711936, 16711937}
, 
[16711937] = {16777471, 16777472}
, 
[16777472] = {16711937, 16843007}
, 
[16843007] = {16777472, 16777473}
, 
[16777473] = {16843007, 16843008}
, 
[16843008] = {16777473, 16711936}
}
local DormCmderEntity = require("Game.Dorm.Character.Entity.DormCmderEntity")
DormCmderCtrl.ctor = function(self, dormCtrl)
  -- function num : 0_0
end

DormCmderCtrl.OnEnterDormScene = function(self)
  -- function num : 0_1 , upvalues : DormCmderEntity, _ENV
  local cmderObject = (((self.dormCtrl).comRes).cmderPrefab):Instantiate()
  self.cmderEntity = (DormCmderEntity.New)()
  ;
  (self.cmderEntity):InitDormCmderEntity(cmderObject)
  ;
  (self.cmderEntity):HideDormCmder()
  self.__enterEffect = (((self.dormCtrl).comRes).enterRoomEffectPrefab):Instantiate()
  ;
  (self.__enterEffect):SetActive(false)
  self.__exitEffect = (((self.dormCtrl).comRes).exitRoomEffectPrefab):Instantiate()
  ;
  (self.__exitEffect):SetActive(false)
  UIManager:ShowWindowAsync(UIWindowTypeID.DormInput, function(inputWindow)
    -- function num : 0_1_0 , upvalues : self, _ENV
    self.__inputWindow = inputWindow
    ;
    (self.__inputWindow):InitDormInput(BindCallback(self, self.OnDormJoystickMove), BindCallback(self, self.OnDormJoystickUp))
    if not self.__cmderActive then
      (self.__inputWindow):Hide()
    end
  end
)
end

DormCmderCtrl.OnEnterDormHouse = function(self)
  -- function num : 0_2
end

DormCmderCtrl.ChangeCmderDorm = function(self, roomEntity, initPos)
  -- function num : 0_3
  if roomEntity == nil then
    return 
  end
  self.__cmderInRoom = roomEntity
  ;
  (self.cmderEntity):CmderAddToRoom(self.__cmderInRoom, initPos)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.__enterEffect).transform).position = ((self.cmderEntity).transform).position
  ;
  (self.__enterEffect):SetActive(false)
  ;
  (self.__enterEffect):SetActive(true)
  self:__SwitchDormCmderState(true)
end

DormCmderCtrl.OnEnterDormHouseEditMode = function(self)
  -- function num : 0_4
  self:__SwitchDormCmderState(false)
end

DormCmderCtrl.OnExitDormEditMode = function(self)
  -- function num : 0_5
  self:__SwitchDormCmderState(true)
end

DormCmderCtrl.OnEnterDormRoom = function(self, roomEntity)
  -- function num : 0_6 , upvalues : _ENV
  self.__cmderInRoom = roomEntity
  ;
  (self.cmderEntity):CmderAddToRoom(self.__cmderInRoom, initPos)
  self:__SwitchDormCmderState(true)
end

DormCmderCtrl.OnExitDormRoom = function(self, roomEntity)
  -- function num : 0_7
  self.__cmderInRoom = nil
  self:__SwitchDormCmderState(false)
  ;
  ((self.cmderEntity).transform):SetParent(nil)
end

DormCmderCtrl.OnEnterDormRoomEditMode = function(self, roomEntity)
  -- function num : 0_8
  self:__SwitchDormCmderState(false)
end

DormCmderCtrl.OnExitDormRoomEditMode = function(self, roomEntity, success)
  -- function num : 0_9
  self:__SwitchDormCmderState(true)
end

DormCmderCtrl.__SwitchDormCmderState = function(self, active)
  -- function num : 0_10
  self.__cmderActive = active
  if active then
    (self.cmderEntity):ShowDormCmder()
    ;
    (self.__inputWindow):Show()
  else
    ;
    (self.cmderEntity):HideDormCmder()
    ;
    (self.__inputWindow):Hide()
  end
end

DormCmderCtrl.OnDormJoystickMove = function(self, moveData)
  -- function num : 0_11
  (self.cmderEntity):CmderStartMove(moveData)
end

DormCmderCtrl.OnDormJoystickUp = function(self)
  -- function num : 0_12
  (self.cmderEntity):CmderEndMove()
end

DormCmderCtrl.OnCmderUpdate = function(self)
  -- function num : 0_13 , upvalues : CmderRoomMove, _ENV
  if self.cmderEntity == nil or self.__cmderInRoom == nil or (self.cmderEntity).transform == nil then
    return 
  end
  local newPos, initPos = nil, nil
  if (((self.cmderEntity).transform).localPosition).x >= 3.5 then
    newPos = (CmderRoomMove[(self.__cmderInRoom).spos])[1]
    initPos = (Vector3.New)(1.8, 0, 3)
  end
  if (((self.cmderEntity).transform).localPosition).z >= 3.5 then
    newPos = (CmderRoomMove[(self.__cmderInRoom).spos])[2]
    initPos = (Vector3.New)(3, 0, 1.8)
  end
  if newPos == nil then
    return 
  end
  local roomEntity = (((self.dormCtrl).houseCtrl).roomEnityDic)[newPos]
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.__exitEffect).transform).position = ((self.cmderEntity).transform).position
  ;
  (self.__exitEffect):SetActive(false)
  ;
  (self.__exitEffect):SetActive(true)
  self:ChangeCmderDorm(roomEntity, initPos)
end

DormCmderCtrl.OnDelete = function(self)
  -- function num : 0_14
end

return DormCmderCtrl

