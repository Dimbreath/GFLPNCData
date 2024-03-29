local UIEpYTrack = class("UIEpYTrack", UIBaseNode)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIEpYTrack.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, ExplorationEnum
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.lineDefaultColor = ((self.ui).img_Trunk).color
  self.pointColor = ((self.ui).img_Point).color
  self.lineDefaultHeight = ((((self.ui).img_Trunk).transform).sizeDelta).y
  self.traceType = (ExplorationEnum.eTrackLineType).NormalYTrack
end

UIEpYTrack.InitEpYTrack = function(self, roomData, trunkSizeX, forkLength)
  -- function num : 0_1 , upvalues : _ENV
  self.roomData = roomData
  local sizeDeltaY = ((((self.ui).img_Trunk).transform).sizeDelta).y
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).img_Trunk).transform).sizeDelta = (Vector2.New)(trunkSizeX, sizeDeltaY)
  local forkSizeY = ((((self.ui).img_LineUP).transform).sizeDelta).y
  local newSize = (Vector2.New)(forkLength, forkSizeY)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (((self.ui).img_LineUP).transform).sizeDelta = newSize
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (((self.ui).img_LineDown).transform).sizeDelta = newSize
  ;
  (((self.ui).img_Trunk).gameObject):SetActive(roomData:GetVisible())
  self.forkLineDic = {}
  local downDirRoom = roomData:GetNextDownDirRoom()
  local downDirLineShow = (downDirRoom ~= nil and downDirRoom:GetVisible())
  ;
  (((self.ui).img_LineDown).gameObject):SetActive(downDirLineShow)
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R9 in 'UnsetPending'

  if downDirRoom ~= nil then
    (self.forkLineDic)[downDirRoom.position] = (self.ui).img_LineDown
  end
  local upDirRoom = roomData:GetNextUpDirRoom()
  local upDirLineShow = (upDirRoom ~= nil and upDirRoom:GetVisible())
  ;
  (((self.ui).img_LineUP).gameObject):SetActive(upDirLineShow)
  -- DECOMPILER ERROR at PC85: Confused about usage of register: R11 in 'UnsetPending'

  if upDirRoom ~= nil then
    (self.forkLineDic)[upDirRoom.position] = (self.ui).img_LineUP
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UIEpYTrack.SetTrunkLinePass = function(self, lineState, color, height)
  -- function num : 0_2 , upvalues : ExplorationEnum
  local sizeDelta = (((self.ui).img_Trunk).transform).sizeDelta
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  if lineState == (ExplorationEnum.eTrackLineState).Pass then
    ((self.ui).img_Trunk).color = color
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_Point).color = color
    sizeDelta.y = height
  else
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

    if lineState == (ExplorationEnum.eTrackLineState).Auto then
      ((self.ui).img_Trunk).color = ExplorationEnum.LineAutoModeColor
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_Point).color = ExplorationEnum.LineAutoModeColor
      sizeDelta.y = height
    else
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_Trunk).color = self.lineDefaultColor
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_Point).color = self.pointColor
      sizeDelta.y = self.lineDefaultHeight
    end
  end
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).img_Trunk).transform).sizeDelta = sizeDelta
end

UIEpYTrack.SetForkLinePass = function(self, forkRoom, mapCtrl, lineState, color, height)
  -- function num : 0_3 , upvalues : ExplorationEnum
  local forkLine = (self.forkLineDic)[forkRoom.position]
  if forkLine == nil then
    return 
  end
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
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (forkLine.transform).sizeDelta = sizeDelta
end

UIEpYTrack.SetTrunkLineActive = function(self)
  -- function num : 0_4
  (((self.ui).img_Trunk).gameObject):SetActive((self.roomData):GetVisible())
end

UIEpYTrack.SetForkLineActive = function(self, roomData, mapCtrl)
  -- function num : 0_5 , upvalues : _ENV
  local lineItem = (self.forkLineDic)[roomData.position]
  if not IsNull(lineItem) then
    (lineItem.gameObject):SetActive(roomData:GetVisible())
  end
end

UIEpYTrack.GetTrackCrossingPos = function(self)
  -- function num : 0_6
  return (((self.ui).img_Point).transform).position
end

return UIEpYTrack

