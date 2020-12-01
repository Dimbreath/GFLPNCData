-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpSingleTrack = class("UIEpSingleTrack", UIBaseNode)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIEpSingleTrack.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.lineDefaultColor = ((self.ui).img_Trunk).color
  self.lineDefaultHeight = ((((self.ui).img_Trunk).transform).sizeDelta).y
end

UIEpSingleTrack.InitEpSingleTrack = function(self, roomData, trunkSizeX)
  -- function num : 0_1 , upvalues : _ENV
  self.roomData = roomData
  local sizeDeltaY = ((((self.ui).img_Trunk).transform).sizeDelta).y
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).img_Trunk).transform).sizeDelta = (Vector2.New)(trunkSizeX, sizeDeltaY)
  local sizeDeltaY = ((((self.ui).img_Trunk).transform).sizeDelta).y
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).img_Line).transform).sizeDelta = (Vector2.New)(trunkSizeX, sizeDeltaY)
  local nextRoom = roomData:GetNextParallelRoom()
  local nextLineShow = (nextRoom ~= nil and nextRoom:GetVisible())
  self.__nextRoomPos = (nextRoom ~= nil and nextRoom.position)
  ;
  (((self.ui).img_Trunk).gameObject):SetActive(not (self.roomData):GetVisible() or nextLineShow)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UIEpSingleTrack.SetTrunkLinePass = function(self, lineState, color, height)
  -- function num : 0_2 , upvalues : ExplorationEnum
  local sizeDelta = (((self.ui).img_Trunk).transform).sizeDelta
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  if lineState == (ExplorationEnum.eTrackLineState).Pass then
    ((self.ui).img_Trunk).color = color
    sizeDelta.y = height
  else
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

    if lineState == (ExplorationEnum.eTrackLineState).Auto then
      ((self.ui).img_Trunk).color = ExplorationEnum.LineAutoModeColor
      sizeDelta.y = height
    else
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_Trunk).color = self.lineDefaultColor
      sizeDelta.y = self.lineDefaultHeight
    end
  end
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).img_Trunk).transform).sizeDelta = sizeDelta
end

UIEpSingleTrack.SetForkLinePass = function(self, forkRoom, mapCtrl, lineState, color, height)
  -- function num : 0_3 , upvalues : ExplorationEnum
  if self.__nextRoomPos ~= forkRoom.position then
    return 
  end
  local forkLine = (self.ui).img_Line
  local sizeDelta = (forkLine.transform).sizeDelta
  if lineState == (ExplorationEnum.eTrackLineState).Pass then
    forkLine.color = color
    sizeDelta.y = height
  else
    if lineState == (ExplorationEnum.eTrackLineState).Auto then
      forkLine.color = ExplorationEnum.LineAutoModeColor
      sizeDelta.y = height
    else
      forkLine.color = self.lineDefaultColor
      sizeDelta.y = self.lineDefaultHeight
    end
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (forkLine.transform).sizeDelta = sizeDelta
end

UIEpSingleTrack.SetTrunkLineActive = function(self, forkRoom)
  -- function num : 0_4
  if self.__nextRoomPos == forkRoom.position then
    if (self.roomData):GetVisible() then
      (((self.ui).img_Trunk).gameObject):SetActive(forkRoom:GetVisible())
    end
  end
end

UIEpSingleTrack.SetForkLineActive = function(self, roomData, mapCtrl)
  -- function num : 0_5
end

UIEpSingleTrack.GetTrackCrossingPos = function(self)
  -- function num : 0_6
  return (((self.ui).lineList).transform).position
end

return UIEpSingleTrack

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpSingleTrack = class("UIEpSingleTrack", UIBaseNode)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIEpSingleTrack.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.lineDefaultColor = ((self.ui).img_Trunk).color
    self.lineDefaultHeight = ((((self.ui).img_Trunk).transform).sizeDelta).y
end

UIEpSingleTrack.InitEpSingleTrack = function(self, roomData, trunkSizeX)
    -- function num : 0_1 , upvalues : _ENV
    self.roomData = roomData
    local sizeDeltaY = ((((self.ui).img_Trunk).transform).sizeDelta).y -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (((self.ui).img_Trunk).transform).sizeDelta =
        (Vector2.New)(trunkSizeX, sizeDeltaY)
    local sizeDeltaY = ((((self.ui).img_Trunk).transform).sizeDelta).y -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'
    ;
    (((self.ui).img_Line).transform).sizeDelta =
        (Vector2.New)(trunkSizeX, sizeDeltaY)
    local nextRoom = roomData:GetNextParallelRoom()
    local nextLineShow = (nextRoom ~= nil and nextRoom:GetVisible())
    self.__nextRoomPos = (nextRoom ~= nil and nextRoom.position);
    (((self.ui).img_Trunk).gameObject):SetActive(
        not (self.roomData):GetVisible() or nextLineShow)
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UIEpSingleTrack.SetTrunkLinePass = function(self, lineState, color, height)
    -- function num : 0_2 , upvalues : ExplorationEnum
    local sizeDelta = (((self.ui).img_Trunk).transform).sizeDelta
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

    if lineState == (ExplorationEnum.eTrackLineState).Pass then
        ((self.ui).img_Trunk).color = color
        sizeDelta.y = height
    else
        -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

        if lineState == (ExplorationEnum.eTrackLineState).Auto then
            ((self.ui).img_Trunk).color = ExplorationEnum.LineAutoModeColor
            sizeDelta.y = height
        else
            -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'


            ((self.ui).img_Trunk).color = self.lineDefaultColor
            sizeDelta.y = self.lineDefaultHeight
        end
    end -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'
    
    (((self.ui).img_Trunk).transform).sizeDelta = sizeDelta
end

UIEpSingleTrack.SetForkLinePass = function(self, forkRoom, mapCtrl, lineState,
                                           color, height)
    -- function num : 0_3 , upvalues : ExplorationEnum
    if self.__nextRoomPos ~= forkRoom.position then return end
    local forkLine = (self.ui).img_Line
    local sizeDelta = (forkLine.transform).sizeDelta
    if lineState == (ExplorationEnum.eTrackLineState).Pass then
        forkLine.color = color
        sizeDelta.y = height
    else
        if lineState == (ExplorationEnum.eTrackLineState).Auto then
            forkLine.color = ExplorationEnum.LineAutoModeColor
            sizeDelta.y = height
        else
            forkLine.color = self.lineDefaultColor
            sizeDelta.y = self.lineDefaultHeight
        end
    end -- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'
    
    (forkLine.transform).sizeDelta = sizeDelta
end

UIEpSingleTrack.SetTrunkLineActive = function(self, forkRoom)
    -- function num : 0_4
    if self.__nextRoomPos == forkRoom.position then
        if (self.roomData):GetVisible() then
            (((self.ui).img_Trunk).gameObject):SetActive(forkRoom:GetVisible())
        end
    end
end

UIEpSingleTrack.SetForkLineActive = function(self, roomData, mapCtrl)
    -- function num : 0_5
end

UIEpSingleTrack.GetTrackCrossingPos = function(self)
    -- function num : 0_6
    return (((self.ui).lineList).transform).position
end

return UIEpSingleTrack

