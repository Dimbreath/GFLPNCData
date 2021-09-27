local SectorController = class("SectorController", ControllerBase)
local cs_GameObject = (CS.UnityEngine).GameObject
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_GameData_ins = (CS.GameData).instance
local cs_DoTween = ((CS.DG).Tweening).DOTween
local SectorCameraCtrl = require("Game.Sector.Ctrl.SectorCameraCtrl")
local SectorItemEntity = require("Game.Sector.Entity.SectorItemEntity")
local DungeonTypeData = require("Game.Dungeon.DungeonTypeData")
local UI3DSectorCanvas = require("Game.Sector.UI3D.UI3DSectorCanvas")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local util = require("XLua.Common.xlua_util")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local JumpManager = require("Game.Jump.JumpManager")
local SectorEnum = require("Game.Sector.SectorEnum")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local eSectorState = {None = 0, Normal = 1, ShowSto = 2, SelectSectorLevel = 3, DungeonWindow = 4, DailyDungeon = 5, WeeklyChallenge = 6}
SectorController.ctor = function(self)
  -- function num : 0_0 , upvalues : SectorCameraCtrl, _ENV
  self.ctrls = {}
  self.camCtrl = (SectorCameraCtrl.New)(self)
  self.__onClickSectorItem = BindCallback(self, self.OnSectorItemClicked)
  self.__ShowStrategyOverview = BindCallback(self, self.ShowStrategyOverview)
  self.__ResetToNormalState = BindCallback(self, self.ResetToNormalState)
end

SectorController.OnInit = function(self)
  -- function num : 0_1 , upvalues : eSectorState, cs_GameObject, _ENV, cs_ResLoader, UI3DSectorCanvas, BuildingBelong
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
    ;
    (UIUtil.CloseOneCover)("homeToSectorDirector")
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
  self:InitSectorItems()
  self:UpdateUncompletedEp()
  ;
  (((CS.EventTriggerListener).Get)((self.bind).homeCollider)):onClick("+", function()
    -- function num : 0_1_2 , upvalues : self, _ENV
    if self:IsDisableClick() then
      return 
    end
    ;
    (UIUtil.ReturnHome)()
  end
)
  local queueCtrl = ControllerManager:GetController(ControllerTypeId.BuildingQueue, true)
  queueCtrl:InitBuildQueueCtrl(BuildingBelong.Sector)
  self:InitRedDotEvent()
  self:__InitChallenge()
  local isSectorBuildingUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding)
  self:UnlockBuildFocusEnter(isSectorBuildingUnlock)
end

SectorController.__InitChallenge = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyDungeon) then
    (self.uiCanvas):SetDailyDungeonInfo(false)
  else
    ;
    (self.uiCanvas):SetDailyDungeonInfo(true)
  end
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge) then
    (self.uiCanvas):SetWeeklyChallengeInfo(false)
  else
    if (PlayerDataCenter.allWeeklyChallengeData):IsOutOfData() then
      (NetworkManager:GetNetwork(NetworkTypeID.Sector)):CS_WEEKLYCHALLENGE_Detail(function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    (self.uiCanvas):SetWeeklyChallengeInfo((PlayerDataCenter.allWeeklyChallengeData):IsExistChallenge())
  end
)
    else
      ;
      (self.uiCanvas):SetWeeklyChallengeInfo((PlayerDataCenter.allWeeklyChallengeData):IsExistChallenge())
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
  -- function num : 0_4 , upvalues : _ENV, SectorItemEntity, SectorEnum
  self.lastSectorId = nil
  local lastSectorPriority = 0
  self.needPlayEndVideo = {sectorId = nil, flag = nil, Animaflag = nil}
  local maxUnlockSectorId = 0
  local maxPlayedAnimaSectorId = 0
  if self.localModelData == nil then
    self.localModelData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
    if self.localModelData ~= nil then
      maxUnlockSectorId = (self.localModelData):GetLastLocalMaxUnlockSectorId(false)
      maxPlayedAnimaSectorId = (self.localModelData):GetLastLocalMaxUnlockSectorId(true)
    end
  end
  local nowMaxUnlockSectorId = maxUnlockSectorId
  for sectorId,go in ipairs((self.bind).sectorGoList) do
    if (ConfigData.sector)[sectorId] ~= nil then
      local isUnlock = (PlayerDataCenter.sectorStage):IsSectorUnlock(sectorId)
      if isUnlock then
        local focusId = self:__GetSectorFocusId(sectorId)
        local focusCfg = (ConfigData.sector_unlock_mention)[focusId]
        if focusCfg ~= nil and lastSectorPriority < focusCfg.focus_priority then
          self.lastSectorId = sectorId
          lastSectorPriority = focusCfg.focus_priority
        end
        if nowMaxUnlockSectorId < sectorId then
          nowMaxUnlockSectorId = sectorId
        end
      end
      do
        local sctInfoItem = (self.uiCanvas):AddSctInfoItem(sectorId, self.__onClickSectorItem)
        local sctProgressStage = (self.uiCanvas):AddSctProgressStage(sectorId, self.__onClickSectorItem)
        local sctProgressBuild = (self.uiCanvas):AddSctProgressBuild(sectorId, self.__ShowStrategyOverview)
        do
          local sctItemEntity = (SectorItemEntity.New)(self)
          sctItemEntity:InitSectorItemEntity(go, sectorId, sctInfoItem, sctProgressStage, sctProgressBuild, self.uiCanvas)
          sctItemEntity:SetIsSectorBuildingUnlock(self.isSectorBuildingUnlock)
          -- DECOMPILER ERROR at PC96: Confused about usage of register: R15 in 'UnsetPending'

          ;
          (self.sctItemDic)[sectorId] = sctItemEntity
          -- DECOMPILER ERROR at PC97: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC97: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC97: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if nowMaxUnlockSectorId ~= 1 and (PlayerDataCenter.sectorStage):IsSectorClear(nowMaxUnlockSectorId - 1) then
    local sectorStage = ((ConfigData.sector_stage).sectorIdList)[nowMaxUnlockSectorId]
    if sectorStage ~= nil and #sectorStage ~= 0 then
      local sectorStageCfg = (ConfigData.sector_stage)[sectorStage[1]]
      local stageId = sectorStageCfg.id
      -- DECOMPILER ERROR at PC132: Confused about usage of register: R8 in 'UnsetPending'

      if not (PlayerDataCenter.sectorStage):IsStageComplete(stageId) then
        if maxUnlockSectorId < nowMaxUnlockSectorId then
          (self.needPlayEndVideo).sectorId = nowMaxUnlockSectorId
          -- DECOMPILER ERROR at PC134: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self.needPlayEndVideo).flag = true
        else
          -- DECOMPILER ERROR at PC139: Confused about usage of register: R8 in 'UnsetPending'

          if maxPlayedAnimaSectorId < nowMaxUnlockSectorId then
            (self.needPlayEndVideo).sectorId = nowMaxUnlockSectorId
            -- DECOMPILER ERROR at PC141: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (self.needPlayEndVideo).Animaflag = true
            local sctItemEntity = (self.sctItemDic)[nowMaxUnlockSectorId]
            sctItemEntity:SetEmissiveNum(0)
            local sectorInfoUI = ((self.uiCanvas).sctInfoDic)[nowMaxUnlockSectorId]
            local sectorProgressUI = ((self.uiCanvas).sctProgressStageDic)[nowMaxUnlockSectorId]
            -- DECOMPILER ERROR at PC155: Confused about usage of register: R11 in 'UnsetPending'

            ;
            ((sectorInfoUI.ui).fade).alpha = 0
            for key,value in pairs((sectorInfoUI.ui).nameFades) do
              value.alpha = 0
            end
            -- DECOMPILER ERROR at PC166: Confused about usage of register: R11 in 'UnsetPending'

            ;
            ((sectorProgressUI.ui).progressFade).alpha = 0
          end
        end
      end
    end
  end
  do
    ;
    (self.uiCanvas):CreateNewBeeSectorItem(SectorEnum.NewbeeSectorId, self.__onClickSectorItem)
    if self.lastSectorId == nil then
      self.lastSectorId = SectorEnum.NewbeeSectorId
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
  -- function num : 0_7 , upvalues : _ENV, eDungeonEnum, DungeonTypeData
  for dungeonType,systemFuncId in pairs(eDungeonEnum.systemFunctionID4DungeonType) do
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

SectorController.__GetSectorFocusId = function(self, sectorId)
  -- function num : 0_9
  return sectorId * 10
end

SectorController.CheckDungeonInSector = function(self, lastSectorId, focusMetionList)
  -- function num : 0_10 , upvalues : cs_GameData_ins, _ENV
  lastSectorId = self:__GetSectorFocusId(lastSectorId)
  local lastId = lastSectorId
  if focusMetionList[lastId] == nil then
    return lastId
  end
  local dungeonList = (cs_GameData_ins.listDungeonTypeDatas):GetList()
  if dungeonList ~= nil and dungeonList.Count > 0 then
    for i = 0, dungeonList.Count - 1 do
      local id = (dungeonList[i]):GetSectorMentionId()
      local moduelId = (dungeonList[i]):GetFunctionId()
      if focusMetionList[id] ~= nil and (focusMetionList[lastId]).focus_priority < (focusMetionList[id]).focus_priority and FunctionUnlockMgr:ValidateUnlock(moduelId) then
        lastId = id
      end
    end
  end
  do
    return lastId
  end
end

SectorController.FocusSectorAndMentioned = function(self, sectorMentionId, focusMetionList)
  -- function num : 0_11 , upvalues : _ENV
  local remoteLastSectorMentionId = PlayerDataCenter:GetLastRemoteSectorMentionId()
  local remoteFocus = 0
  if focusMetionList[remoteLastSectorMentionId] ~= nil then
    remoteFocus = (focusMetionList[remoteLastSectorMentionId]).focus_priority
  end
  if focusMetionList[sectorMentionId] ~= nil and remoteFocus < (focusMetionList[sectorMentionId]).focus_priority then
    ((self.bind).camTarget):SetPosType(sectorMentionId)
    self:RecordSelectModelDataLocaly(sectorMentionId)
    local completeRecord = BindCallback(self, function(table, id)
    -- function num : 0_11_0 , upvalues : _ENV
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
  -- function num : 0_12 , upvalues : _ENV
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
    -- function num : 0_12_0 , upvalues : self
    ((self.sctItemDic)[node.nodeId]):ShowSctItemRedDot(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  RedDotController:AddListener(RedDotDynPath.SectorItemPath, self.__sectorItemRedDotEvent)
  self.__RefreshBuildingReddot = BindCallback(self, self.RefreshBuildingReddot)
  RedDotController:AddListener(RedDotDynPath.StrategyOverviewPath, self.__RefreshBuildingReddot)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

SectorController.RemoveRedDotEvent = function(self)
  -- function num : 0_13 , upvalues : _ENV
  RedDotController:RemoveListener(RedDotDynPath.SectorItemPath, self.__sectorItemRedDotEvent)
  RedDotController:RemoveListener(RedDotDynPath.StrategyOverviewPath, self.__RefreshBuildingReddot)
end

SectorController.OnUpdate = function(self)
  -- function num : 0_14
  self:__UpdateTimer()
end

SectorController.__UpdateTimer = function(self)
  -- function num : 0_15 , upvalues : _ENV
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
  end
end

SectorController.SetUIBuildingWindow = function(self, window)
  -- function num : 0_16
  self.uiBuildingWindow = window
end

SectorController.SetFrom = function(self, from, argFunc, fromArg, lastSatgeData)
  -- function num : 0_17 , upvalues : _ENV, eSectorState, SectorLevelDetailEnum, eDungeonEnum, util
  self.__sectorFromArg = fromArg
  AudioManager:PlayAudioById(3002)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Home).name, (eAuSelct.Home).sector)
  if (self.needPlayEndVideo).flag then
    local win = UIManager:ShowWindow(UIWindowTypeID.SectorUnlockMovie)
    local couldPlay = win:TryPlayVideo((self.needPlayEndVideo).sectorId - 1)
    if couldPlay then
      UIManager:ShowWindow(UIWindowTypeID.MovieBlack)
    end
    self.__isPlayingVideo = couldPlay
  end
  do
    local waitEnterCo = function()
    -- function num : 0_17_0 , upvalues : from, _ENV, self, fromArg, lastSatgeData, eSectorState, SectorLevelDetailEnum, eDungeonEnum, argFunc
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
      (UIUtil.AddOneCover)("homeToSectorDirector")
      ;
      (self.homeToSectorDirector):Play()
    else
      if from == AreaConst.Exploration then
        (self.sectorToHomeGo):SetActive(false)
        ;
        (self.homeToSectorGo):SetActive(true)
        self:EnbleSectorUI3D(false)
        -- DECOMPILER ERROR at PC57: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (PlayerDataCenter.sectorStage).lastSatgeData = lastSatgeData
        self:__OnEnterSector()
        while 1 do
          if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
            (coroutine.yield)(nil)
            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
        local UncompletedEpSectorStateCfg = ExplorationManager:TryGetUncompletedEpSectorStateCfg()
        do
          local lastSelectSector = (PlayerDataCenter.sectorStage):GetSelectSectorId()
          if lastSelectSector then
            (UIUtil.AddOneCover)("lastSelectSector")
            UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
      -- function num : 0_17_0_0 , upvalues : self, eSectorState, _ENV, lastSelectSector
      if window == nil then
        return 
      end
      self:EnbleSectorUI3D(true)
      self.sctState = eSectorState.SelectSectorLevel
      ;
      (self.uiCanvas):Hide()
      UIManager:HideWindow(UIWindowTypeID.Sector)
      window:InitSectorLevel(lastSelectSector, self.__ResetToNormalState, nil, nil, self.__isPlayingVideo)
      ;
      (UIUtil.CloseOneCover)("lastSelectSector")
    end
)
          else
            if (PlayerDataCenter.sectorStage).lastChallengeType == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge or UncompletedEpSectorStateCfg ~= nil and UncompletedEpSectorStateCfg.difficulty == (SectorLevelDetailEnum.eDifficulty).weekly_challenge then
              if (PlayerDataCenter.allWeeklyChallengeData):IsExistChallenge() then
                UIManager:ShowWindowAsync(UIWindowTypeID.DailyChallenge, function(window)
      -- function num : 0_17_0_1 , upvalues : self, lastSatgeData
      if window == nil then
        return 
      end
      self:EnbleSectorUI3D(true)
      self:OnEnterWeeklyChallenge()
      window:InitWeeklyChallenge(function(tohome)
        -- function num : 0_17_0_1_0 , upvalues : self
        self:ResetToNormalState(tohome)
      end
)
      if lastSatgeData == nil or not lastSatgeData.isWin then
        window:OnClickWeeklyBtn()
      end
    end
)
              else
                self:ResetToNormalState(false)
              end
            else
              self:ResetToNormalState(false)
            end
          end
          -- DECOMPILER ERROR at PC139: Confused about usage of register: R2 in 'UnsetPending'

          ;
          (PlayerDataCenter.sectorStage).lastSatgeData = nil
        end
      else
        do
          if from == AreaConst.FriendshipMoments then
            (self.sectorToHomeGo):SetActive(false)
            ;
            (self.homeToSectorGo):SetActive(true)
            self:DetectedGeneralDungeonUnlock()
            ;
            (UIUtil.AddOneCover)("homeToSectorDirector")
            ;
            (self.homeToSectorDirector):Play()
          else
            if from == AreaConst.DungeonBattle then
              (self.sectorToHomeGo):SetActive(false)
              ;
              (self.homeToSectorGo):SetActive(true)
              self:DetectedGeneralDungeonUnlock()
              if lastSatgeData ~= nil and lastSatgeData.dungeonType == (eDungeonEnum.eDungeonType).fragDungeon then
                self:EnbleSectorUI3D(false)
                self:__OnEnterSector()
              else
                ;
                (UIUtil.AddOneCover)("homeToSectorDirector")
                ;
                (self.homeToSectorDirector):Play()
              end
            end
          end
          while 1 do
            if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
              (coroutine.yield)(nil)
              -- DECOMPILER ERROR at PC224: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC224: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
          if argFunc ~= nil then
            argFunc()
          end
          if self.__JumpInCallback ~= nil then
            (self.__JumpInCallback)()
            self.__JumpInCallback = nil
          end
          if self.needPlayEndVideo ~= nil and (self.needPlayEndVideo).Animaflag then
            self:ShowUnlockSectorEffect((self.needPlayEndVideo).sectorId)
            UIManager:ShowWindow(UIWindowTypeID.MovieBlack)
          end
        end
      end
    end
  end

    self.__fromEpCoroutine = (GR.StartCoroutine)((util.cs_generator)(waitEnterCo))
  end
end

SectorController.SetJumpInCallback = function(self, jumpInCallback)
  -- function num : 0_18
  self.__JumpInCallback = jumpInCallback
end

SectorController.ResetToNormalState = function(self, toHome)
  -- function num : 0_19 , upvalues : eSectorState, _ENV, JumpManager
  self.sctState = eSectorState.Normal
  ;
  (self.uiCanvas):Show()
  local sectorUI = UIManager:GetWindow(UIWindowTypeID.Sector)
  local completeIntro = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CompleteIntro)
  if completeIntro and sectorUI ~= nil and not sectorUI.active then
    sectorUI:Show()
  end
  if toHome == false then
    self:DetectedGeneralDungeonUnlock()
  end
  if toHome or JumpManager:GetIsJumping() or self.__isPlayingUnlockAnima or self.__isPlayingVideo or GuideManager:TryTriggerGuide(eGuideCondition.InSectorSceneNormal) then
  end
end

SectorController.IsSectorNormalState = function(self)
  -- function num : 0_20 , upvalues : eSectorState
  do return self.sctState == eSectorState.Normal end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SectorController.OnEnterPlotOrMateralDungeon = function(self)
  -- function num : 0_21 , upvalues : eSectorState
  self.sctState = eSectorState.DungeonWindow
  self:EnbleSectorUI3D(false)
end

SectorController.OnEnterDailyDungeon = function(self)
  -- function num : 0_22 , upvalues : eSectorState
  self.sctState = eSectorState.DailyDungeon
  self:EnbleSectorUI3D(false)
end

SectorController.OnEnterWeeklyChallenge = function(self)
  -- function num : 0_23 , upvalues : eSectorState
  self.sctState = eSectorState.WeeklyChallenge
  self:EnbleSectorUI3D(false)
end

SectorController.OnSectorItemClicked = function(self, sectorId, difficuty, stageCfg)
  -- function num : 0_24 , upvalues : _ENV, cs_MessageCommon, eSectorState
  if self:IsDisableClick() then
    return 
  end
  local isSectorUnlock = (PlayerDataCenter.sectorStage):IsSectorUnlock(sectorId)
  if not isSectorUnlock then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Sector_Locked))
    return 
  end
  if (self.__lastEpSectorId ~= nil and self.__lastEpSectorId ~= sectorId) or self.__challengeUncomplete then
    ExplorationManager:TryToShowCurrentLevelTips()
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
    -- function num : 0_24_0 , upvalues : self, eSectorState, _ENV, sectorId, difficuty, stageCfg
    if window == nil then
      return 
    end
    self.sctState = eSectorState.SelectSectorLevel
    ;
    (self.uiCanvas):Hide()
    UIManager:HideWindow(UIWindowTypeID.Sector)
    window:InitSectorLevel(sectorId, self.__ResetToNormalState, difficuty, stageCfg)
    self:RecordSelectModelDataLocaly(sectorId * 10)
  end
)
end

SectorController.HasUnfinishEp = function(self)
  -- function num : 0_25
  do return self.__lastEpSectorId ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SectorController.IsUnfinishEp = function(self, stageCfg)
  -- function num : 0_26 , upvalues : _ENV, SectorLevelDetailEnum
  local lastEpCfg = ExplorationManager:TryGetUncompletedEpSectorStateCfg()
  if lastEpCfg == nil then
    return false
  end
  if lastEpCfg.difficulty ~= stageCfg.difficulty then
    return false
  end
  if lastEpCfg.dungeonId ~= stageCfg.dungeonId then
    do return stageCfg.difficulty ~= (SectorLevelDetailEnum.eDifficulty).infinity end
    do return lastEpCfg.id == stageCfg.id end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

SectorController.OnBtnHomeClicked = function(self)
  -- function num : 0_27 , upvalues : _ENV, eSectorState
  local completeIntro = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CompleteIntro)
  if not completeIntro then
    return 
  end
  if self.sctState == eSectorState.None then
    return false
  end
  self.sctState = eSectorState.None
  AudioManager:PlayAudioById(1017)
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
  ControllerManager:DeleteController(ControllerTypeId.RecommeFormation)
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
  -- function num : 0_28 , upvalues : _ENV
  if self.sectorToHomeDirector == director then
    (self.sectorToHomeDirector):stopped("-", self.sectorToHomeDirectorStopped)
    ;
    ((CS.GSceneManager).Instance):LoadSceneByAB((Consts.SceneName).Main, function()
    -- function num : 0_28_0 , upvalues : _ENV
    (ControllerManager:GetController(ControllerTypeId.HomeController, true)):OnEnterHome()
    ControllerManager:DeleteController(ControllerTypeId.SectorController)
    UIManager:CreateWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_28_0_0 , upvalues : _ENV
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
  -- function num : 0_29 , upvalues : eSectorState
  if self.homeToSectorDirector == director then
    (self.homeToSectorDirector):stopped("-", self.homeToSectorDirectorStopped)
    self:__OnEnterSector()
    if self.sctState == eSectorState.None then
      if self.__sectorFromArg == nil and not self:IsHave2PlayUnlockSectorShow() then
        self:ResetToNormalState()
      else
        self.sctState = eSectorState.Normal
      end
    end
  end
end

SectorController.__OnEnterSector = function(self)
  -- function num : 0_30 , upvalues : _ENV
  self.enableClick = true
  ;
  (self.camCtrl):InitSectorCameraCtrl()
  UIManager:ShowWindowAsync(UIWindowTypeID.Sector, function(window)
    -- function num : 0_30_0 , upvalues : self, _ENV
    window:InitUISector(self)
    self.GetUIWindowTypeId = function()
      -- function num : 0_30_0_0 , upvalues : _ENV
      return UIWindowTypeID.Sector
    end

    local completeIntro = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CompleteIntro)
    ;
    (UIUtil.SetTopStatus)(self, self.OnBtnHomeClicked, {ConstGlobalItem.SKey}, nil, nil, not completeIntro)
    if not completeIntro then
      window:Hide()
    end
  end
)
end

SectorController.ShowStrategyOverview = function(self, sectorId, buildId)
  -- function num : 0_31 , upvalues : eSectorState, _ENV
  if not self:_CheckStrategyOverview(sectorId) then
    return 
  end
  self.sctState = eSectorState.ShowSto
  local ctrl = ControllerManager:GetController(ControllerTypeId.StrategyOverview, true)
  ctrl:InitStOCtrl(sectorId, buildId, function()
    -- function num : 0_31_0 , upvalues : self
    self:OnStrategyOverviewClose()
  end
)
end

SectorController.ShowCareerStO = function(self, buildId)
  -- function num : 0_32 , upvalues : eSectorState, _ENV
  if not self:_CheckStrategyOverview(nil) then
    return 
  end
  self.sctState = eSectorState.ShowSto
  local ctrl = ControllerManager:GetController(ControllerTypeId.StrategyOverview, true)
  ctrl:InitCareerStO(buildId, function()
    -- function num : 0_32_0 , upvalues : self
    self:OnStrategyOverviewClose()
  end
)
end

SectorController._CheckStrategyOverview = function(self, sectorId)
  -- function num : 0_33 , upvalues : _ENV, cs_MessageCommon
  if self:IsDisableClick() then
    return false
  end
  if not self.isSectorBuildingUnlock then
    return false
  end
  do
    if sectorId ~= nil then
      local isSectorUnlock = (PlayerDataCenter.sectorStage):IsSectorUnlock(sectorId)
      if not isSectorUnlock then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Sector_Locked))
        return false
      end
    end
    return true
  end
end

SectorController.OnStrategyOverviewClose = function(self)
  -- function num : 0_34 , upvalues : _ENV
  if ControllerManager:GetController(ControllerTypeId.SectorController) == nil then
    return 
  end
  self:ResetToNormalState()
end

SectorController.CollectAllSctBuildRes = function(self)
  -- function num : 0_35 , upvalues : _ENV
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
  -- function num : 0_36 , upvalues : _ENV, cs_MessageCommon
  if objList.Count == 0 then
    return 
  end
  local resDic = objList[0]
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
  -- function num : 0_37 , upvalues : _ENV, cs_MessageCommon
  local buildingData = ((PlayerDataCenter.AllBuildingData).built)[id]
  if not buildingData.waitConfirmOver then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Building_Incomplete))
    return 
  end
  ;
  (self.buildingNetworkCtr):SendBuildingConfirmOver(id)
end

SectorController.RefreshBuildingReddot = function(self)
  -- function num : 0_38 , upvalues : _ENV
  for id,item in pairs(self.sctItemDic) do
    local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.SectorBuilding, id)
    local tempBool = not ok or node:GetRedDotCount() > 0
    item:ShowSctResRedDot(tempBool)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

SectorController.ConfirmOver = function(self, id)
  -- function num : 0_39 , upvalues : _ENV, BuildingBelong, cs_MessageCommon
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
  -- function num : 0_40 , upvalues : _ENV
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
  -- function num : 0_41 , upvalues : _ENV
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

SectorController.__AddBuildRes = function(self, allResDic, resData, countMax)
  -- function num : 0_42
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
  -- function num : 0_43 , upvalues : eSectorState
  do return self.sctState == eSectorState.Normal end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SectorController.EnbleSectorUI3D = function(self, enable)
  -- function num : 0_44
  if self.uiCanvas ~= nil then
    if enable then
      (self.uiCanvas):Show()
    else
      ;
      (self.uiCanvas):Hide()
    end
  end
end

SectorController.IsDisableClick = function(self)
  -- function num : 0_45 , upvalues : eSectorState
  do return (self.camCtrl):InSctCamDrag() or self.sctState ~= eSectorState.Normal end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

SectorController.ShowUnlockSectorEffect = function(self, sectorId, finishCallback, isLeftSector)
  -- function num : 0_46 , upvalues : _ENV, cs_DoTween
  local localModelData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
  if localModelData ~= nil then
    localModelData:RecordLastMaxUnlockSectorId(sectorId, true)
  end
  self.__isPlayingVideo = false
  self.__isPlayingUnlockAnima = true
  ;
  (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.Sector)
  self:SetForceFocus(sectorId * 10)
  local sectorWindow = UIManager:GetWindow(UIWindowTypeID.Sector)
  local sctItemEntity = (self.sctItemDic)[sectorId]
  local mats = sctItemEntity:GetMats()
  local sectorInfoUI = ((self.uiCanvas).sctInfoDic)[sectorId]
  local sectorProgressUI = ((self.uiCanvas).sctProgressStageDic)[sectorId]
  if sctItemEntity == nil or sectorInfoUI == nil or sectorProgressUI == nil then
    error("can\'t read unlock anima go")
    return 
  end
  sctItemEntity:SetEmissiveNum(0)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((sectorInfoUI.ui).fade).alpha = 0
  for key,value in pairs((sectorInfoUI.ui).nameFades) do
    value.alpha = 0
  end
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((sectorProgressUI.ui).progressFade).alpha = 0
  local doTweenSequence = (cs_DoTween.Sequence)()
  doTweenSequence:AppendCallback(function()
    -- function num : 0_46_0 , upvalues : _ENV, sectorWindow
    (UIUtil.AddOneCover)("sectorUnlockAnima")
    ;
    (UIUtil.HideTopStatus)()
    sectorWindow:HideAllButtomGo()
  end
)
  doTweenSequence:AppendInterval(0.5)
  for index,mat in ipairs(mats) do
    if index == 1 then
      doTweenSequence:Append(mat:DOFloat(1, "_EmissiveSwitch", 0.5))
      hasMat = true
    else
      doTweenSequence:Join(mat:DOFloat(1, "_EmissiveSwitch", 0.5))
    end
  end
  doTweenSequence:Join(((sectorInfoUI.ui).fade):DOFade(1, 1))
  local isDelayed = false
  for key,value in pairs((sectorInfoUI.ui).nameFades) do
    if not isDelayed then
      doTweenSequence:Join((value:DOFade(1, 1)):SetDelay(0.5))
      isDelayed = true
    else
      doTweenSequence:Join(value:DOFade(1, 1))
    end
  end
  doTweenSequence:Join(((sectorProgressUI.ui).progressFade):DOFade(1, 1))
  doTweenSequence:AppendInterval(1)
  doTweenSequence:AppendCallback(function()
    -- function num : 0_46_1 , upvalues : finishCallback, _ENV, sectorWindow, self, isLeftSector
    if finishCallback ~= nil then
      finishCallback()
    end
    ;
    (UIUtil.ReShowTopStatus)()
    sectorWindow:ReShowllButtomGo()
    local CloseFunc = function()
      -- function num : 0_46_1_0 , upvalues : self, isLeftSector, _ENV
      if self.__afterUnlockSectorShowCallback ~= nil then
        (self.__afterUnlockSectorShowCallback)()
      end
      self.__isPlayingVideo = nil
      self.__isPlayingUnlockAnima = nil
      if not isLeftSector then
        self:ResetToNormalState(nil)
      end
      ;
      (UIUtil.CloseOneCover)("sectorUnlockAnima")
      NoticeManager:ContinueShowNotice("sector")
    end

    local win = UIManager:GetWindow(UIWindowTypeID.MovieBlack)
    if win ~= nil then
      win:SlowClose(1, function()
      -- function num : 0_46_1_1 , upvalues : CloseFunc
      CloseFunc()
    end
)
    else
      CloseFunc()
    end
  end
)
  doTweenSequence:SetAutoKill(true)
end

SectorController.IsHave2PlayUnlockSectorShow = function(self)
  -- function num : 0_47
  do return (self.needPlayEndVideo == nil or not (self.needPlayEndVideo).Animaflag) and (self.needPlayEndVideo).flag end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

SectorController.SetAfterUnlockSectorShowCallback = function(self, callback)
  -- function num : 0_48
  self.__afterUnlockSectorShowCallback = callback
end

SectorController.OnDelete = function(self)
  -- function num : 0_49 , upvalues : _ENV
  for k,v in pairs(self.ctrls) do
    v:OnDelete()
  end
  self.ctrls = nil
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

