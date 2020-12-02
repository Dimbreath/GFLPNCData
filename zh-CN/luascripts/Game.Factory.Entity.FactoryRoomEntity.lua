-- params : ...
-- function num : 0 , upvalues : _ENV
local FactoryRoomEntity = class("FactoryRoomEntity")
local CS_EventTriggerListener = CS.EventTriggerListener
local CS_GameObject = (CS.UnityEngine).GameObject
local FactoryEnum = require("Game.Factory.FactoryEnum")
FactoryRoomEntity.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.type = nil
  self.__onRoomClicked = BindCallback(self, self.OnRoomClicked)
end

FactoryRoomEntity.InitRoomObject = function(self, object, clickAction, type, index, unlockLevel)
  -- function num : 0_1 , upvalues : CS_EventTriggerListener, FactoryEnum
  object:SetActive(true)
  self.gameObject = object
  self.transform = object.transform
  self.clickAction = clickAction
  self.type = type
  self.index = index
  self.unlockLevel = unlockLevel
  local eventTrigger = (CS_EventTriggerListener.Get)(self.gameObject)
  eventTrigger:onClick("+", self.__onRoomClicked)
  if self.type ~= (FactoryEnum.eRoomType).locked then
    self:GenRoomInfo()
  else
    self:ChangeEntityLock(true)
  end
end

FactoryRoomEntity.ChangeRoomModelGo = function(self, object, type)
  -- function num : 0_2 , upvalues : CS_EventTriggerListener, FactoryEnum
  if type == self.type then
    return 
  end
  local oldType = self.type
  ;
  (self.gameObject):SetActive(false)
  local eventTrigger = (CS_EventTriggerListener.Get)(self.gameObject)
  eventTrigger:onClick("-", self.__onRoomClicked)
  object:SetActive(true)
  self.gameObject = object
  self.transform = object.transform
  self.type = type
  local eventTrigger = (CS_EventTriggerListener.Get)(self.gameObject)
  eventTrigger:onClick("+", self.__onRoomClicked)
  if oldType == (FactoryEnum.eRoomType).locked and self.type ~= (FactoryEnum.eRoomType).locked then
    self:GenRoomInfo()
  else
    self:ChangeEntityLock(false)
  end
end

FactoryRoomEntity.GenRoomInfo = function(self)
  -- function num : 0_3
  ((self.factoryController).uiCanvas):GenRoomInfo(self.index, self.transform)
end

FactoryRoomEntity.ChangeEntityLock = function(self, bool)
  -- function num : 0_4
  ((self.factoryController).factoryMainUI):ChangeUILock(self, bool)
end

FactoryRoomEntity.OnRoomClicked = function(self, go, eventData)
  -- function num : 0_5
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

FactoryRoomEntity.OnDelete = function(self)
  -- function num : 0_6
end

return FactoryRoomEntity

