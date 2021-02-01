-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationController = class("ExplorationController")
local ExplorationPlayerCtrl = require("Game.Exploration.Ctrl.ExplorationPlayerCtrl")
local ExplorationMapCtrl = require("Game.Exploration.Ctrl.ExplorationMapCtrl")
local ExplorationTreasureCtrl = require("Game.Exploration.Ctrl.ExplorationTreasureCtrl")
local ExplorationStoreCtrl = require("Game.Exploration.Ctrl.ExplorationStoreCtrl")
local ExplorationResidentStoreCtrl = require("Game.Exploration.Ctrl.ExplorationResidentStoreCtrl")
local ExplorationEventCtrl = require("Game.Exploration.Ctrl.ExplorationEventCtrl")
local ExplorationResetRoomCtrl = require("Game.Exploration.Ctrl.ExplorationResetRoomCtrl")
local ExplorationSceneCtrl = require("Game.Exploration.Ctrl.ExplorationSceneCtrl")
local ExplorationBattleCtrl = require("Game.Exploration.Ctrl.ExplorationBattleCtrl")
local ExplorationAutoCtrl = require("Game.Exploration.Ctrl.ExplorationAutoCtrl")
local ExplorationCampFetterCtrl = require("Game.Exploration.Ctrl.ExplorationCampFetterCtrl")
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
local CS_BattleManager_Ins = (CS.BattleManager).Instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local ePlayerState = {InTheRoom = 1, OutsideTheRoom = 2, SelectingChip = 3, HalfOver = 4, DropChip = 5, BattleFailure = 6, ReplaceChip = 7}
ExplorationController.ctor = function(self, mapData, dynPlayer)
  -- function num : 0_0 , upvalues : ExplorationPlayerCtrl, ExplorationMapCtrl, ExplorationTreasureCtrl, ExplorationStoreCtrl, ExplorationEventCtrl, ExplorationResetRoomCtrl, ExplorationSceneCtrl, ExplorationBattleCtrl, ExplorationResidentStoreCtrl, ExplorationAutoCtrl, ExplorationCampFetterCtrl, _ENV
  self.ctrls = {}
  self.mapData = mapData
  self.dynPlayer = dynPlayer
  self.loadSceneComplete = false
  self.playerCtrl = (ExplorationPlayerCtrl.New)(self)
  self.mapCtrl = (ExplorationMapCtrl.New)(self)
  self.treasureCtrl = (ExplorationTreasureCtrl.New)(self)
  self.storeCtrl = (ExplorationStoreCtrl.New)(self)
  self.eventCtrl = (ExplorationEventCtrl.New)(self)
  self.resetRoomCtrl = (ExplorationResetRoomCtrl.New)(self)
  self.sceneCtrl = (ExplorationSceneCtrl.New)(self)
  self.battleCtrl = (ExplorationBattleCtrl.New)(self)
  self.residentStoreCtrl = (ExplorationResidentStoreCtrl.New)(self)
  self.autoCtrl = (ExplorationAutoCtrl.New)(self)
  self.campFetterCtrl = (ExplorationCampFetterCtrl.New)(self)
  self.epNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.itemRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.ItemRoom)
  self.storeRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.StoreRoom)
  self.eventRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.EventRoom)
  self.resetRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.ResetRoom)
  self.cameraViewValue = -1
  self.resloader = ((CS.ResLoader).Create)()
  self.__onUpdateNextRoomInfo = BindCallback(self, self.UpdateNextRoomInfo)
  MsgCenter:AddListener(eMsgEventId.OnEpGridDetailDiff, self.__onUpdateNextRoomInfo)
  self.__onEpResidentDiff = BindCallback(self, self.UpdateResidentDetail)
  MsgCenter:AddListener(eMsgEventId.OnEpResidentDiff, self.__onEpResidentDiff)
  self.__onEnterEpSceneCompleteAction = BindCallback(self, self.__OnEnterEpSceneComplete)
end

ExplorationController.RecordLastSelectChoiceCtrl = function(self, roomCtrl)
  -- function num : 0_1
  self.__lastSelectChoiceCtrl = roomCtrl
end

ExplorationController.GetLastSelectChoiceCtrl = function(self)
  -- function num : 0_2
  return self.__lastSelectChoiceCtrl
end

ExplorationController.Start = function(self, isReconnect)
  -- function num : 0_3 , upvalues : _ENV
  self.__isReconnect = isReconnect
  ;
  (self.sceneCtrl):FirstEnterScene(BindCallback(self, self.OnSceneLoadComplete), BindCallback(self, self.OnStartTimelineComplete))
end

ExplorationController.OnSceneLoadComplete = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.loadSceneComplete = true
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Sector).name, (eAuSelct.Sector).normalCombat)
  local sectorCfg = ExplorationManager:GetSectorCfg()
  if sectorCfg ~= nil then
    AudioManager:PlayAudioById(sectorCfg.audio_id)
  end
  local epWindow = UIManager:ShowWindow(UIWindowTypeID.Exploration)
  epWindow:ShowExplorationFirst(self.dynPlayer)
  epWindow:Hide()
  local epWindow = UIManager:ShowWindow(UIWindowTypeID.DungeonStateInfo)
  epWindow:InitHeroAndChip(self.dynPlayer)
  epWindow:Hide()
  local curRoomData = self:GetCurrentRoomData()
  MsgCenter:Broadcast(eMsgEventId.OnEpPlayerMoveComplete, curRoomData)
  GuideManager:TryTriggerGuide(eGuideCondition.InExploration)
end

ExplorationController.OnStartTimelineComplete = function(self)
  -- function num : 0_5
  self:ContinueExploration()
  ;
  (self.autoCtrl):OnExplorationStart()
end

ExplorationController.ContinueExploration = function(self)
  -- function num : 0_6 , upvalues : _ENV, ePlayerState
  local currentRoom = self:GetCurrentRoomData()
  local opDetail = (self.dynPlayer):GetOperatorDetail()
  local opState = opDetail.state
  if opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_Secleted then
    if self.inTheTempRoom then
      return 
    end
    if currentRoom:IsBattleRoom() then
      self:__EnterBattleScene(currentRoom, self.__isReconnect)
    else
      self:__EnterExplorationScene(ePlayerState.InTheRoom)
    end
  else
    if opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
      self:__EnterExplorationScene(ePlayerState.OutsideTheRoom)
      ;
      (self.campFetterCtrl):OnEpCouldeSelectNextRoom()
    else
      if opState == proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleALGWaiting then
        self:__EnterExplorationScene(ePlayerState.SelectingChip)
      else
        if opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_DropAlg then
          self:__EnterExplorationScene(ePlayerState.DropChip)
        else
          if opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_HalfOver then
            self:__EnterExplorationScene(ePlayerState.HalfOver)
          else
            if opState == proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleFailure then
              self:__EnterExplorationScene(ePlayerState.BattleFailure)
            else
              if opState == proto_object_ExplorationCurGridState.ExplorationCurGridStateReplaceChip then
                self:__EnterExplorationScene(ePlayerState.ReplaceChip)
              end
            end
          end
        end
      end
    end
  end
  ;
  (self.campFetterCtrl):__OnEpOpStateChanged(nil, opState)
  self.__isReconnect = nil
end

ExplorationController.__EnterExplorationScene = function(self, state)
  -- function num : 0_7 , upvalues : _ENV, ExplorationEnum
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Sector).name, (eAuSelct.Sector).roomSelect)
  self.__playerState = state
  if (self.sceneCtrl):InBattleScene() then
    local window = UIManager:GetWindow(UIWindowTypeID.Exploration)
    if window ~= nil then
      window:RefreshPlayerData(self.dynPlayer)
    end
    ;
    (self.sceneCtrl):BattleToExplorationScene(self.__onEnterEpSceneCompleteAction)
  else
    do
      ;
      (self.sceneCtrl):ChangeEpSceneState((ExplorationEnum.eEpSceneState).InEpScene)
      self:__OnEnterEpSceneComplete()
    end
  end
end

ExplorationController.__OnEnterEpSceneComplete = function(self)
  -- function num : 0_8 , upvalues : ePlayerState, _ENV
  if self.__playerState == ePlayerState.InTheRoom then
    (self.playerCtrl):InitEpPlayerMove()
  else
    if self.__playerState == ePlayerState.OutsideTheRoom then
      self:CheckBossRoom()
      GuideManager:TryTriggerGuide(eGuideCondition.InExplorationScene)
    else
      if self.__playerState == ePlayerState.SelectingChip then
        self:CheckChipSelect(BindCallback(self, self.__ContinueSelectChipComplete))
        GuideManager:TryTriggerGuide(eGuideCondition.InExplorationScene)
      else
        if self.__playerState == ePlayerState.DropChip then
          self:DiscardChip()
        else
          if self.__playerState == ePlayerState.BattleFailure then
            self:ExplorationFailSettle()
          else
            if self.__playerState == ePlayerState.HalfOver then
              warn("未实现该功能：中场结束,自动选下一个房间")
            else
              if self.__playerState == ePlayerState.ReplaceChip then
                self:OpenChipReplace()
              end
            end
          end
        end
      end
    end
  end
end

ExplorationController.__ContinueSelectChipComplete = function(self)
  -- function num : 0_9 , upvalues : _ENV, ExplorationEnum
  if (self.dynPlayer):GetOperatorDetailState() ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_DropAlg then
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).OutsideSelectChip)
  end
end

ExplorationController.CheckBossRoom = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local currentRoom = self:GetCurrentRoomData()
  if currentRoom:IsRealBossRoom() then
    if (self.mapData):HasOverBossRoom() then
      if (self.autoCtrl):IsAutoModeRunning() then
        local stageId = (ExplorationManager:GetSectorStageCfg()).id
        do
          local curFloor = ExplorationManager:GetCurLevelIndex() + 1
          ;
          (ControllerManager:GetController(ControllerTypeId.AvgPlay, true)):TryPlayAvg(eAvgTriggerType.MainAvgEp, stageId, curFloor, 3, function()
    -- function num : 0_10_0 , upvalues : _ENV, self
    ((CS.MessageCommon).ShowMessageBox)(ConfigData:GetTipContent(255), function()
      -- function num : 0_10_0_0
    end
, function()
      -- function num : 0_10_0_1 , upvalues : self
      self:StartCompleteExploration()
    end
)
  end
)
          self:StartCompleteExploration()
          if currentRoom:IsEndColRoom() then
            self:StartCompleteExploration()
          end
        end
      end
    end
  end
end

ExplorationController.IsCompleteExploration = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if ((self.dynPlayer):GetOperatorDetail()).canFloorOver and not ExplorationManager:HasNextLevel() then
    return true
  end
  return false
end

ExplorationController.StartCompleteExploration = function(self, endAction)
  -- function num : 0_12 , upvalues : _ENV
  if ExplorationManager:HasNextLevel() then
    self:__CompleteExplorationFloor(endAction)
  else
    self:__CompleteExploration(endAction)
  end
end

ExplorationController.__CompleteExplorationFloor = function(self, endAction)
  -- function num : 0_13 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
    -- function num : 0_13_0 , upvalues : _ENV, self, endAction
    if window ~= nil then
      window:CompleteExplorationFloor(data)
    end
    ;
    (self.autoCtrl):OnEpFloorSettle()
    if self.mapCtrl ~= nil then
      (self.mapCtrl):HideMapCavasWithoutBg()
    end
    UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
    UIManager:HideWindow(UIWindowTypeID.Exploration)
    if endAction ~= nil then
      endAction()
    end
  end
)
end

ExplorationController.ExplorationFailSettle = function(self, clearAction)
  -- function num : 0_14 , upvalues : _ENV
  (self.epNetwork):CS_EXPLORATION_RewardsShow(function(dataList)
    -- function num : 0_14_0 , upvalues : _ENV, self, clearAction
    local msgData = nil
    if dataList.Count > 0 then
      msgData = dataList[0]
    else
      msgData = {}
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
      -- function num : 0_14_0_0 , upvalues : self, clearAction, msgData
      if window == nil then
        return 
      end
      ;
      (self.autoCtrl):CloseAutoMode()
      window:FailExploration(clearAction, msgData.rewards)
    end
)
  end
)
end

ExplorationController.__CompleteExploration = function(self, endAction)
  -- function num : 0_15 , upvalues : _ENV
  local beforeSettleStageState = (PlayerDataCenter.sectorStage):GetStageState((ExplorationManager:GetSectorStageCfg()).id)
  local resultSettlementData = ((ExplorationManager.epCtrl).dynPlayer):SetResultSettlementData()
  ExplorationManager:SendSettle(function(msg)
    -- function num : 0_15_0 , upvalues : _ENV, beforeSettleStageState, resultSettlementData, self, endAction
    ((CS.BattleManager).Instance):ForceExitBattle()
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (Time.unity_time).timeScale = 1
    local data = {}
    if msg.Count < 1 then
      error("can\'t get msg arg0")
    else
      data = msg[0]
    end
    local StageState = (PlayerDataCenter.sectorStage):GetStageState((ExplorationManager:GetSectorStageCfg()).id)
    local needFirsPassReward = false
    if StageState ~= beforeSettleStageState and StageState == proto_object_DungeonStageState.DungeonStageStatePicked then
      needFirsPassReward = true
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
      -- function num : 0_15_0_0 , upvalues : data, needFirsPassReward, resultSettlementData, self, _ENV, endAction
      if window ~= nil then
        window:CompleteExploration(data.rewards, data.firstClearRewards, needFirsPassReward, resultSettlementData)
      end
      ;
      (self.autoCtrl):CloseAutoMode()
      if self.mapCtrl ~= nil then
        (self.mapCtrl):HideMapCavasWithoutBg()
      end
      UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
      UIManager:HideWindow(UIWindowTypeID.Exploration)
      if endAction ~= nil then
        endAction()
      end
    end
)
  end
)
  local heroIdList = {}
  for index,heroData in ipairs((self.dynPlayer).heroList) do
    (table.insert)(heroIdList, heroData.dataId)
  end
end

ExplorationController.__EnterBattleScene = function(self, roomData, isReconnect)
  -- function num : 0_16 , upvalues : _ENV, ExplorationEnum, CS_BattleManager_Ins
  if isGameDev then
    print("[Dev]battleId:", roomData.battleId)
  end
  if roomData:IsBossRoom() or roomData:GetRoomType() == (ExplorationEnum.eRoomType).challenge then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Sector).name, (eAuSelct.Sector).bossCombat)
  else
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Sector).name, (eAuSelct.Sector).normalCombat)
  end
  self:RollbackTempChipCurBattleRoom((self.dynPlayer):GetEpBuffChipDic())
  self:ExecuteTempChipCurBattleRoom((self.dynPlayer):GetEpBuffChipDic())
  local window = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if window ~= nil then
    window:Hide(true)
  end
  window = UIManager:GetWindow(UIWindowTypeID.Exploration)
  if window ~= nil then
    window:Hide(true)
  end
  ;
  (self.battleCtrl):OnEnterBattleScene(roomData)
  local battleCtrl = CS_BattleManager_Ins:StartNewBattle(roomData, self.dynPlayer, self.battleCtrl)
  local epToBattleAction = function()
    -- function num : 0_16_0 , upvalues : battleCtrl
    battleCtrl:StartEnterDeployState()
  end

  if roomData:IsDeployRoom() or isReconnect then
    (self.sceneCtrl):ExplorationToBattleSceneInReconnected(epToBattleAction)
  else
    local epDetail = (self.dynPlayer):GetOperatorDetail()
    if epDetail.state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over or not #epDetail.path - 1 then
      local index = #epDetail.path
    end
    local lastRoomCoord = (epDetail.path)[index]
    local lastRoomPos = ((self.mapCtrl):GetRoomEntity(lastRoomCoord)):GetRoomEntityLocalPos(0)
    local curRoomPos = ((self.mapCtrl):GetRoomEntity(roomData.position)):GetRoomEntityLocalPos(0)
    local isUp = lastRoomPos.y < curRoomPos.y
    local dir = -1
    if isUp then
      dir = 1
    end
    if roomData:IsBossRoom() then
      dir = 0
    end
    local roomPos = (self.mapCtrl):GetRoomEntityPos(roomData)
    local mapRoot = self:GetRoomRoot()
    ;
    (self.sceneCtrl):ExplorationToBattleSceneNormal(dir, mapRoot, roomPos, epToBattleAction)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

ExplorationController.EnterDeployRoom = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local epState = (self.dynPlayer):GetOperatorDetailState()
  if epState ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    return 
  end
  local deployRoomData = (self.mapData):GetDeployRoom()
  self:__EnterBattleScene(deployRoomData)
end

ExplorationController.GenExplorationMap = function(self)
  -- function num : 0_18
  (self.mapCtrl):GenMap(self.mapData, self:GetCurrentRoomData())
end

ExplorationController.SetViewPositionOffset = function(self, offsetPosition)
  -- function num : 0_19
  local position = (self.mapCtrl):GetViewPosition() + offsetPosition
  return (self.mapCtrl):SetViewPosition(position)
end

ExplorationController.GetViewPosition = function(self)
  -- function num : 0_20
  return (self.mapCtrl):GetViewPosition()
end

ExplorationController.OnPlayerMoveStart = function(self, roomData)
  -- function num : 0_21 , upvalues : _ENV
  AudioManager:PlayAudioById(1002)
  if roomData:IsBattleRoom() then
    (self.mapCtrl):PlayerPosItemMove2NextPos()
    self:OnPlayerMoveComplete(roomData)
  else
    ;
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
    local roomUI = self:GetRoomUI(roomData.position)
    ;
    (self.mapCtrl):PlayerPosItemMove2NextPos()
    ;
    (self.sceneCtrl):EpRoomCoverBattleMap(true, function()
    -- function num : 0_21_0 , upvalues : self, roomData, _ENV
    self:OnPlayerMoveComplete(roomData)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end
, (roomUI.transform).position)
  end
end

ExplorationController.OnPlayerMoveComplete = function(self, roomData)
  -- function num : 0_22 , upvalues : ExplorationEnum, _ENV
  local roomType = roomData:GetRoomType()
  if roomData:IsBattleRoom() then
    self:__EnterBattleScene(roomData)
  else
    if roomType == (ExplorationEnum.eRoomType).chip then
      (self.resetRoomCtrl):OnResetRoomOpen(roomData)
    else
      if roomType == (ExplorationEnum.eRoomType).store then
        (self.storeCtrl):OnStoreRoomOpen(roomData, true)
      else
        if roomType == (ExplorationEnum.eRoomType).item then
          (self.treasureCtrl):OnTreasureRoomOpen(roomData, true)
        else
          if roomType == (ExplorationEnum.eRoomType).recovery then
            (self.eventCtrl):OnEventRoomOpen(roomData, true)
          else
            if roomType == (ExplorationEnum.eRoomType).eventroom then
              (self.eventCtrl):OnEventRoomOpen(roomData, true)
            else
            end
          end
        end
      end
    end
  end
  if roomType ~= (ExplorationEnum.eRoomType).empty or (ExplorationEnum.eRoomType).start < roomType then
    error("Unsupported room type : " .. tostring(roomType))
  end
  MsgCenter:Broadcast(eMsgEventId.OnEpPlayerMoveComplete, roomData)
  roomData:ResetJumpCat()
end

ExplorationController.OnExitEpRoom = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local curRoomData = self:GetCurrentRoomData()
  if curRoomData:IsEndColRoom() then
    return 
  end
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  ;
  (self.mapCtrl):PlayerPosItemMove2NextPos(function()
    -- function num : 0_23_0 , upvalues : self, _ENV
    (self.sceneCtrl):EpRoomCoverBattleMap(true, function()
      -- function num : 0_23_0_0 , upvalues : _ENV
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    end
)
  end
)
end

ExplorationController.UpdateNextRoomInfo = function(self, epGrid, jumpCat)
  -- function num : 0_24 , upvalues : _ENV, ExplorationEnum
  if epGrid.monster ~= nil then
    for k,v in pairs(epGrid.monster) do
      local roomData = (self.mapData):GetRoomByCoord(k)
      if roomData ~= nil and roomData:IsBattleRoom(jumpCat) then
        roomData:InitBattleData(v)
        roomData:ExecuteMonsterChip(self.dynPlayer)
        roomData:ExecuteMonsterTempChip((self.dynPlayer):GetHiddenChipDic())
        ;
        (self.mapCtrl):ShowFightingPower(roomData, (self.dynPlayer):GetCacheFightPower())
        roomData:SetAmbushAndSneakData(v.ambush, v.stealth)
      end
    end
  end
  do
    if epGrid.item ~= nil then
      for k,v in pairs(epGrid.item) do
        local roomData = (self.mapData):GetRoomByCoord(k)
        if roomData ~= nil then
          roomData:InitTreasureRoomData(v)
        end
      end
    end
    do
      if epGrid.store ~= nil then
        for k,v in pairs(epGrid.store) do
          local roomData = (self.mapData):GetRoomByCoord(k)
          if roomData ~= nil then
            roomData:InitStoreRoomData(v)
          end
        end
      end
      do
        if epGrid.evt ~= nil then
          for k,v in pairs(epGrid.evt) do
            local roomData = (self.mapData):GetRoomByCoord(k)
            if roomData ~= nil then
              roomData:InitEventAndRecoveryRoomData(v, jumpCat)
            end
          end
        end
        do
          if epGrid.reconstitution ~= nil then
            for k,v in pairs(epGrid.reconstitution) do
              local roomData = (self.mapData):GetRoomByCoord(k)
              if roomData ~= nil then
                roomData:InitResetRoomData(v)
              end
            end
          end
          do
            if epGrid.tmpStore ~= nil then
              local tmpStore = epGrid.tmpStore
              local curRoomData = self:GetCurrentRoomData()
              local curPos = curRoomData:GetRoomPosition()
              local x, y = (ExplorationManager.Coordination2Pos)(curPos)
              local DynEpRoomData = require("Game.Exploration.MapData.DynEpRoomData")
              local type = (ExplorationEnum.eRoomType).store
              local roomData = (DynEpRoomData.New)(x, y, type, curPos, false)
              roomData:InitStoreRoomData(tmpStore)
              ;
              (self.storeCtrl):OnStoreRoomOpen(roomData)
              self.inTheTempRoom = true
            end
            do
              if epGrid.buffData ~= nil then
                local curRoomData = self:GetCurrentRoomData()
                if curRoomData ~= nil then
                  curRoomData:InitEpBuffEffective((epGrid.buffData).data)
                end
              end
            end
          end
        end
      end
    end
  end
end

ExplorationController.UpdateResidentDetail = function(self, epResident)
  -- function num : 0_25
  if epResident.store ~= nil then
    (self.residentStoreCtrl):UpdateResidentStore(epResident.store)
  end
end

ExplorationController.OpenResidentStore = function(self)
  -- function num : 0_26
  (self.residentStoreCtrl):OnResidentStoreRoomOpen()
end

ExplorationController.IsMapLogic = function(self, mapLogic)
  -- function num : 0_27
  do return (self.mapData).logic == mapLogic end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ExplorationController.CheckChipSelect = function(self, noSelectEvent, toFakeCamera)
  -- function num : 0_28 , upvalues : _ENV
  if noSelectEvent ~= nil then
    self.__noChipSelectEvent = noSelectEvent
  end
  if (self.dynPlayer):GetOperatorDetailState() ~= proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleALGWaiting then
    if self.__noChipSelectEvent ~= nil then
      (self.__noChipSelectEvent)()
      self.__noChipSelectEvent = nil
    end
    return false
  end
  local chipList = (self:GetCurrentRoomData()):GetRewardChipList()
  if #chipList == 0 then
    error("rewardChipList.count == 0")
    return false
  end
  local window = nil
  if toFakeCamera then
    window = UIManager:ShowWindow(UIWindowTypeID.SelectChip, UIWindowTypeID.ThreeDSelectChip)
  else
    window = UIManager:ShowWindow(UIWindowTypeID.SelectChip)
  end
  if window ~= nil then
    window:InitSelectChip(chipList, self.dynPlayer, BindCallback(self, self.__SelectChipComplete), BindCallback(self, self.__GiveSelectChipComplect), toFakeCamera)
    ;
    (self.autoCtrl):OnEpBattleSelectChip()
  end
  ;
  (self.campFetterCtrl):OnEpSelectChip()
  return true
end

ExplorationController.__SelectChipComplete = function(self, index, selectComplete)
  -- function num : 0_29
  index = index - 1
  local position = (self:GetCurrentRoomData()):GetRoomPosition()
  ;
  (self.epNetwork):CS_EXPLORATION_BATTLE_ALGSelect(position, index, function(dataList)
    -- function num : 0_29_0 , upvalues : selectComplete, self
    if selectComplete ~= nil then
      selectComplete()
    end
    self:CheckChipSelect()
  end
)
end

ExplorationController.__GiveSelectChipComplect = function(self, selectComplete)
  -- function num : 0_30
  (self.epNetwork):CS_EXPLORATION_BATTLE_GiveUpAlg(function()
    -- function num : 0_30_0 , upvalues : selectComplete, self
    if selectComplete ~= nil then
      selectComplete()
    end
    self:CheckChipSelect()
  end
)
end

ExplorationController.DiscardChip = function(self)
  -- function num : 0_31 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.EpChipDiscard)
  if win ~= nil and win.active then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpChipDiscard, function(win)
    -- function num : 0_31_0 , upvalues : _ENV, self
    if win == nil then
      error("can\'t open EpChipDiscard UI")
      return 
    end
    win:InitEpChipDiscard(self.dynPlayer, function()
      -- function num : 0_31_0_0 , upvalues : self
      self:CheckBossRoom()
    end
)
  end
)
end

ExplorationController.GetRoomRoot = function(self)
  -- function num : 0_32
  return (self.mapCtrl):GetRoomRoot()
end

ExplorationController.GetRoomUI = function(self, position, index)
  -- function num : 0_33
  return (self.mapCtrl):GetRoomUI(position, index)
end

ExplorationController.GetCurrentRoomData = function(self)
  -- function num : 0_34
  local currentRoom = (self.playerCtrl):GetCurrentRoomData()
  return currentRoom
end

ExplorationController.GetCurrentRoomTitle = function(self)
  -- function num : 0_35 , upvalues : _ENV
  local currentRoom = (self.playerCtrl):GetCurrentRoomData()
  local roomType = currentRoom:GetRoomType()
  local roomTypeCfg = (ConfigData.exploration_roomtype)[roomType]
  if roomTypeCfg == nil then
    error("exploration room type is null,id:" .. tostring(roomType))
    return ""
  end
  return (LanguageUtil.GetLocaleText)(roomTypeCfg.title)
end

ExplorationController.ExecuteNormalChipBattleRoom = function(self)
  -- function num : 0_36 , upvalues : _ENV
  local nextRooms = (self:GetCurrentRoomData()):GetNextRoom()
  for k,roomData in pairs(nextRooms) do
    if roomData:IsBattleRoom() then
      roomData:ExecuteMonsterChip(self.dynPlayer)
    end
  end
  local curRoomData = self:GetCurrentRoomData()
  if curRoomData:IsBattleRoom() then
    curRoomData:ExecuteMonsterChip(self.dynPlayer)
  end
end

ExplorationController.RollbackNormalChipBattleRoom = function(self)
  -- function num : 0_37 , upvalues : _ENV
  local nextRooms = (self:GetCurrentRoomData()):GetNextRoom()
  for k,roomData in pairs(nextRooms) do
    if roomData:IsBattleRoom() then
      roomData:RollbackMonsterChip(self.dynPlayer)
    end
  end
  local curRoomData = self:GetCurrentRoomData()
  if curRoomData:IsBattleRoom() then
    curRoomData:RollbackMonsterChip(self.dynPlayer)
  end
end

ExplorationController.ExecuteTempChipCurBattleRoom = function(self, chipTemporaryDic)
  -- function num : 0_38
  local curRoomData = self:GetCurrentRoomData()
  if curRoomData:IsBattleRoom() then
    curRoomData:ExecuteMonsterTempChip(chipTemporaryDic)
  end
end

ExplorationController.RollbackTempChipCurBattleRoom = function(self, chipTemporaryDic)
  -- function num : 0_39
  local curRoomData = self:GetCurrentRoomData()
  if curRoomData:IsBattleRoom() then
    curRoomData:RollbackMonsterTempChip(chipTemporaryDic)
  end
end

ExplorationController.ExecuteTempChipNextBattleRoom = function(self, chipTemporaryDic)
  -- function num : 0_40 , upvalues : _ENV
  local nextRooms = (self:GetCurrentRoomData()):GetNextRoom()
  for k,roomData in pairs(nextRooms) do
    if roomData:IsBattleRoom() then
      roomData:ExecuteMonsterTempChip(chipTemporaryDic)
    end
  end
end

ExplorationController.RollbackTempChipNextBattleRoom = function(self, chipTemporaryDic)
  -- function num : 0_41 , upvalues : _ENV
  local nextRooms = (self:GetCurrentRoomData()):GetNextRoom()
  for k,roomData in pairs(nextRooms) do
    if roomData:IsBattleRoom() then
      roomData:RollbackMonsterTempChip(chipTemporaryDic)
    end
  end
end

ExplorationController.OnDelete = function(self)
  -- function num : 0_42 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnEpGridDetailDiff, self.__onUpdateNextRoomInfo)
  MsgCenter:RemoveListener(eMsgEventId.OnEpResidentDiff, self.__onEpResidentDiff)
  UIManager:DeleteWindow(UIWindowTypeID.Exploration)
  ;
  (GR.SetIsOneTheEpMap)(false)
  for k,v in pairs(self.ctrls) do
    v:OnDelete()
  end
  self.ctrls = nil
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  self.loadSceneComplete = false
end

ExplorationController.OpenChipReplace = function(self)
  -- function num : 0_43 , upvalues : _ENV
  local opDetail = (self.dynPlayer):GetOperatorDetail()
  local roomData = (self.mapData):GetRoomByCoord(opDetail.curPostion)
  UIManager:ShowWindowAsync(UIWindowTypeID.ChipDisplace, function(window)
    -- function num : 0_43_0 , upvalues : roomData, self
    local remainCount = ((roomData.eventData).replaceChip).remainingReplaceChipTimes
    local isAllDisplace = ((roomData.eventData).replaceChip).replaceNum == 0
    window:InitChipDisplace(remainCount, isAllDisplace, self)
    ;
    (self.autoCtrl):OnEnterChipReplace(true)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

ExplorationController.SendChipReplace = function(self, id)
  -- function num : 0_44
  local opDetail = (self.dynPlayer):GetOperatorDetail()
  local roomData = (self.mapData):GetRoomByCoord(opDetail.curPostion)
  ;
  (self.epNetwork):CS_EXPLORATION_EVENT_ReplaceAlg(opDetail.curPostion, id, function()
    -- function num : 0_44_0 , upvalues : self
    self:ChipReplaceSuccess()
  end
)
end

ExplorationController.ChipReplaceSuccess = function(self)
  -- function num : 0_45 , upvalues : _ENV
  local opDetail = (self.dynPlayer):GetOperatorDetail()
  local roomData = (self.mapData):GetRoomByCoord(opDetail.curPostion)
  local window = UIManager:GetWindow(UIWindowTypeID.ChipDisplace)
  if window ~= nil then
    window:UpdateDiff()
    ;
    (self.autoCtrl):OnEnterChipReplace(false)
  end
end

ExplorationController.SendExitChipReplace = function(self)
  -- function num : 0_46
  local opDetail = (self.dynPlayer):GetOperatorDetail()
  ;
  (self.epNetwork):CS_EXPLORATION_EVENT_ReplaceExit(opDetail.curPostion, function()
    -- function num : 0_46_0 , upvalues : self
    self:ExitChipReplaceSuccess()
  end
)
end

ExplorationController.ExitChipReplaceSuccess = function(self)
  -- function num : 0_47 , upvalues : _ENV, ExplorationEnum
  UIManager:DeleteWindow(UIWindowTypeID.ChipDisplace)
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).EventRoom)
end

ExplorationController.EnterBattleSceneInReplay = function(self)
  -- function num : 0_48 , upvalues : _ENV, CS_BattleManager_Ins
  if self.roomDataClone == nil or self.dynPlayerClone == nil then
    print("return")
    return 
  end
  UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
  local battleCtrl = CS_BattleManager_Ins:StartNewBattle(self.roomDataClone, self.dynPlayerClone, self.battleCtrl)
  local epToBattleAction = function()
    -- function num : 0_48_0 , upvalues : battleCtrl
    (battleCtrl.fsm):BroadcastEvent(1)
  end

  local roomPos = (self.mapCtrl):GetRoomEntityPos(self.roomDataClone)
  local mapRoot = self:GetRoomRoot()
  ;
  (self.sceneCtrl):ExplorationToBattleSceneNormal(1, mapRoot, roomPos, epToBattleAction)
end

ExplorationController.CopyAndGetReplayData = function(self)
  -- function num : 0_49 , upvalues : _ENV
  self.roomDataClone = (table.deepCopy)(self:GetCurrentRoomData())
  self.dynPlayerClone = (table.deepCopy)(self.dynPlayer)
end

return ExplorationController

