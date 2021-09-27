local UISectorLevel = class("UISectorLevel", UIBaseWindow)
local base = UIBaseWindow
local UINDifficultList = require("Game.Sector.SectorLevel.UINDifficultList")
local UINLevelDifficultItem = require("Game.Sector.SectorLevel.UINLevelDifficultItem")
local UINSectorLevelTypeAnima = require("Game.Sector.SectorLevel.UINSectorLevelTypeAnima")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local SectorEnum = require("Game.Sector.SectorEnum")
local cs_MessageCommon = CS.MessageCommon
UISectorLevel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDifficultList, UINSectorLevelTypeAnima, UINLevelDifficultItem
  self.isFiffcultListHolderOpen = false
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SectorTask, self, self.__OnSectrorTaskClick)
  self.__onLevelItemClicked = BindCallback(self, self.OnLevelItemClicked)
  self.__onLevelAvgMainClicked = BindCallback(self, self.OnLevelAvgMainItemClicked)
  self.__onLevelAvgSubClickEvent = BindCallback(self, self.OnLevelAvgSubClicked)
  self.difficultListNode = (UINDifficultList.New)()
  ;
  (self.difficultListNode):Init((self.ui).difficultList)
  self.stageTypeAnima = (UINSectorLevelTypeAnima.New)()
  ;
  (self.stageTypeAnima):Init((self.ui).obj_AniStageType)
  self.__onHasUncompletedEp = BindCallback(self, self.UpdateUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  self.__onAVGCtrlPlayEnd = BindCallback(self, self.OnAVGCtrlPlayEnd)
  MsgCenter:AddListener(eMsgEventId.AVGCtrlPlayEnd, self.__onAVGCtrlPlayEnd)
  self.__onMainAvgStateChange = BindCallback(self, self.OnMainAvgStateChange)
  MsgCenter:AddListener(eMsgEventId.OnMainAvgStateChange, self.__onMainAvgStateChange)
  self.__lastEpStateCfg = ExplorationManager:TryGetUncompletedEpSectorStateCfg()
  self.poolDifficultItem = (UIItemPool.New)(UINLevelDifficultItem, (self.ui).btn_Difficult)
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorTask)
  self:SetTaskTaskUnlock(isUnlock)
  AudioManager:PlayAudioById(1073)
end

UISectorLevel.InitSectorLevel = function(self, sectorId, closeAction, autoDifficulty, autoStageCfg, isPlayingVideo)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self.OnClickBackBtn)
  self.__sectorId = sectorId
  self.sectorCfg = (ConfigData.sector)[self.__sectorId]
  self.__closeAction = closeAction
  if (PlayerDataCenter.sectorStage):GetSelectSectorId() ~= sectorId then
    (PlayerDataCenter.sectorStage):SetSelectSectorId(sectorId)
  end
  if autoDifficulty ~= nil and (PlayerDataCenter.sectorStage):GetSelectDifficult(sectorId) ~= autoDifficulty then
    (PlayerDataCenter.sectorStage):SetSelectDifficult(autoDifficulty)
  end
  if self.__lastEpStateCfg ~= nil or autoDifficulty == nil or not autoDifficulty then
    local lastDifficulty = (PlayerDataCenter.sectorStage):GetSelectDifficult(sectorId)
  end
  self:__InitSectorBaseInfo(lastDifficulty)
  local isUnCompleteEp = false
  if self.__lastEpStateCfg ~= nil then
    autoStageCfg = self.__lastEpStateCfg
    isUnCompleteEp = true
  end
  ;
  (self.difficultListNode):InitDifficeltLevel(sectorId, autoStageCfg, isUnCompleteEp, self.__onLevelItemClicked, self.__onLevelAvgMainClicked, self.__onLevelAvgSubClickEvent, BindCallback(self, self.__ClickLevelListBgFunc))
  if not isPlayingVideo then
    self:__TryTriggerSectorLevelGuide()
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  avgPlayCtrl:TryPlayTaskAvg(4, nil)
  self:__InitRedDotEvent()
end

UISectorLevel.__TryTriggerSectorLevelGuide = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if not GuideManager:TryTriggerGuide(eGuideCondition.FInSectorLevel) or GuideManager:TryTriggerGuide(eGuideCondition.InSectorLevel) then
  end
end

UISectorLevel.__InitSectorBaseInfo = function(self, lastDifficulty)
  -- function num : 0_3 , upvalues : _ENV, UINLevelDifficultItem
  if (self.sectorCfg).is_special then
    ((self.ui).sectorInfo):SetActive(false)
    return 
  end
  ;
  ((self.ui).sectorInfo):SetActive(true)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_SectorName).text = (LanguageUtil.GetLocaleText)((self.sectorCfg).name)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_SectorNameEn).text = (LanguageUtil.GetLocaleText)((self.sectorCfg).name_en)
  ;
  (((self.ui).diffcultListHolder).gameObject):SetActive(false)
  self.onSelectDifficultyEvent = BindCallback(self, self.OnSelectDifficulty)
  self:__UpdateLevelDifficultItem(lastDifficulty)
  self.difficultBtn = (UINLevelDifficultItem.New)()
  ;
  (self.difficultBtn):Init((self.ui).btn_Difficult)
  ;
  (self.difficultBtn):InitLevelDiffItem(self.__sectorId, lastDifficulty, BindCallback(self, self.OnClickDifficulty))
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_DiffArrow).color = (self.difficultBtn):GetDifficultyColor()
  self:__UpdataTaskProcessUI()
end

UISectorLevel.__UpdateLevelDifficultItem = function(self, lastDifficulty)
  -- function num : 0_4 , upvalues : _ENV, ExplorationEnum
  if lastDifficulty == nil then
    lastDifficulty = (PlayerDataCenter.sectorStage):GetSelectDifficult(self.__sectorId)
  end
  ;
  (self.poolDifficultItem):HideAll()
  local isHardUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Hard)
  for i = 1, (ConfigData.sector_stage).difficultyCount do
    if lastDifficulty ~= i and (i ~= (ExplorationEnum.eDifficultType).Hard or isHardUnlock) then
      local diffItem = (self.poolDifficultItem):GetOne()
      ;
      (diffItem.transform):SetParent(((self.ui).diffcultListHolder).transform)
      diffItem:InitLevelDiffItem(self.__sectorId, i, self.onSelectDifficultyEvent)
    end
  end
  local isInfinityUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Endless)
  if isInfinityUnlock and lastDifficulty ~= (ConfigData.sector_stage).difficultyCount + 1 then
    local diffItem = (self.poolDifficultItem):GetOne()
    ;
    (diffItem.transform):SetParent(((self.ui).diffcultListHolder).transform)
    diffItem:InitLevelDiffItem(self.__sectorId, (ConfigData.sector_stage).difficultyCount + 1, self.onSelectDifficultyEvent)
  end
end

UISectorLevel.OnLevelItemClicked = function(self, levelItem)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  local stageCfg = (levelItem:GetLevelStageData())
  -- DECOMPILER ERROR at PC2: Overwrote pending register: R3 in 'AssignReg'

  local isLocked = .end
  do
    if not levelItem:IsLevelUnlock() then
      local unLockInfo = (PlayerDataCenter.sectorStage):GetGetUnlockInfo(stageCfg.id)
      ;
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(unLockInfo)
      isLocked = true
    end
    if self.__lastEpStateCfg ~= nil and (self.__lastEpStateCfg).num ~= stageCfg.num then
      ExplorationManager:TryToShowCurrentLevelTips()
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
    self.selectLevelId = stageCfg.id
    levelItem:SeletedLevelItem(true, true)
    ;
    (UIUtil.AddOneCover)("InitSectorLevelDetail")
    self:ShowLevelDetailWindow(function(window)
    -- function num : 0_5_0 , upvalues : self, stageCfg, isLocked, _ENV
    window:InitSectorLevelDetail(self.__sectorId, stageCfg.id, isLocked)
    ;
    (UIUtil.CloseOneCover)("InitSectorLevelDetail")
  end
)
  end
end

UISectorLevel.ShowLevelDetailWindow = function(self, callback)
  -- function num : 0_6 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevelDetail, function(window)
    -- function num : 0_6_0 , upvalues : self, callback
    window:SetLevelDetaiHideStartEvent(function()
      -- function num : 0_6_0_0 , upvalues : self
      (self.difficultListNode):PlayMoveLeftTween(false)
      local selectLevelItem = (self.difficultListNode):GetSectorStageItem(self.selectLevelId)
      if selectLevelItem ~= nil then
        selectLevelItem:SeletedLevelItem(false, true)
      end
    end
)
    window:SetLevelDetaiHideEndEvent(function()
      -- function num : 0_6_0_1 , upvalues : self
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
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  local avgCfg = (lAvgMainItem:GetLAvgMainCfg())
  -- DECOMPILER ERROR at PC2: Overwrote pending register: R3 in 'AssignReg'

  local isLocked = .end
  do
    if not lAvgMainItem:IsLAvgMainUnlock() then
      local lockTip = (CheckCondition.GetUnlockInfoLua)(avgCfg.pre_condition, avgCfg.pre_para1, avgCfg.pre_para2)
      ;
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(lockTip)
      isLocked = true
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
    -- function num : 0_7_0 , upvalues : self, avgCfg, isLocked
    window:InitSectorLevelAvgDetail(self.__sectorId, avgCfg, function()
      -- function num : 0_7_0_0 , upvalues : self, avgCfg
      (self.difficultListNode):LocationSectorStageItem(avgCfg.id, true)
    end
, isLocked)
  end
)
  end
end

UISectorLevel.OnLevelAvgSubClicked = function(self, lAvgSubItem)
  -- function num : 0_8 , upvalues : _ENV
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
    -- function num : 0_8_0 , upvalues : self, avgCfg, lAvgSubItem
    window:InitSectorLevelAvgDetail(self.__sectorId, avgCfg, function()
      -- function num : 0_8_0_0 , upvalues : lAvgSubItem, self, avgCfg
      lAvgSubItem:RefreshLAvgSubPlayed()
      ;
      (self.difficultListNode):LocationSectorStageItem(avgCfg.id, true)
    end
)
  end
)
end

UISectorLevel.OnMainAvgStateChange = function(self, sectorId, difficulty, avgId)
  -- function num : 0_9
  (self.difficultListNode):RefreshCurDiffLevelState()
end

UISectorLevel.UpdateUncompletedEp = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self.__lastEpStateCfg = ExplorationManager:TryGetUncompletedEpSectorStateCfg()
  ;
  (self.difficultListNode):RefreshUncompletedEp(self.__lastEpStateCfg)
  ;
  (self.difficultListNode):RefreshCurDiffLevelState()
end

UISectorLevel.OnSelectDifficulty = function(self, difficulty)
  -- function num : 0_11 , upvalues : _ENV
  self.isFiffcultListHolderOpen = false
  ;
  (((self.ui).diffcultListHolder).gameObject):SetActive(false)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).img_DiffArrow).transform).localScale = (Vector3.New)(1, -1, 1)
  if (PlayerDataCenter.sectorStage):GetSelectDifficult(self.__sectorId) == difficulty then
    return 
  end
  ;
  (self.difficultBtn):RefreshLevelDiffItem(self.__sectorId, difficulty)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

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
  AudioManager:PlayAudioById(1073)
  ;
  (self.stageTypeAnima):ShowStageAnima(difficulty)
end

UISectorLevel.OnClickDifficulty = function(self, difficulty)
  -- function num : 0_12 , upvalues : _ENV
  if self.__lastEpStateCfg ~= nil then
    ExplorationManager:TryToShowCurrentLevelTips()
    return 
  end
  if #(self.poolDifficultItem).listItem > 0 then
    if not self.isFiffcultListHolderOpen then
      self.isFiffcultListHolderOpen = true
      ;
      (((self.ui).diffcultListHolder).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((self.ui).img_DiffArrow).transform).localScale = (Vector3.New)(1, 1, 1)
    else
      self.isFiffcultListHolderOpen = false
      ;
      (((self.ui).diffcultListHolder).gameObject):SetActive(false)
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((self.ui).img_DiffArrow).transform).localScale = (Vector3.New)(1, -1, 1)
    end
  else
    self.isFiffcultListHolderOpen = false
    ;
    (((self.ui).diffcultListHolder).gameObject):SetActive(false)
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).img_DiffArrow).transform).localScale = (Vector3.New)(1, -1, 1)
  end
end

UISectorLevel.GetDifficultListNode = function(self)
  -- function num : 0_13
  return self.difficultListNode
end

UISectorLevel.SetTaskTaskUnlock = function(self, bool)
  -- function num : 0_14
  (((self.ui).btn_SectorTask).gameObject):SetActive(bool)
end

UISectorLevel.__OnSectrorTaskClick = function(self)
  -- function num : 0_15 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorTask, function(window)
    -- function num : 0_15_0 , upvalues : _ENV, self
    if window == nil then
      return 
    end
    UIManager:HideWindow(UIWindowTypeID.SectorLevel)
    if self.levelDetailWindow ~= nil and (self.levelDetailWindow).active then
      self.islevelDetailOpen = true
      UIManager:HideWindow(UIWindowTypeID.SectorLevelDetail)
    end
    window:InitSectorTask(self.__sectorId, function()
      -- function num : 0_15_0_0 , upvalues : _ENV, self
      UIManager:ShowWindow(UIWindowTypeID.SectorLevel)
      if self.levelDetailWindow ~= nil and not (self.levelDetailWindow).active and self.islevelDetailOpen then
        self.islevelDetailOpen = nil
        UIManager:ShowWindow(UIWindowTypeID.SectorLevelDetail)
      end
      self:__UpdataTaskProcessUI()
    end
)
  end
)
end

UISectorLevel.__UpdataTaskProcessUI = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local sectorTaskCtrl = ControllerManager:GetController(ControllerTypeId.SectorTaskCtrl, true)
  local starId, starCount, _ = sectorTaskCtrl:GetSectorAchievementScore(self.__sectorId)
  local starTotalCount = sectorTaskCtrl:GetSectorTaskTotalCount(starId, self.__sectorId)
  if starCount <= 9 then
    ((self.ui).tex_CompleteNum):SetIndex(0, "0", tostring(starCount))
  else
    ;
    ((self.ui).tex_CompleteNum):SetIndex(0, "", tostring(starCount))
  end
  if starTotalCount <= 9 then
    ((self.ui).tex_TotalNum):SetIndex(0, "0", tostring(starTotalCount))
  else
    ;
    ((self.ui).tex_TotalNum):SetIndex(0, "", tostring(starTotalCount))
  end
end

UISectorLevel.__InitRedDotEvent = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, self.__sectorId, RedDotStaticTypeId.SectorTaskBtn)
  if node:GetRedDotCount() <= 0 then
    ((self.ui).redDot_Task):SetActive(not ok)
    self.__onTaskRedDotEvent = function(node)
    -- function num : 0_17_0 , upvalues : self
    if node:GetRedDotCount() <= 0 then
      ((self.ui).redDot_Task):SetActive(node:GetParentNodeId() ~= self.__sectorId)
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end

    RedDotController:AddListener(RedDotDynPath.SectorItemTaskBtnPath, self.__onTaskRedDotEvent)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UISectorLevel.__RemoveRedDotEvent = function(self)
  -- function num : 0_18 , upvalues : _ENV
  RedDotController:RemoveListener(RedDotDynPath.SectorItemTaskBtnPath, self.__onTaskRedDotEvent)
end

UISectorLevel.__SetProcessNum = function(self, num)
  -- function num : 0_19 , upvalues : _ENV
  if num <= 9 then
    return "0", tostring(num)
  end
  return "", tostring(num)
end

UISectorLevel.OnClickBackBtn = function(self, fromHome)
  -- function num : 0_20
  self:Delete()
  if self.__closeAction ~= nil then
    (self.__closeAction)(fromHome)
  end
end

UISectorLevel.__ClickLevelListBgFunc = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if self.levelDetailWindow ~= nil and (self.levelDetailWindow).active then
    (UIUtil.OnClickBack)()
  end
end

UISectorLevel.OnAVGCtrlPlayEnd = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if GuideManager:TryTriggerGuide(eGuideCondition.InSectorLevel) then
  end
end

UISectorLevel.GetSelectedStageId = function(self)
  -- function num : 0_23
  return self.selectLevelId
end

UISectorLevel.GetSelectedLAvgMainId = function(self)
  -- function num : 0_24
  return self.selectLAvgMainId
end

UISectorLevel.OnDelete = function(self)
  -- function num : 0_25 , upvalues : _ENV, base
  (self.difficultListNode):Delete()
  MsgCenter:RemoveListener(eMsgEventId.AVGCtrlPlayEnd, self.__onAVGCtrlPlayEnd)
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.OnMainAvgStateChange, self.__onMainAvgStateChange)
  UIManager:DeleteWindow(UIWindowTypeID.SectorLevelDetail)
  self:__RemoveRedDotEvent()
  if self.SectorTaskController ~= nil then
    (self.SectorTaskController):OnDelete()
    self.SectorTaskController = nil
  end
  ;
  (self.stageTypeAnima):Delete()
  ;
  (base.OnDelete)(self)
end

return UISectorLevel

