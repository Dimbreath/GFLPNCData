local ExplorationAutoCtrl = class("ExplorationAutoCtrl", ExplorationCtrlBase)
local base = ExplorationCtrlBase
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local EpAutoUtil = require("Game.Exploration.Util.EpAutoUtil")
local DeployTeamUtil = require("Game.Exploration.Util.DeployTeamUtil")
ExplorationAutoCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.__enableAutoMode = false
  self.__autoModeRunning = false
  self.__autoTime = 0
  self.__isBreakAutoMode = false
  self.__defaultAutoMode = false
  self.__onEpOpStateChanged = BindCallback(self, self.OnEpOpStateChanged)
  self.__onEpSceneStateChanged = BindCallback(self, self.OnEpSceneStateChanged)
  MsgCenter:AddListener(eMsgEventId.OnEpSceneStateChanged, self.__onEpSceneStateChanged)
  self.__onBeforeCreateEpBattle = BindCallback(self, self.OnBeforeCreateEpBattle)
  MsgCenter:AddListener(eMsgEventId.BeforeNewEpBattle, self.__onBeforeCreateEpBattle)
  self.__onEpBattleReady = BindCallback(self, self.OnEpBattleReady)
  MsgCenter:AddListener(eMsgEventId.OnBattleReady, self.__onEpBattleReady)
  self.__onEpExitRoomComplete = BindCallback(self, self.OnEpExitRoomComplete)
  MsgCenter:AddListener(eMsgEventId.OnExitRoomComplete, self.__onEpExitRoomComplete)
  self.__onEnterEpChipDiscard = BindCallback(self, self.OnEnterEpChipDiscard)
  MsgCenter:AddListener(eMsgEventId.OnChipDiscardChanged, self.__onEnterEpChipDiscard)
  self.__DisableEpAutoMode = BindCallback(self, self.DisableEpAutoMode)
end

ExplorationAutoCtrl.IsEnableAutoMode = function(self)
  -- function num : 0_1
  return self.__enableAutoMode
end

ExplorationAutoCtrl.IsAutoModeRunning = function(self)
  -- function num : 0_2
  return self.__autoModeRunning
end

ExplorationAutoCtrl.SetDefaultAutoEp = function(self, active)
  -- function num : 0_3
  self.__defaultAutoMode = active
end

ExplorationAutoCtrl.IsDefaultAutoEp = function(self)
  -- function num : 0_4
  return self.__defaultAutoMode
end

ExplorationAutoCtrl.GetEpAutoPath = function(self)
  -- function num : 0_5
  return self.__autoPath
end

ExplorationAutoCtrl.EnableEpAutoMode = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((self.epCtrl).campFetterCtrl):SetAllActiveFetterVisible(false)
  if ((ExplorationManager:GetDynPlayer()):GetOperatorDetail()).state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    return 
  end
  if self:IsDefaultAutoEp() then
    self:__RealEnableEpAutoMode(true)
    return 
  end
  local originFightPower = (ExplorationManager:GetDynPlayer()):GetMirrorTeamFightPower(true, false)
  local recommendPower = (ExplorationManager:GetSectorStageCfg()).combat
  if originFightPower < recommendPower then
    ((CS.MessageCommon).ShowMessageBox)(ConfigData:GetTipContent(280), ConfigData:GetTipContent(281), ConfigData:GetTipContent(282), function()
    -- function num : 0_6_0 , upvalues : self
    self:__RealEnableEpAutoMode()
  end
, nil)
  else
    self:__RealEnableEpAutoMode()
  end
end

ExplorationAutoCtrl.__RealEnableEpAutoMode = function(self, isRunning)
  -- function num : 0_7 , upvalues : _ENV
  self.__enableAutoMode = true
  self:CalcAutoEpPath()
  local curRoomData = (self.epCtrl):GetCurrentRoomData(true)
  ;
  ((self.epCtrl).mapCtrl):RefreshMapShowState((ExplorationManager:GetDynPlayer()):GetOperatorDetail(), curRoomData)
  local explorationWindow = UIManager:GetWindow(UIWindowTypeID.Exploration)
  if explorationWindow ~= nil then
    explorationWindow:RefreshAutoModeState(true, isRunning)
  end
end

ExplorationAutoCtrl.DisableEpAutoMode = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if not self:IsEnableAutoMode() and not self:IsAutoModeRunning() then
    return 
  end
  ;
  ((self.epCtrl).campFetterCtrl):SetAllActiveFetterVisible(true)
  self:__ClearAutoData()
  local curRoomData = (self.epCtrl):GetCurrentRoomData(true)
  ;
  ((self.epCtrl).mapCtrl):RefreshMapShowState((ExplorationManager:GetDynPlayer()):GetOperatorDetail(), curRoomData)
  local explorationWindow = UIManager:GetWindow(UIWindowTypeID.Exploration)
  if explorationWindow ~= nil then
    explorationWindow:RefreshAutoModeState(false)
  end
end

ExplorationAutoCtrl.CloseAutoMode = function(self)
  -- function num : 0_9
  if not self:IsAutoModeRunning() then
    return 
  end
  self:__ClearAutoData()
end

ExplorationAutoCtrl.__ClearAutoData = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self.__enableAutoMode = false
  self.__autoModeRunning = false
  self.__waitSelectRoom = nil
  self.__autoTime = 0
  self.__isBreakAutoMode = false
  self.__defaultAutoMode = false
  TimerManager:StopTimer(self.__autoWaitTimerId)
  UIManager:DeleteWindow(UIWindowTypeID.EpAutoMode)
  self.epAutoWindow = nil
  local explorationWindow = UIManager:GetWindow(UIWindowTypeID.Exploration)
  if explorationWindow ~= nil then
    explorationWindow:RefreshAutoModeState(false)
  end
end

ExplorationAutoCtrl.OnExplorationStart = function(self)
  -- function num : 0_11
  if not self:IsDefaultAutoEp() then
    return 
  end
  if self:IsEnableAutoMode() then
    return 
  end
  self:EnableEpAutoMode()
  self:StartOrStopEpAutoMode()
end

ExplorationAutoCtrl.StartOrStopEpAutoMode = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if not self:IsEnableAutoMode() then
    return false, false
  end
  if self:IsAutoModeRunning() then
    self:DisableEpAutoMode()
    return false, false
  end
  local aliveRoleCount = (ExplorationManager:GetDynPlayer()):GetDeployAliveHeroCount()
  if aliveRoleCount <= 0 then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(284))
    return true, false
  end
  self.__autoModeRunning = true
  self.epAutoWindow = UIManager:ShowWindow(UIWindowTypeID.EpAutoMode)
  ;
  (self.epAutoWindow):SetAutoMaskClickFunc(self.__DisableEpAutoMode)
  local opDetail = (ExplorationManager:GetDynPlayer()):GetOperatorDetail()
  self:OnEpOpStateChanged(opDetail)
  return true, true
end

ExplorationAutoCtrl.BreakAutoMode = function(self)
  -- function num : 0_13 , upvalues : _ENV, ExplorationEnum
  if TimerManager:ContainTimer(self.__autoWaitTimerId) then
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.__isBreakAutoMode = true
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
    return true
  end
  return false
end

ExplorationAutoCtrl.BreakAutoModeForce = function(self)
  -- function num : 0_14 , upvalues : ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  self.__isBreakAutoMode = true
  if self.epAutoWindow == nil then
    return 
  end
  ;
  (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  ;
  (self.epAutoWindow):SetAutoTitleActive(false)
end

ExplorationAutoCtrl.OnAutoStageOver = function(self)
  -- function num : 0_15
  if self.__isBreakAutoMode then
    self.__isBreakAutoMode = false
    ;
    (self.epAutoWindow):SetAutoTitleActive(true)
  end
end

ExplorationAutoCtrl.OnEpExitRoomComplete = function(self, exitFromType)
  -- function num : 0_16 , upvalues : ExplorationEnum, _ENV
  if exitFromType ~= (ExplorationEnum.eExitRoomCompleteType).BattleToEp then
    self:OnAutoStageOver()
  end
  local dynplayer = (BattleUtil.GetCurDynPlayer)()
  if dynplayer ~= nil then
    self:OnEpOpStateChanged(dynplayer:GetOperatorDetail())
  else
    error("CurDynPlayer is NIL")
  end
end

ExplorationAutoCtrl.OnEpOpStateChanged = function(self, opDetail)
  -- function num : 0_17 , upvalues : _ENV
  if self:IsAutoModeRunning() and opDetail.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    for k,position in pairs(self.__autoPath) do
      if position == opDetail.curPostion and k < #self.__autoPath then
        local nextRoomPos = (self.__autoPath)[k + 1]
        if ((self.epCtrl).sceneCtrl):InBattleScene() then
          self.__waitSelectRoom = nextRoomPos
          return 
        end
        self:__StartSelectRoomTimer(nextRoomPos)
        break
      end
    end
  end
end

ExplorationAutoCtrl.OnEpSceneStateChanged = function(self, epBattleState)
  -- function num : 0_18 , upvalues : ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  if epBattleState ~= (ExplorationEnum.eEpSceneState).InEpScene then
    return 
  end
  if self.__waitSelectRoom ~= nil then
    local nextRoomPos = self.__waitSelectRoom
    self.__waitSelectRoom = nil
    self:__StartSelectRoomTimer(nextRoomPos)
  end
end

ExplorationAutoCtrl.__StartSelectRoomTimer = function(self, nextRoomPos)
  -- function num : 0_19 , upvalues : _ENV, ExplorationEnum
  self.__autoTime = ((ConfigData.game_config).autoEpTime).selectRoom
  ;
  (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).SelectRoom, self.__autoTime)
  self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_19_0 , upvalues : self, ExplorationEnum, _ENV, nextRoomPos
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).SelectRoom, self.__autoTime)
      return 
    end
    TimerManager:StopTimer(self.__autoWaitTimerId)
    local playerCtrl = (ExplorationManager.epCtrl).playerCtrl
    local mapData = (self.epCtrl).mapData
    local roomData = mapData:GetRoomByCoord(nextRoomPos)
    playerCtrl:Move(roomData)
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  end
, nil, false, false, false)
end

ExplorationAutoCtrl.OnBeforeCreateEpBattle = function(self, roomData)
  -- function num : 0_20 , upvalues : _ENV, DeployTeamUtil
  if not self:IsAutoModeRunning() then
    return 
  end
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local size_row, size_col, deploy_rows = ExplorationManager:GetEpSceneBattleFieldSize()
  ;
  (DeployTeamUtil.AutoBattleDeploy)(roomData, dynPlayer.heroList, size_row, size_col, deploy_rows)
end

ExplorationAutoCtrl.OnEpBattleReady = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if not self:IsAutoModeRunning() then
    return 
  end
  if self.__isBreakAutoMode then
    return 
  end
  self.__autoWaitTimerId = TimerManager:StartTimer(((ConfigData.game_config).autoEpTime).meaningless, function()
    -- function num : 0_21_0 , upvalues : _ENV, self
    TimerManager:StopTimer(self.__autoWaitTimerId)
    ;
    ((self.epCtrl).battleCtrl):EnterEpBattleRunning()
  end
, nil, true, false, false)
end

ExplorationAutoCtrl.OnEpBattleResultShow = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if not self:IsAutoModeRunning() then
    return 
  end
  ;
  (self.epAutoWindow):SetAutoMaskActive(true)
  self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_22_0 , upvalues : _ENV, self
    TimerManager:StopTimer(self.__autoWaitTimerId)
    if self.epAutoWindow ~= nil then
      (self.epAutoWindow):SetAutoMaskActive(false)
    end
    local battleResultWindow = UIManager:GetWindow(UIWindowTypeID.BattleResult)
    if battleResultWindow ~= nil then
      battleResultWindow:ExitBattleResult()
    end
  end
, nil, false, false, false)
end

ExplorationAutoCtrl.OnEpBattleSelectChip = function(self, chipList)
  -- function num : 0_23 , upvalues : _ENV, ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
  local showTitleType, chipPanel = self:__AutoEpSelectChipLogic(chipList, true)
  local showOperator = chipPanel ~= nil
  do
    if showOperator then
      local autoChipHolder = chipPanel:GetAutoTipsHolder()
      ;
      (self.epAutoWindow):SetAutoOperatorActive(true, autoChipHolder)
      ;
      (self.epAutoWindow):SetAutoOperatorText(self.__autoTime)
    end
    ;
    (self.epAutoWindow):SetAutoTitleState(showTitleType, self.__autoTime)
    ;
    (self.epAutoWindow):SetAutoMaskActive(true)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_23_0 , upvalues : self, showOperator, showTitleType, _ENV, chipList, ExplorationEnum
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      if showOperator then
        (self.epAutoWindow):SetAutoOperatorText(self.__autoTime)
      end
      ;
      (self.epAutoWindow):SetAutoTitleState(showTitleType, self.__autoTime)
      return 
    end
    if showOperator then
      (self.epAutoWindow):SetAutoOperatorText(0)
    end
    ;
    (self.epAutoWindow):SetAutoTitleState(showTitleType, 0)
    if (((self.epCtrl).sceneCtrl).epSceneEntity):IsExitBattleTLPlaying() then
      return 
    end
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self:__AutoEpSelectChipLogic(chipList)
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
    ;
    (self.epAutoWindow):SetAutoOperatorActive(false)
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  end
, nil, false, false, false)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

ExplorationAutoCtrl.__AutoEpSelectChipLogic = function(self, originChipList, noSend)
  -- function num : 0_24 , upvalues : _ENV, ExplorationEnum, EpAutoUtil
  local send = not noSend
  local selectChipWindow = UIManager:GetWindow(UIWindowTypeID.SelectChip)
  if selectChipWindow == nil then
    return (ExplorationEnum.eAutoTitleType).Normal
  end
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local isOverLimit, ableGetNew = (EpAutoUtil.AbleGetNewChip)(dynPlayer)
  local chipList = {}
  local totalPowerDic = {}
  for _,chipData in pairs(originChipList) do
    local isNew, ableUpgrade = dynPlayer:IsChipNewAndUpgradeState(chipData.dataId)
    if ableUpgrade or isNew and ableGetNew then
      local power = dynPlayer:GetChipCombatEffect(chipData)
      if power > 0 then
        (table.insert)(chipList, chipData)
        totalPowerDic[chipData] = power
      end
    end
  end
  if #chipList == 0 then
    if send then
      selectChipWindow:StartGiveUpLogic()
    end
    return (ExplorationEnum.eAutoTitleType).GiveupChip
  end
  local chipData = ((EpAutoUtil.GetAutoBestValueChip)(dynPlayer, chipList, totalPowerDic))
  local chipPanel = nil
  if chipData ~= nil then
    for index,chip in pairs(originChipList) do
      if chip == chipData then
        chipPanel = selectChipWindow:GetChipPanelByIndex(index)
        break
      end
    end
  end
  do
    if chipPanel == nil then
      if send then
        selectChipWindow:StartGiveUpLogic()
      end
      return (ExplorationEnum.eAutoTitleType).GiveupChip
    end
    if send then
      selectChipWindow:ComfirmSelectChip(chipPanel)
    end
    return (ExplorationEnum.eAutoTitleType).SelectChip, chipPanel
  end
end

ExplorationAutoCtrl.OnEnterEpTreasureRoom = function(self, treasureData, isFirstOpen)
  -- function num : 0_25 , upvalues : _ENV, ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  if isFirstOpen then
    (self.epAutoWindow):SetAutoMaskActive(true)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_25_0 , upvalues : self, _ENV, treasureData, ExplorationEnum
    self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
    local showTitleType, chipPanel = self:__AutoEpTreasureLogic(treasureData, true)
    local showOperator = chipPanel ~= nil
    do
      if showOperator then
        local autoChipHolder = chipPanel:GetAutoTipsHolder()
        ;
        (self.epAutoWindow):SetAutoOperatorActive(true, autoChipHolder)
        ;
        (self.epAutoWindow):SetAutoOperatorText(self.__autoTime)
      end
      ;
      (self.epAutoWindow):SetAutoTitleState(showTitleType, self.__autoTime)
      self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
      -- function num : 0_25_0_0 , upvalues : self, showOperator, showTitleType, _ENV, treasureData, ExplorationEnum
      self.__autoTime = self.__autoTime - 1
      if self.__autoTime > 0 then
        if showOperator then
          (self.epAutoWindow):SetAutoOperatorText(self.__autoTime)
        end
        ;
        (self.epAutoWindow):SetAutoTitleState(showTitleType, self.__autoTime)
        return 
      end
      TimerManager:StopTimer(self.__autoWaitTimerId)
      self:__AutoEpTreasureLogic(treasureData)
      ;
      (self.epAutoWindow):SetAutoMaskActive(false)
      ;
      (self.epAutoWindow):SetAutoOperatorActive(false)
      ;
      (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
    end
, nil, false, false, false)
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end
, nil, true, true, false)
  else
    self:__AutoEpTreasureLogic(treasureData)
  end
end

ExplorationAutoCtrl.__AutoEpTreasureLogic = function(self, treasureData, noSend)
  -- function num : 0_26 , upvalues : _ENV, ExplorationEnum, EpAutoUtil
  local treasureWindow = UIManager:GetWindow(UIWindowTypeID.EpTreasureRoom)
  if treasureWindow == nil then
    return (ExplorationEnum.eAutoTitleType).Normal
  end
  local send = not noSend
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local isOverLimit, ableGetNew = (EpAutoUtil.AbleGetNewChip)(dynPlayer)
  local chipList = {}
  local totalPowerDic = {}
  for _,tData in pairs(treasureData.chipDatas) do
    local chipData = tData.data
    local isNew, ableUpgrade = dynPlayer:IsChipNewAndUpgradeState(chipData.dataId)
    if ableUpgrade or isNew and ableGetNew then
      local power = dynPlayer:GetChipCombatEffect(chipData)
      if power > 0 then
        (table.insert)(chipList, chipData)
        totalPowerDic[chipData] = power
      end
    end
  end
  if #chipList == 0 then
    if send then
      treasureWindow:TreasureGiveupLogic()
    end
    return (ExplorationEnum.eAutoTitleType).GiveupChip
  end
  local chipData = ((EpAutoUtil.GetAutoBestValueChip)(dynPlayer, chipList, totalPowerDic))
  local chipPanel = nil
  if chipData ~= nil then
    for index,tData in pairs(treasureData.chipDatas) do
      if tData.data == chipData then
        chipPanel = treasureWindow:GetChipPanelByIndex(index)
        break
      end
    end
  end
  do
    if chipPanel == nil then
      if send then
        treasureWindow:StartGiveUpLogic()
      end
      return (ExplorationEnum.eAutoTitleType).GiveupChip
    end
    if send then
      treasureWindow:OnComfirmClick(chipPanel)
    end
    return (ExplorationEnum.eAutoTitleType).SelectChip, chipPanel
  end
end

ExplorationAutoCtrl.OnEnterEpStoreRoom = function(self, storeDataList, currencyId, isFirstOpen)
  -- function num : 0_27 , upvalues : _ENV, ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  if self.__isBreakAutoMode then
    return 
  end
  if isFirstOpen then
    local showTitleType = self:__AutoEpStoreLogic(storeDataList, currencyId, true)
    do
      self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
      ;
      (self.epAutoWindow):SetAutoTitleState(showTitleType, self.__autoTime)
      ;
      (self.epAutoWindow):SetAutoMaskActive(true)
      self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_27_0 , upvalues : self, showTitleType, _ENV, storeDataList, currencyId, ExplorationEnum
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      (self.epAutoWindow):SetAutoTitleState(showTitleType, self.__autoTime)
      return 
    end
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self:__AutoEpStoreLogic(storeDataList, currencyId)
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  end
, nil, false, false, false)
    end
  else
    do
      self:__AutoEpStoreLogic(storeDataList, currencyId)
    end
  end
end

ExplorationAutoCtrl.__AutoEpStoreLogic = function(self, storeDataList, currencyId, noSend)
  -- function num : 0_28 , upvalues : _ENV, ExplorationEnum, EpAutoUtil
  local send = not noSend
  local storeWindow = UIManager:GetWindow(UIWindowTypeID.EpStoreRoom)
  if storeWindow == nil then
    return (ExplorationEnum.eAutoTitleType).Normal
  end
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local isOverLimit, nowCount, nowLimit = dynPlayer:IsChipOverLimitNum()
  if isOverLimit then
    if send then
      ((self.epCtrl).storeCtrl):SendStoreQuit()
    end
    return (ExplorationEnum.eAutoTitleType).ExitRoom
  end
  local noLimit = nowCount < nowLimit
  local money = dynPlayer:GetItemCount(currencyId)
  local couldLoanMoney = ((self.epCtrl).campFetterCtrl):GetCouldLeonMoney()
  local useMoney = money + couldLoanMoney
  local chipList = {}
  local totalPowerDic = {}
  for _,storeData in pairs(storeDataList) do
    if not storeData.saled then
      local chipData = storeData.chipData
      if chipData ~= nil then
        local isNew, ableUpgrade = dynPlayer:IsChipNewAndUpgradeState(chipData.dataId)
        if ableUpgrade or isNew and noLimit then
          local buyPrice = chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId())
          if useMoney >= buyPrice then
            local power = dynPlayer:GetChipCombatEffect(chipData)
            if power > 0 then
              (table.insert)(chipList, chipData)
              totalPowerDic[chipData] = power
            end
          end
        end
      end
    end
  end
  if #chipList == 0 then
    if money < (ConfigData.game_config).epAutoStoreMoney or money < ((self.epCtrl).storeCtrl):GetEpStoreRefreshPrice() then
      if send then
        ((self.epCtrl).storeCtrl):SendStoreQuit()
      end
      return (ExplorationEnum.eAutoTitleType).ExitRoom
    end
    local haveNoFullLevel = false
    local chipDic = dynPlayer:GetNormalChipDic()
    for _,chipData in pairs(chipDic) do
      if not chipData:IsChipFullLevel() then
        haveNoFullLevel = true
        break
      end
    end
    if haveNoFullLevel then
      if send then
        ((self.epCtrl).storeCtrl):ReqEpStoreRefresh()
      end
      return (ExplorationEnum.eAutoTitleType).BuyChip
    else
      if send then
        ((self.epCtrl).storeCtrl):SendStoreQuit()
      end
      return (ExplorationEnum.eAutoTitleType).ExitRoom
    end
  end
  local chipData = ((EpAutoUtil.GetAutoBestValueChip)(dynPlayer, chipList, totalPowerDic))
  local storeData = nil
  if chipData ~= nil then
    for _,tstoreData in pairs(storeDataList) do
      if tstoreData.chipData == chipData then
        storeData = tstoreData
        break
      end
    end
  end
  if storeData == nil then
    if send then
      ((self.epCtrl).storeCtrl):SendStoreQuit()
    end
    return (ExplorationEnum.eAutoTitleType).ExitRoom
  end
  do
    if send then
      local buyPrice = (storeData.chipData):GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId())
      ;
      ((self.epCtrl).storeCtrl):SendStorePurchase(storeData.idx, buyPrice)
    end
    do return (ExplorationEnum.eAutoTitleType).BuyChip end
    -- DECOMPILER ERROR: 17 unprocessed JMP targets
  end
end

ExplorationAutoCtrl.OnEnterEpEventRoom = function(self, eventRoomData, isFirstOpen)
  -- function num : 0_29 , upvalues : _ENV, EpAutoUtil, ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  if self.__isBreakAutoMode then
    return 
  end
  ;
  (self.epAutoWindow):SetAutoMaskActive(true)
  self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_29_0 , upvalues : _ENV, eventRoomData, self, EpAutoUtil, ExplorationEnum
    local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
    if eventWindow == nil then
      return 
    end
    local ableChoiceList = {}
    local autoChoiceList = {}
    local choicePriorityDic = {}
    local choiceDatalist = eventRoomData.choiceDatalist
    for _,choiceData in pairs(choiceDatalist) do
      if choiceData.isAble then
        (table.insert)(ableChoiceList, choiceData)
        choicePriorityDic[choiceData] = 0
        local choiceCfg = ((self.epCtrl).eventCtrl):GetEpEventChoiceCfg(choiceData)
        if not choiceCfg.auto_priority then
          choicePriorityDic[choiceData] = choiceCfg == nil or 0
          if choiceCfg.auto_choice_type ~= 0 then
            local dynPlayer = ExplorationManager:GetDynPlayer()
            local autoSuccess = (EpAutoUtil.IsEventChoiceAutoSuccess)(choiceCfg.auto_choice_type, choiceCfg.auto_choice_arg, dynPlayer)
            if autoSuccess then
              (table.insert)(autoChoiceList, choiceData)
            end
          end
          do
            -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    local resultIndex = 0
    if #autoChoiceList > 0 then
      resultIndex = self:__AutoSelectEventChoice(autoChoiceList, choicePriorityDic)
    else
      resultIndex = self:__AutoSelectEventChoice(ableChoiceList, choicePriorityDic)
    end
    if resultIndex == 0 then
      return 
    end
    local choiceItem = eventWindow:GetEventChoiceItem(resultIndex)
    if choiceItem == nil then
      return 
    end
    local choiceData = choiceDatalist[resultIndex]
    local choiceCfg = nil
    if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Normal then
      choiceCfg = (ConfigData.event_choice)[choiceData.choiceId]
    else
      if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Upgrade then
        choiceCfg = (ConfigData.event_upgrade)[choiceData.choiceId]
      else
        if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Jump then
          choiceCfg = (ConfigData.event_jump)[choiceData.choiceId]
        else
          error("Unsupported eEventRoomChoiceType, id = " .. tostring(choiceData.catId))
          return 
        end
      end
    end
    local autoChipHolder = choiceItem:GetAutoTipsHolder()
    ;
    (self.epAutoWindow):SetAutoOperatorActive(true, autoChipHolder)
    self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
    ;
    (self.epAutoWindow):SetAutoOperatorText(self.__autoTime)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
      -- function num : 0_29_0_0 , upvalues : self, _ENV, choiceCfg, resultIndex
      self.__autoTime = self.__autoTime - 1
      if self.__autoTime > 0 then
        (self.epAutoWindow):SetAutoOperatorText(self.__autoTime)
        return 
      end
      TimerManager:StopTimer(self.__autoWaitTimerId)
      ;
      ((self.epCtrl).eventCtrl):OnChoiceItemClick(choiceCfg, resultIndex - 1, true)
      ;
      (self.epAutoWindow):SetAutoMaskActive(false)
      ;
      (self.epAutoWindow):SetAutoOperatorActive(false)
    end
, nil, false, false, false)
  end
, nil, true, true, false)
end

ExplorationAutoCtrl.__AutoSelectEventChoice = function(self, choiceList, choicePriorityDic)
  -- function num : 0_30 , upvalues : _ENV
  if #choiceList == 0 then
    return 0
  end
  if #choiceList == 1 then
    return (choiceList[1]).idx + 1
  end
  ;
  (table.sort)(choiceList, function(c1, c2)
    -- function num : 0_30_0 , upvalues : choicePriorityDic
    do return choicePriorityDic[c1] < choicePriorityDic[c2] end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  while #choiceList >= 2 and choicePriorityDic[choiceList[1]] ~= choicePriorityDic[choiceList[#choiceList]] do
    (table.remove)(choiceList)
  end
  local idx = (choiceList[(math.random)(#choiceList)]).idx + 1
  return idx
end

ExplorationAutoCtrl.OnEnterEpEventRoomUpgrade = function(self, eventRoomData, isFirstOpen)
  -- function num : 0_31 , upvalues : _ENV, ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  if self.__isBreakAutoMode then
    return 
  end
  if isFirstOpen then
    self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).UpgradeChip, self.__autoTime)
    ;
    (self.epAutoWindow):SetAutoMaskActive(true)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_31_0 , upvalues : self, ExplorationEnum, _ENV
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).UpgradeChip, self.__autoTime)
      return 
    end
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self:AutoEpEventRoomUpgradeLogic()
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  end
, nil, false, false, false)
  else
    self:AutoEpEventRoomUpgradeLogic()
  end
end

ExplorationAutoCtrl.AutoEpEventRoomUpgradeLogic = function(self)
  -- function num : 0_32 , upvalues : _ENV
  local epUpgradeWindow = UIManager:GetWindow(UIWindowTypeID.EpUpgradeRoom)
  if epUpgradeWindow == nil then
    return 
  end
  if not epUpgradeWindow:CheckRefreshTimeEnough() then
    return 
  end
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local currencyNum = dynPlayer:GetMoneyCount()
  local upgradePrice = ConfigData:CalculateEpChipUpgradePrice(epUpgradeWindow.roomId, epUpgradeWindow.refreshTime)
  if currencyNum < upgradePrice and upgradePrice > 0 then
    ((self.epCtrl).eventCtrl):SendSpecifyExit()
    return 
  end
  local chipDataList = dynPlayer:GetChipList()
  if chipDataList == nil or #chipDataList == 0 then
    ((self.epCtrl).eventCtrl):SendSpecifyExit()
    return 
  end
  local fightPower = -1
  local chipData = nil
  for k,tmpChipData in pairs(chipDataList) do
    if not tmpChipData:IsChipFullLevel() then
      local curFightPower = dynPlayer:GetChipCombatEffect(tmpChipData, true, true)
      if fightPower < curFightPower then
        fightPower = curFightPower
        chipData = tmpChipData
      end
    end
  end
  if chipData == nil then
    ((self.epCtrl).eventCtrl):SendSpecifyExit()
    return 
  end
  if fightPower <= 0 and upgradePrice > 0 then
    ((self.epCtrl).eventCtrl):SendSpecifyExit()
    return 
  end
  ;
  ((self.epCtrl).eventCtrl):SendMsgChipUpgrade(chipData, nil)
end

ExplorationAutoCtrl.OnEnterEpChipDiscard = function(self, isFirstOpen)
  -- function num : 0_33 , upvalues : _ENV, ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  if TimerManager:ContainTimer(self.__autoWaitTimerId) then
    return 
  end
  if self.__isBreakAutoMode and not isFirstOpen then
    return 
  end
  if isFirstOpen then
    local showTitleType = self:__AutoEpChipDiscardLogic(true)
    do
      self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
      ;
      (self.epAutoWindow):SetAutoTitleState(showTitleType, self.__autoTime)
      ;
      (self.epAutoWindow):SetAutoMaskActive(true)
      self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_33_0 , upvalues : self, showTitleType, _ENV, ExplorationEnum
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      (self.epAutoWindow):SetAutoTitleState(showTitleType, self.__autoTime)
      return 
    end
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self:__AutoEpChipDiscardLogic()
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  end
, nil, false, false, false)
    end
  else
    do
      self:__AutoEpChipDiscardLogic()
    end
  end
end

ExplorationAutoCtrl.__AutoEpChipDiscardLogic = function(self, noSend)
  -- function num : 0_34 , upvalues : _ENV, ExplorationEnum
  local send = not noSend
  local chipDiscardWindow = UIManager:GetWindow(UIWindowTypeID.EpChipDiscard)
  if chipDiscardWindow == nil then
    return (ExplorationEnum.eAutoTitleType).Normal
  end
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local isOverLimit, nowCount, nowLimit = dynPlayer:IsChipOverLimitNum()
  if not isOverLimit then
    if ((CS.WaitNetworkResponse).Instance):ContainWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Exit) then
      return (ExplorationEnum.eAutoTitleType).Normal
    end
    if send then
      chipDiscardWindow:CloseEpDiscard()
    end
    return (ExplorationEnum.eAutoTitleType).Normal
  end
  local chipDataList = dynPlayer:GetChipList()
  local fightPower = CommonUtil.Int32Max
  local chipData = nil
  for _,tmpChipData in pairs(dynPlayer:GetChipList()) do
    local tmpFightPower = dynPlayer:GetChipDiscardFightPower(tmpChipData, true)
    if tmpFightPower <= 0 then
      fightPower = 0
      chipData = tmpChipData
      break
    else
      if tmpFightPower < fightPower then
        fightPower = tmpFightPower
        chipData = tmpChipData
      end
    end
  end
  do
    if fightPower == 0 then
      if send then
        chipDiscardWindow:StartDiscardChip(chipData)
      end
      return (ExplorationEnum.eAutoTitleType).DiscardChip
    end
    local currentItemNum = dynPlayer:GetItemCount(chipDiscardWindow.costItemId)
    if chipDiscardWindow.costItemNum <= currentItemNum then
      if send then
        chipDiscardWindow:AddChipLimit()
      end
      return (ExplorationEnum.eAutoTitleType).UpgradeChipLimit
    end
    if send then
      chipDiscardWindow:StartDiscardChip(chipData)
    end
    return (ExplorationEnum.eAutoTitleType).DiscardChip
  end
end

ExplorationAutoCtrl.OnEnterChipReplace = function(self, isFirstOpen)
  -- function num : 0_35 , upvalues : _ENV, ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  if self.__isBreakAutoMode and not isFirstOpen then
    return 
  end
  local window = UIManager:GetWindow(UIWindowTypeID.ChipDisplace)
  if window == nil then
    return 
  end
  if isFirstOpen then
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal, self.__autoTime)
    ;
    (self.epAutoWindow):SetAutoMaskActive(true)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_35_0 , upvalues : self, ExplorationEnum, _ENV
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal, self.__autoTime)
      return 
    end
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self:AutoChipReplace()
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  end
, nil, false, false, false)
  else
    self:AutoChipReplace()
  end
end

ExplorationAutoCtrl.AutoChipReplace = function(self)
  -- function num : 0_36 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.ChipDisplace)
  if window == nil then
    return 
  end
  if window.remainCount <= 0 then
    (self.epCtrl):SendExitChipReplace()
    return 
  end
  if #window.chipList <= 0 then
    (self.epCtrl):SendExitChipReplace()
    return 
  end
  if window.isAllDisplace then
    (self.epCtrl):SendChipReplace(0)
  else
    local selectIdex = 1
    local chipData = (window.chipList)[selectIdex]
    for i = 2, #window.chipList do
      local item = (window.chipList)[i]
      if item:GetQuality() < chipData:GetQuality() then
        chipData = item
        selectIdex = i
      else
        if chipData:GetQuality() == item:GetQuality() and item:GetCount() < chipData:GetCount() then
          chipData = item
          selectIdex = i
        end
      end
    end
    window.selectIndex = selectIdex
    ;
    (self.epCtrl):SendChipReplace((chipData.chipCfg).id)
  end
end

ExplorationAutoCtrl.OnEnterTaskSelect = function(self, isFirstOpen)
  -- function num : 0_37 , upvalues : _ENV, ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  if self.__isBreakAutoMode and not isFirstOpen then
    return 
  end
  local window = UIManager:GetWindow(UIWindowTypeID.EpTask)
  if window == nil then
    return 
  end
  if isFirstOpen then
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal, self.__autoTime)
    ;
    (self.epAutoWindow):SetAutoMaskActive(true)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_37_0 , upvalues : self, ExplorationEnum, _ENV
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal, self.__autoTime)
      return 
    end
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self:AutoTaskSelect()
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  end
, nil, false, false, false)
  else
    self:AutoTaskSelect()
  end
end

ExplorationAutoCtrl.AutoTaskSelect = function(self)
  -- function num : 0_38 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.EpTask)
  if window == nil then
    return 
  end
  local taskId = window:GetDefaultSelectTaskId()
  if taskId or 0 == 0 then
    (self.epCtrl):SendGiveUpTask()
  else
    ;
    (self.epCtrl):SendGetTask(taskId)
  end
end

ExplorationAutoCtrl.OnEnterActiveChipDrop = function(self, func)
  -- function num : 0_39 , upvalues : _ENV, ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  if self.__isBreakAutoMode then
    return 
  end
  local window = UIManager:GetWindow(UIWindowTypeID.DungeonInfoDetail)
  if window == nil then
    return 
  end
  TimerManager:StopTimer(self.__autoWaitTimerId)
  self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
  ;
  (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal, self.__autoTime)
  ;
  (self.epAutoWindow):SetAutoMaskActive(true)
  self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_39_0 , upvalues : self, ExplorationEnum, _ENV, func
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal, self.__autoTime)
      return 
    end
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self:AutoActiveChipDrop(func)
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  end
, nil, false, false, false)
end

ExplorationAutoCtrl.AutoActiveChipDrop = function(self, func)
  -- function num : 0_40 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.DungeonInfoDetail)
  if window == nil then
    return 
  end
  func()
end

ExplorationAutoCtrl.OnEpFloorSettle = function(self)
  -- function num : 0_41 , upvalues : _ENV
  if not self:IsAutoModeRunning() then
    return 
  end
  ;
  (self.epAutoWindow):SetAutoMaskActive(true)
  self.__autoWaitTimerId = TimerManager:StartTimer(((ConfigData.game_config).autoEpTime).meaningless, function()
    -- function num : 0_41_0 , upvalues : _ENV, self
    TimerManager:StopTimer(self.__autoWaitTimerId)
    ExplorationManager:EnterNextSectionExploration()
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
  end
, nil, true, false, false)
end

ExplorationAutoCtrl.CalcAutoEpPath = function(self)
  -- function num : 0_42 , upvalues : _ENV
  self.__autoPath = {}
  local mapData = (self.epCtrl).mapData
  local opDetail = ((self.epCtrl).dynPlayer):GetOperatorDetail()
  local curPostion = opDetail.curPostion
  local roomData = mapData:GetRoomByCoord(curPostion)
  ;
  (table.insert)(self.__autoPath, curPostion)
  repeat
    if not roomData:IsEndColRoom() then
      local priorRoom, priorValue = nil, nil
      local priorFightPower = 0
      local nextRoom = roomData:GetNextRoom()
      for k,tmpRoomData in pairs(nextRoom) do
        local roomType = tmpRoomData:GetRoomType()
        local roomTypeCfg = (ConfigData.exploration_roomtype)[roomType]
        local curPriority = roomTypeCfg.priority
        local curFightPower = roomData:GetTotalFightingPower()
        if priorRoom == nil then
          priorRoom = tmpRoomData
          priorValue = curPriority
          priorFightPower = curFightPower
        else
          if curPriority < priorValue then
            priorRoom = tmpRoomData
            priorValue = curPriority
            priorFightPower = curFightPower
          else
            if curPriority == priorValue and (curFightPower < priorFightPower or curFightPower ~= priorFightPower or tmpRoomData.y < priorRoom.y) then
              priorRoom = tmpRoomData
              priorValue = curPriority
            end
          end
        end
      end
      roomData = priorRoom
      ;
      (table.insert)(self.__autoPath, roomData.position)
    end
  until roomData:IsEndColRoom()
end

ExplorationAutoCtrl.CheckAutoModeRoomClick = function(self, keyRoom)
  -- function num : 0_43 , upvalues : _ENV
  if not self:IsEnableAutoMode() then
    return false
  end
  if self:IsAutoModeRunning() then
    return true
  end
  local keyIndex = nil
  local newAutoPath = {}
  for k,position in pairs(self.__autoPath) do
    local x, y = (ExplorationManager.Coordination2Pos)(position)
    if x == keyRoom.x and y ~= keyRoom.y then
      keyIndex = k
    end
    newAutoPath[k] = position
  end
  if keyIndex == nil then
    return true
  end
  newAutoPath[keyIndex] = keyRoom.position
  local curRoomData = keyRoom
  for i = keyIndex - 1, 1, -1 do
    local roomList = (curRoomData:GetLastRoom())
    local cRoom = nil
    local pos = newAutoPath[i]
    local x, y = (ExplorationManager.Coordination2Pos)(pos)
    local distance = CommonUtil.Int32Max
    for k,tmpRoomData in pairs(roomList) do
      local tmpDistance = (math.abs)(tmpRoomData.y - y)
      if tmpDistance < distance then
        newAutoPath[i] = tmpRoomData.position
        cRoom = tmpRoomData
        distance = tmpDistance
      end
    end
    if cRoom == nil then
      return true
    end
    curRoomData = cRoom
  end
  if newAutoPath[1] ~= (self.__autoPath)[1] then
    return true
  end
  curRoomData = keyRoom
  for i = keyIndex + 1, #newAutoPath do
    local roomList = (curRoomData:GetNextRoom())
    local cRoom = nil
    local pos = newAutoPath[i]
    local x, y = (ExplorationManager.Coordination2Pos)(pos)
    local distance = CommonUtil.Int32Max
    for k,tmpRoomData in pairs(roomList) do
      local tmpDistance = (math.abs)(tmpRoomData.y - y)
      if tmpDistance < distance then
        newAutoPath[i] = tmpRoomData.position
        cRoom = tmpRoomData
        distance = tmpDistance
      end
    end
    if cRoom == nil then
      return true
    end
    curRoomData = cRoom
  end
  if newAutoPath[#newAutoPath] ~= (self.__autoPath)[#self.__autoPath] then
    return true
  end
  self.__autoPath = newAutoPath
  local curRoomData = (self.epCtrl):GetCurrentRoomData(true)
  ;
  ((self.epCtrl).mapCtrl):RefreshMapShowState((ExplorationManager:GetDynPlayer()):GetOperatorDetail(), curRoomData)
  return true
end

ExplorationAutoCtrl.OnDelete = function(self)
  -- function num : 0_44 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnEpOpStateChanged, self.__onEpOpStateChanged)
  MsgCenter:RemoveListener(eMsgEventId.OnEpOpStateChanged, self.__onEpSceneStateChanged)
  MsgCenter:RemoveListener(eMsgEventId.BeforeNewEpBattle, self.__onBeforeCreateEpBattle)
  MsgCenter:RemoveListener(eMsgEventId.OnBattleReady, self.__onEpBattleReady)
  MsgCenter:RemoveListener(eMsgEventId.OnExitRoomComplete, self.__onEpExitRoomComplete)
  MsgCenter:RemoveListener(eMsgEventId.OnChipDiscardChanged, self.__onEnterEpChipDiscard)
  self:__ClearAutoData()
  ;
  (base.OnDelete)(self)
end

return ExplorationAutoCtrl

