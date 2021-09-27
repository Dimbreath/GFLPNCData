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

FactoryRoomEntity.InitRoomObject = function(self, object, clickAction, type, index, unlcokDes)
  -- function num : 0_1 , upvalues : CS_EventTriggerListener
  object:SetActive(true)
  self.gameObject = object
  self.transform = object.transform
  self.clickAction = clickAction
  self.type = type
  self.index = index
  self.unlcokDes = unlcokDes
  local eventTrigger = (CS_EventTriggerListener.Get)(self.gameObject)
  eventTrigger:onClick("+", self.__onRoomClicked)
  self:GenRoomInfo()
end

FactoryRoomEntity.ChangeRoomModelGo = function(self, object, type)
  -- function num : 0_2 , upvalues : CS_EventTriggerListener
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
  self:GenRoomInfo()
end

FactoryRoomEntity.GenRoomInfo = function(self)
  -- function num : 0_3
  self.uiRoomInfo = ((self.factoryController).ui3DCanvas):GenRoomInfo(self.index, self.transform, self.type, self.unlcokDes)
  ;
  ((self.factoryController).ui3DCanvas):SetRoomInfoSate(self.index, self.type)
end

FactoryRoomEntity.SetSelected = function(self, bool)
  -- function num : 0_4
  (self.uiRoomInfo):SetRoomSeleced(bool)
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

