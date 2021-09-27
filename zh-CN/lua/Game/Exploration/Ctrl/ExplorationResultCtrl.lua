local ExplorationResultCtrl = class("ExplorationResultCtrl")
local EpMvpData = require("Game.Exploration.Data.EpMvpData")
ExplorationResultCtrl.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.epCtrl = ExplorationManager.epCtrl
  self.__TryOpenStore = BindCallback(self, self._TryOpenStore)
  self.__ReqSettle = BindCallback(self, self._ReqSettle)
  self.__TryOpenStoreReward = BindCallback(self, self._TryOpenStoreReward)
  self.__TryOpenScore = BindCallback(self, self._TryOpenScore)
  self.__TryOpenResult = BindCallback(self, self._TryOpenResult)
  self.__ExitExplorationAndContinueProcess = BindCallback(self, self.ExitExplorationAndContinueProcess)
  self.__ContinueProcessEpExitAfter = BindCallback(self, self._ContinueProcessEpExitAfter)
  self.processTable_InEp = {self.__TryOpenStore, self.__ReqSettle, self.__TryOpenScore, self.__TryOpenResult, self.__ExitExplorationAndContinueProcess}
  self.processTable_OutEp = {self.__TryOpenStore, self.__ReqSettle, self.__TryOpenStoreReward, self.__ContinueProcessEpExitAfter}
end

ExplorationResultCtrl.EnterResultProcess = function(self, isWin, isInEp, battleEndClearCallback)
  -- function num : 0_1 , upvalues : _ENV
  if ExplorationManager.epCtrl ~= nil then
    ((ExplorationManager.epCtrl).autoCtrl):CloseAutoMode()
  end
  self.battleEndClearCallback = battleEndClearCallback
  self.isWin = isWin
  self.isInEp = isInEp
  self.storeRewardDic = nil
  self.pickInfo = nil
  self.resultMsg = nil
  self.firstRewardDic = nil
  self.normalRewardDic = nil
  if not self.isInEp or not self.processTable_InEp then
    self.processTable = self.processTable_OutEp
    self:_ContinueNextStep(true)
  end
end

ExplorationResultCtrl.ExitExplorationAndContinueProcess = function(self, SceneName, loadMainCallback)
  -- function num : 0_2 , upvalues : _ENV
  self:ExecuteBattleEndClear()
  ExplorationManager:ExitExploration(SceneName, loadMainCallback, self.isWin, self.__ContinueProcessEpExitAfter)
end

ExplorationResultCtrl.ExecuteBattleEndClear = function(self)
  -- function num : 0_3
  if self.isExecutedBattleEndClear then
    return 
  end
  self.isExecutedBattleEndClear = true
  if self.battleEndClearCallback ~= nil then
    (self.battleEndClearCallback)()
  end
end

ExplorationResultCtrl._TryOpenStore = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local epBagDropList = ExplorationManager:GetStoreData()
  local hasBagDrop = epBagDropList ~= nil and #epBagDropList > 0
  if not hasBagDrop then
    self:_ContinueNextStep()
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpRewardBag, function(window)
    -- function num : 0_4_0 , upvalues : self, _ENV, epBagDropList
    if window == nil then
      return 
    end
    local stageCfg, epModuleId, stageId = nil, nil, nil
    if self.isInEp then
      stageCfg = ExplorationManager:GetSectorStageCfg()
      epModuleId = ExplorationManager:GetEpModuleId()
      stageId = ExplorationManager:GetEpDungeonId()
    else
      stageCfg = ExplorationManager:TryGetUncompletedEpSectorStateCfg()
      _ = ExplorationManager:HasUncompletedEp()
    end
    if not self.isWin or not ExplorationManager:GetEpFirstClearDic(stageId, R7_PC27) then
      local firstClearRewards = table.emptytable
    end
    -- DECOMPILER ERROR at PC44: Overwrote pending register: R7 in 'AssignReg'

    window:InitEpRewardBag(R7_PC27, stageCfg, self.isInEp, firstClearRewards, true, epModuleId, stageId)
    if self.mapCtrl ~= nil then
      (self.mapCtrl):HideMapCavasWithoutBg()
    end
    -- DECOMPILER ERROR at PC60: Overwrote pending register: R7 in 'AssignReg'

    -- DECOMPILER ERROR at PC61: Overwrote pending register: R7 in 'AssignReg'

    UIManager:HideWindow(R7_PC27)
    -- DECOMPILER ERROR at PC65: Overwrote pending register: R7 in 'AssignReg'

    -- DECOMPILER ERROR at PC66: Overwrote pending register: R7 in 'AssignReg'

    UIManager:HideWindow(R7_PC27)
    -- DECOMPILER ERROR at PC70: Overwrote pending register: R7 in 'AssignReg'

    -- DECOMPILER ERROR at PC71: Overwrote pending register: R7 in 'AssignReg'

    UIManager:HideWindow(R7_PC27)
    -- DECOMPILER ERROR at PC75: Overwrote pending register: R7 in 'AssignReg'

    -- DECOMPILER ERROR at PC76: Overwrote pending register: R7 in 'AssignReg'

    UIManager:HideWindow(R7_PC27)
    -- DECOMPILER ERROR at PC80: Overwrote pending register: R7 in 'AssignReg'

    -- DECOMPILER ERROR at PC81: Overwrote pending register: R7 in 'AssignReg'

    UIManager:HideWindow(R7_PC27)
    -- DECOMPILER ERROR at PC84: Overwrote pending register: R7 in 'AssignReg'

    window:SetEpRewardBagCloseFunc(R7_PC27)
  end
)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ExplorationResultCtrl._ReqFailRewardShowAndShow = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.isWin then
    return 
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  network:CS_EXPLORATION_RewardsShow(function(dataList)
    -- function num : 0_5_0 , upvalues : _ENV, self
    local msgData = nil
    if dataList.Count > 0 then
      msgData = dataList[0]
    else
      msgData = {}
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
      -- function num : 0_5_0_0 , upvalues : _ENV, msgData, self
      if window == nil then
        return 
      end
      window:FailExploration(clearAction, msgData.rewards)
      window:SetReturnCallback(function()
        -- function num : 0_5_0_0_0 , upvalues : self
        self:_ContinueNextStep()
      end
)
    end
)
  end
)
end

ExplorationResultCtrl._ReqSettle = function(self)
  -- function num : 0_6 , upvalues : _ENV, EpMvpData
  local position = nil
  local isAutoSettle = false
  local isGiveUpLastEp = false
  local costumeStm = false
  local mvpHeroId = 0
  local refreshLastEp = nil
  local _, suitLevelMap = ExplorationManager:GetChipSuitMaxLevelDic()
  if self.isInEp then
    position = ((ExplorationManager:GetDynPlayer()):GetOperatorDetail()).curPostion
    if ExplorationManager.epMvpData == nil or not (ExplorationManager.epMvpData):GetBossFightMvp(true) then
      mvpHeroId = (((ExplorationManager:GetDynPlayer()).heroList)[1]).uid
      local lastEpData = ExplorationManager:GetLastEpData()
      position = (lastEpData.epOp).curPostion
      do
        local mapData = (EpMvpData.New)((lastEpData.epRoleStc).heroes)
        mapData:AddServerSaveData((lastEpData.epStc).record)
        mvpHeroId = mapData:GetBossFightMvp(true)
        isGiveUpLastEp = true
        local network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
        network:CS_EXPLORATION_Settle(position, isAutoSettle, isGiveUpLastEp, costumeStm, mvpHeroId, self.pickInfo, refreshLastEp, suitLevelMap, function(msg)
    -- function num : 0_6_0 , upvalues : self, isGiveUpLastEp, _ENV
    self.resultMsg = msg
    if isGiveUpLastEp then
      MsgCenter:Broadcast(eMsgEventId.GiveUncompleteExploration)
    end
    self:_RewardSplit()
    self:_ContinueNextStep()
    ExplorationManager:SettleDataDeal(msg)
  end
)
      end
    end
  end
end

ExplorationResultCtrl._TryOpenScore = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if not ExplorationManager:GetIsInWeeklyChallenge() then
    self:_ContinueNextStep()
    return 
  end
  if self.resultMsg == nil or (self.resultMsg).Count < 1 then
    error("can\'t get msg arg0")
    self:_ContinueNextStep()
    return 
  end
  local data = (self.resultMsg)[0]
  if data.scoreShow ~= nil then
    (ExplorationManager:GetDynPlayer()):SetWeekExtrReward(((PlayerDataCenter.allWeeklyChallengeData).ConvetTypeReward2RewadDic)((data.scoreShow).reward))
    ;
    (ExplorationManager:GetDynPlayer()).weekExtrIsDouble = (data.scoreShow).double
    if self.isWin then
      (NetworkManager:GetNetwork(NetworkTypeID.Sector)):CS_WEEKLYCHALLENGE_Detail()
    end
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.WCDebuffResult, function(win)
    -- function num : 0_7_0 , upvalues : _ENV, data, self
    if win ~= nil then
      local resultWin = UIManager:GetWindow(UIWindowTypeID.ExplorationResult)
      if resultWin ~= nil then
        resultWin:Hide()
      end
      win:InitWCDebuffResult(data.scoreShow, self.isWin, function()
      -- function num : 0_7_0_0 , upvalues : self
      self:_ContinueNextStep()
    end
)
      if ExplorationManager.epCtrl ~= nil and (ExplorationManager.epCtrl).mapCtrl ~= nil then
        ((ExplorationManager.epCtrl).mapCtrl):HideMapCavasWithoutBg()
      end
      UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
      UIManager:HideWindow(UIWindowTypeID.Exploration)
      UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
      UIManager:HideWindow(UIWindowTypeID.BattlePause)
      UIManager:HideWindow(UIWindowTypeID.EpChipSuit)
    else
      do
        self:_ContinueNextStep()
      end
    end
  end
)
end

ExplorationResultCtrl._TryOpenStoreReward = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.storeRewardDic == nil or (table.count)(self.storeRewardDic) == 0 then
    self:_ContinueNextStep()
    return 
  end
  local ShowWinFunc = function(window)
    -- function num : 0_8_0 , upvalues : _ENV, self
    local rewardIds = {}
    local rewardNums = {}
    for id,num in pairs(self.storeRewardDic) do
      (table.insert)(rewardIds, id)
      ;
      (table.insert)(rewardNums, num)
    end
    window:InitRewardsItem(rewardIds, rewardNums)
    window:BindCommonRewardExit(function()
      -- function num : 0_8_0_0 , upvalues : self
      self:_ContinueNextStep()
    end
)
  end

  local rewardWin = UIManager:GetWindow(UIWindowTypeID.CommonReward)
  if rewardWin ~= nil then
    ShowWinFunc(rewardWin)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_8_1 , upvalues : ShowWinFunc
    if window == nil then
      return 
    end
    ShowWinFunc(window)
  end
)
  end
end

ExplorationResultCtrl._TryOpenResult = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    self:_ContinueNextStep()
    return 
  end
  local data = nil
  if self.resultMsg == nil or (self.resultMsg).Count < 1 then
    data = {}
  else
    data = (self.resultMsg)[0]
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
    -- function num : 0_9_0 , upvalues : self, _ENV, data
    if window == nil then
      return 
    end
    if self.isWin then
      local epModuleId = ExplorationManager:GetEpModuleId()
      local stageId = (ExplorationManager:GetEpDungeonId())
      -- DECOMPILER ERROR at PC12: Overwrote pending register: R3 in 'AssignReg'

      local resultSettlementData = .end
      if ExplorationManager.epCtrl ~= nil then
        resultSettlementData = ((ExplorationManager.epCtrl).dynPlayer):SetResultSettlementData()
      end
      window:CompleteExploration(data.rewards, self.firstRewardDic, nil, resultSettlementData, self.normalRewardDic)
    else
      do
        window:FailExploration(data.rewards, self.normalRewardDic, true)
        window:SetReturnCallback(function()
      -- function num : 0_9_0_0 , upvalues : _ENV, self
      UIManager:DeleteWindow(UIWindowTypeID.ExplorationResult, true)
      self:_ContinueNextStep()
    end
)
      end
    end
  end
)
end

ExplorationResultCtrl._ContinueProcessEpExitAfter = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
  if aftertTeatmentCtrl ~= nil then
    aftertTeatmentCtrl:TeatmentBengin()
  end
end

ExplorationResultCtrl._RewardSplit = function(self)
  -- function num : 0_11 , upvalues : _ENV
  self.firstRewardDic = {}
  self.normalRewardDic = {}
  local StOCareerRewardDic = {}
  if self.resultMsg == nil or (self.resultMsg).Count <= 0 then
    return 
  end
  local AddItemInDic = function(id, count, dic)
    -- function num : 0_11_0
    local newCount = dic[id] or 0
    dic[id] = newCount + count
  end

  local StOCareerItemIdDic = {}
  for _,itemId in ipairs((ConfigData.game_config).STOCareerCostIds) do
    StOCareerItemIdDic[itemId] = true
  end
  local data = (self.resultMsg)[0]
  if data.firstClearRewards ~= nil then
    for id,count in pairs(data.firstClearRewards) do
      if StOCareerItemIdDic[id] == nil then
        AddItemInDic(id, count, self.firstRewardDic)
      else
        AddItemInDic(id, count, StOCareerRewardDic)
      end
    end
  end
  do
    if data.rewards ~= nil and (data.rewards).rewards ~= nil then
      for id,count in pairs((data.rewards).rewards) do
        if StOCareerItemIdDic[id] == nil then
          AddItemInDic(id, count, self.normalRewardDic)
        else
          AddItemInDic(id, count, StOCareerRewardDic)
        end
      end
    end
    do
      if (table.count)(StOCareerRewardDic) > 0 then
        local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment, true)
        aftertTeatmentCtrl:AddShowReward(StOCareerRewardDic)
      end
    end
  end
end

ExplorationResultCtrl._ContinueNextStep = function(self, isFirst)
  -- function num : 0_12
  if isFirst then
    self.currentProcess = 0
    self.isExecutedBattleEndClear = false
  end
  self.currentProcess = self.currentProcess + 1
  if #self.processTable < self.currentProcess then
    return 
  end
  ;
  ((self.processTable)[self.currentProcess])()
end

return ExplorationResultCtrl

