-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorLevel = class("UISectorLevel", UIBaseWindow)
local base = UIBaseWindow
local UINDifficultList = require("Game.Sector.SectorLevel.UINDifficultList")
local UINLevelDifficultItem = require("Game.Sector.SectorLevel.UINLevelDifficultItem")
local SectorTaskController = require("Game.Sector.SectorTask.New.SectorTaskController")
local cs_MessageCommon = CS.MessageCommon
UISectorLevel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDifficultList, SectorTaskController, UINLevelDifficultItem
  self.isFiffcultListHolderOpen = false
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SectorTask, self, self.__OnSectrorTaskClick)
  self.__onLevelItemClicked = BindCallback(self, self.OnLevelItemClicked)
  self.__onLevelAvgMainClicked = BindCallback(self, self.OnLevelAvgMainItemClicked)
  self.__onLevelAvgSubClickEvent = BindCallback(self, self.OnLevelAvgSubClicked)
  self.difficultListNode = (UINDifficultList.New)()
  ;
  (self.difficultListNode):Init((self.ui).difficultList)
  ;
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.OnClickBackBtn)
  self.__onHasUncompletedEp = BindCallback(self, self.UpdateUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  self.SectorTaskController = (SectorTaskController.New)()
  ;
  (self.SectorTaskController):OnInit()
  self.__lastEpStateCfg = ExplorationManager:TryGetUncompletedEpSectorStateCfg()
  self.poolDifficultItem = (UIItemPool.New)(UINLevelDifficultItem, (self.ui).btn_Difficult)
end

UISectorLevel.InitSectorLevel = function(self, sectorId, closeAction)
  -- function num : 0_1 , upvalues : _ENV, UINLevelDifficultItem
  if (PlayerDataCenter.sectorStage).lastSelectSector ~= sectorId then
    (PlayerDataCenter.sectorStage):InitSelectStage(sectorId)
  end
  self.id = sectorId
  self.sectorCfg = (ConfigData.sector)[self.id]
  self.__closeAction = closeAction
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_SectorName).text = (LanguageUtil.GetLocaleText)((self.sectorCfg).name)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_SectorNameEn).text = (LanguageUtil.GetLocaleText)((self.sectorCfg).name_en)
  ;
  (((self.ui).diffcultListHolder).gameObject):SetActive(false)
  self.onSelectDifficultyEvent = BindCallback(self, self.OnSelectDifficulty)
  local lastDifficulty = (PlayerDataCenter.sectorStage).lastSelectDiff
  self:__UpdateLevelDifficultItem(lastDifficulty)
  self.difficultBtn = (UINLevelDifficultItem.New)()
  ;
  (self.difficultBtn):Init((self.ui).btn_Difficult)
  ;
  (self.difficultBtn):InitLevelDiffItem(self.id, lastDifficulty, BindCallback(self, self.OnClickDifficulty))
  ;
  (self.difficultListNode):InitDifficeltLevel(sectorId, self.__lastEpStateCfg, self.__onLevelItemClicked, self.__onLevelAvgMainClicked, self.__onLevelAvgSubClickEvent, BindCallback(self, self.__ClickLevelListBgFunc))
  ;
  (self.SectorTaskController):InitCurrSectorData(self.id, self.sectorCfg)
  ;
  (self.SectorTaskController):SetWindowQuitEvent(BindCallback(self, self.__UpdataTaskProcessUI))
  self:__UpdataTaskProcessUI()
  self:__InitRedDotEvent()
  if not GuideManager:TryTriggerGuide(eGuideCondition.FInSectorLevel) or GuideManager:TryTriggerGuide(eGuideCondition.InSectorLevel) then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    avgPlayCtrl:TryPlayTaskAvg(4, nil)
    self:__InitRedDotEvent()
  end
end

UISectorLevel.__UpdateLevelDifficultItem = function(self, lastDifficulty)
  -- function num : 0_2 , upvalues : _ENV
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  if lastDifficulty == nil then
    lastDifficulty = (PlayerDataCenter.sectorStage).lastSelectDiff
  end
  ;
  (self.poolDifficultItem):HideAll()
  local isHardUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Hard)
  for i = 1, (ConfigData.sector_stage).difficultyCount do
    if lastDifficulty ~= i and (i ~= 2 or isHardUnlock) then
      local diffItem = (self.poolDifficultItem):GetOne()
      ;
      (diffItem.transform):SetParent(((self.ui).diffcultListHolder).transform)
      diffItem:InitLevelDiffItem(self.id, i, self.onSelectDifficultyEvent)
    end
  end
  local isInfinityUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Endless)
  if isInfinityUnlock and lastDifficulty ~= (ConfigData.sector_stage).difficultyCount + 1 then
    local diffItem = (self.poolDifficultItem):GetOne()
    ;
    (diffItem.transform):SetParent(((self.ui).diffcultListHolder).transform)
    diffItem:InitLevelDiffItem(self.id, (ConfigData.sector_stage).difficultyCount + 1, self.onSelectDifficultyEvent)
  end
end

UISectorLevel.OnLevelItemClicked = function(self, levelItem)
  -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
  local stageData = levelItem:GetLevelStageData()
  if not levelItem:IsLevelUnlock() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Sector_HaveToClearanceLastLevelToUnlock))
    return 
  end
  do
    if self.__lastEpStateCfg ~= nil and (self.__lastEpStateCfg).num ~= stageData.num then
      local levelInfo = tostring((self.__lastEpStateCfg).sector) .. "-" .. tostring((self.__lastEpStateCfg).num)
      ;
      (cs_MessageCommon.ShowMessageTips)((string.format)(ConfigData:GetTipContent(TipContent.Sector_IsExploringOtherSector), levelInfo))
      return 
    end
    local lastSelectLevelItem = (self.difficultListNode):GetSectorStageItem(self.selectLevelId)
    if lastSelectLevelItem ~= nil then
      lastSelectLevelItem:SeletedLevelItem(false, true)
      self.selectLevelId = nil
    end
    local selectLAvgMain = (self.difficultListNode):GetSectorLAvgMainItem(self.selectLAvgMainId)
    if selectLAvgMain ~= nil then
      selectLAvgMain:SelectedLAvgMain(false)
      self.selectLAvgMainId = nil
    end
    self.selectLevelId = stageData.id
    levelItem:SeletedLevelItem(true, true)
    self:ShowLevelDetailWindow(function(window)
    -- function num : 0_3_0 , upvalues : self, stageData
    window:InitSectorLevelDetail(self.id, stageData.id)
  end
)
  end
end

UISectorLevel.ShowLevelDetailWindow = function(self, callback)
  -- function num : 0_4 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevelDetail, function(window)
    -- function num : 0_4_0 , upvalues : self, callback
    window:SetLevelDetaiHideStartEvent(function()
      -- function num : 0_4_0_0 , upvalues : self
      (self.difficultListNode):PlayMoveLeftTween(false)
      local selectLevelItem = (self.difficultListNode):GetSectorStageItem(self.selectLevelId)
      if selectLevelItem ~= nil then
        selectLevelItem:SeletedLevelItem(false, true)
      end
    end
)
    window:SetLevelDetaiHideEndEvent(function()
      -- function num : 0_4_0_1 , upvalues : self
      if not self.__waitChangeDifficulty then
        return 
      end
      self.__waitChangeDifficulty = false
      ;
      (self.difficultListNode):ChangeLevelDifficulty(self.__difficulty)
    end
)
    local width, duration = window:GetLevelDetailWidthAndDuration()
    ;
    (self.difficultListNode):PlayMoveLeftTween(true, width, duration)
    self.levelDetailWindow = window
    callback(window)
  end
)
end

UISectorLevel.OnLevelAvgMainItemClicked = function(self, lAvgMainItem)
  -- function num : 0_5 , upvalues : cs_MessageCommon, _ENV
  local avgCfg = lAvgMainItem:GetLAvgMainCfg()
  if not lAvgMainItem:IsLAvgMainUnlock() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Sector_HaveToClearanceLastLevelToUnlock))
    return 
  end
  local selectLevelItem = (self.difficultListNode):GetSectorStageItem(self.selectLevelId)
  if selectLevelItem ~= nil then
    selectLevelItem:SeletedLevelItem(false, true)
    self.selectLevelId = nil
  end
  local selectLAvgMain = (self.difficultListNode):GetSectorLAvgMainItem(self.selectLAvgMainId)
  if selectLAvgMain ~= nil then
    selectLAvgMain:SelectedLAvgMain(false)
    self.selectLAvgMainId = nil
  end
  self.selectLAvgMainId = avgCfg.id
  lAvgMainItem:SelectedLAvgMain(true)
  self:ShowLevelDetailWindow(function(window)
    -- function num : 0_5_0 , upvalues : self, avgCfg
    window:InitSectorLevelAvgDetail(self.id, avgCfg, function()
      -- function num : 0_5_0_0 , upvalues : self
      (self.difficultListNode):RefreshCurDiffLevelState()
    end
)
  end
)
end

UISectorLevel.OnLevelAvgSubClicked = function(self, lAvgSubItem)
  -- function num : 0_6 , upvalues : _ENV
  local avgCfg = lAvgSubItem:GetLAvgSubCfg()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  if not avgPlayCtrl:IsAvgUnlock(avgCfg.id) then
    error("Avg is not unlock,avgId = " .. avgCfg.id)
    return 
  end
  local selectLevelItem = (self.difficultListNode):GetSectorStageItem(self.selectLevelId)
  if selectLevelItem ~= nil then
    selectLevelItem:SeletedLevelItem(false, true)
    self.selectLevelId = nil
  end
  local selectLAvgMain = (self.difficultListNode):GetSectorLAvgMainItem(self.selectLAvgMainId)
  if selectLAvgMain ~= nil then
    selectLAvgMain:SelectedLAvgMain(false)
    self.selectLAvgMainId = nil
  end
  self:ShowLevelDetailWindow(function(window)
    -- function num : 0_6_0 , upvalues : self, avgCfg, lAvgSubItem
    window:InitSectorLevelAvgDetail(self.id, avgCfg, function()
      -- function num : 0_6_0_0 , upvalues : lAvgSubItem
      lAvgSubItem:RefreshLAvgSubPlayed()
    end
)
  end
)
end

UISectorLevel.UpdateUncompletedEp = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self.__lastEpStateCfg = ExplorationManager:TryGetUncompletedEpSectorStateCfg()
  ;
  (self.difficultListNode):RefreshUncompletedEp(self.__lastEpStateCfg)
end

UISectorLevel.OnSelectDifficulty = function(self, difficulty)
  -- function num : 0_8 , upvalues : _ENV
  self.isFiffcultListHolderOpen = false
  ;
  (((self.ui).diffcultListHolder).gameObject):SetActive(false)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).img_DiffArrow).transform).localScale = (Vector3.New)(1, -1, 1)
  if (PlayerDataCenter.sectorStage).lastSelectDiff == difficulty then
    return 
  end
  ;
  (self.difficultBtn):RefreshLevelDiffItem(self.id, difficulty)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_DiffArrow).color = (self.difficultBtn):GetDifficultyColor()
  self.__difficulty = difficulty
  if self.levelDetailWindow ~= nil and (self.levelDetailWindow).active then
    (self.levelDetailWindow):OnClickSectorLevelDetailBackBtn()
    self.__waitChangeDifficulty = true
  else
    ;
    (self.difficultListNode):ChangeLevelDifficulty(difficulty)
    self:__UpdateLevelDifficultItem()
  end
end

UISectorLevel.OnClickDifficulty = function(self)
  -- function num : 0_9 , upvalues : _ENV, cs_MessageCommon
  do
    if self.__lastEpStateCfg ~= nil then
      local levelInfo = nil
      if (self.difficultBtn).difficulty == (ConfigData.sector_stage).difficultyCount + 1 then
        levelInfo = ConfigData:GetTipContent(TipContent.Sector_InifinityName)
      else
        levelInfo = tostring((self.__lastEpStateCfg).sector) .. "-" .. tostring((self.__lastEpStateCfg).num)
      end
      ;
      (cs_MessageCommon.ShowMessageTips)((string.format)(ConfigData:GetTipContent(TipContent.Sector_IsExploringOtherSector), levelInfo))
      return 
    end
    if #(self.poolDifficultItem).listItem > 0 then
      if not self.isFiffcultListHolderOpen then
        self.isFiffcultListHolderOpen = true
        ;
        (((self.ui).diffcultListHolder).gameObject):SetActive(true)
        -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

        ;
        (((self.ui).img_DiffArrow).transform).localScale = (Vector3.New)(1, 1, 1)
      else
        self.isFiffcultListHolderOpen = false
        ;
        (((self.ui).diffcultListHolder).gameObject):SetActive(false)
        -- DECOMPILER ERROR at PC83: Confused about usage of register: R1 in 'UnsetPending'

        ;
        (((self.ui).img_DiffArrow).transform).localScale = (Vector3.New)(1, -1, 1)
      end
    else
      self.isFiffcultListHolderOpen = false
      ;
      (((self.ui).diffcultListHolder).gameObject):SetActive(false)
      -- DECOMPILER ERROR at PC101: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (((self.ui).img_DiffArrow).transform).localScale = (Vector3.New)(1, -1, 1)
    end
  end
end

UISectorLevel.GetDifficultListNode = function(self)
  -- function num : 0_10
  return self.difficultListNode
end

UISectorLevel.__OnSectrorTaskClick = function(self)
  -- function num : 0_11
  (self.SectorTaskController):OpenSectorTaskWindows()
end

UISectorLevel.__UpdataTaskProcessUI = function(self)
  -- function num : 0_12
  local id, star, totalStar = (self.SectorTaskController):GetSectorTaskProcess()
  ;
  ((self.ui).tex_StarNum):SetIndex(0, self:__SetProcessNum(star))
  ;
  ((self.ui).tex_TotalStar):SetIndex(0, self:__SetProcessNum(totalStar))
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_TaskProcess).fillAmount = star / totalStar
end

UISectorLevel.__InitRedDotEvent = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, self.id, RedDotStaticTypeId.SectorTaskBtn)
  if node:GetRedDotCount() <= 0 then
    ((self.ui).redDot_Task):SetActive(not ok)
    self.__onTaskRedDotEvent = function(node)
    -- function num : 0_13_0 , upvalues : self
    if node:GetRedDotCount() <= 0 then
      ((self.ui).redDot_Task):SetActive(node:GetParentNodeId() ~= self.id)
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end

    RedDotController:AddListener(RedDotDynPath.SectorItemTaskBtnPath, self.__onTaskRedDotEvent)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UISectorLevel.__RemoveRedDotEvent = function(self)
  -- function num : 0_14 , upvalues : _ENV
  RedDotController:RemoveListener(RedDotDynPath.SectorItemTaskBtnPath, self.__onTaskRedDotEvent)
end

UISectorLevel.__SetProcessNum = function(self, num)
  -- function num : 0_15 , upvalues : _ENV
  if num <= 9 then
    return "0", tostring(num)
  end
  return "", tostring(num)
end

UISectorLevel.OnClickBackBtn = function(self, invokeArg)
  -- function num : 0_16
  self:Delete()
  if self.__closeAction ~= nil then
    (self.__closeAction)(not invokeArg)
  end
end

UISectorLevel.__ClickLevelListBgFunc = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if self.levelDetailWindow ~= nil and (self.levelDetailWindow).active then
    (self.levelDetailWindow):OnClickSectorLevelDetailBackBtn()
    ;
    (UIUtil.PopFromBackStack)()
  end
end

UISectorLevel.GetSelectedStageId = function(self)
  -- function num : 0_18
  return self.selectLevelId
end

UISectorLevel.GetSelectedLAvgMainId = function(self)
  -- function num : 0_19
  return self.selectLAvgMainId
end

UISectorLevel.OnDelete = function(self)
  -- function num : 0_20 , upvalues : _ENV, base
  (self.difficultListNode):Delete()
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  UIManager:DeleteWindow(UIWindowTypeID.SectorLevelDetail)
  self:__RemoveRedDotEvent()
  if self.SectorTaskController ~= nil then
    (self.SectorTaskController):OnDelete()
    self.SectorTaskController = nil
  end
  ;
  (base.OnDelete)(self)
end

return UISectorLevel

-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorLevel = class("UISectorLevel", UIBaseWindow)
local base = UIBaseWindow
local UINDifficultList = require("Game.Sector.SectorLevel.UINDifficultList")
local UINLevelDifficultItem = require(
                                  "Game.Sector.SectorLevel.UINLevelDifficultItem")
local SectorTaskController = require(
                                 "Game.Sector.SectorTask.New.SectorTaskController")
local cs_MessageCommon = CS.MessageCommon
UISectorLevel.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINDifficultList, SectorTaskController, UINLevelDifficultItem
    self.isFiffcultListHolderOpen = false;
    (UIUtil.AddButtonListener)((self.ui).btn_SectorTask, self,
                               self.__OnSectrorTaskClick)
    self.__onLevelItemClicked = BindCallback(self, self.OnLevelItemClicked)
    self.__onLevelAvgMainClicked = BindCallback(self,
                                                self.OnLevelAvgMainItemClicked)
    self.__onLevelAvgSubClickEvent = BindCallback(self,
                                                  self.OnLevelAvgSubClicked)
    self.difficultListNode = (UINDifficultList.New)();
    (self.difficultListNode):Init((self.ui).difficultList);
    (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self,
                               self.OnClickBackBtn)
    self.__onHasUncompletedEp = BindCallback(self, self.UpdateUncompletedEp)
    MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp,
                          self.__onHasUncompletedEp)
    self.SectorTaskController = (SectorTaskController.New)();
    (self.SectorTaskController):OnInit()
    self.__lastEpStateCfg =
        ExplorationManager:TryGetUncompletedEpSectorStateCfg()
    self.poolDifficultItem = (UIItemPool.New)(UINLevelDifficultItem,
                                              (self.ui).btn_Difficult)
end

UISectorLevel.InitSectorLevel = function(self, sectorId, closeAction)
    -- function num : 0_1 , upvalues : _ENV, UINLevelDifficultItem
    if (PlayerDataCenter.sectorStage).lastSelectSector ~= sectorId then
        (PlayerDataCenter.sectorStage):InitSelectStage(sectorId)
    end
    self.id = sectorId
    self.sectorCfg = (ConfigData.sector)[self.id]
    self.__closeAction = closeAction -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).tex_SectorName).text = (LanguageUtil.GetLocaleText)(
                                          (self.sectorCfg).name) -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).tex_SectorNameEn).text = (LanguageUtil.GetLocaleText)(
                                            (self.sectorCfg).name_en);
    (((self.ui).diffcultListHolder).gameObject):SetActive(false)
    self.onSelectDifficultyEvent = BindCallback(self, self.OnSelectDifficulty)
    local lastDifficulty = (PlayerDataCenter.sectorStage).lastSelectDiff
    self:__UpdateLevelDifficultItem(lastDifficulty)
    self.difficultBtn = (UINLevelDifficultItem.New)();
    (self.difficultBtn):Init((self.ui).btn_Difficult);
    (self.difficultBtn):InitLevelDiffItem(self.id, lastDifficulty, BindCallback(
                                              self, self.OnClickDifficulty));
    (self.difficultListNode):InitDifficeltLevel(sectorId, self.__lastEpStateCfg,
                                                self.__onLevelItemClicked,
                                                self.__onLevelAvgMainClicked,
                                                self.__onLevelAvgSubClickEvent,
                                                BindCallback(self,
                                                             self.__ClickLevelListBgFunc));
    (self.SectorTaskController):InitCurrSectorData(self.id, self.sectorCfg);
    (self.SectorTaskController):SetWindowQuitEvent(
        BindCallback(self, self.__UpdataTaskProcessUI))
    self:__UpdataTaskProcessUI()
    self:__InitRedDotEvent()
    if not GuideManager:TryTriggerGuide(eGuideCondition.FInSectorLevel) or
        GuideManager:TryTriggerGuide(eGuideCondition.InSectorLevel) then
        local avgPlayCtrl = ControllerManager:GetController(
                                ControllerTypeId.AvgPlay)
        avgPlayCtrl:TryPlayTaskAvg(4, nil)
        self:__InitRedDotEvent()
    end
end

UISectorLevel.__UpdateLevelDifficultItem =
    function(self, lastDifficulty)
        -- function num : 0_2 , upvalues : _ENV
        local funcUnLockCrtl = ControllerManager:GetController(
                                   ControllerTypeId.FunctionUnlock, true)
        if lastDifficulty == nil then
            lastDifficulty = (PlayerDataCenter.sectorStage).lastSelectDiff
        end
        (self.poolDifficultItem):HideAll()
        local isHardUnlock = funcUnLockCrtl:ValidateUnlock(
                                 proto_csmsg_SystemFunctionID.SystemFunctionID_Hard)
        for i = 1, (ConfigData.sector_stage).difficultyCount do
            if lastDifficulty ~= i and (i ~= 2 or isHardUnlock) then
                local diffItem = (self.poolDifficultItem):GetOne();
                (diffItem.transform):SetParent(
                    ((self.ui).diffcultListHolder).transform)
                diffItem:InitLevelDiffItem(self.id, i,
                                           self.onSelectDifficultyEvent)
            end
        end
        local isInfinityUnlock = funcUnLockCrtl:ValidateUnlock(
                                     proto_csmsg_SystemFunctionID.SystemFunctionID_Endless)
        if isInfinityUnlock and lastDifficulty ~=
            (ConfigData.sector_stage).difficultyCount + 1 then
            local diffItem = (self.poolDifficultItem):GetOne();
            (diffItem.transform):SetParent(
                ((self.ui).diffcultListHolder).transform)
            diffItem:InitLevelDiffItem(self.id,
                                       (ConfigData.sector_stage).difficultyCount +
                                           1, self.onSelectDifficultyEvent)
        end
    end

UISectorLevel.OnLevelItemClicked = function(self, levelItem)
    -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
    local stageData = levelItem:GetLevelStageData()
    if not levelItem:IsLevelUnlock() then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(
                TipContent.Sector_HaveToClearanceLastLevelToUnlock))
        return
    end
    do
        if self.__lastEpStateCfg ~= nil and (self.__lastEpStateCfg).num ~=
            stageData.num then
            local levelInfo = tostring((self.__lastEpStateCfg).sector) .. "-" ..
                                  tostring((self.__lastEpStateCfg).num);
            (cs_MessageCommon.ShowMessageTips)(
                (string.format)(ConfigData:GetTipContent(
                                    TipContent.Sector_IsExploringOtherSector),
                                levelInfo))
            return
        end
        local lastSelectLevelItem = (self.difficultListNode):GetSectorStageItem(
                                        self.selectLevelId)
        if lastSelectLevelItem ~= nil then
            lastSelectLevelItem:SeletedLevelItem(false, true)
            self.selectLevelId = nil
        end
        local selectLAvgMain = (self.difficultListNode):GetSectorLAvgMainItem(
                                   self.selectLAvgMainId)
        if selectLAvgMain ~= nil then
            selectLAvgMain:SelectedLAvgMain(false)
            self.selectLAvgMainId = nil
        end
        self.selectLevelId = stageData.id
        levelItem:SeletedLevelItem(true, true)
        self:ShowLevelDetailWindow(function(window)
            -- function num : 0_3_0 , upvalues : self, stageData
            window:InitSectorLevelDetail(self.id, stageData.id)
        end)
    end
end

UISectorLevel.ShowLevelDetailWindow = function(self, callback)
    -- function num : 0_4 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevelDetail, function(window)
        -- function num : 0_4_0 , upvalues : self, callback
        window:SetLevelDetaiHideStartEvent(
            function()
                -- function num : 0_4_0_0 , upvalues : self
                (self.difficultListNode):PlayMoveLeftTween(false)
                local selectLevelItem =
                    (self.difficultListNode):GetSectorStageItem(
                        self.selectLevelId)
                if selectLevelItem ~= nil then
                    selectLevelItem:SeletedLevelItem(false, true)
                end
            end)
        window:SetLevelDetaiHideEndEvent(
            function()
                -- function num : 0_4_0_1 , upvalues : self
                if not self.__waitChangeDifficulty then return end
                self.__waitChangeDifficulty = false;
                (self.difficultListNode):ChangeLevelDifficulty(self.__difficulty)
            end)
        local width, duration = window:GetLevelDetailWidthAndDuration();
        (self.difficultListNode):PlayMoveLeftTween(true, width, duration)
        self.levelDetailWindow = window
        callback(window)
    end)
end

UISectorLevel.OnLevelAvgMainItemClicked =
    function(self, lAvgMainItem)
        -- function num : 0_5 , upvalues : cs_MessageCommon, _ENV
        local avgCfg = lAvgMainItem:GetLAvgMainCfg()
        if not lAvgMainItem:IsLAvgMainUnlock() then
            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(
                    TipContent.Sector_HaveToClearanceLastLevelToUnlock))
            return
        end
        local selectLevelItem = (self.difficultListNode):GetSectorStageItem(
                                    self.selectLevelId)
        if selectLevelItem ~= nil then
            selectLevelItem:SeletedLevelItem(false, true)
            self.selectLevelId = nil
        end
        local selectLAvgMain = (self.difficultListNode):GetSectorLAvgMainItem(
                                   self.selectLAvgMainId)
        if selectLAvgMain ~= nil then
            selectLAvgMain:SelectedLAvgMain(false)
            self.selectLAvgMainId = nil
        end
        self.selectLAvgMainId = avgCfg.id
        lAvgMainItem:SelectedLAvgMain(true)
        self:ShowLevelDetailWindow(function(window)
            -- function num : 0_5_0 , upvalues : self, avgCfg
            window:InitSectorLevelAvgDetail(self.id, avgCfg, function()
                -- function num : 0_5_0_0 , upvalues : self
                (self.difficultListNode):RefreshCurDiffLevelState()
            end)
        end)
    end

UISectorLevel.OnLevelAvgSubClicked = function(self, lAvgSubItem)
    -- function num : 0_6 , upvalues : _ENV
    local avgCfg = lAvgSubItem:GetLAvgSubCfg()
    local avgPlayCtrl =
        ControllerManager:GetController(ControllerTypeId.AvgPlay)
    if not avgPlayCtrl:IsAvgUnlock(avgCfg.id) then
        error("Avg is not unlock,avgId = " .. avgCfg.id)
        return
    end
    local selectLevelItem = (self.difficultListNode):GetSectorStageItem(
                                self.selectLevelId)
    if selectLevelItem ~= nil then
        selectLevelItem:SeletedLevelItem(false, true)
        self.selectLevelId = nil
    end
    local selectLAvgMain = (self.difficultListNode):GetSectorLAvgMainItem(
                               self.selectLAvgMainId)
    if selectLAvgMain ~= nil then
        selectLAvgMain:SelectedLAvgMain(false)
        self.selectLAvgMainId = nil
    end
    self:ShowLevelDetailWindow(function(window)
        -- function num : 0_6_0 , upvalues : self, avgCfg, lAvgSubItem
        window:InitSectorLevelAvgDetail(self.id, avgCfg, function()
            -- function num : 0_6_0_0 , upvalues : lAvgSubItem
            lAvgSubItem:RefreshLAvgSubPlayed()
        end)
    end)
end

UISectorLevel.UpdateUncompletedEp = function(self)
    -- function num : 0_7 , upvalues : _ENV
    self.__lastEpStateCfg =
        ExplorationManager:TryGetUncompletedEpSectorStateCfg();
    (self.difficultListNode):RefreshUncompletedEp(self.__lastEpStateCfg)
end

UISectorLevel.OnSelectDifficulty = function(self, difficulty)
    -- function num : 0_8 , upvalues : _ENV
    self.isFiffcultListHolderOpen = false;
    (((self.ui).diffcultListHolder).gameObject):SetActive(false) -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (((self.ui).img_DiffArrow).transform).localScale = (Vector3.New)(1, -1, 1)
    if (PlayerDataCenter.sectorStage).lastSelectDiff == difficulty then
        return
    end
    (self.difficultBtn):RefreshLevelDiffItem(self.id, difficulty) -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).img_DiffArrow).color = (self.difficultBtn):GetDifficultyColor()
    self.__difficulty = difficulty
    if self.levelDetailWindow ~= nil and (self.levelDetailWindow).active then
        (self.levelDetailWindow):OnClickSectorLevelDetailBackBtn()
        self.__waitChangeDifficulty = true
    else

        (self.difficultListNode):ChangeLevelDifficulty(difficulty)
        self:__UpdateLevelDifficultItem()
    end
end

UISectorLevel.OnClickDifficulty = function(self)
    -- function num : 0_9 , upvalues : _ENV, cs_MessageCommon
    do
        if self.__lastEpStateCfg ~= nil then
            local levelInfo = nil
            if (self.difficultBtn).difficulty ==
                (ConfigData.sector_stage).difficultyCount + 1 then
                levelInfo = ConfigData:GetTipContent(
                                TipContent.Sector_InifinityName)
            else
                levelInfo = tostring((self.__lastEpStateCfg).sector) .. "-" ..
                                tostring((self.__lastEpStateCfg).num)
            end
            (cs_MessageCommon.ShowMessageTips)(
                (string.format)(ConfigData:GetTipContent(
                                    TipContent.Sector_IsExploringOtherSector),
                                levelInfo))
            return
        end
        if #(self.poolDifficultItem).listItem > 0 then
            if not self.isFiffcultListHolderOpen then
                self.isFiffcultListHolderOpen = true;
                (((self.ui).diffcultListHolder).gameObject):SetActive(true) -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'
                ;
                (((self.ui).img_DiffArrow).transform).localScale =
                    (Vector3.New)(1, 1, 1)
            else
                self.isFiffcultListHolderOpen = false;
                (((self.ui).diffcultListHolder).gameObject):SetActive(false) -- DECOMPILER ERROR at PC83: Confused about usage of register: R1 in 'UnsetPending'
                ;
                (((self.ui).img_DiffArrow).transform).localScale =
                    (Vector3.New)(1, -1, 1)
            end
        else
            self.isFiffcultListHolderOpen = false;
            (((self.ui).diffcultListHolder).gameObject):SetActive(false) -- DECOMPILER ERROR at PC101: Confused about usage of register: R1 in 'UnsetPending'
            ;
            (((self.ui).img_DiffArrow).transform).localScale =
                (Vector3.New)(1, -1, 1)
        end
    end
end

UISectorLevel.GetDifficultListNode = function(self)
    -- function num : 0_10
    return self.difficultListNode
end

UISectorLevel.__OnSectrorTaskClick = function(self)
    -- function num : 0_11
    (self.SectorTaskController):OpenSectorTaskWindows()
end

UISectorLevel.__UpdataTaskProcessUI = function(self)
    -- function num : 0_12
    local id, star, totalStar =
        (self.SectorTaskController):GetSectorTaskProcess();
    ((self.ui).tex_StarNum):SetIndex(0, self:__SetProcessNum(star));
    ((self.ui).tex_TotalStar):SetIndex(0, self:__SetProcessNum(totalStar)) -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).img_TaskProcess).fillAmount = star / totalStar
end

UISectorLevel.__InitRedDotEvent = function(self)
    -- function num : 0_13 , upvalues : _ENV
    local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main,
                                                    RedDotStaticTypeId.Sector,
                                                    self.id,
                                                    RedDotStaticTypeId.SectorTaskBtn)
    if node:GetRedDotCount() <= 0 then
        ((self.ui).redDot_Task):SetActive(not ok)
        self.__onTaskRedDotEvent = function(node)
            -- function num : 0_13_0 , upvalues : self
            if node:GetRedDotCount() <= 0 then
                ((self.ui).redDot_Task):SetActive(
                    node:GetParentNodeId() ~= self.id)
                -- DECOMPILER ERROR: 2 unprocessed JMP targets
            end
        end

        RedDotController:AddListener(RedDotDynPath.SectorItemTaskBtnPath,
                                     self.__onTaskRedDotEvent)
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
end

UISectorLevel.__RemoveRedDotEvent = function(self)
    -- function num : 0_14 , upvalues : _ENV
    RedDotController:RemoveListener(RedDotDynPath.SectorItemTaskBtnPath,
                                    self.__onTaskRedDotEvent)
end

UISectorLevel.__SetProcessNum = function(self, num)
    -- function num : 0_15 , upvalues : _ENV
    if num <= 9 then return "0", tostring(num) end
    return "", tostring(num)
end

UISectorLevel.OnClickBackBtn = function(self, invokeArg)
    -- function num : 0_16
    self:Delete()
    if self.__closeAction ~= nil then (self.__closeAction)(not invokeArg) end
end

UISectorLevel.__ClickLevelListBgFunc = function(self)
    -- function num : 0_17 , upvalues : _ENV
    if self.levelDetailWindow ~= nil and (self.levelDetailWindow).active then
        (self.levelDetailWindow):OnClickSectorLevelDetailBackBtn();
        (UIUtil.PopFromBackStack)()
    end
end

UISectorLevel.GetSelectedStageId = function(self)
    -- function num : 0_18
    return self.selectLevelId
end

UISectorLevel.GetSelectedLAvgMainId = function(self)
    -- function num : 0_19
    return self.selectLAvgMainId
end

UISectorLevel.OnDelete = function(self)
    -- function num : 0_20 , upvalues : _ENV, base
    (self.difficultListNode):Delete()
    MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp,
                             self.__onHasUncompletedEp)
    UIManager:DeleteWindow(UIWindowTypeID.SectorLevelDetail)
    self:__RemoveRedDotEvent()
    if self.SectorTaskController ~= nil then
        (self.SectorTaskController):OnDelete()
        self.SectorTaskController = nil
    end
    (base.OnDelete)(self)
end

return UISectorLevel

