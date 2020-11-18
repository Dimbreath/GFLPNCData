-- params : ...
-- function num : 0 , upvalues : _ENV
local EpRoomEntity = class("EpRoomEntity")
EpRoomEntity.ctor = function(self)
  -- function num : 0_0
end

EpRoomEntity.InitEpRoom = function(self, uiRoom, roomData, visibleEvent)
  -- function num : 0_1
  self.uiRoom = uiRoom
  self.roomData = roomData
  self.__visibleEvent = visibleEvent
end

EpRoomEntity.InitEpRoomInterface = function(self, roomInterface)
  -- function num : 0_2
  self.roomInterface = roomInterface
end

EpRoomEntity.UpdateRoomVisible = function(self)
  -- function num : 0_3
  local visible = (self.roomData):GetVisible()
  self:ShowRoom(visible)
  if visible and self.__visibleEvent ~= nil then
    (self.__visibleEvent)(self:GetRoomEntityPos())
  end
end

EpRoomEntity.ShowRoom = function(self, show)
  -- function num : 0_4
  if show then
    (self.uiRoom):Show()
  else
    ;
    (self.uiRoom):Hide()
  end
  if self.roomInterface ~= nil then
    if show then
      (self.roomInterface):Show()
    else
      ;
      (self.roomInterface):Hide()
    end
  end
end

EpRoomEntity.GetUIRoom = function(self)
  -- function num : 0_5
  return self.uiRoom
end

EpRoomEntity.ChangeRoomEntityUIState = function(self, roomTypeState)
  -- function num : 0_6
  (self:GetUIRoom()):ChangeUIState(roomTypeState)
end

EpRoomEntity.GetRoomData = function(self)
  -- function num : 0_7
  return self.roomData
end

EpRoomEntity.GetRoomEntityLocalPos = function(self)
  -- function num : 0_8
  return ((self.uiRoom).transform).localPosition
end

EpRoomEntity.GetRoomEntityPos = function(self)
  -- function num : 0_9
  return ((self.uiRoom).transform).position
end

EpRoomEntity.GetRoomInterface = function(self)
  -- function num : 0_10
  return self.roomInterface
end

EpRoomEntity.OnDelete = function(self)
  -- function num : 0_11
  if self.uiRoom ~= nil then
    (self.uiRoom):Delete()
  end
end

return EpRoomEntity

