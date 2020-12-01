-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpETrack = class("UIEpETrack", UIBaseNode)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIEpETrack.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).img_Vertical):SetActive(false)
  ;
  ((self.ui).img_Line):SetActive(false)
  self.lineSizeDeltaY = ((((self.ui).img_Line).transform).sizeDelta).y
  self.lineDefaultColor = ((self.ui).img_Trunk).color
  self.lineDefaultHeight = ((((self.ui).img_Trunk).transform).sizeDelta).y
end

UIEpETrack.InitRoomNormalETrack = function(self, roomData, mapCtrl, trackLength, verticalIntervalY)
  -- function num : 0_1
  self.roomData = roomData
  self:__InitTrunkLine(trackLength)
  local nextRoom = roomData:GetNextRoom()
  self:__InitTrackDynLine(nextRoom, mapCtrl, verticalIntervalY)
end

UIEpETrack.InitRoomReverseETrack = function(self, roomData, mapCtrl, trackLength, verticalIntervalY)
  -- function num : 0_2 , upvalues : _ENV
  self.roomData = roomData
  local originScale = (((self.ui).img_Trunk).transform).localScale
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((self.ui).img_Trunk).transform).localScale = (Vector3.New)(-originScale.x, originScale.y, originScale.z)
  self:__InitTrunkLine(trackLength)
  local lastRoom = roomData:GetLastRoom()
  self:__InitTrackDynLine(lastRoom, mapCtrl, verticalIntervalY)
end

UIEpETrack.__InitTrunkLine = function(self, trackLength)
  -- function num : 0_3 , upvalues : _ENV
  local lineSizeDelta = (((self.ui).img_Line).transform).sizeDelta
  local trunkSizeX = trackLength - lineSizeDelta.x
  local sizeDeltaY = ((((self.ui).img_Trunk).transform).sizeDelta).y
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).img_Trunk).transform).sizeDelta = (Vector2.New)(trunkSizeX, sizeDeltaY)
  ;
  (((self.ui).img_Trunk).gameObject):SetActive((self.roomData):GetVisible())
end

UIEpETrack.__InitTrackDynLine = function(self, nextRoomList, mapCtrl, verticalIntervalY)
  -- function num : 0_4 , upvalues : _ENV
  local forkRoomList = {}
  for _,v in pairs(nextRoomList) do
    (table.insert)(forkRoomList, v)
  end
  ;
  (table.sort)(forkRoomList, function(r1, r2)
    -- function num : 0_4_0
    do return r1.y < r2.y end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self.forkRoomList = forkRoomList
  if #self.forkRoomList == 0 then
    return 
  end
  self.forkRoomVisible = {}
  for k,tmpRoomData in ipairs(self.forkRoomList) do
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R10 in 'UnsetPending'

    (self.forkRoomVisible)[k] = tmpRoomData:GetVisible()
  end
  self.curForkLineRoomPos = nil
  self.forkLineDic = {}
  local oldLinePosition = (((self.ui).img_Line).transform).localPosition
  for k,roomData in pairs(self.forkRoomList) do
    local lineItemObj = ((self.ui).img_Line):Instantiate()
    lineItemObj:SetActive(roomData:GetVisible())
    local lineItem = lineItemObj:FindComponent(eUnityComponentID.Image)
    local uiRoom = mapCtrl:GetRoomUI(roomData.position)
    local localPos = ((lineItemObj.transform).parent):InverseTransformPoint((uiRoom.transform).position)
    oldLinePosition.y = localPos.y
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (lineItem.transform).localPosition = oldLinePosition
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.forkLineDic)[roomData.position] = lineItem
  end
  local verticalLineItemObj = ((self.ui).img_Vertical):Instantiate()
  self.verticalLineDown = verticalLineItemObj:FindComponent(eUnityComponentID.Image)
  verticalLineItemObj = ((self.ui).img_Vertical):Instantiate()
  self.verticalLineUp = verticalLineItemObj:FindComponent(eUnityComponentID.Image)
  verticalLineItemObj = ((self.ui).img_Vertical):Instantiate()
  verticalLineItemObj:SetActive(true)
  self.verticalLineCenter = verticalLineItemObj:FindComponent(eUnityComponentID.Image)
  self:__ReCalcVerticalLen(mapCtrl)
  self:__ResetDynLine()
end

UIEpETrack.__ReCalcVerticalLen = function(self, mapCtrl)
  -- function num : 0_5 , upvalues : _ENV
  local curPosY = ((((self.verticalLineCenter).transform).parent):InverseTransformPoint((self.transform).position)).y
  local minRoom = nil
  for i = 1, #self.forkRoomList do
    if (self.forkRoomVisible)[i] then
      minRoom = (self.forkRoomList)[i]
      break
    end
  end
  do
    local minPosY = nil
    if minRoom ~= nil then
      local uiRoomDown = mapCtrl:GetRoomUI(minRoom.position)
      minPosY = ((((self.verticalLineCenter).transform).parent):InverseTransformPoint((uiRoomDown.transform).position)).y
    else
      do
        minPosY = curPosY
        local maxRoom = nil
        for i = #self.forkRoomList, 1, -1 do
          if (self.forkRoomVisible)[i] then
            maxRoom = (self.forkRoomList)[i]
            break
          end
        end
        do
          local maxPosY = nil
          if maxRoom ~= nil then
            local uiRoomUp = mapCtrl:GetRoomUI(maxRoom.position)
            maxPosY = ((((self.verticalLineCenter).transform).parent):InverseTransformPoint((uiRoomUp.transform).position)).y
          else
            do
              maxPosY = curPosY
              self.verticalMinPosY = (math.min)(minPosY, curPosY)
              self.verticalMaxPosY = (math.max)(maxPosY, curPosY)
              self.verticalCurPosY = curPosY
            end
          end
        end
      end
    end
  end
end

UIEpETrack.__ResetDynLine = function(self)
  -- function num : 0_6
  self:SetVerticalLineSizePos(self.verticalLineCenter, self.verticalMinPosY, self.verticalMaxPosY)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.verticalLineCenter).color = self.lineDefaultColor
  local sizeDelta = ((self.verticalLineCenter).transform).sizeDelta
  sizeDelta.x = self.lineDefaultHeight
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.verticalLineCenter).transform).sizeDelta = sizeDelta
  ;
  ((self.verticalLineDown).gameObject):SetActive(false)
  ;
  ((self.verticalLineUp).gameObject):SetActive(false)
end

UIEpETrack.SetVerticalLineSizePos = function(self, lineItem, minPosY, maxPosY)
  -- function num : 0_7
  local oldVerticalSizeDelta = (lineItem.transform).sizeDelta
  oldVerticalSizeDelta.y = maxPosY - minPosY + self.lineSizeDeltaY
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (lineItem.transform).sizeDelta = oldVerticalSizeDelta
  local oldVerticalPos = (lineItem.transform).localPosition
  oldVerticalPos.y = (minPosY + maxPosY) / 2 - self.verticalCurPosY
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (lineItem.transform).localPosition = oldVerticalPos
end

UIEpETrack.SetTrunkLinePass = function(self, lineState, color, height)
  -- function num : 0_8 , upvalues : ExplorationEnum
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

UIEpETrack.SetForkLinePass = function(self, forkRoom, mapCtrl, lineState, color, height)
  -- function num : 0_9 , upvalues : ExplorationEnum, _ENV
  local lineItem = (self.forkLineDic)[forkRoom.position]
  do
    if lineItem ~= nil then
      local sizeDelta = (lineItem.transform).sizeDelta
      if lineState == (ExplorationEnum.eTrackLineState).Pass then
        lineItem.color = color
        sizeDelta.y = height
      else
        if lineState == (ExplorationEnum.eTrackLineState).Auto then
          lineItem.color = ExplorationEnum.LineAutoModeColor
          sizeDelta.y = height
        else
          lineItem.color = self.lineDefaultColor
          sizeDelta.y = self.lineDefaultHeight
        end
      end
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (lineItem.transform).sizeDelta = sizeDelta
    end
    if lineState == (ExplorationEnum.eTrackLineState).Normal then
      if forkRoom.position == self.curForkLineRoomPos then
        self:__ResetDynLine()
        self.curForkLineRoomPos = nil
      end
      return 
    end
    self.curForkLineRoomPos = forkRoom.position
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R7 in 'UnsetPending'

    if lineState == (ExplorationEnum.eTrackLineState).Pass then
      (self.verticalLineCenter).color = color
    else
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.verticalLineCenter).color = ExplorationEnum.LineAutoModeColor
    end
    if #self.forkRoomList <= 1 then
      return 
    end
    local roomIndex = nil
    for k,roomData in ipairs(self.forkRoomList) do
      if roomData == forkRoom then
        roomIndex = k
        break
      end
    end
    do
      if roomIndex == nil then
        return 
      end
      local uiForkRoom = mapCtrl:GetRoomUI(forkRoom.position)
      if uiForkRoom == nil then
        return 
      end
      local forRoomPosY = ((((self.verticalLineCenter).transform).parent):InverseTransformPoint((uiForkRoom.transform).position)).y
      local curVerticalMinPosY = (math.min)(self.verticalCurPosY, forRoomPosY)
      local curVerticalMaxPosY = (math.max)(self.verticalCurPosY, forRoomPosY)
      self:SetVerticalLineSizePos(self.verticalLineCenter, curVerticalMinPosY, curVerticalMaxPosY)
      local sizeDelta = ((self.verticalLineCenter).transform).sizeDelta
      sizeDelta.x = height
      -- DECOMPILER ERROR at PC106: Confused about usage of register: R13 in 'UnsetPending'

      ;
      ((self.verticalLineCenter).transform).sizeDelta = sizeDelta
      if roomIndex > 1 then
        ((self.verticalLineDown).gameObject):SetActive(true)
        local tmpVerticalMinPosY = self.verticalMinPosY
        local tmpVerticalMaxPosY = curVerticalMinPosY
        self:SetVerticalLineSizePos(self.verticalLineDown, tmpVerticalMinPosY, tmpVerticalMaxPosY)
      else
        do
          ;
          ((self.verticalLineDown).gameObject):SetActive(false)
          if roomIndex < #self.forkRoomList then
            ((self.verticalLineUp).gameObject):SetActive(true)
            local tmpVerticalMinPosY = curVerticalMaxPosY
            local tmpVerticalMaxPosY = self.verticalMaxPosY
            self:SetVerticalLineSizePos(self.verticalLineUp, tmpVerticalMinPosY, tmpVerticalMaxPosY)
          else
            do
              ;
              ((self.verticalLineUp).gameObject):SetActive(false)
            end
          end
        end
      end
    end
  end
end

UIEpETrack.SetTrunkLineActive = function(self)
  -- function num : 0_10
  (((self.ui).img_Trunk).gameObject):SetActive((self.roomData):GetVisible())
end

UIEpETrack.SetForkLineActive = function(self, roomData, mapCtrl)
  -- function num : 0_11 , upvalues : _ENV
  local lineItem = (self.forkLineDic)[roomData.position]
  if not IsNull(lineItem) then
    (lineItem.gameObject):SetActive(roomData:GetVisible())
  end
  for i = 1, #self.forkRoomList do
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

    if roomData == (self.forkRoomList)[i] and (self.forkRoomVisible)[i] == false then
      (self.forkRoomVisible)[i] = true
      self:__ReCalcVerticalLen(mapCtrl)
      self:__ResetDynLine()
      break
    end
  end
end

UIEpETrack.GetTrackCrossingPos = function(self)
  -- function num : 0_12
  return (((self.ui).lineList).transform).position
end

return UIEpETrack

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpETrack = class("UIEpETrack", UIBaseNode)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIEpETrack.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    ((self.ui).img_Vertical):SetActive(false);
    ((self.ui).img_Line):SetActive(false)
    self.lineSizeDeltaY = ((((self.ui).img_Line).transform).sizeDelta).y
    self.lineDefaultColor = ((self.ui).img_Trunk).color
    self.lineDefaultHeight = ((((self.ui).img_Trunk).transform).sizeDelta).y
end

UIEpETrack.InitRoomNormalETrack = function(self, roomData, mapCtrl, trackLength,
                                           verticalIntervalY)
    -- function num : 0_1
    self.roomData = roomData
    self:__InitTrunkLine(trackLength)
    local nextRoom = roomData:GetNextRoom()
    self:__InitTrackDynLine(nextRoom, mapCtrl, verticalIntervalY)
end

UIEpETrack.InitRoomReverseETrack = function(self, roomData, mapCtrl,
                                            trackLength, verticalIntervalY)
    -- function num : 0_2 , upvalues : _ENV
    self.roomData = roomData
    local originScale = (((self.ui).img_Trunk).transform).localScale -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'
    ;
    (((self.ui).img_Trunk).transform).localScale =
        (Vector3.New)(-originScale.x, originScale.y, originScale.z)
    self:__InitTrunkLine(trackLength)
    local lastRoom = roomData:GetLastRoom()
    self:__InitTrackDynLine(lastRoom, mapCtrl, verticalIntervalY)
end

UIEpETrack.__InitTrunkLine = function(self, trackLength)
    -- function num : 0_3 , upvalues : _ENV
    local lineSizeDelta = (((self.ui).img_Line).transform).sizeDelta
    local trunkSizeX = trackLength - lineSizeDelta.x
    local sizeDeltaY = ((((self.ui).img_Trunk).transform).sizeDelta).y -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'
    ;
    (((self.ui).img_Trunk).transform).sizeDelta =
        (Vector2.New)(trunkSizeX, sizeDeltaY);
    (((self.ui).img_Trunk).gameObject):SetActive((self.roomData):GetVisible())
end

UIEpETrack.__InitTrackDynLine = function(self, nextRoomList, mapCtrl,
                                         verticalIntervalY)
    -- function num : 0_4 , upvalues : _ENV
    local forkRoomList = {}
    for _, v in pairs(nextRoomList) do (table.insert)(forkRoomList, v) end
    (table.sort)(forkRoomList, function(r1, r2)
        -- function num : 0_4_0
        do return r1.y < r2.y end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
    self.forkRoomList = forkRoomList
    if #self.forkRoomList == 0 then return end
    self.forkRoomVisible = {}
    for k, tmpRoomData in ipairs(self.forkRoomList) do
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R10 in 'UnsetPending'

        (self.forkRoomVisible)[k] = tmpRoomData:GetVisible()
    end
    self.curForkLineRoomPos = nil
    self.forkLineDic = {}
    local oldLinePosition = (((self.ui).img_Line).transform).localPosition
    for k, roomData in pairs(self.forkRoomList) do
        local lineItemObj = ((self.ui).img_Line):Instantiate()
        lineItemObj:SetActive(roomData:GetVisible())
        local lineItem = lineItemObj:FindComponent(eUnityComponentID.Image)
        local uiRoom = mapCtrl:GetRoomUI(roomData.position)
        local localPos = ((lineItemObj.transform).parent):InverseTransformPoint(
                             (uiRoom.transform).position)
        oldLinePosition.y = localPos.y -- DECOMPILER ERROR at PC70: Confused about usage of register: R15 in 'UnsetPending'
        ;
        (lineItem.transform).localPosition = oldLinePosition -- DECOMPILER ERROR at PC73: Confused about usage of register: R15 in 'UnsetPending'
        ;
        (self.forkLineDic)[roomData.position] = lineItem
    end
    local verticalLineItemObj = ((self.ui).img_Vertical):Instantiate()
    self.verticalLineDown = verticalLineItemObj:FindComponent(
                                eUnityComponentID.Image)
    verticalLineItemObj = ((self.ui).img_Vertical):Instantiate()
    self.verticalLineUp = verticalLineItemObj:FindComponent(
                              eUnityComponentID.Image)
    verticalLineItemObj = ((self.ui).img_Vertical):Instantiate()
    verticalLineItemObj:SetActive(true)
    self.verticalLineCenter = verticalLineItemObj:FindComponent(
                                  eUnityComponentID.Image)
    self:__ReCalcVerticalLen(mapCtrl)
    self:__ResetDynLine()
end

UIEpETrack.__ReCalcVerticalLen = function(self, mapCtrl)
    -- function num : 0_5 , upvalues : _ENV
    local curPosY =
        ((((self.verticalLineCenter).transform).parent):InverseTransformPoint(
            (self.transform).position)).y
    local minRoom = nil
    for i = 1, #self.forkRoomList do
        if (self.forkRoomVisible)[i] then
            minRoom = (self.forkRoomList)[i]
            break
        end
    end
    do
        local minPosY = nil
        if minRoom ~= nil then
            local uiRoomDown = mapCtrl:GetRoomUI(minRoom.position)
            minPosY =
                ((((self.verticalLineCenter).transform).parent):InverseTransformPoint(
                    (uiRoomDown.transform).position)).y
        else
            do
                minPosY = curPosY
                local maxRoom = nil
                for i = #self.forkRoomList, 1, -1 do
                    if (self.forkRoomVisible)[i] then
                        maxRoom = (self.forkRoomList)[i]
                        break
                    end
                end
                do
                    local maxPosY = nil
                    if maxRoom ~= nil then
                        local uiRoomUp = mapCtrl:GetRoomUI(maxRoom.position)
                        maxPosY =
                            ((((self.verticalLineCenter).transform).parent):InverseTransformPoint(
                                (uiRoomUp.transform).position)).y
                    else
                        do
                            maxPosY = curPosY
                            self.verticalMinPosY = (math.min)(minPosY, curPosY)
                            self.verticalMaxPosY = (math.max)(maxPosY, curPosY)
                            self.verticalCurPosY = curPosY
                        end
                    end
                end
            end
        end
    end
end

UIEpETrack.__ResetDynLine = function(self)
    -- function num : 0_6
    self:SetVerticalLineSizePos(self.verticalLineCenter, self.verticalMinPosY,
                                self.verticalMaxPosY) -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.verticalLineCenter).color = self.lineDefaultColor
    local sizeDelta = ((self.verticalLineCenter).transform).sizeDelta
    sizeDelta.x = self.lineDefaultHeight -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.verticalLineCenter).transform).sizeDelta = sizeDelta;
    ((self.verticalLineDown).gameObject):SetActive(false);
    ((self.verticalLineUp).gameObject):SetActive(false)
end

UIEpETrack.SetVerticalLineSizePos = function(self, lineItem, minPosY, maxPosY)
    -- function num : 0_7
    local oldVerticalSizeDelta = (lineItem.transform).sizeDelta
    oldVerticalSizeDelta.y = maxPosY - minPosY + self.lineSizeDeltaY -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'
    ;
    (lineItem.transform).sizeDelta = oldVerticalSizeDelta
    local oldVerticalPos = (lineItem.transform).localPosition
    oldVerticalPos.y = (minPosY + maxPosY) / 2 - self.verticalCurPosY -- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'
    ;
    (lineItem.transform).localPosition = oldVerticalPos
end

UIEpETrack.SetTrunkLinePass = function(self, lineState, color, height)
    -- function num : 0_8 , upvalues : ExplorationEnum
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

UIEpETrack.SetForkLinePass = function(self, forkRoom, mapCtrl, lineState, color,
                                      height)
    -- function num : 0_9 , upvalues : ExplorationEnum, _ENV
    local lineItem = (self.forkLineDic)[forkRoom.position]
    do
        if lineItem ~= nil then
            local sizeDelta = (lineItem.transform).sizeDelta
            if lineState == (ExplorationEnum.eTrackLineState).Pass then
                lineItem.color = color
                sizeDelta.y = height
            else
                if lineState == (ExplorationEnum.eTrackLineState).Auto then
                    lineItem.color = ExplorationEnum.LineAutoModeColor
                    sizeDelta.y = height
                else
                    lineItem.color = self.lineDefaultColor
                    sizeDelta.y = self.lineDefaultHeight
                end
            end -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'
            
            (lineItem.transform).sizeDelta = sizeDelta
        end
        if lineState == (ExplorationEnum.eTrackLineState).Normal then
            if forkRoom.position == self.curForkLineRoomPos then
                self:__ResetDynLine()
                self.curForkLineRoomPos = nil
            end
            return
        end
        self.curForkLineRoomPos = forkRoom.position
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R7 in 'UnsetPending'

        if lineState == (ExplorationEnum.eTrackLineState).Pass then
            (self.verticalLineCenter).color = color
        else
            -- DECOMPILER ERROR at PC51: Confused about usage of register: R7 in 'UnsetPending'


            (self.verticalLineCenter).color = ExplorationEnum.LineAutoModeColor
        end
        if #self.forkRoomList <= 1 then return end
        local roomIndex = nil
        for k, roomData in ipairs(self.forkRoomList) do
            if roomData == forkRoom then
                roomIndex = k
                break
            end
        end
        do
            if roomIndex == nil then return end
            local uiForkRoom = mapCtrl:GetRoomUI(forkRoom.position)
            if uiForkRoom == nil then return end
            local forRoomPosY =
                ((((self.verticalLineCenter).transform).parent):InverseTransformPoint(
                    (uiForkRoom.transform).position)).y
            local curVerticalMinPosY = (math.min)(self.verticalCurPosY,
                                                  forRoomPosY)
            local curVerticalMaxPosY = (math.max)(self.verticalCurPosY,
                                                  forRoomPosY)
            self:SetVerticalLineSizePos(self.verticalLineCenter,
                                        curVerticalMinPosY, curVerticalMaxPosY)
            local sizeDelta = ((self.verticalLineCenter).transform).sizeDelta
            sizeDelta.x = height -- DECOMPILER ERROR at PC106: Confused about usage of register: R13 in 'UnsetPending'
            ;
            ((self.verticalLineCenter).transform).sizeDelta = sizeDelta
            if roomIndex > 1 then
                ((self.verticalLineDown).gameObject):SetActive(true)
                local tmpVerticalMinPosY = self.verticalMinPosY
                local tmpVerticalMaxPosY = curVerticalMinPosY
                self:SetVerticalLineSizePos(self.verticalLineDown,
                                            tmpVerticalMinPosY,
                                            tmpVerticalMaxPosY)
            else
                do

                    ((self.verticalLineDown).gameObject):SetActive(false)
                    if roomIndex < #self.forkRoomList then
                        ((self.verticalLineUp).gameObject):SetActive(true)
                        local tmpVerticalMinPosY = curVerticalMaxPosY
                        local tmpVerticalMaxPosY = self.verticalMaxPosY
                        self:SetVerticalLineSizePos(self.verticalLineUp,
                                                    tmpVerticalMinPosY,
                                                    tmpVerticalMaxPosY)
                    else
                        do

                            ((self.verticalLineUp).gameObject):SetActive(false)
                        end
                    end
                end
            end
        end
    end
end

UIEpETrack.SetTrunkLineActive = function(self)
    -- function num : 0_10
    (((self.ui).img_Trunk).gameObject):SetActive((self.roomData):GetVisible())
end

UIEpETrack.SetForkLineActive = function(self, roomData, mapCtrl)
    -- function num : 0_11 , upvalues : _ENV
    local lineItem = (self.forkLineDic)[roomData.position]
    if not IsNull(lineItem) then
        (lineItem.gameObject):SetActive(roomData:GetVisible())
    end
    for i = 1, #self.forkRoomList do
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

        if roomData == (self.forkRoomList)[i] and (self.forkRoomVisible)[i] ==
            false then
            (self.forkRoomVisible)[i] = true
            self:__ReCalcVerticalLen(mapCtrl)
            self:__ResetDynLine()
            break
        end
    end
end

UIEpETrack.GetTrackCrossingPos = function(self)
    -- function num : 0_12
    return (((self.ui).lineList).transform).position
end

return UIEpETrack

