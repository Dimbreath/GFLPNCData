local UINStioListBase = require("Game.StrategyOverview.UI.UINStioListBase")
local UINStOCareerList = class("UINStOCareerList", UINStioListBase)
local base = UINStioListBase
local UINStOTechItem = require("Game.StrategyOverview.UI.StOList.UINStOTechItem")
local UINStOTechLineItem = require("Game.StrategyOverview.UI.StOList.UINStOTechLineItem")
UINStOCareerList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINStOTechItem, UINStOTechLineItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.techItemPool = (UIItemPool.New)(UINStOTechItem, (self.prefabUITable).prefab_techItem)
  self.techLinePool = (UIItemPool.New)(UINStOTechLineItem, (self.prefabUITable).prefab_obj_Line)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).rect).enabled = false
  self.__RefreshCostShow = BindCallback(self, self.RefreshCostShow)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RefreshCostShow)
end

UINStOCareerList.InitStOCareer = function(self, resLoader, techList)
  -- function num : 0_1 , upvalues : _ENV
  self.isInit = true
  self.resLoader = resLoader
  self:ResetTechItemDic()
  local afterBuildDic = {}
  local beforeBuildDic = {}
  local limitY = 0
  for k,techData in ipairs(techList) do
    local row = (((techData.buildingData).dynData).stcData).row
    local posIndex = (((techData.buildingData).dynData).stcData).strategy_career
    local pos = self:_GetTechPos(row, posIndex)
    local techItem = (self.techItemPool):GetOne()
    ;
    (techItem.transform):SetParent(((self.ui).rect).transform)
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (techItem.gameObject).name = tostring(k)
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (techItem.transform).anchoredPosition = pos
    local buildingData = techData.buildingData
    local edge = self:GetTechItemEdge(buildingData)
    techItem:InitStOTechItem(buildingData, resLoader, self, edge)
    self:AddTechItem(buildingData.id, techItem)
    if pos.y < limitY then
      limitY = pos.y
    end
    if techData.selected then
      self:SelectStOTechItem(techItem, techData.buildingData)
    end
    local preBuildingIds = (buildingData.dynData):GetPreBuildingId(1)
    for _,preBuildingId in ipairs(preBuildingIds) do
      local childList = afterBuildDic[preBuildingId]
      if childList == nil then
        childList = {}
        afterBuildDic[preBuildingId] = childList
      end
      ;
      (table.insert)(childList, techItem)
    end
    beforeBuildDic[buildingData.id] = preBuildingIds
  end
  self:_ResetRectSize(limitY)
  for id,beforeIds in pairs(beforeBuildDic) do
    if (table.count)(beforeIds) == 0 then
      beforeBuildDic[id] = nil
    else
      local beforeItems = {}
      for _,buildId in ipairs(beforeIds) do
        local item = self:GetTechItem(buildId)
        ;
        (table.insert)(beforeItems, item)
      end
      beforeBuildDic[id] = beforeItems
    end
  end
  self:_DrawLineNew(afterBuildDic, beforeBuildDic)
  for _,techItem in pairs(self.techItemDic) do
    techItem:InitStOTechItemLine()
  end
  self:RefreshCostShow()
end

UINStOCareerList._GetTechPos = function(self, row, posIndex)
  -- function num : 0_2 , upvalues : _ENV
  local padding = ((self.ui).rect).padding
  local cellSize = ((self.ui).rect).cellSize
  local spacing = ((self.ui).rect).spacing
  local x = padding.left + (posIndex - 0.5) * cellSize.x + spacing.x * (posIndex - 1)
  local y = (padding.top + (row - 0.5) * cellSize.y + spacing.y * (row - 1)) * -1
  return (Vector2.New)(x, y)
end

UINStOCareerList._ResetRectSize = function(self, limitY)
  -- function num : 0_3 , upvalues : _ENV
  local cellSize = ((self.ui).rect).cellSize
  local padding = ((self.ui).rect).padding
  local height = (math.abs)(limitY)
  height = height + cellSize.y / 2 + padding.bottom
  local rectTr = ((self.ui).rect):GetComponent(typeof((CS.UnityEngine).RectTransform))
  rectTr.sizeDelta = (Vector2.New)((rectTr.sizeDelta).x, height)
end

UINStOCareerList._DrawLineNew = function(self, afterBuildDic, beforeBuildDic)
  -- function num : 0_4 , upvalues : _ENV
  local buildXYDic = {}
  local pointXYDic = {}
  local CreateXYDicFunc = function(dic, x, y, val)
    -- function num : 0_4_0
    if dic[x] == nil then
      dic[x] = {}
    end
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

    if (dic[x])[y] == nil then
      (dic[x])[y] = val
    end
  end

  local GetXYDicFunc = function(dic, x, y)
    -- function num : 0_4_1
    if dic[x] == nil then
      return nil
    end
    return (dic[x])[y]
  end

  for buildId,_ in pairs(afterBuildDic) do
    local techItem = self:GetTechItem(buildId)
    local y = (((techItem.buildingData).dynData).stcData).row * 2
    local x = (((techItem.buildingData).dynData).stcData).strategy_career
    CreateXYDicFunc(buildXYDic, x, y, techItem)
    CreateXYDicFunc(pointXYDic, x, y, {x = x, y = y / 2})
  end
  for buildId,_ in pairs(beforeBuildDic) do
    local techItem = self:GetTechItem(buildId)
    local y = (((techItem.buildingData).dynData).stcData).row * 2
    local x = (((techItem.buildingData).dynData).stcData).strategy_career
    CreateXYDicFunc(buildXYDic, x, y, techItem)
    CreateXYDicFunc(pointXYDic, x, y, {x = x, y = y / 2})
  end
  for preBuildId,techItems in pairs(afterBuildDic) do
    local preTechItem = self:GetTechItem(preBuildId)
    local preRow = (((preTechItem.buildingData).dynData).stcData).row
    local pointIndex = (((preTechItem.buildingData).dynData).stcData).strategy_career
    if #techItems ~= 1 or ((((techItems[1]).buildingData).dynData).stcData).strategy_career ~= pointIndex then
      local topRow = nil
      for _,techItem in ipairs(techItems) do
        if topRow == nil or (((techItem.buildingData).dynData).stcData).row < topRow then
          topRow = (((techItem.buildingData).dynData).stcData).row
        end
      end
      local raw = topRow + preRow
      CreateXYDicFunc(pointXYDic, pointIndex, raw, {x = pointIndex, y = raw / 2})
      for _,techItem in ipairs(techItems) do
        local rearPointIndex = (((techItem.buildingData).dynData).stcData).strategy_career
        if rearPointIndex ~= pointIndex then
          CreateXYDicFunc(pointXYDic, rearPointIndex, raw, {x = rearPointIndex, y = raw / 2})
        end
      end
    end
  end
  local SeekPointFunc = function(startPoint, endPoint)
    -- function num : 0_4_2 , upvalues : _ENV, pointXYDic
    if startPoint ~= endPoint then
      error("同点 " .. tostring(endPoint.x) .. "," .. tostring(endPoint.y) .. "  " .. tostring(endPoint.x ~= startPoint.x or endPoint.y ~= startPoint.y))
      local isRow = nil
      if endPoint.x == startPoint.x then
        isRow = true
      elseif endPoint.y == startPoint.y then
        isRow = false
      else
        error("非同行也非同列 " .. tostring(endPoint.x) .. "," .. tostring(endPoint.y) .. "  " .. tostring(startPoint.x) .. "," .. tostring(startPoint.y))
      end
      if not isRow or not endPoint.y - startPoint.y then
        local sortMul = endPoint.x - startPoint.x
      end
      sortMul = sortMul > 0 and 1 or -1
      local points = {}
      if isRow then
        for _,point in pairs(pointXYDic[startPoint.x]) do
          (table.insert)(points, point)
        end
      else
        for x,Ypoints in pairs(pointXYDic) do
          if Ypoints[startPoint.y * 2] ~= nil then
            (table.insert)(points, Ypoints[startPoint.y * 2])
          end
        end
      end
      ;
      (table.sort)(points, function(a, b)
      -- function num : 0_4_2_0 , upvalues : isRow, sortMul
      if a.y * sortMul >= b.y * sortMul then
        do return not isRow end
        do return a.x * sortMul < b.x * sortMul end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
)
      local prePoint = nil
      for i,point in ipairs(points) do
        if point == startPoint then
          prePoint = point
        elseif prePoint ~= nil then
          local prePointDic = point.prePointDic
          if prePointDic == nil then
            prePointDic = {}
            point.prePointDic = prePointDic
          end
          prePointDic[prePoint] = true
          prePoint = point
        end
      end
      if point ~= endPoint then
        -- DECOMPILER ERROR: 18 unprocessed JMP targets
      end
    end
  end

  for preBuildId,techItems in pairs(afterBuildDic) do
    local preTechItem = self:GetTechItem(preBuildId)
    local startY = (((preTechItem.buildingData).dynData).stcData).row * 2
    local startX = (((preTechItem.buildingData).dynData).stcData).strategy_career
    if #techItems == 1 and ((((techItems[1]).buildingData).dynData).stcData).strategy_career == (((preTechItem.buildingData).dynData).stcData).strategy_career then
      local endTechItem = techItems[1]
      local endY = (((endTechItem.buildingData).dynData).stcData).row * 2
      local endX = (((endTechItem.buildingData).dynData).stcData).strategy_career
      SeekPointFunc((pointXYDic[startX])[startY], (pointXYDic[endX])[endY])
    else
      do
        local preRow = (((preTechItem.buildingData).dynData).stcData).row
        local topRow = nil
        for _,techItem in ipairs(techItems) do
          if topRow == nil or (((techItem.buildingData).dynData).stcData).row < topRow then
            topRow = (((techItem.buildingData).dynData).stcData).row
          end
        end
        local pointIndex = (((preTechItem.buildingData).dynData).stcData).strategy_career
        local raw = topRow + preRow
        local joinPoint = (pointXYDic[pointIndex])[raw]
        do
          local startPoint = (pointXYDic[pointIndex])[preRow * 2]
          SeekPointFunc(startPoint, joinPoint)
          for _,techItem in ipairs(techItems) do
            local rearPointIndex = (((techItem.buildingData).dynData).stcData).strategy_career
            local rearRow = (((techItem.buildingData).dynData).stcData).row * 2
            local endPoint = (pointXYDic[rearPointIndex])[rearRow]
            if rearPointIndex ~= pointIndex then
              local newJoinPoint = (pointXYDic[rearPointIndex])[raw]
              SeekPointFunc(joinPoint, newJoinPoint)
              SeekPointFunc(newJoinPoint, endPoint)
            else
              do
                do
                  SeekPointFunc(joinPoint, endPoint)
                  -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC264: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
          -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  local drawLineFunc = function(startPos, endPos)
    -- function num : 0_4_3 , upvalues : self
    local lineItem = (self.techLinePool):GetOne()
    lineItem:InitStOTechLineItem(startPos, endPos)
    ;
    (lineItem.transform):SetParent(((self.ui).lineObj).transform)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (lineItem.transform).anchoredPosition = startPos
    return lineItem
  end

  local CreateLineFunc = function(point)
    -- function num : 0_4_4 , upvalues : _ENV, GetXYDicFunc, buildXYDic, self, drawLineFunc
    if point.prePointDic == nil or (table.count)(point.prePointDic) == 0 then
      return 
    end
    local techItem = GetXYDicFunc(buildXYDic, point.x, point.y * 2)
    if techItem == nil or not techItem:GetStOTechItemUpPointPos() then
      local endPos = self:_GetTechPos(point.y, point.x)
    end
    point.prePointLineDic = {}
    for prePoint,_ in pairs(point.prePointDic) do
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R8 in 'UnsetPending'

      if prePoint.prePointLineDic ~= nil and (prePoint.prePointLineDic)[point] ~= nil then
        (point.prePointLineDic)[prePoint] = (prePoint.prePointLineDic)[point]
      else
        local preTechItem = GetXYDicFunc(buildXYDic, prePoint.x, prePoint.y * 2)
        if preTechItem == nil or not preTechItem:GetStOTechItemDownPointPos() then
          local startPos = self:_GetTechPos(prePoint.y, prePoint.x)
        end
        local line = drawLineFunc(startPos, endPos)
        -- DECOMPILER ERROR at PC67: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (point.prePointLineDic)[prePoint] = line
        prePoint.tech = preTechItem
      end
    end
    point.prePointDic = nil
  end

  self.pointDic = pointXYDic
  for x,Ypoints in pairs(self.pointDic) do
    for y,point in pairs(Ypoints) do
      -- DECOMPILER ERROR at PC290: Confused about usage of register: R20 in 'UnsetPending'

      if point.prePointDic == nil or (table.count)(point.prePointDic) == 0 then
        ((self.pointDic)[x])[y] = nil
      else
        CreateLineFunc(point)
      end
    end
  end
end

UINStOCareerList.RefreshLine = function(self, techItem, valid)
  -- function num : 0_5 , upvalues : _ENV
  local y = (((techItem.buildingData).dynData).stcData).row * 2
  local x = (((techItem.buildingData).dynData).stcData).strategy_career
  if self.pointDic == nil or (self.pointDic)[x] == nil or ((self.pointDic)[x])[y] == nil then
    return 
  end
  local techPoint = ((self.pointDic)[x])[y]
  if valid then
    local tempDic = {}
    do
      local Local_Unlock_RefreshLineItem = function(point, lastPoint)
    -- function num : 0_5_0 , upvalues : _ENV, Local_Unlock_RefreshLineItem
    if point.prePointLineDic == nil then
      return 
    end
    for prePoint,line in pairs(point.prePointLineDic) do
      line:RefreshStOTechLineItem(true)
      if prePoint ~= lastPoint then
        Local_Unlock_RefreshLineItem(prePoint, point)
      end
    end
  end

      Local_Unlock_RefreshLineItem(techPoint)
    end
  else
    do
      local preBuildUnlockDic = ((techItem.buildingData).dynData):GetPreBuildUnlockLevel(1)
      local count = 0
      local tmp = {}
      local Local_Lock_RefreshLineItem = function(point, lastPoint, isInFlip)
    -- function num : 0_5_1 , upvalues : techItem, preBuildUnlockDic, _ENV, Local_Lock_RefreshLineItem
    do return not ((point.tech).buildingData).level and preBuildUnlockDic[((point.tech).buildingData).id] <= point.tech == nil or point.tech == techItem or 0 end
    if point.prePointLineDic == nil then
      error(" Line data is error :tech and prePointLineDic is empty ")
      return false
    end
    local activate = true
    for prePoint,line in pairs(point.prePointLineDic) do
      local isLastPoint = prePoint == lastPoint
      local banGo = not isLastPoint or isInFlip
      if not isLastPoint then
        do
          local tempActivate = Local_Lock_RefreshLineItem(prePoint, point, banGo or isInFlip)
          line:RefreshStOTechLineItem(tempActivate)
          if not tempActivate then
            activate = tempActivate
          end
          -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    do return activate end
    -- DECOMPILER ERROR: 7 unprocessed JMP targets
  end

      Local_Lock_RefreshLineItem(techPoint)
    end
  end
end

UINStOCareerList.RefreshCostShow = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local costIds = (ConfigData.game_config).STOCareerCostIds
  for i,costText in ipairs((self.ui).headitemCountList) do
    if i <= #costIds then
      costText.text = PlayerDataCenter:GetItemCount(costIds[i])
    else
      costText.text = "0"
      error("game_config.STOCareerCostIds error")
    end
  end
end

UINStOCareerList.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  (self.techItemPool):DeleteAll()
  ;
  (self.techLinePool):DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RefreshCostShow)
  ;
  (base.OnDelete)(self)
end

return UINStOCareerList

