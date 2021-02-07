-- params : ...
-- function num : 0 , upvalues : _ENV
local SectorController = class("SectorController", ControllerBase)
local cs_GameObject = (CS.UnityEngine).GameObject
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_GameData_ins = (CS.GameData).instance
local SectorCameraCtrl = require("Game.Sector.Ctrl.SectorCameraCtrl")
local SectorItemEntity = require("Game.Sector.Entity.SectorItemEntity")
local DungeonTypeData = require("Game.Dungeon.DungeonTypeData")
local UI3DSectorCanvas = require("Game.Sector.UI3D.UI3DSectorCanvas")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local util = require("XLua.Common.xlua_util")
local eSectorState = {None = 0, Normal = 1, ShowSto = 2, SelectSectorLevel = 3, DungeonWindow = 4, DailyChallenge = 5}
SectorController.ctor = function(self)
  -- function num : 0_0 , upvalues : SectorCameraCtrl, _ENV
  self.ctrls = {}
  self.camCtrl = (SectorCameraCtrl.New)(self)
  self.__onClickSectorItem = BindCallback(self, self.OnSectorItemClicked)
  self.__ShowStrategyOverview = BindCallback(self, self.ShowStrategyOverview)
  self.__ResetToNormalState = BindCallback(self, self.ResetToNormalState)
end

SectorController.OnInit = function(self)
  -- function num : 0_1 , upvalues : eSectorState, cs_GameObject, _ENV, cs_ResLoader, UI3DSectorCanvas, BuildingBelong, util
  self.sctState = eSectorState.None
  local sectorRoot = ((cs_GameObject.Find)("SectorRoot")).transform
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)(sectorRoot, self.bind)
  self.__update__handle = BindCallback(self, self.OnUpdate)
  UpdateManager:AddUpdate(self.__update__handle)
  self.enableClick = false
  self.resLoader = (cs_ResLoader.Create)()
  self.buildingNetworkCtr = NetworkManager:GetNetwork(NetworkTypeID.Building)
  self.sectorToHomeDirector = (self.bind).pd_sectorToHome
  self.homeToSectorDirector = (self.bind).pd_homeToSector
  self.sectorToHomeGo = (self.sectorToHomeDirector).gameObject
  self.homeToSectorGo = (self.homeToSectorDirector).gameObject
  self.sectorToHomeDirectorStopped = function(director)
    -- function num : 0_1_0 , upvalues : self
    self:OnSectorToHomeDirectorStopped(director)
  end

  self.homeToSectorDirectorStopped = function(director)
    -- function num : 0_1_1 , upvalues : self, _ENV
    self:OnHomeToSectorDirectorStopped(director)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end

  ;
  (self.homeToSectorDirector):stopped("+", self.homeToSectorDirectorStopped)
  self.sctItemDic = {}
  self.dungeonTypeDataDic = {}
  self.__ConfirmOver = BindCallback(self, self.ConfirmOver)
  MsgCenter:AddListener(eMsgEventId.BuildingUpgradeComplete, self.__ConfirmOver)
  self.__onHasUncompletedEp = BindCallback(self, self.UpdateUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  self.__onSctStageStateChange = BindCallback(self, self.OnSctStageStateChange)
  MsgCenter:AddListener(eMsgEventId.OnSectorStageStateChange, self.__onSctStageStateChange)
  self.uiCanvas = (UI3DSectorCanvas.New)()
  ;
  (self.uiCanvas):Init((self.bind).uICanvas)
  local initFunc = function()
    -- function num : 0_1_2 , upvalues : self, _ENV, BuildingBelong
    self:InitSectorItems()
    self:UpdateAllSctBuildRes()
    self:UpdateUncompletedEp()
    ;
    (((CS.EventTriggerListener).Get)((self.bind).homeCollider)):onClick("+", function()
      -- function num : 0_1_2_0 , upvalues : self, _ENV
      if self:IsDisableClick() then
        return 
      end
      self:OnBtnHomeClicked()
      ;
      (UIUtil.OnClickBack)()
    end
)
    local queueCtrl = ControllerManager:GetController(ControllerTypeId.BuildingQueue, true)
    queueCtrl:InitBuildQueueCtrl(BuildingBelong.Sector)
    self:InitRedDotEvent()
    self:__InitChallenge()
  end

  self.__initCoroutine = (GR.StartCoroutine)((util.cs_generator)(initFunc))
  local isSectorBuildingUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding)
  self:UnlockBuildFocusEnter(isSectorBuildingUnlock)
end

SectorController.__InitChallenge = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge) then
    (self.uiCanvas):SetDailyChallengeInfo(false)
  else
    local isOutOfData = (PlayerDataCenter.periodicChallengeData):GetIsDailyOutOfData()
    if isOutOfData then
      (NetworkManager:GetNetwork(NetworkTypeID.Sector)):CS_DAILYCHALLENGE_Detail(function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    (self.uiCanvas):SetDailyChallengeInfo(not (PlayerDataCenter.periodicChallengeData).dataHasError)
  end
)
    else
      ;
      (self.uiCanvas):SetDailyChallengeInfo(not (PlayerDataCenter.periodicChallengeData).dataHasError)
    end
  end
end

SectorController.UnlockBuildFocusEnter = function(self, bool)
  -- function num : 0_3 , upvalues : _ENV
  self.isSectorBuildingUnlock = bool
  if self.sctItemDic ~= nil then
    for key,value in pairs(self.sctItemDic) do
      value:SetIsSectorBuildingUnlock(bool)
      local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, RedDotStaticTypeId.SectorBuilding, value.id)
      if node:GetRedDotCount() <= 0 then
        do
          value:ShowSctResRedDot(not ok or not self.isSectorBuildingUnlock)
          -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  local sectorWindow = UIManager:GetWindow(UIWindowTypeID.Sector)
  if sectorWindow ~= nil then
    sectorWindow:RefreshStrategyOverviewBtn()
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

SectorController.InitSectorItems = function(self)
  -- function num : 0_4 , upvalues : _ENV, SectorItemEntity
  self.lastSectorId = nil
  for sectorId,go in ipairs((self.bind).sectorGoList) do
    if (ConfigData.sector)[sectorId] ~= nil then
      if (PlayerDataCenter.sectorStage):IsSectorUnlock(sectorId) then
        self.lastSectorId = sectorId
      end
      local sctInfoItem = (self.uiCanvas):AddSctInfoItem(sectorId, self.__onClickSectorItem)
      local sctProgressStage = (self.uiCanvas):AddSctProgressStage(sectorId, self.__onClickSectorItem)
      local sctProgressBuild = (self.uiCanvas):AddSctProgressBuild(sectorId, self.__ShowStrategyOverview)
      do
        local sctItemEntity = (SectorItemEntity.New)(self)
        sctItemEntity:InitSectorItemEntity(go, sectorId, sctInfoItem, sctProgressStage, sctProgressBuild, self.uiCanvas)
        sctItemEntity:SetIsSectorBuildingUnlock(self.isSectorBuildingUnlock)
        -- DECOMPILER ERROR at PC49: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.sctItemDic)[sectorId] = sctItemEntity
        -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
end

SectorController.DetectedGeneralDungeonUnlock = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local lastSectorId = self.lastSectorId
  local focusMetionList = ConfigData.sector_unlock_mention
  local lastSectorMentionId = self:CheckDungeonInSector(lastSectorId, focusMetionList)
  lastSectorMentionId = self:FocusSectorAndMentioned(lastSectorMentionId, focusMetionList)
  local selectSectorItem = (self.sctItemDic)[lastSectorId]
  if selectSectorItem ~= nil then
    selectSectorItem:SetSctItemSelect()
  end
  self:CheckAndSetDungeonUnlock()
  return lastSectorMentionId
end

SectorController.SetForceFocus = function(self, moduelId)
  -- function num : 0_6
  ((self.bind).camTarget):SetPosType(moduelId)
  self:CheckAndSetDungeonUnlock()
end

SectorController.CheckAndSetDungeonUnlock = function(self)
  -- function num : 0_7 , upvalues : _ENV, DungeonTypeData
  for dungeonType,systemFuncId in pairs(DungeonTypeData.systemFunctionID4DungeonType) do
    local dungeonTypeData = nil
    if (self.dungeonTypeDataDic)[dungeonType] ~= nil then
      dungeonTypeData = (self.dungeonTypeDataDic)[dungeonType]
      dungeonTypeData:Update()
    else
      dungeonTypeData = (DungeonTypeData.CreateDungeonTypeData)(dungeonType)
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.dungeonTypeDataDic)[dungeonType] = dungeonTypeData
    end
    ;
    (self.uiCanvas):SetDungeonUnlock(dungeonTypeData)
  end
end

SectorController.RecordSelectModelDataLocaly = function(self, sectorId)
  -- function num : 0_8 , upvalues : _ENV
  if self.localModelData == nil then
    self.localModelData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
  end
  if self.localModelData ~= nil then
    (self.localModelData):RecordLastSectorSelected(sectorId)
  end
end

SectorController.CheckDungeonInSector = function(self, lastSectorId, focusMetionList)
  -- function num : 0_9 , upvalues : cs_GameData_ins, _ENV
  lastSectorId = lastSectorId * 10
  local lastId = lastSectorId
  local dungeonList = (cs_GameData_ins.listDungeonTypeDatas):GetList()
  if dungeonList ~= nil and dungeonList.Count > 0 then
    for i = 0, dungeonList.Count - 1 do
      local id = (dungeonList[i]):GetSectorMentionId()
      local moduelId = (dungeonList[i]):GetFunctionId()
      if focusMetionList[id] ~= nil and lastId < id and FunctionUnlockMgr:ValidateUnlock(moduelId) then
        lastId = id
      end
    end
  end
  do
    return lastId
  end
end

SectorController.FocusSectorAndMentioned = function(self, sectorMentionId, focusMetionList)
  -- function num : 0_10 , upvalues : _ENV
  local remoteLastSectorMentionId = PlayerDataCenter:GetLastRemoteSectorMentionId()
  if remoteLastSectorMentionId < sectorMentionId then
    ((self.bind).camTarget):SetPosType(sectorMentionId)
    self:RecordSelectModelDataLocaly(sectorMentionId)
    local completeRecord = BindCallback(self, function(table, id)
    -- function num : 0_10_0 , upvalues : _ENV
    PlayerDataCenter:RecordLastRemoteSectorMentionId(id)
  end
, sectorMentionId)
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_User_ClientLastSectorMention(sectorMentionId, completeRecord)
    return sectorMentionId
  end
  do
    if self.localModelData == nil then
      self.localModelData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
      if self.localModelData == nil then
        return sectorMentionId
      end
    end
    local localSectorMentionId = (self.localModelData):GetLastLocalSectorMentionId()
    if localSectorMentionId ~= nil and localSectorMentionId > 0 then
      ((self.bind).camTarget):SetPosType(localSectorMentionId)
      return localSectorMentionId
    end
    if focusMetionList[sectorMentionId] ~= nil then
      ((self.bind).camTarget):SetPosType(sectorMentionId)
    end
    return sectorMentionId
  end
end

SectorController.InitRedDotEvent = function(self)
  -- function num : 0_11 , upvalues : _ENV
  for k,v in pairs(self.sctItemDic) do
    local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, v.id)
    if node:GetRedDotCount() <= 0 then
      v:ShowSctItemRedDot(not ok)
      local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, RedDotStaticTypeId.SectorBuilding, v.id)
      if node:GetRedDotCount() <= 0 then
        do
          v:ShowSctResRedDot(not ok)
          -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  self.__sectorItemRedDotEvent = function(node)
    -- function num : 0_11_0 , upvalues : self
    ((self.sctItemDic)[node.nodeId]):ShowSctItemRedDot(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  RedDotController:AddListener(RedDotDynPath.SectorItemPath, self.__sectorItemRedDotEvent)
  self.__sectorBuildRedDotEvent = function(node)
    -- function num : 0_11_1 , upvalues : self
    ((self.sctItemDic)[node.nodeId]):ShowSctResRedDot(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  RedDotController:AddListener(RedDotDynPath.SectorBuildingPath, self.__sectorBuildRedDotEvent)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

SectorController.RemoveRedDotEvent = function(self)
  -- function num : 0_12 , upvalues : _ENV
  RedDotController:RemoveListener(RedDotDynPath.SectorItemPath, self.__sectorItemRedDotEvent)
  RedDotController:RemoveListener(RedDotDynPath.SectorBuildingPath, self.__sectorBuildRedDotEvent)
end

SectorController.OnUpdate = function(self)
  -- function num : 0_13
  self:__UpdateTimer()
end

SectorController.__UpdateTimer = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local timestamp = PlayerDataCenter.timestamp
  if self.__timeSecond == nil then
    self.__timeSecond = timestamp
  end
  local isSecond = false
  if self.__timeSecond + 1 < timestamp then
    self.__timeSecond = self.__timeSecond + 1
    isSecond = true
  end
  if self.uiBuildingWindow ~= nil then
    (self.uiBuildingWindow):Update(timestamp, isSecond)
  end
  local queueCtrl = ControllerManager:GetController(ControllerTypeId.BuildingQueue)
  if queueCtrl ~= nil then
    queueCtrl:UpdateBuildQueueSecond(timestamp, isSecond)
  end
  if isSecond then
    self:UpdateAllSctBuildRes()
  end
end

SectorController.SetUIBuildingWindow = function(self, window)
  -- function num : 0_15
  self.uiBuildingWindow = window
end

SectorController.SetFrom = function(self, from, argFunc, fromArg)
  -- function num : 0_16 , upvalues : _ENV, eSectorState, util
  self.__sectorFromArg = fromArg
  AudioManager:PlayAudioById(3002)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Home).name, (eAuSelct.Home).sector)
  if from == AreaConst.Home or from == AreaConst.Oasis then
    (self.sectorToHomeGo):SetActive(false)
    ;
    (self.homeToSectorGo):SetActive(true)
    if fromArg ~= nil then
      self:SetForceFocus(fromArg)
    else
      self:DetectedGeneralDungeonUnlock()
    end
    ;
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
    ;
    (self.homeToSectorDirector):Play()
  else
    if from == AreaConst.Exploration then
      (self.sectorToHomeGo):SetActive(false)
      ;
      (self.homeToSectorGo):SetActive(true)
      local func = function()
    -- function num : 0_16_0 , upvalues : self, _ENV, eSectorState
    self:__OnEnterSector()
    while 1 do
      if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
        (coroutine.yield)(nil)
        -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    local UncompletedEpSectorStateCfg = ExplorationManager:TryGetUncompletedEpSectorStateCfg()
    if (PlayerDataCenter.sectorStage).lastSelectSector ~= nil then
      UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
      -- function num : 0_16_0_0 , upvalues : self, eSectorState, _ENV
      if window == nil then
        return 
      end
      self.sctState = eSectorState.SelectSectorLevel
      ;
      (self.uiCanvas):Hide()
      UIManager:HideWindow(UIWindowTypeID.Sector)
      window:InitSectorLevel((PlayerDataCenter.sectorStage).lastSelectSector, self.__ResetToNormalState)
    end
)
    else
      while 1 do
        if (PlayerDataCenter.sectorStage).lastPeriodicChallenge ~= nil or UncompletedEpSectorStateCfg ~= nil and UncompletedEpSectorStateCfg.challengeCfg ~= nil then
          if (PlayerDataCenter.periodicChallengeData):GetIsDailyOutOfData() then
            (coroutine.yield)(nil)
            -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      UIManager:ShowWindowAsync(UIWindowTypeID.DailyChallenge, function(window)
      -- function num : 0_16_0_1 , upvalues : self
      if window == nil then
        return 
      end
      self:OnEnterDailyChallenge()
      window:InitPeriodicChallenge(function(tohome)
        -- function num : 0_16_0_1_0 , upvalues : self
        self:ResetToNormalState(tohome)
      end
)
      window:__OnClickDailyBtn()
    end
)
    end
    self:ResetToNormalState(false)
  end

      self.__fromEpCoroutine = (GR.StartCoroutine)((util.cs_generator)(func))
    else
      do
        if from == AreaConst.FriendshipMoments then
          (self.sectorToHomeGo):SetActive(false)
          ;
          (self.homeToSectorGo):SetActive(true)
          self.homeToSectorDirectorArgFunc = argFunc
          ;
          (self.homeToSectorDirector):stopped("+", argFunc)
          self:DetectedGeneralDungeonUnlock()
          ;
          (self.homeToSectorDirector):Play()
        else
          if from == AreaConst.DungeonBattle then
            (self.sectorToHomeGo):SetActive(false)
            ;
            (self.homeToSectorGo):SetActive(true)
            self.homeToSectorDirectorArgFunc = argFunc
            ;
            (self.homeToSectorDirector):stopped("+", argFunc)
            self:DetectedGeneralDungeonUnlock()
            ;
            (self.homeToSectorDirector):Play()
          end
        end
      end
    end
  end
end

SectorController.ResetToNormalState = function(self, toHome)
  -- function num : 0_17 , upvalues : eSectorState, _ENV
  self.sctState = eSectorState.Normal
  ;
  (self.uiCanvas):Show()
  local sectorUI = UIManager:GetWindow(UIWindowTypeID.Sector)
  if sectorUI ~= nil and not sectorUI.active then
    sectorUI:Show()
  end
  if toHome == false then
    self:DetectedGeneralDungeonUnlock()
  end
  if toHome or GuideManager:TryTriggerGuide(eGuideCondition.InSectorSceneNormal) then
  end
end

SectorController.IsSectorNormalState = function(self)
  -- function num : 0_18 , upvalues : eSectorState
  do return self.sctState == eSectorState.Normal end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SectorController.OnEnterPlotOrMateralDungeon = function(self)
  -- function num : 0_19 , upvalues : eSectorState
  self.sctState = eSectorState.DungeonWindow
end

SectorController.OnEnterDailyChallenge = function(self)
  -- function num : 0_20 , upvalues : eSectorState
  self.sctState = eSectorState.DailyChallenge
  self:EnbleSectorUI3D(false)
end

SectorController.OnSectorItemClicked = function(self, sectorId)
  -- function num : 0_21 , upvalues : _ENV, cs_MessageCommon, eSectorState
  if self:IsDisableClick() then
    return 
  end
  local isSectorUnlock = (PlayerDataCenter.sectorStage):IsSectorUnlock(sectorId)
  if not isSectorUnlock then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Sector_Locked))
    return 
  end
  if (self.__lastEpSectorId ~= nil and self.__lastEpSectorId ~= sectorId) or self.__challengeUncomplete then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Sector_HasExpNotFinished))
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
    -- function num : 0_21_0 , upvalues : self, eSectorState, _ENV, sectorId
    if window == nil then
      return 
    end
    self.sctState = eSectorState.SelectSectorLevel
    ;
    (self.uiCanvas):Hide()
    UIManager:HideWindow(UIWindowTypeID.Sector)
    window:InitSectorLevel(sectorId, self.__ResetToNormalState)
    self:RecordSelectModelDataLocaly(sectorId * 10)
  end
)
end

SectorController.HasUnfinishEp = function(self)
  -- function num : 0_22
  do return self.__lastEpSectorId ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SectorController.OnBtnHomeClicked = function(self)
  -- function num : 0_23 , upvalues : eSectorState, _ENV
  if self.sctState == eSectorState.None then
    return 
  end
  self.sctState = eSectorState.None
  AudioManager:PlayAudioById(1017)
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
  if self.sectorToHomeGo ~= nil then
    (self.sectorToHomeGo):SetActive(true)
    ;
    (self.homeToSectorGo):SetActive(false)
  end
  ;
  (self.sectorToHomeDirector):Play()
  ;
  (self.sectorToHomeDirector):stopped("+", self.sectorToHomeDirectorStopped)
end

SectorController.OnSectorToHomeDirectorStopped = function(self, director)
  -- function num : 0_24 , upvalues : _ENV
  if self.sectorToHomeDirector == director then
    (self.sectorToHomeDirector):stopped("-", self.sectorToHomeDirectorStopped)
    ;
    ((CS.GSceneManager).Instance):LoadSceneByAB((Consts.SceneName).Main, function()
    -- function num : 0_24_0 , upvalues : _ENV
    ControllerManager:DeleteController(ControllerTypeId.SectorController)
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_24_0_0 , upvalues : _ENV
      if window == nil then
        return 
      end
      window:SetFrom2Home(AreaConst.Sector, true)
    end
)
  end
)
  end
end

SectorController.OnHomeToSectorDirectorStopped = function(self, director)
  -- function num : 0_25 , upvalues : eSectorState
  if self.homeToSectorDirector == director then
    (self.homeToSectorDirector):stopped("-", self.homeToSectorDirectorStopped)
    self:__OnEnterSector()
    if self.sctState == eSectorState.None and self.__sectorFromArg == nil then
      self:ResetToNormalState()
    end
    if self.homeToSectorDirectorArgFunc ~= nil then
      (self.homeToSectorDirector):stopped("-", self.homeToSectorDirectorArgFunc)
      self.homeToSectorDirectorArgFunc = nil
    end
  end
end

SectorController.__OnEnterSector = function(self)
  -- function num : 0_26 , upvalues : _ENV
  self.enableClick = true
  ;
  (self.camCtrl):InitSectorCameraCtrl()
  UIManager:ShowWindowAsync(UIWindowTypeID.Sector, function(window)
    -- function num : 0_26_0 , upvalues : self, _ENV
    window:InitUISector(self)
    ;
    (UIUtil.SetTopStatus)(self, self.OnBtnHomeClicked, {ConstGlobalItem.SKey})
    self:UpdateAllSctBuildRes()
  end
)
end

SectorController.ShowStrategyOverview = function(self, sectorId)
  -- function num : 0_27 , upvalues : _ENV, cs_MessageCommon, eSectorState
  if self:IsDisableClick() then
    return 
  end
  if not self.isSectorBuildingUnlock then
    return 
  end
  do
    if sectorId ~= nil then
      local isSectorUnlock = (PlayerDataCenter.sectorStage):IsSectorUnlock(sectorId)
      if not isSectorUnlock then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Sector_Locked))
        return 
      end
    end
    self.sctState = eSectorState.ShowSto
    local ctrl = ControllerManager:GetController(ControllerTypeId.StrategyOverview, true)
    ctrl:InitStOCtrl(sectorId, function()
    -- function num : 0_27_0 , upvalues : self
    self:OnStrategyOverviewClose()
  end
)
  end
end

SectorController.OnStrategyOverviewClose = function(self)
  -- function num : 0_28 , upvalues : _ENV
  if ControllerManager:GetController(ControllerTypeId.SectorController) == nil then
    return 
  end
  self:ResetToNormalState()
end

SectorController.CollectAllSctBuildRes = function(self)
  -- function num : 0_29 , upvalues : _ENV
  local buildingIdDic = {}
  for k,sctItem in pairs(self.sctItemDic) do
    sctItem:GetSctCanGetResBuild(buildingIdDic)
  end
  local canGetRes = false
  for k,v in pairs(buildingIdDic) do
    canGetRes = true
    do break end
  end
  do
    if canGetRes then
      if self.__onCollectAllBuildResComplete == nil then
        self.__onCollectAllBuildResComplete = BindCallback(self, self.OnCollectAllSctBuildResComplete)
      end
      ;
      (self.buildingNetworkCtr):SendBuildingCollectGroup(buildingIdDic, self.__onCollectAllBuildResComplete)
    end
  end
end

SectorController.OnCollectAllSctBuildResComplete = function(self, objList)
  -- function num : 0_30 , upvalues : _ENV, cs_MessageCommon
  if objList.Count == 0 then
    return 
  end
  local resDic = objList[0]
  self:UpdateAllSctBuildRes()
  for itemId,count in pairs(resDic) do
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg ~= nil then
      local msg = ConfigData:GetTipContent(TipContent.Building_GainReward) .. (LanguageUtil.GetLocaleText)(itemCfg.name) .. " x " .. tostring(count)
      ;
      (cs_MessageCommon.ShowMessageTips)(msg, true)
    end
  end
end

SectorController.FinishBuilding = function(self, id)
  -- function num : 0_31 , upvalues : _ENV, cs_MessageCommon
  local buildingData = ((PlayerDataCenter.AllBuildingData).built)[id]
  if not buildingData.waitConfirmOver then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Building_Incomplete))
    return 
  end
  ;
  (self.buildingNetworkCtr):SendBuildingConfirmOver(id)
end

SectorController.ConfirmOver = function(self, id)
  -- function num : 0_32 , upvalues : _ENV, BuildingBelong, cs_MessageCommon
  local buildingData = ((PlayerDataCenter.AllBuildingData).built)[id]
  if buildingData ~= nil and buildingData.belong == BuildingBelong.Sector then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Building_NoticeConstructFinish) .. buildingData.name)
  end
  for k,sctItem in pairs(self.sctItemDic) do
    for k2,buildingId in pairs((sctItem.sectorCfg).building) do
      if buildingId == id then
        sctItem:RefreshSctBuildProgress()
        break
      end
    end
  end
end

SectorController.UpdateUncompletedEp = function(self)
  -- function num : 0_33 , upvalues : _ENV
  local lastEpStateCfg = ExplorationManager:TryGetUncompletedEpSectorStateCfg()
  if lastEpStateCfg ~= nil then
    if lastEpStateCfg.challengeCfg ~= nil then
      self.__challengeUncomplete = true
    end
    local sectorItem = (self.sctItemDic)[lastEpStateCfg.sector]
    if sectorItem ~= nil then
      sectorItem:ShowSctItemInEp(true)
      self.__lastEpSectorId = lastEpStateCfg.sector
    end
  else
    do
      if self.__lastEpSectorId ~= nil or self.__challengeUncomplete then
        local sectorItem = (self.sctItemDic)[self.__lastEpSectorId]
        if sectorItem ~= nil then
          sectorItem:ShowSctItemInEp(false)
        end
        self.__lastEpSectorId = nil
        self.__challengeUncomplete = nil
      end
    end
  end
end

SectorController.OnSctStageStateChange = function(self, data)
  -- function num : 0_34 , upvalues : _ENV
  local sectorIdDic = {}
  for stageId,v in pairs(data) do
    if (PlayerDataCenter.sectorStage):IsStageComplete(stageId) then
      local stageCfg = (ConfigData.sector_stage)[stageId]
      if stageCfg == nil then
        error("Can\'t get sector_stage cfg, stageId = " .. tostring(stageId))
        return 
      end
      sectorIdDic[stageCfg.sector] = true
    end
  end
  for sectorId,v in pairs(sectorIdDic) do
    local sctItem = (self.sctItemDic)[sectorId]
    if sctItem ~= nil then
      sctItem:RefreshSctStageProress()
    end
  end
end

SectorController.UpdateAllSctBuildRes = function(self)
  -- function num : 0_35 , upvalues : _ENV
  local allResDic = {}
  local allHasRes = false
  for sectorId,sctItem in pairs(self.sctItemDic) do
    local curSctResDic = {}
    local hasRes = false
    for k,buildId in pairs((sctItem.sectorCfg).building) do
      local builtData = ((PlayerDataCenter.AllBuildingData).built)[buildId]
      if builtData ~= nil and builtData.resDatas ~= nil then
        local resDatas = builtData:GetResDatas()
        for itemId,resData in pairs(resDatas) do
          self:__AddBuildRes(allResDic, resData, resDatas.countMax)
          self:__AddBuildRes(curSctResDic, resData, resDatas.countMax)
          hasRes = true
          allHasRes = true
        end
      end
    end
  end
  local uiSector = UIManager:GetWindow(UIWindowTypeID.Sector)
  if uiSector ~= nil then
    uiSector:UpdateUIAllSctBuildRes(allResDic, allHasRes)
  end
end

SectorController.__AddBuildRes = function(self, allResDic, resData, countMax)
  -- function num : 0_36
  local allResData = allResDic[resData.id]
  if allResData == nil then
    allResData = {id = resData.id, name = resData.name, count = resData.count, speed = resData.speed, effSpeed = resData.effSpeed, progress = resData.progress, countMax = countMax}
    allResDic[resData.id] = allResData
  else
    allResData.effSpeed = allResData.effSpeed + resData.effSpeed
    allResData.speed = allResData.speed + resData.speed
    allResData.count = allResData.count + resData.count
    allResData.countMax = allResData.countMax + countMax
  end
end

SectorController.EnableSectorCamDrag = function(self)
  -- function num : 0_37 , upvalues : eSectorState
  do return self.sctState == eSectorState.Normal end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SectorController.EnbleSectorUI3D = function(self, enable)
  -- function num : 0_38
  if enable then
    (self.uiCanvas):Show()
  else
    ;
    (self.uiCanvas):Hide()
  end
end

SectorController.IsDisableClick = function(self)
  -- function num : 0_39 , upvalues : eSectorState
  do return (self.camCtrl):InSctCamDrag() or self.sctState ~= eSectorState.Normal end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

SectorController.OnDelete = function(self)
  -- function num : 0_40 , upvalues : _ENV
  for k,v in pairs(self.ctrls) do
    v:OnDelete()
  end
  self.ctrls = nil
  if self.__initCoroutine ~= nil then
    (GR.StopCoroutine)(self.__initCoroutine)
  end
  if self.__fromEpCoroutine ~= nil then
    (GR.StopCoroutine)(self.__fromEpCoroutine)
  end
  UpdateManager:RemoveUpdate(self.__update__handle)
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.BuildingUpgradeComplete, self.__ConfirmOver)
  MsgCenter:RemoveListener(eMsgEventId.OnSectorStageStateChange, self.__onSctStageStateChange)
  self:RemoveRedDotEvent()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Building)):OnRedDotBuildingTimerUpdate()
  for k,v in pairs(self.sctItemDic) do
    v:OnDelete()
  end
  if self.uiCanvas ~= nil then
    (self.uiCanvas):Delete()
  end
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  UIManager:DeleteWindow(UIWindowTypeID.Sector)
  UIManager:DeleteWindow(UIWindowTypeID.SectorLevel)
  ControllerManager:DeleteController(ControllerTypeId.BuildingQueue)
  PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
end

return SectorController

