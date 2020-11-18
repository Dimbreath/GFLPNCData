-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDiffLevelCanvas = class("UINDiffLevelCanvas", UIBaseNode)
local base = UIBaseNode
local UINLevelGroup = require("Game.Sector.SectorLevel.UINLevelGroup")
local LoopVerticalScrollRect = ((CS.UnityEngine).UI).LoopVerticalScrollRect
local LoopHorizontalScrollRect = ((CS.UnityEngine).UI).LoopHorizontalScrollRect
local CS_Ease = ((CS.DG).Tweening).Ease
UINDiffLevelCanvas.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__levelGroupUI = {}
  ;
  (UIUtil.LuaUIBindingTable)(((self.ui).levelGroup).transform, self.__levelGroupUI)
  ;
  (UIUtil.AddButtonListener)((self.ui).contentVertical, self, self.__OnClickBg)
  ;
  (UIUtil.AddButtonListener)((self.ui).contentHorizontal, self, self.__OnClickBg)
  self.__inited = false
  ;
  (((self.ui).switchTween).onComplete):AddListener(BindCallback(self, self.OnSwitchTweenComplete))
  ;
  (((self.ui).switchTween).onRewind):AddListener(BindCallback(self, self.OnSwitchTweenRewind))
  self.scrollItemGoDic = {}
end

UINDiffLevelCanvas.InitDiffLevelCanvas = function(self, sectorId, lastEpStateCfg, difficulty, levelItemClickEvent, levelAvgMainClickEvent, lAvgSubClickEvent, tweenCompleteEvent, resLoader, sectorLevelTipsGuides, clickBackFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.sectorId = sectorId
  self.lastEpStateCfg = lastEpStateCfg
  self.difficulty = difficulty
  self.levelItemClickEvent = levelItemClickEvent
  self.levelAvgMainClickEvent = levelAvgMainClickEvent
  self.lAvgSubClickEvent = lAvgSubClickEvent
  self.tweenCompleteEvent = tweenCompleteEvent
  self.resLoader = resLoader
  self.sectorLevelTipsGuides = sectorLevelTipsGuides
  self.clickBackFunc = clickBackFunc
  local sectorCfg = (ConfigData.sector)[sectorId]
  local levelArrangeType = (sectorCfg.level_arrange)[difficulty]
  local arrangeCfg = (ConfigData.level_arrange)[levelArrangeType]
  if arrangeCfg == nil then
    error((string.format)("Can\'t find level arrange Cfg,arrangeId:%s, difficulty:%s, sectorId:%s", levelArrangeType, difficulty, sectorId))
    return 
  end
  self.arrangeCfg = arrangeCfg
  self:InitLevelGroupData()
  local isVertical = (arrangeCfg[1]).vertical
  local verticalChange = self.isVertical ~= nil and self.isVertical ~= isVertical
  self.isVertical = isVertical
  if self.__inited and verticalChange then
    ((self.ui).scrollRect):ClearCells()
    local prefabSource = ((self.ui).scrollRect):GetPrefabSource()
    DestroyUnityObject((self.ui).scrollRect, true)
    self:AddScrollRect(prefabSource)
  end
  self:AddScrollRect()
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R16 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC81: Confused about usage of register: R16 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R16 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.__inited = true
  self:RefillScrollRect()
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINDiffLevelCanvas.SetBackground = function(self, texture)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).Img_background).texture = texture
end

UINDiffLevelCanvas.InitLevelGroupData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local levelGroupDataList = {}
  local groupCount = #self.arrangeCfg
  self.lastCompletedStage = {groupIndex = nil, index = nil}
  local index = 0
  local groupIndex = 0
  local tempList = {}
  local stageCount = 0
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local AddTempListFunc = function(cfg, isState)
    -- function num : 0_3_0 , upvalues : stageCount, index, groupCount, tempList, groupIndex, _ENV, levelGroupDataList, self, avgPlayCtrl
    stageCount = stageCount + 1
    if groupCount < index + 1 then
      index = 0
      tempList = {}
    end
    if index == 0 then
      groupIndex = groupIndex + 1
      ;
      (table.insert)(levelGroupDataList, tempList)
      tempList.startIndex = stageCount
    end
    index = index + 1
    local tab = {}
    if isState then
      tab.stageCfg = cfg
    else
      tab.avgCfg = cfg
    end
    ;
    (table.insert)(tempList, tab)
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

    if self.lastEpStateCfg ~= nil and isState and cfg.id == (self.lastEpStateCfg).id then
      (self.lastCompletedStage).groupIndex = groupIndex
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.lastCompletedStage).index = index
    end
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R3 in 'UnsetPending'

    if (isState and (PlayerDataCenter.sectorStage):IsStageComplete(cfg.id)) or not isState and avgPlayCtrl:IsAvgPlayed(cfg.id) then
      (self.lastCompletedStage).groupIndex = groupIndex
      -- DECOMPILER ERROR at PC78: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.lastCompletedStage).index = index
    end
  end

  local sectorStageCfg = (((ConfigData.sector_stage).sectorDiffDic)[self.sectorId])[self.difficulty]
  for k,stageId in ipairs(sectorStageCfg) do
    local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 1)
    if avgCfg ~= nil then
      AddTempListFunc(avgCfg, false)
    end
    local stage = (ConfigData.sector_stage)[stageId]
    AddTempListFunc(stage, true)
    avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 2)
    if avgCfg ~= nil then
      AddTempListFunc(avgCfg, false)
    end
  end
  self.stageCount = stageCount
  self.levelGroupDataList = levelGroupDataList
end

UINDiffLevelCanvas.AddScrollRect = function(self, prefabSource)
  -- function num : 0_4 , upvalues : _ENV, LoopVerticalScrollRect, LoopHorizontalScrollRect
  ((self.ui).scrollRectGo):SetActive(false)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  if self.isVertical then
    (self.ui).scrollRect = ((self.ui).scrollRectGo):AddComponent(typeof(LoopVerticalScrollRect))
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).scrollRect).horizontal = false
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).scrollRect).content = ((self.ui).contentVertical).transform
  else
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.ui).scrollRect = ((self.ui).scrollRectGo):AddComponent(typeof(LoopHorizontalScrollRect))
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).scrollRect).vertical = false
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).scrollRect).content = ((self.ui).contentHorizontal).transform
  end
  if prefabSource == nil then
    ((self.ui).scrollRect):SetPrefab((self.ui).levelGroup)
  else
    ;
    ((self.ui).scrollRect):SetPrefabSource(prefabSource)
  end
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).rubberScale = 0.4
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).newItemBoundOffset = (self.__levelGroupUI).padding
  ;
  ((self.ui).scrollRectGo):SetActive(true)
end

UINDiffLevelCanvas.LocationSectorStageItem = function(self, id, isAvg)
  -- function num : 0_5 , upvalues : _ENV
  if not isAvg then
    isAvg = false
  end
  for groupIndex,group in pairs(self.levelGroupDataList) do
    for index,data in ipairs(group) do
      do
        -- DECOMPILER ERROR at PC23: Unhandled construct in 'MakeBoolean' P1

        if isAvg and data.avgCfg ~= nil and (data.avgCfg).id == id then
          local groupItem = self:GetLevelGroupItemByIndex(groupIndex)
          if groupItem ~= nil then
            return groupItem:GetLevelItemByIndex(index), groupItem
          end
          return nil, nil
        end
        -- DECOMPILER ERROR at PC41: Confused about usage of register: R13 in 'UnsetPending'

        if data.stageCfg ~= nil and (data.stageCfg).id == id then
          (self.lastCompletedStage).groupIndex = groupIndex
          -- DECOMPILER ERROR at PC43: Confused about usage of register: R13 in 'UnsetPending'

          ;
          (self.lastCompletedStage).index = index
          self:RefillScrollRect()
          local groupItem = self:GetLevelGroupItemByIndex(groupIndex)
          if groupItem ~= nil then
            return groupItem:GetLevelItemByIndex(index), groupItem
          end
          return nil, nil
        end
        do
          -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
end

UINDiffLevelCanvas.SetSectorStageItemRedDot = function(self, stageId, show)
  -- function num : 0_6 , upvalues : _ENV
  for groupIndex,group in pairs(self.levelGroupDataList) do
    for index,data in ipairs(group) do
      if data.stageCfg ~= nil and (data.stageCfg).id == stageId then
        local groupItem = self:GetLevelGroupItemByIndex(groupIndex)
        do
          do
            if groupItem ~= nil then
              local levelItem = groupItem:GetLevelItemByIndex(index)
              if levelItem ~= nil then
                levelItem:ShowRedDotLevelItem(show)
              end
            end
            do return  end
            -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

UINDiffLevelCanvas.SetSectorLAvgMainItemRedDot = function(self, avgId, show)
  -- function num : 0_7 , upvalues : _ENV
  for groupIndex,group in pairs(self.levelGroupDataList) do
    for index,data in ipairs(group) do
      if data.avgCfg ~= nil and (data.avgCfg).id == avgId then
        local groupItem = self:GetLevelGroupItemByIndex(groupIndex)
        do
          do
            if groupItem ~= nil then
              local lAvgMainItem = groupItem:GetLevelItemByIndex(index)
              if lAvgMainItem ~= nil then
                lAvgMainItem:ShowRedDotLAvgMain(show)
              end
            end
            do return  end
            -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

UINDiffLevelCanvas.RefillScrollRect = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local index = (self.lastCompletedStage).index or 1
  local groupIndex = (self.lastCompletedStage).groupIndex or 1
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).totalCount = #self.levelGroupDataList
  local indexOffset = groupIndex - 1
  local posOffset = 0
  do
    if index > 1 then
      local pos = ((self.arrangeCfg)[index]).pos
      if self.isVertical then
        posOffset = -pos[2] - (self.__levelGroupUI).padding
      else
        posOffset = pos[1] - (self.__levelGroupUI).padding
      end
    end
    local remainLength = 0
    for i = groupIndex, #self.levelGroupDataList do
      local grouDatas = (self.levelGroupDataList)[i]
      local lastArrage = (self.arrangeCfg)[#grouDatas]
      if not self.isVertical or not (lastArrage.pos)[2] then
        local endPos = (lastArrage.pos)[1]
      end
      remainLength = remainLength + (math.abs)(endPos) + (self.__levelGroupUI).padding
    end
    remainLength = remainLength - (posOffset)
    if not self.isVertical or not ((self.transform).rect).height then
      local viewLength = ((self.transform).rect).width
    end
    if viewLength < remainLength then
      ((self.ui).scrollRect):RefillCells(indexOffset, posOffset)
    else
      ;
      ((self.ui).scrollRect):RefillCellsFromEnd()
    end
  end
end

UINDiffLevelCanvas.__OnNewItem = function(self, go)
  -- function num : 0_9 , upvalues : UINLevelGroup
  local item = (UINLevelGroup.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.scrollItemGoDic)[go] = item
end

UINDiffLevelCanvas.__OnReturnItem = function(self, go)
  -- function num : 0_10 , upvalues : _ENV
  local item = (self.scrollItemGoDic)[go]
  if item == nil then
    error("OnReturnItem : Can\'t find item by gameObject")
    return 
  end
  item:OnReturnLevelGroup()
end

UINDiffLevelCanvas.__OnChangeItem = function(self, go, index)
  -- function num : 0_11 , upvalues : _ENV
  self.scrollRectIndex = index
  local item = (self.scrollItemGoDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  local levelGroupData = (self.levelGroupDataList)[index + 1]
  if levelGroupData == nil then
    error("Can\'t find levelGroupData by index, index = " .. tonumber(index))
    return 
  end
  item:InitLevelGroup(levelGroupData, self.lastEpStateCfg, self.arrangeCfg, (self.ui).lineHolder, (self.ui).bgHolder, self.stageCount, self.levelItemClickEvent, self.levelAvgMainClickEvent, self.lAvgSubClickEvent, self.resLoader, self.sectorLevelTipsGuides)
  for k,v in ipairs(levelGroupData) do
    if v.stageCfg ~= nil then
      local levelItem = item:GetLevelItemByIndex(k)
      if levelItem ~= nil then
        local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, self.sectorId, self.difficulty, (v.stageCfg).id)
        if node:GetRedDotCount() <= 0 then
          do
            levelItem:ShowRedDotLevelItem(not ok)
            if v.avgCfg ~= nil then
              local lAvgMainItem = item:GetLevelItemByIndex(k)
              if lAvgMainItem ~= nil then
                local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, self.sectorId, self.difficulty, RedDotStaticTypeId.MainAvg, (v.avgCfg).id)
                if node:GetRedDotCount() <= 0 then
                  do
                    lAvgMainItem:ShowRedDotLAvgMain(not ok)
                    -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINDiffLevelCanvas.GetLevelGroupItemByIndex = function(self, index)
  -- function num : 0_12
  local go = ((self.ui).scrollRect):GetCellByIndex(index - 1)
  return (self.scrollItemGoDic)[go]
end

UINDiffLevelCanvas.RefreshUncompletedEp = function(self, lastEpStateCfg)
  -- function num : 0_13 , upvalues : _ENV
  self.lastEpStateCfg = lastEpStateCfg
  for k,v in ipairs(self.levelGroupDataList) do
    local groupItem = self:GetLevelGroupItemByIndex(k)
    if groupItem ~= nil then
      groupItem:RefreshUncompletedEp(lastEpStateCfg)
    end
  end
end

UINDiffLevelCanvas.RefreshLevelState = function(self)
  -- function num : 0_14 , upvalues : _ENV
  for k,v in ipairs(self.levelGroupDataList) do
    local groupItem = self:GetLevelGroupItemByIndex(k)
    if groupItem ~= nil then
      groupItem:RefreshLevelItemState()
    end
  end
end

UINDiffLevelCanvas.PlayDiffLevelCanvasSwitchTween = function(self, isUpTween)
  -- function num : 0_15 , upvalues : _ENV
  ((self.gameObject).transform):SetAsLastSibling()
  if isUpTween then
    ((self.ui).switchTween):DORestart()
  else
    self.__isBackwardsTween = true
    ;
    ((self.ui).switchTween):DOComplete()
    ;
    ((self.ui).switchTween):DOPlayBackwards()
  end
  local continueWindow = UIManager:ShowWindow(UIWindowTypeID.ClickContinue)
  continueWindow:InitContinue(nil, nil, nil, Color.clear, false)
end

UINDiffLevelCanvas.OnSwitchTweenComplete = function(self)
  -- function num : 0_16
  if self.__isBackwardsTween then
    return 
  end
  self:OnSwitchTweenEndEvent()
end

UINDiffLevelCanvas.OnSwitchTweenRewind = function(self)
  -- function num : 0_17
  if not self.__isBackwardsTween then
    return 
  end
  self.__isBackwardsTween = false
  self:OnSwitchTweenEndEvent()
end

UINDiffLevelCanvas.OnSwitchTweenEndEvent = function(self)
  -- function num : 0_18 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  ;
  ((self.ui).switchTween):DORewind()
  if self.tweenCompleteEvent ~= nil then
    (self.tweenCompleteEvent)()
  end
end

UINDiffLevelCanvas.PlayDiffLevelContentTween = function(self, duration)
  -- function num : 0_19 , upvalues : CS_Ease
  if not self.isVertical then
    return 
  end
  if self.contentVerticalTween ~= nil then
    (self.contentVerticalTween):Kill()
  end
  self.contentVerticalTween = ((((self.ui).contentVertical).transform):DOAnchorPosX(0, duration)):SetEase(CS_Ease.InQuad)
end

UINDiffLevelCanvas.__OnClickBg = function(self)
  -- function num : 0_20
  if self.clickBackFunc ~= nil then
    (self.clickBackFunc)()
  end
end

UINDiffLevelCanvas.OnDelete = function(self)
  -- function num : 0_21 , upvalues : _ENV, base
  if self.contentVerticalTween ~= nil then
    (self.contentVerticalTween):Kill()
  end
  for k,v in pairs(self.scrollItemGoDic) do
    v:Delete()
  end
  self.resLoader = nil
  ;
  (base.OnDelete)(self)
end

return UINDiffLevelCanvas

