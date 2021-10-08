local UINInfinityLevelCanvas = class("UINInfinityLevelCanvas", UIBaseNode)
local base = UIBaseNode
local UINInfinityLevelItem = require("Game.Sector.SectorLevel.UINInfinityLevelItem")
local ePlaceHolderType = (require("Game.Sector.Enum.SectorLevelInfinityEnum")).ePlaceHolderType
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local UINInfinityWheelItem = require("Game.Sector.SectorLevel.UINInfinityWheelItem")
UINInfinityLevelCanvas.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINInfinityWheelItem
  self.sectorId = nil
  self.tweenCompleteEvent = nil
  self.itemDic = {}
  self.levelDataList = {}
  self.bestRecordLevelData = nil
  self.bestCompleteLevelData = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopScrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopScrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopScrollRect).onReturnItem = BindCallback(self, self.__OnReturnItem)
  ;
  (((self.ui).loopScrollRect).onValueChanged):AddListener(BindCallback(self, self.__OnValueChange))
  self.wheel = (UINInfinityWheelItem.New)()
  ;
  (self.wheel):Init((self.ui).wheel)
  ;
  (((self.ui).switchTween).onComplete):AddListener(BindCallback(self, self.OnSwitchTweenComplete))
  ;
  (((self.ui).switchTween).onRewind):AddListener(BindCallback(self, self.OnSwitchTweenRewind))
  self._OnclickLevelItem = BindCallback(self, self.OnclickLevelItem)
  -- DECOMPILER ERROR at PC80: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).obj_OnItemSelect = ((((self.ui).obj_arrows).transform).parent).gameObject
end

UINInfinityLevelCanvas.InitInfinityLevelCanvas = function(self, sectorId, autoStateCfg, isUnCompleteEp, tweenCompleteEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.sectorId = sectorId
  self.tweenCompleteEvent = tweenCompleteEvent
  if isUnCompleteEp then
    self.lastEpStateCfg = autoStateCfg
  else
    self.lastEpStateCfg = nil
  end
  local locateStageIndex, isWin = nil, nil
  if (PlayerDataCenter.sectorStage).lastSatgeData ~= nil then
    locateStageIndex = (((PlayerDataCenter.sectorStage).lastSatgeData).stageCfg).index
    isWin = ((PlayerDataCenter.sectorStage).lastSatgeData).isWin
  else
    if autoStateCfg ~= nil then
      locateStageIndex = (autoStateCfg.endlessCfg).index
      isWin = false
    end
  end
  self.levelDataList = {}
  self:GenLevels(locateStageIndex, isWin)
end

UINInfinityLevelCanvas.RefreshUncompletedEp = function(self, lastEpStateCfg)
  -- function num : 0_2
  if self.lastEpStateCfg ~= nil then
    local lastIndex = ((self.lastEpStateCfg).endlessCfg).index
    self.lastEpStateCfg = lastEpStateCfg
    self.levelDataList = {}
    self:GenLevels(lastIndex)
  end
end

UINInfinityLevelCanvas.SetBackground = function(self, texture)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).Img_background).texture = texture
end

UINInfinityLevelCanvas.GenLevels = function(self, selectIndex, justRollto)
  -- function num : 0_4 , upvalues : _ENV, ePlaceHolderType
  local maxReachedIndex = 0
  local maxCompletedIndex = 0
  local notCompleteLevelIndex = nil
  if (ConfigData.endless)[self.sectorId] == nil then
    error("can\'t read endlessCfg with")
    return 
  end
  for index,cfg in ipairs((ConfigData.endless)[self.sectorId]) do
    local isUnlock = ((CheckCondition.CheckLua)(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2))
    local lockInfo = nil
    if not isUnlock then
      lockInfo = (CheckCondition.GetUnlockInfoLua)(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
    end
    local isForbid = false
    local forbidInfo = nil
    if self.lastEpStateCfg ~= nil then
      if cfg.id == (self.lastEpStateCfg).dungeonId then
        isForbid = false
        notCompleteLevelIndex = index
      else
        isForbid = true
        forbidInfo = (string.format)(ConfigData:GetTipContent(TipContent.Sector_IsExploringOtherSector2endless), (LanguageUtil.GetLocaleText)(((self.lastEpStateCfg).endlessCfg).name), tostring(((self.lastEpStateCfg).endlessCfg).index * 10) .. "m")
      end
    end
    local isComplete = (PlayerDataCenter.infinityData):IsInfinityDungeonCompleted(cfg.id)
    local passNum = 0
    passNum = isComplete or (PlayerDataCenter.infinityData):GetInfinityDungeonProcess(cfg.id) or 0
    ;
    (table.insert)(self.levelDataList, {index = index, cfg = cfg, isUnlock = isUnlock, isForbid = isForbid, isComplete = isComplete, passNum = passNum, lockInfo = lockInfo, forbidInfo = forbidInfo})
    if isComplete or passNum > 0 then
      maxReachedIndex = index
    end
    if isComplete then
      maxCompletedIndex = index
    end
  end
  self.bestRecordLevelData = (self.levelDataList)[maxReachedIndex]
  self.bestCompleteLevelData = (self.levelDataList)[maxCompletedIndex]
  ;
  (table.insert)(self.levelDataList, 1, {isPlaceHoleder = true, placeHolederType = ePlaceHolderType.Top})
  ;
  (table.insert)(self.levelDataList, 1, {isPlaceHoleder = true, placeHolederType = ePlaceHolderType.None})
  ;
  (table.insert)(self.levelDataList, {isPlaceHoleder = true, placeHolederType = ePlaceHolderType.Down})
  ;
  (table.insert)(self.levelDataList, {isPlaceHoleder = true, placeHolederType = ePlaceHolderType.None})
  local num = #self.levelDataList
  -- DECOMPILER ERROR at PC156: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).loopScrollRect).totalCount = num
  ;
  ((self.ui).loopScrollRect):RefillCells()
  local viewSizeY = (((self.ui).loopScrollRect).sizeOfviewRect).y
  local elementSizeY = ((self.ui).loopScrollRect):sizeOfItem(1)
  self.rollOffset = viewSizeY / elementSizeY // 2 - 1
  ;
  (self.wheel):InitWheel(num, viewSizeY, elementSizeY)
  if selectIndex then
    self:Refill2TargetIndex(selectIndex)
    if not justRollto then
      local item = self:__GetItemGoByIndex(selectIndex - 1)
      if item ~= nil then
        item:OnClick()
      end
    end
  else
    do
      if notCompleteLevelIndex ~= nil then
        self:Refill2TargetIndex(notCompleteLevelIndex)
        local item = self:__GetItemGoByIndex(notCompleteLevelIndex - 1)
        if item ~= nil then
          item:OnClick()
        end
      else
        do
          self:Roll2TargetIndex()
          self:TryShowJumpLevelReward()
        end
      end
    end
  end
end

UINInfinityLevelCanvas.__OnNewItem = function(self, go)
  -- function num : 0_5 , upvalues : UINInfinityLevelItem
  local levelItem = (UINInfinityLevelItem.New)()
  levelItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = levelItem
end

UINInfinityLevelCanvas.__OnChangeItem = function(self, go, index)
  -- function num : 0_6 , upvalues : _ENV
  local levelItem = (self.itemDic)[go]
  if levelItem == nil then
    error("Can\'t find levelItem by gameObject")
    return 
  end
  local levelData = (self.levelDataList)[index + 1]
  if levelData == nil then
    error("Can\'t find levelData by index, index = " .. tonumber(index))
    return 
  end
  if levelData.isPlaceHoleder then
    levelItem:InitPlaceHolder(levelData, (self.ui).obj_IsTop, (self.ui).obj_IsDown)
  else
    levelItem:InitInfinityLevel(levelData, self._OnclickLevelItem)
    if self.lastSelectData == levelData then
      self:m_MoveOnItemSelect(levelItem)
    end
    if self.bestRecordLevelData == levelData then
      self:m_MoveCurDepth(levelItem)
    end
  end
end

UINInfinityLevelCanvas.__OnReturnItem = function(self, go)
  -- function num : 0_7 , upvalues : _ENV
  local levelItem = (self.itemDic)[go]
  if levelItem == nil then
    error("Can\'t find levelItem by gameObject")
    return 
  end
  local levelData = levelItem.levelData
  if self.lastSelectData == levelData then
    ((self.ui).obj_OnItemSelect):SetActive(false)
    ;
    ((self.ui).obj_arrows):SetActive(false)
  end
  if self.bestRecordLevelData == levelData then
    ((self.ui).obj_CurDepth):SetActive(false)
    ;
    (self.wheel):SetArrowActive(false)
  end
end

UINInfinityLevelCanvas.__OnValueChange = function(self, pos)
  -- function num : 0_8
  (self.wheel):RoteWheel(pos.y)
end

UINInfinityLevelCanvas.__GetItemGoByIndex = function(self, index, isRawIndex)
  -- function num : 0_9
  if not isRawIndex then
    index = index + 2
  end
  local go = ((self.ui).loopScrollRect):GetCellByIndex(index)
  do
    if go ~= nil then
      local goodItem = (self.itemDic)[go]
      return goodItem
    end
    return nil
  end
end

UINInfinityLevelCanvas.OnclickLevelItem = function(self, levelData, levelItem)
  -- function num : 0_10 , upvalues : _ENV
  if levelData.isPlaceHoleder then
    return 
  end
  self.lastSelectData = levelData
  ;
  (self.wheel):SetArrowActive(true)
  self:m_MoveOnItemSelect(levelItem)
  AudioManager:PlayAudioById(1038)
  self:ShowLevelDetailWindow(function(win)
    -- function num : 0_10_0 , upvalues : levelData, self
    levelData.bestCompleteLevelData = self.bestCompleteLevelData
    win:InitInfinityLevelDetailNode(self.sectorId, levelData)
  end
)
end

UINInfinityLevelCanvas.m_MoveOnItemSelect = function(self, levelItem)
  -- function num : 0_11 , upvalues : _ENV
  (((self.ui).obj_OnItemSelect).transform):SetParent(((levelItem.ui).obj_selectNode).transform)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).obj_OnItemSelect).transform).anchoredPosition = (Vector2.New)(0, 0)
  ;
  ((self.ui).obj_OnItemSelect):SetActive(true)
  ;
  ((self.ui).obj_arrows):SetActive(true)
end

UINInfinityLevelCanvas.m_MoveCurDepth = function(self, levelItem)
  -- function num : 0_12 , upvalues : _ENV
  (((self.ui).obj_CurDepth).transform):SetParent(((levelItem.ui).obj_curDepthNode).transform)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).obj_CurDepth).transform).anchoredPosition = (Vector2.New)(0, 0)
  ;
  ((self.ui).obj_CurDepth):SetActive(true)
end

UINInfinityLevelCanvas.ShowLevelDetailWindow = function(self, callback)
  -- function num : 0_13 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevelDetail, function(win)
    -- function num : 0_13_0 , upvalues : self, callback
    local width, duration = win:GetLevelDetailWidthAndDuration()
    win:SetLevelDetaiHideStartEvent(function()
      -- function num : 0_13_0_0 , upvalues : self, width, duration
      ((self.ui).obj_OnItemSelect):SetActive(false)
      ;
      (self.wheel):SetArrowActive(false)
      self:PlayMoveLeftTween(false, width, duration)
      self.lastSelectData = nil
    end
)
    self:PlayMoveLeftTween(true, width, duration)
    callback(win)
  end
)
end

UINInfinityLevelCanvas.Roll2TargetIndex = function(self, index)
  -- function num : 0_14 , upvalues : _ENV
  if self.bestRecordLevelData == nil then
    return 
  end
  local targetIndex = nil
  if index == nil then
    targetIndex = (self.bestRecordLevelData).index - self.rollOffset
    if targetIndex < 0 then
      targetIndex = 0
    end
  else
    if index < 0 or (self.bestRecordLevelData).index <= index then
      error("can\'t roll to index " .. tostring(index))
      targetIndex = 0
    else
      targetIndex = index - self.rollOffset
    end
  end
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  ;
  ((self.ui).loopScrollRect):SrollToCell(targetIndex, 8000, function()
    -- function num : 0_14_0 , upvalues : _ENV, index, self, targetIndex
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    if index == nil or index == #(ConfigData.endless)[self.sectorId] then
      return 
    end
    ;
    ((self.ui).loopScrollRect):RefillCells(targetIndex)
  end
)
end

UINInfinityLevelCanvas.Refill2TargetIndex = function(self, index)
  -- function num : 0_15
  local targetIndex = index - self.rollOffset
  if targetIndex < 0 then
    targetIndex = 0
  end
  ;
  ((self.ui).loopScrollRect):RefillCells(targetIndex)
end

UINInfinityLevelCanvas.TryShowJumpLevelReward = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local items = (PlayerDataCenter.infinityData):GetJumpLevelReward(self.sectorId)
  ;
  (PlayerDataCenter.infinityData):CleanJumpLevelReward(self.sectorId)
  if items == nil then
    return 
  end
  local ids = {}
  local nums = {}
  for itemId,itemNum in pairs(items) do
    (table.insert)(ids, itemId)
    ;
    (table.insert)(nums, itemNum)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_16_0 , upvalues : ids, nums
    if window == nil then
      return 
    end
    window:InitRewardsItem(ids, nums, nil)
  end
)
end

UINInfinityLevelCanvas.PlayDiffLevelCanvasSwitchTween = function(self, isUpTween)
  -- function num : 0_17 , upvalues : _ENV
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

UINInfinityLevelCanvas.OnSwitchTweenComplete = function(self)
  -- function num : 0_18
  if self.__isBackwardsTween then
    return 
  end
  self:OnSwitchTweenEndEvent()
end

UINInfinityLevelCanvas.OnSwitchTweenRewind = function(self)
  -- function num : 0_19
  if not self.__isBackwardsTween then
    return 
  end
  self.__isBackwardsTween = false
  self:OnSwitchTweenEndEvent()
end

UINInfinityLevelCanvas.OnSwitchTweenEndEvent = function(self)
  -- function num : 0_20 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  ;
  ((self.ui).switchTween):DORewind()
  if self.tweenCompleteEvent ~= nil then
    (self.tweenCompleteEvent)()
  end
end

UINInfinityLevelCanvas.PlayMoveLeftTween = function(self, isLeft, offset, duration)
  -- function num : 0_21 , upvalues : _ENV
  do
    if self.__moveLeftTween == nil then
      local endValue = (Vector2.unity_vector2)(1 - offset / ((self.transform).rect).width, 1)
      self.__moveLeftTween = (((self.ui).UI_SectorLevel):DOAnchorMax(endValue, duration)):SetAutoKill(false)
    end
    do
      if self.__moveLeftTween2 == nil then
        local endValue2 = (Vector2.unity_vector2)(offset / ((self.transform).rect).width / 2, 0)
        self.__moveLeftTween2 = (((self.ui).ui_wheel):DOAnchorMin(endValue2, duration)):SetAutoKill(false)
      end
      if isLeft then
        (self.__moveLeftTween):PlayForward()
        ;
        (self.__moveLeftTween2):PlayForward()
      else
        ;
        (self.__moveLeftTween):PlayBackwards()
        ;
        (self.__moveLeftTween2):PlayBackwards()
      end
    end
  end
end

UINInfinityLevelCanvas.OnHide = function(self)
  -- function num : 0_22
  ((self.ui).obj_OnItemSelect):SetActive(false)
  ;
  ((self.ui).obj_arrows):SetActive(false)
  ;
  ((self.ui).obj_CurDepth):SetActive(false)
end

UINInfinityLevelCanvas.OnDelete = function(self)
  -- function num : 0_23 , upvalues : base
  if self.__moveLeftTween ~= nil then
    (self.__moveLeftTween):Kill()
    self.__moveLeftTween = nil
  end
  if self.__moveLeftTween2 ~= nil then
    (self.__moveLeftTween2):Kill()
    self.__moveLeftTween2 = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINInfinityLevelCanvas

