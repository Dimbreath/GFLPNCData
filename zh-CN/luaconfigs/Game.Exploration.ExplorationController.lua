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
local ExplorationSupportCtrl = require("Game.Exploration.Ctrl.ExplorationSupportCtrl")
local ExplorationOverclockCtrl = require("Game.Exploration.Ctrl.ExplorationOverclockCtrl")
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local ePlayerState = {InTheRoom = 1, OutsideTheRoom = 2, SelectingChip = 3, HalfOver = 4, DropChip = 5, BattleFailure = 6, ReplaceChip = 7, MonsterLvUpgrade = 8}
ExplorationController.ctor = function(self, mapData, dynPlayer)
  -- function num : 0_0 , upvalues : ExplorationPlayerCtrl, ExplorationMapCtrl, ExplorationTreasureCtrl, ExplorationStoreCtrl, ExplorationEventCtrl, ExplorationResetRoomCtrl, ExplorationSceneCtrl, ExplorationBattleCtrl, ExplorationResidentStoreCtrl, ExplorationAutoCtrl, ExplorationCampFetterCtrl, ExplorationSupportCtrl, ExplorationOverclockCtrl, _ENV
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
  self.epSupportCtrl = (ExplorationSupportCtrl.New)(self)
  self.overclockCtrl = (ExplorationOverclockCtrl.New)(self)
  self.epNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.itemRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.ItemRoom)
  self.storeRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.StoreRoom)
  self.eventRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.EventRoom)
  self.resetRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.ResetRoom)
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

ExplorationController.Start = function(self, isReconnect, isFirstEnter)
  -- function num : 0_3 , upvalues : _ENV
  self.__isReconnect = isReconnect
  self.__isFirstEnter = isFirstEnter
  ;
  (self.sceneCtrl):FirstEnterScene(BindCallback(self, self.OnSceneLoadComplete), BindCallback(self, self.OnStartTimelineComplete))
end

ExplorationController.IsFirstEnterEp = function(self)
  -- function num : 0_4
  return self.__isFirstEnter
end

ExplorationController.OnSceneLoadComplete = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self.loadSceneComplete = true
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Sector).name, (eAuSelct.Sector).normalCombat)
  local sceneCfg = (self.mapData):GetEpSceneCfg()
  AudioManager:PlayAudioById(sceneCfg.audio_id)
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
  -- function num : 0_6
  self:ContinueExploration()
  ;
  (self.autoCtrl):OnExplorationStart()
end

ExplorationController.ContinueExploration = function(self, isRevive)
  -- function num : 0_7 , upvalues : _ENV, ePlayerState
  self.__isRevive = isRevive or false
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
    else
      if opState == proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleALGWaiting then
        self:__EnterExplorationScene(ePlayerState.SelectingChip)
      else
        if opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_DropAlg then
          self:__EnterExplorationScene(ePlayerState.DropChip)
        else
          if opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_MonsterLvUpgrade then
            if self.__isReconnect then
              self:__EnterExplorationScene(ePlayerState.MonsterLvUpgrade)
            else
              self:__EnterExplorationScene(ePlayerState.OutsideTheRoom)
            end
          else
            if opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_HalfOver then
              self:__EnterExplorationScene(ePlayerState.HalfOver)
            else
              if opState == proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleFailure then
                self:__EnterExplorationScene(ePlayerState.BattleFailure)
              else
                if opState == proto_object_ExplorationCurGridState.ExplorationCurGridStateReplaceChip then
                  self:__EnterExplorationScene(ePlayerState.ReplaceChip)
                else
                  error("Unsupported opState : " .. tostring(opState))
                end
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
  -- function num : 0_8 , upvalues : _ENV, ExplorationEnum
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
  -- function num : 0_9 , upvalues : ePlayerState, _ENV
  if self.__playerState == ePlayerState.InTheRoom then
    local currentRoom = self:GetCurrentRoomData()
    self:OnPlayerMoveComplete(currentRoom)
  else
    do
      if self.__playerState == ePlayerState.OutsideTheRoom then
        if not self._outsideTheRoomFunc then
          self._outsideTheRoomFunc = function()
    -- function num : 0_9_0 , upvalues : self, _ENV
    self:CheckBossRoom()
    GuideManager:TryTriggerGuide(eGuideCondition.InExplorationScene)
  end

          if not (self.residentStoreCtrl):CheckEpResidentStore(self._outsideTheRoomFunc) then
            (self._outsideTheRoomFunc)()
          end
          self.__isFirstEnter = false
          if self.__playerState == ePlayerState.SelectingChip then
            if not self.__ContinueSelectChipCompleteFunc then
              self.__ContinueSelectChipCompleteFunc = BindCallback(self, self.__ContinueSelectChipComplete)
              self:CheckChipSelect(self.__ContinueSelectChipCompleteFunc)
              GuideManager:TryTriggerGuide(eGuideCondition.InExplorationScene)
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
                    else
                      if self.__playerState == ePlayerState.MonsterLvUpgrade then
                        self:OpenSelectDebuffUI()
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

ExplorationController.__ContinueSelectChipComplete = function(self)
  -- function num : 0_10 , upvalues : _ENV, ExplorationEnum
  if (self.dynPlayer):GetOperatorDetailState() ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_DropAlg then
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).OutsideSelectChip)
  end
end

ExplorationController.CheckBossRoom = function(self)
  -- function num : 0_11 , upvalues : _ENV, cs_MessageCommon
  local currentRoom = self:GetCurrentRoomData()
  if currentRoom:IsRealBossRoom() then
    if (self.mapData):HasWeeklyChallengeBigBossRoom() then
      local bossMonsterName = "?"
      local bigBossRoomData = (currentRoom:GetNextRoom())[1]
      if bigBossRoomData ~= nil and bigBossRoomData.mode == 5 then
        for _,dynMonster in pairs(bigBossRoomData.monsterList) do
          if dynMonster:GetBossBloodNum() > 0 then
            bossMonsterName = dynMonster:GetName()
            break
          end
        end
      end
      do
        do
          ;
          (cs_MessageCommon.ShowMessageBox)((string.format)(ConfigData:GetTipContent(905), bossMonsterName))
          if (self.mapData):HasOverBossRoom() and not (self.autoCtrl):IsAutoModeRunning() then
            if self.__isRevive then
              local stageId = (ExplorationManager:GetSectorStageCfg()).id
              do
                local curFloor = ExplorationManager:GetCurLevelIndex() + 1
                ;
                (ControllerManager:GetController(ControllerTypeId.AvgPlay, true)):TryPlayAvg(eAvgTriggerType.MainAvgEp, stageId, curFloor, 3, function()
    -- function num : 0_11_0 , upvalues : cs_MessageCommon, _ENV, self
    (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(255), function()
      -- function num : 0_11_0_0
    end
, function()
      -- function num : 0_11_0_1 , upvalues : self
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
    end
  end
end

ExplorationController.IsCompleteExploration = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if ((self.dynPlayer):GetOperatorDetail()).canFloorOver and not ExplorationManager:HasNextLevel() then
    return true
  end
  return false
end

ExplorationController.StartCompleteExploration = function(self, endAction)
  -- function num : 0_13 , upvalues : _ENV
  if ExplorationManager:HasNextLevel() then
    self:__CompleteExplorationFloor(endAction)
  else
    self:__CompleteExploration(endAction)
  end
end

ExplorationController.__CompleteExplorationFloor = function(self, endAction)
  -- function num : 0_14 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
    -- function num : 0_14_0 , upvalues : _ENV, self, endAction
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
  -- function num : 0_15 , upvalues : _ENV
  if ExplorationManager:HasEpRewardBag() then
    local epBagDropList = ((ExplorationManager:GetDynPlayer()).dynRewardBag):GetEpRewardBagDataList()
    local hasBagDrop = epBagDropList ~= nil and #epBagDropList > 0
    if hasBagDrop then
      UIManager:ShowWindowAsync(UIWindowTypeID.EpRewardBag, function(window)
    -- function num : 0_15_0 , upvalues : _ENV, self, clearAction
    if window == nil then
      return 
    end
    local rewardList = ((ExplorationManager:GetDynPlayer()).dynRewardBag):GetEpRewardBagDataList()
    local stageCfg = ExplorationManager:GetSectorStageCfg()
    local epModuleId = ExplorationManager:GetEpModuleId()
    local stageId = ExplorationManager:GetEpDungeonId()
    window:InitEpRewardBag(rewardList, stageCfg, true, nil, true, epModuleId, stageId)
    ;
    (self.autoCtrl):CloseAutoMode()
    if self.mapCtrl ~= nil then
      (self.mapCtrl):HideMapCavasWithoutBg()
    end
    UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
    UIManager:HideWindow(UIWindowTypeID.Exploration)
    UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
    window:SetEpRewardBagCloseFunc(function(rewardDic)
      -- function num : 0_15_0_0 , upvalues : window, _ENV, clearAction
      window:Delete()
      UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(resultWindow)
        -- function num : 0_15_0_0_0 , upvalues : clearAction, rewardDic
        if resultWindow == nil then
          return 
        end
        resultWindow:FailExploration(clearAction, nil, rewardDic, true)
      end
)
    end
)
  end
)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(resultWindow)
    -- function num : 0_15_1 , upvalues : self, _ENV, clearAction
    if resultWindow == nil then
      return 
    end
    ;
    (self.autoCtrl):CloseAutoMode()
    if self.mapCtrl ~= nil then
      (self.mapCtrl):HideMapCavasWithoutBg()
    end
    UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
    UIManager:HideWindow(UIWindowTypeID.Exploration)
    UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
    resultWindow:FailExploration(clearAction, nil, nil, false)
  end
)
    end
  elseif ExplorationManager:GetIsInWeeklyChallenge() then
    ExplorationManager:SendSettle(function(dataList)
    -- function num : 0_15_2 , upvalues : _ENV, self, clearAction
    local msgData = nil
    if dataList.Count > 0 then
      msgData = dataList[0]
    else
      msgData = {}
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
      -- function num : 0_15_2_0 , upvalues : self, clearAction, msgData
      if window == nil then
        return 
      end
      ;
      (self.autoCtrl):CloseAutoMode()
      window:FailExploration(clearAction, msgData.rewards)
    end
)
  end
, false, nil, false)
  else
    (self.epNetwork):CS_EXPLORATION_RewardsShow(function(dataList)
    -- function num : 0_15_3 , upvalues : _ENV, self, clearAction
    local msgData = nil
    if dataList.Count > 0 then
      msgData = dataList[0]
    else
      msgData = {}
    end
    if ExplorationManager:GetIsInWeeklyChallenge() then
      ExplorationManager:SendSettle(function()
      -- function num : 0_15_3_0 , upvalues : _ENV, self, clearAction, msgData
      UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
        -- function num : 0_15_3_0_0 , upvalues : self, clearAction, msgData
        if window == nil then
          return 
        end
        ;
        (self.autoCtrl):CloseAutoMode()
        window:FailExploration(clearAction, msgData.rewards)
      end
)
    end
, false, nil, false)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
      -- function num : 0_15_3_1 , upvalues : self, clearAction, msgData
      if window == nil then
        return 
      end
      ;
      (self.autoCtrl):CloseAutoMode()
      window:FailExploration(clearAction, msgData.rewards)
    end
)
    end
  end
)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

ExplorationController.__CompleteExploration = function(self, endAction)
  -- function num : 0_16 , upvalues : _ENV
  local beforeSettleStageState = (PlayerDataCenter.sectorStage):GetStageState((ExplorationManager:GetSectorStageCfg()).id)
  local resultSettlementData = ((ExplorationManager.epCtrl).dynPlayer):SetResultSettlementData()
  ;
  ((CS.BattleManager).Instance):ForceExitBattle()
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (Time.unity_time).timeScale = 1
  if ExplorationManager:HasEpRewardBag() then
    local epBagDropList = ((ExplorationManager:GetDynPlayer()).dynRewardBag):GetEpRewardBagDataList()
    local hasBagDrop = epBagDropList ~= nil and #epBagDropList > 0
    if hasBagDrop then
      UIManager:ShowWindowAsync(UIWindowTypeID.EpRewardBag, function(window)
    -- function num : 0_16_0 , upvalues : _ENV, self, endAction, resultSettlementData
    if window == nil then
      return 
    end
    local rewardList = ((ExplorationManager:GetDynPlayer()).dynRewardBag):GetEpRewardBagDataList()
    local stageCfg = ExplorationManager:GetSectorStageCfg()
    local epModuleId = ExplorationManager:GetEpModuleId()
    local stageId = ExplorationManager:GetEpDungeonId()
    local firstClearRewards = ExplorationManager:GetEpFirstClearDic(stageId, epModuleId)
    window:InitEpRewardBag(rewardList, stageCfg, true, firstClearRewards, true, epModuleId, stageId)
    ;
    (self.autoCtrl):CloseAutoMode()
    if self.mapCtrl ~= nil then
      (self.mapCtrl):HideMapCavasWithoutBg()
    end
    UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
    UIManager:HideWindow(UIWindowTypeID.Exploration)
    UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
    if endAction ~= nil then
      endAction()
    end
    window:SetEpRewardBagCloseFunc(function(rewardDic)
      -- function num : 0_16_0_0 , upvalues : window, _ENV, resultSettlementData
      window:Delete()
      UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(resultWindow)
        -- function num : 0_16_0_0_0 , upvalues : _ENV, resultSettlementData, rewardDic
        local epModuleId = ExplorationManager:GetEpModuleId()
        local stageId = ExplorationManager:GetEpDungeonId()
        local firstClearRewards = ExplorationManager:GetEpFirstClearDic(stageId, epModuleId)
        if resultWindow ~= nil then
          resultWindow:CompleteExploration(nil, firstClearRewards, nil, resultSettlementData, rewardDic, true)
        end
      end
)
    end
)
  end
)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(resultWindow)
    -- function num : 0_16_1 , upvalues : _ENV, resultSettlementData, self, endAction
    local epModuleId = ExplorationManager:GetEpModuleId()
    local stageId = ExplorationManager:GetEpDungeonId()
    local firstClearRewards = ExplorationManager:GetEpFirstClearDic(stageId, epModuleId)
    if resultWindow ~= nil then
      resultWindow:CompleteExploration(nil, firstClearRewards, nil, resultSettlementData, nil, false)
    end
    ;
    (self.autoCtrl):CloseAutoMode()
    if self.mapCtrl ~= nil then
      (self.mapCtrl):HideMapCavasWithoutBg()
    end
    UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
    UIManager:HideWindow(UIWindowTypeID.Exploration)
    UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
    if endAction ~= nil then
      endAction()
    end
  end
)
    end
  else
    ExplorationManager:SendSettle(function(msg)
    -- function num : 0_16_2 , upvalues : _ENV, beforeSettleStageState, resultSettlementData, self, endAction
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
      -- function num : 0_16_2_0 , upvalues : data, needFirsPassReward, resultSettlementData, self, _ENV, endAction
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
      UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
      if endAction ~= nil then
        endAction()
      end
    end
)
  end
, nil, nil, true)
  end
  local heroIdList = {}
  for index,heroData in ipairs((self.dynPlayer).heroList) do
    (table.insert)(heroIdList, heroData.dataId)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

ExplorationController.__EnterBattleScene = function(self, roomData, isReconnect)
  -- function num : 0_17 , upvalues : _ENV, ExplorationEnum
  if isGameDev then
    print("[Dev]battleId:", roomData.battleId)
  end
  if self.bloodGridMax == nil then
    local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
    local unitBlood, bossUnitBlood = saveUserData:GetUnitBlood()
    if unitBlood or 0 > 0 then
      self:SetBloodGrid(unitBlood, bossUnitBlood)
    else
      self:CalculateBloodGrid()
    end
  end
  do
    ;
    (roomData.battleMap):SetBloodGridParam(self.unitBlood, self.bossUnitBlood, self.bloodGridMax, (ConfigData.game_config).bloodDensity)
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
    local csbattleCtrl = (self.battleCtrl):StartNewEpBattle(roomData, self.dynPlayer)
    local epToBattleAction = function()
    -- function num : 0_17_0 , upvalues : csbattleCtrl
    csbattleCtrl:StartEnterDeployState()
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
end

ExplorationController.EnterDeployRoom = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local epState = (self.dynPlayer):GetOperatorDetailState()
  if epState ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    return 
  end
  local deployRoomData = (self.mapData):GetDeployRoom()
  self:__EnterBattleScene(deployRoomData)
end

ExplorationController.GenExplorationMap = function(self)
  -- function num : 0_19
  (self.mapCtrl):GenMap(self.mapData, self:GetCurrentRoomData(true))
end

ExplorationController.SetViewPositionOffset = function(self, offsetPosition)
  -- function num : 0_20
  local position = (self.mapCtrl):GetViewPosition() + offsetPosition
  return (self.mapCtrl):SetViewPosition(position)
end

ExplorationController.GetViewPosition = function(self)
  -- function num : 0_21
  return (self.mapCtrl):GetViewPosition()
end

ExplorationController.OnPlayerMoveStart = function(self, roomData)
  -- function num : 0_22 , upvalues : _ENV
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
    ((self.sceneCtrl).epSceneEntity):EpRoomCoverBattleMap(true, function()
    -- function num : 0_22_0 , upvalues : self, roomData, _ENV
    self:OnPlayerMoveComplete(roomData)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end
, (roomUI.transform).position)
  end
end

ExplorationController.OnPlayerMoveComplete = function(self, roomData)
  -- function num : 0_23 , upvalues : ExplorationEnum, _ENV
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
              if roomType == (ExplorationEnum.eRoomType).story then
                (self.eventCtrl):OnEventRoomOpen(roomData, true)
              else
              end
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
  -- function num : 0_24 , upvalues : _ENV
  local curRoomData = self:GetCurrentRoomData(true)
  if curRoomData:IsEndColRoom() then
    return 
  end
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  ;
  (self.mapCtrl):PlayerPosItemMove2NextPos(function()
    -- function num : 0_24_0 , upvalues : self, _ENV, curRoomData
    ((self.sceneCtrl).epSceneEntity):EpRoomCoverBattleMap(true, function()
      -- function num : 0_24_0_0 , upvalues : _ENV, curRoomData, self
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
      if curRoomData:IsCrossRoom() and not (self.autoCtrl):IsAutoModeRunning() then
        GuideManager:TryTriggerGuide(eGuideCondition.AfterEpCrossRoom)
      end
    end
)
  end
)
end

ExplorationController.UpdateNextRoomInfo = function(self, epGrid, jumpCat)
  -- function num : 0_25 , upvalues : _ENV, ExplorationEnum
  if epGrid.monster ~= nil then
    for k,v in pairs(epGrid.monster) do
      local roomData = (self.mapData):GetRoomByCoord(k)
      if roomData ~= nil and roomData:IsBattleRoom(jumpCat) then
        roomData:InitBattleData(v)
        roomData:ExecuteMonsterChip(self.dynPlayer)
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
              do
                if epGrid.buffData ~= nil then
                  local curRoomData = self:GetCurrentRoomData()
                  if curRoomData ~= nil then
                    curRoomData:InitEpBuffEffective((epGrid.buffData).data)
                  end
                end
                if self.bloodGridMax == nil then
                  self:CalculateBloodGrid()
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
  -- function num : 0_26
  (self.residentStoreCtrl):UpdateResidentStore(epResident)
end

ExplorationController.OpenResidentStore = function(self)
  -- function num : 0_27
  (self.residentStoreCtrl):OnResidentStoreRoomOpen()
end

ExplorationController.IsMapLogic = function(self, mapLogic)
  -- function num : 0_28
  do return (self.mapData).epMapLogic == mapLogic end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ExplorationController.CheckChipSelect = function(self, noSelectEvent, toFakeCamera)
  -- function num : 0_29 , upvalues : _ENV
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
  self.selectChipWindow = nil
  if toFakeCamera then
    self.selectChipWindow = UIManager:ShowWindow(UIWindowTypeID.SelectChip, UIWindowTypeID.ThreeDSelectChip)
  else
    self.selectChipWindow = UIManager:ShowWindow(UIWindowTypeID.SelectChip)
  end
  if self.selectChipWindow ~= nil then
    (self.selectChipWindow):InitSelectChip(true, chipList, self.dynPlayer, BindCallback(self, self.__SelectChipComplete), BindCallback(self, self.__GiveSelectChipComplect), toFakeCamera, BindCallback(self, self.__ReqReFreshSelectChipAfterBtl))
    ;
    (self.autoCtrl):OnEpBattleSelectChip()
  end
  ;
  (self.campFetterCtrl):OnEpSelectChip()
  return true
end

ExplorationController.__ReqReFreshSelectChipAfterBtl = function(self, currencyId, remainRefreshTime, refreshPrice, lockChipIdx)
  -- function num : 0_30 , upvalues : _ENV, cs_MessageCommon
  if remainRefreshTime > 0 or remainRefreshTime == -1 then
    if refreshPrice <= (self.dynPlayer):GetItemCount(currencyId) or refreshPrice <= 0 then
      if lockChipIdx == nil then
        lockChipIdx = table.emptytable
      end
      ;
      (self.epNetwork):CS_EXPLORATION_BATTLE_RefreshAlg(lockChipIdx, BindCallback(self, self.__UpdaterRefreshChipCountAfterBtlUI))
    else
      ;
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.exploration_Treasure_MoneyInsufficient))
    end
  else
    ;
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.exploration_Treasure_RefreshNumInsufficient))
  end
end

ExplorationController.__UpdaterRefreshChipCountAfterBtlUI = function(self)
  -- function num : 0_31 , upvalues : _ENV
  if self.selectChipWindow == nil then
    return 
  end
  local chipList = (self:GetCurrentRoomData()):GetRewardChipList()
  if #chipList == 0 then
    error("rewardChipList.count == 0")
    return false
  end
  ;
  (self.selectChipWindow):RefreshChipList(chipList, true)
  ;
  (self.selectChipWindow):OnUpdateRemainRefreshInfo()
end

ExplorationController.__SelectChipComplete = function(self, index, selectComplete)
  -- function num : 0_32
  index = index - 1
  local position = (self:GetCurrentRoomData()):GetRoomPosition()
  ;
  (self.epNetwork):CS_EXPLORATION_BATTLE_ALGSelect(position, index, function(dataList)
    -- function num : 0_32_0 , upvalues : selectComplete, self
    if selectComplete ~= nil then
      selectComplete()
    end
    self:CheckChipSelect()
  end
)
end

ExplorationController.__GiveSelectChipComplect = function(self, selectComplete)
  -- function num : 0_33
  (self.epNetwork):CS_EXPLORATION_BATTLE_GiveUpAlg(function()
    -- function num : 0_33_0 , upvalues : selectComplete, self
    if selectComplete ~= nil then
      selectComplete(function()
      -- function num : 0_33_0_0 , upvalues : self
      self:CheckChipSelect()
    end
)
    end
  end
)
end

ExplorationController.DiscardChip = function(self)
  -- function num : 0_34 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.EpChipDiscard)
  if win ~= nil and win.active then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpChipDiscard, function(win)
    -- function num : 0_34_0 , upvalues : _ENV, self
    if win == nil then
      error("can\'t open EpChipDiscard UI")
      return 
    end
    win:InitEpChipDiscard(self.dynPlayer, function()
      -- function num : 0_34_0_0 , upvalues : self
      self:CheckBossRoom()
    end
)
  end
)
end

ExplorationController.OpenSelectDebuffUI = function(self)
  -- function num : 0_35 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.EpSelectDebuff)
  if win ~= nil and win.active then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpSelectDebuff, function(win)
    -- function num : 0_35_0 , upvalues : _ENV, self
    if win == nil then
      error("can\'t open EpSelectDebuff UI")
      return 
    end
    win:InitEpSelectDebuff(self.dynPlayer)
  end
)
end

ExplorationController.GetRoomRoot = function(self)
  -- function num : 0_36
  return (self.mapCtrl):GetRoomRoot()
end

ExplorationController.GetRoomUI = function(self, position, index)
  -- function num : 0_37
  return (self.mapCtrl):GetRoomUI(position, index)
end

ExplorationController.GetCurrentRoomData = function(self, withoutSpecialRoom)
  -- function num : 0_38
  local currentRoom = (self.playerCtrl):GetCurrentRoomData(withoutSpecialRoom)
  return currentRoom
end

ExplorationController.GetCurrentRoomTitle = function(self)
  -- function num : 0_39 , upvalues : _ENV
  local currentRoom = (self.playerCtrl):GetCurrentRoomData()
  local roomType = currentRoom:GetRoomType()
  local roomTypeCfg = (ConfigData.exploration_roomtype)[roomType]
  if roomTypeCfg == nil then
    error("exploration room type is null,id:" .. tostring(roomType))
    return ""
  end
  return (LanguageUtil.GetLocaleText)(roomTypeCfg.title)
end

ExplorationController.ExecuteTempChipCurBattleRoom = function(self, chipTemporaryDic)
  -- function num : 0_40
  local curRoomData = self:GetCurrentRoomData()
  if curRoomData:IsBattleRoom() then
    curRoomData:ExecuteMonsterTempChip(chipTemporaryDic)
  end
end

ExplorationController.RollbackTempChipCurBattleRoom = function(self, chipTemporaryDic)
  -- function num : 0_41
  local curRoomData = self:GetCurrentRoomData()
  if curRoomData:IsBattleRoom() then
    curRoomData:RollbackMonsterTempChip(chipTemporaryDic)
  end
end

ExplorationController.OnDelete = function(self)
  -- function num : 0_42 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnEpGridDetailDiff, self.__onUpdateNextRoomInfo)
  MsgCenter:RemoveListener(eMsgEventId.OnEpResidentDiff, self.__onEpResidentDiff)
  UIManager:DeleteWindow(UIWindowTypeID.Exploration)
  for k,v in pairs(self.ctrls) do
    v:OnDelete()
  end
  self.ctrls = nil
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

ExplorationController.CalculateBloodGrid = function(self)
  -- function num : 0_48 , upvalues : _ENV
  local roomList = {}
  local curRoom = self:GetCurrentRoomData(true)
  local nextRoomList = curRoom:GetNextRoom()
  ;
  (table.insert)(roomList, curRoom)
  ;
  (table.insertto)(roomList, nextRoomList)
  local heroDic = (self.dynPlayer).heroDic
  local maxHp, minHp = nil, nil
  for id,dyHero in pairs(heroDic) do
    local hp = dyHero:GetRealAttr(eHeroAttr.maxHp)
    if maxHp ~= nil or not hp then
      maxHp = (math.max)(maxHp, hp)
    end
    if minHp ~= nil or not hp then
      minHp = (math.min)(minHp, hp)
    end
  end
  for _,epRoom in ipairs(roomList) do
    if epRoom ~= nil and epRoom:IsBattleRoom() then
      local monsterList = epRoom:GetMonsterList()
      for _,monster in ipairs(monsterList) do
        if monster:GetBossBloodNum() == 0 then
          local hp = monster:GetRealAttr(eHeroAttr.maxHp)
          if maxHp ~= nil or not hp then
            maxHp = (math.max)(maxHp, hp)
          end
          if minHp ~= nil or not hp then
            minHp = (math.min)(minHp, hp)
          end
        end
      end
    end
  end
  self.unitBlood = (BattleUtil.CalculateBloodGrid)(maxHp, minHp)
  local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
  saveUserData:SetUnitBlood(self.unitBlood, self.bossUnitBlood)
end

ExplorationController.SetBloodGrid = function(self, unitBlood, bossUnitBlood)
  -- function num : 0_49 , upvalues : _ENV
  self.unitBlood = unitBlood
  self.bossUnitBlood = bossUnitBlood
  self.bloodGridMax = (ConfigData.game_config).bloodGridMax
end

return ExplorationController

