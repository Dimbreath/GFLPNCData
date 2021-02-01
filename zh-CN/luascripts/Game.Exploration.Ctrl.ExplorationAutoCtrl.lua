-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationAutoCtrl = class("ExplorationAutoCtrl", ExplorationCtrlBase)
local base = ExplorationCtrlBase
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
ExplorationAutoCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.__enableAutoMode = false
  self.__autoModeRunning = false
  self.__autoTime = 0
  self.__isBreakAutoMode = false
  self.__defaultAutoMode = false
  self.__onEpOpStateChanged = BindCallback(self, self.OnEpOpStateChanged)
  MsgCenter:AddListener(eMsgEventId.OnEpOpStateChanged, self.__onEpOpStateChanged)
  self.__onEpSceneStateChanged = BindCallback(self, self.OnEpSceneStateChanged)
  MsgCenter:AddListener(eMsgEventId.OnEpSceneStateChanged, self.__onEpSceneStateChanged)
  self.__onEpBattleReady = BindCallback(self, self.OnEpBattleReady)
  MsgCenter:AddListener(eMsgEventId.OnBattleReady, self.__onEpBattleReady)
  self.__onEpExitRoomComplete = BindCallback(self, self.OnEpExitRoomComplete)
  MsgCenter:AddListener(eMsgEventId.OnExitRoomComplete, self.__onEpExitRoomComplete)
  self.__onEnterEpChipDiscard = BindCallback(self, self.OnEnterEpChipDiscard)
  MsgCenter:AddListener(eMsgEventId.OnChipDiscardChanged, self.__onEnterEpChipDiscard)
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
  local curRoomData = (self.epCtrl):GetCurrentRoomData()
  ;
  ((self.epCtrl).mapCtrl):RefreshMapShowState((ExplorationManager:GetDynPlayer()):GetOperatorDetail(), curRoomData)
  local explorationWindow = UIManager:GetWindow(UIWindowTypeID.Exploration)
  if explorationWindow ~= nil then
    explorationWindow:RefreshAutoModeState(true, isRunning)
  end
end

ExplorationAutoCtrl.DisableEpAutoMode = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((self.epCtrl).campFetterCtrl):SetAllActiveFetterVisible(true)
  self.__defaultAutoMode = false
  self:__ClearAutoData()
  local curRoomData = (self.epCtrl):GetCurrentRoomData()
  ;
  ((self.epCtrl).mapCtrl):RefreshMapShowState((ExplorationManager:GetDynPlayer()):GetOperatorDetail(), curRoomData)
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
  if self.__autoWaitTimer ~= nil then
    (self.__autoWaitTimer):Stop()
    self.__autoWaitTimer = nil
  end
  UIManager:DeleteWindow(UIWindowTypeID.EpAutoMode)
  self.epAutoWindow = nil
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
  local opDetail = (ExplorationManager:GetDynPlayer()):GetOperatorDetail()
  self:OnEpOpStateChanged(opDetail)
  return true, true
end

ExplorationAutoCtrl.BreakAutoMode = function(self)
  -- function num : 0_13 , upvalues : ExplorationEnum
  if self.__autoWaitTimer ~= nil then
    (self.__autoWaitTimer):Stop()
    self.__autoWaitTimer = nil
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
  -- function num : 0_16 , upvalues : ExplorationEnum
  if exitFromType == nil or exitFromType == (ExplorationEnum.eExitRoomCompleteType).BattleToEp then
    return 
  end
  self:OnAutoStageOver()
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
  self.__autoWaitTimer = (TimerManager:GetTimer(1, function()
    -- function num : 0_19_0 , upvalues : self, ExplorationEnum, _ENV, nextRoomPos
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).SelectRoom, self.__autoTime)
      return 
    end
    if self.__autoWaitTimer ~= nil then
      (self.__autoWaitTimer):Stop()
      self.__autoWaitTimer = nil
    end
    local playerCtrl = (ExplorationManager.epCtrl).playerCtrl
    local mapData = (self.epCtrl).mapData
    local roomData = mapData:GetRoomByCoord(nextRoomPos)
    playerCtrl:Move(roomData)
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  end
, nil, false, false, false)):Start()
end

ExplorationAutoCtrl.OnEpBattleReady = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if not self:IsAutoModeRunning() then
    return 
  end
  if self.__isBreakAutoMode then
    return 
  end
  self.__autoWaitTimer = (TimerManager:GetTimer(((ConfigData.game_config).autoEpTime).meaningless, function()
    -- function num : 0_20_0 , upvalues : self
    if self.__autoWaitTimer ~= nil then
      (self.__autoWaitTimer):Stop()
      self.__autoWaitTimer = nil
    end
    ;
    ((self.epCtrl).battleCtrl):EnterEpBattleRunning()
  end
, nil, true, false, false)):Start()
end

ExplorationAutoCtrl.OnEpBattleResultShow = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if not self:IsAutoModeRunning() then
    return 
  end
  ;
  (self.epAutoWindow):SetAutoMaskActive(true)
  self.__autoWaitTimer = (TimerManager:GetTimer(1, function()
    -- function num : 0_21_0 , upvalues : self, _ENV
    if self.__autoWaitTimer ~= nil then
      (self.__autoWaitTimer):Stop()
      self.__autoWaitTimer = nil
    end
    local battleResultWindow = UIManager:GetWindow(UIWindowTypeID.BattleResult)
    if battleResultWindow ~= nil then
      battleResultWindow:ExitBattleResult()
    end
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
  end
, nil, false, false, false)):Start()
end

ExplorationAutoCtrl.OnEpBattleSelectChip = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if not self:IsAutoModeRunning() then
    return 
  end
  local selectChipWindow = UIManager:GetWindow(UIWindowTypeID.SelectChip)
  if selectChipWindow == nil then
    return 
  end
  local chipPanel = selectChipWindow:GetMaxInPlayPowerChip()
  local autoChipHolder = chipPanel:GetAutoTipsHolder()
  ;
  (self.epAutoWindow):SetAutoOperatorActive(true, autoChipHolder)
  self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
  ;
  (self.epAutoWindow):SetAutoOperatorText(self.__autoTime)
  ;
  (self.epAutoWindow):SetAutoMaskActive(true)
  self.__autoWaitTimer = (TimerManager:GetTimer(1, function()
    -- function num : 0_22_0 , upvalues : self, selectChipWindow, chipPanel
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      (self.epAutoWindow):SetAutoOperatorText(self.__autoTime)
      return 
    end
    if self.__autoWaitTimer ~= nil then
      (self.__autoWaitTimer):Stop()
      self.__autoWaitTimer = nil
    end
    selectChipWindow:ComfirmSelectChip(chipPanel)
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
    ;
    (self.epAutoWindow):SetAutoOperatorActive(false)
  end
, nil, false, false, false)):Start()
end

ExplorationAutoCtrl.OnEnterEpTreasureRoom = function(self)
  -- function num : 0_23 , upvalues : _ENV
  if not self:IsAutoModeRunning() then
    return 
  end
  ;
  (self.epAutoWindow):SetAutoMaskActive(true)
  self.__autoWaitTimer = (TimerManager:GetTimer(1, function()
    -- function num : 0_23_0 , upvalues : self, _ENV
    self.__autoWaitTimer = nil
    local treasureWindow = UIManager:GetWindow(UIWindowTypeID.EpTreasureRoom)
    if treasureWindow == nil then
      return 
    end
    local chipPanel = treasureWindow:GetMaxInPlayPowerChip()
    local autoChipHolder = chipPanel:GetAutoTipsHolder()
    ;
    (self.epAutoWindow):SetAutoOperatorActive(true, autoChipHolder)
    self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
    ;
    (self.epAutoWindow):SetAutoOperatorText(self.__autoTime)
    self.__autoWaitTimer = (TimerManager:GetTimer(1, function()
      -- function num : 0_23_0_0 , upvalues : self, treasureWindow, chipPanel
      self.__autoTime = self.__autoTime - 1
      if self.__autoTime > 0 then
        (self.epAutoWindow):SetAutoOperatorText(self.__autoTime)
        return 
      end
      if self.__autoWaitTimer ~= nil then
        (self.__autoWaitTimer):Stop()
        self.__autoWaitTimer = nil
      end
      treasureWindow:OnComfirmClick(chipPanel)
      ;
      (self.epAutoWindow):SetAutoMaskActive(false)
      ;
      (self.epAutoWindow):SetAutoOperatorActive(false)
    end
, nil, false, false, false)):Start()
  end
, nil, true, true, false)):Start()
end

ExplorationAutoCtrl.OnEnterEpStoreRoom = function(self)
  -- function num : 0_24 , upvalues : _ENV, ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  local storeWindow = UIManager:GetWindow(UIWindowTypeID.EpStoreRoom)
  if storeWindow == nil then
    return 
  end
  self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
  ;
  (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).ExitRoom, self.__autoTime)
  ;
  (self.epAutoWindow):SetAutoMaskActive(true)
  self.__autoWaitTimer = (TimerManager:GetTimer(1, function()
    -- function num : 0_24_0 , upvalues : self, ExplorationEnum
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).ExitRoom, self.__autoTime)
      return 
    end
    if self.__autoWaitTimer ~= nil then
      (self.__autoWaitTimer):Stop()
      self.__autoWaitTimer = nil
    end
    ;
    ((self.epCtrl).storeCtrl):SendStoreQuit()
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  end
, nil, false, false, false)):Start()
end

ExplorationAutoCtrl.OnEnterEpEventRoom = function(self, eventRoomData, isFirstOpen)
  -- function num : 0_25 , upvalues : _ENV, ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  if self.__isBreakAutoMode then
    return 
  end
  ;
  (self.epAutoWindow):SetAutoMaskActive(true)
  self.__autoWaitTimer = (TimerManager:GetTimer(1, function()
    -- function num : 0_25_0 , upvalues : self, _ENV, eventRoomData, ExplorationEnum
    self.__autoWaitTimer = nil
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
            end
          end
        end
        if not choiceCfg.auto_priority then
          choicePriorityDic[choiceData] = choiceCfg == nil or 0
          if choiceCfg.auto_choice_type ~= 0 then
            local dynPlayer = ExplorationManager:GetDynPlayer()
            local autoSuccess = false
            if choiceCfg.auto_choice_type == (ExplorationEnum.eAutoEventChoiceType).AllRoleHpLess then
              local hp = (choiceCfg.auto_choice_arg)[1] * 10
              autoSuccess = true
              for _,dynHero in ipairs(dynPlayer.heroList) do
                if hp < dynHero.hpPer then
                  autoSuccess = false
                  break
                end
              end
            else
              do
                if choiceCfg.auto_choice_type == (ExplorationEnum.eAutoEventChoiceType).OneRoleHpLess then
                  local hp = (choiceCfg.auto_choice_arg)[1] * 10
                  for _,dynHero in ipairs(dynPlayer.heroList) do
                    if dynHero.hpPer <= hp then
                      autoSuccess = true
                      break
                    end
                  end
                else
                  do
                    do
                      if choiceCfg.auto_choice_type == (ExplorationEnum.eAutoEventChoiceType).HasItemCount and (choiceCfg.auto_choice_arg)[2] <= dynPlayer:GetItemCount((choiceCfg.auto_choice_arg)[1]) then
                        autoSuccess = true
                      end
                      if autoSuccess then
                        (table.insert)(autoChoiceList, choiceData)
                      end
                      -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out IF_STMT

                    end
                  end
                end
              end
            end
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
    self.__autoWaitTimer = (TimerManager:GetTimer(1, function()
      -- function num : 0_25_0_0 , upvalues : self, choiceCfg, resultIndex
      self.__autoTime = self.__autoTime - 1
      if self.__autoTime > 0 then
        (self.epAutoWindow):SetAutoOperatorText(self.__autoTime)
        return 
      end
      if self.__autoWaitTimer ~= nil then
        (self.__autoWaitTimer):Stop()
        self.__autoWaitTimer = nil
      end
      ;
      ((self.epCtrl).eventCtrl):OnChoiceItemClick(choiceCfg, resultIndex - 1, true)
      ;
      (self.epAutoWindow):SetAutoMaskActive(false)
      ;
      (self.epAutoWindow):SetAutoOperatorActive(false)
    end
, nil, false, false, false)):Start()
  end
, nil, true, true, false)):Start()
end

ExplorationAutoCtrl.__AutoSelectEventChoice = function(self, choiceList, choicePriorityDic)
  -- function num : 0_26 , upvalues : _ENV
  if #choiceList == 0 then
    return 0
  end
  if #choiceList == 1 then
    return (choiceList[1]).idx + 1
  end
  ;
  (table.sort)(choiceList, function(c1, c2)
    -- function num : 0_26_0 , upvalues : choicePriorityDic
    do return choicePriorityDic[c1] < choicePriorityDic[c2] end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  while #choiceList >= 2 and choicePriorityDic[choiceList[1]] ~= choicePriorityDic[choiceList[#choiceList]] do
    (table.remove)(choiceList)
  end
  return (choiceList[(math.random)(#choiceList)]).idx + 1
end

ExplorationAutoCtrl.OnEnterEpEventRoomUpgrade = function(self, eventRoomData, isFirstOpen)
  -- function num : 0_27 , upvalues : _ENV, ExplorationEnum
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
    self.__autoWaitTimer = (TimerManager:GetTimer(1, function()
    -- function num : 0_27_0 , upvalues : self, ExplorationEnum
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).UpgradeChip, self.__autoTime)
      return 
    end
    if self.__autoWaitTimer ~= nil then
      (self.__autoWaitTimer):Stop()
      self.__autoWaitTimer = nil
    end
    self:AutoEpEventRoomUpgradeLogic()
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  end
, nil, false, false, false)):Start()
  else
    self:AutoEpEventRoomUpgradeLogic()
  end
end

ExplorationAutoCtrl.AutoEpEventRoomUpgradeLogic = function(self)
  -- function num : 0_28 , upvalues : _ENV
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
  -- function num : 0_29 , upvalues : _ENV, ExplorationEnum
  if not self:IsAutoModeRunning() then
    return 
  end
  if self.__autoWaitTimer ~= nil then
    return 
  end
  if self.__isBreakAutoMode and not isFirstOpen then
    return 
  end
  if isFirstOpen then
    self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).DiscardChip, self.__autoTime)
    ;
    (self.epAutoWindow):SetAutoMaskActive(true)
    self.__autoWaitTimer = (TimerManager:GetTimer(1, function()
    -- function num : 0_29_0 , upvalues : self, ExplorationEnum
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).DiscardChip, self.__autoTime)
      return 
    end
    if self.__autoWaitTimer ~= nil then
      (self.__autoWaitTimer):Stop()
      self.__autoWaitTimer = nil
    end
    self:AutoEpChipDiscardLogic()
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  end
, nil, false, false, false)):Start()
  else
    self:AutoEpChipDiscardLogic()
  end
end

ExplorationAutoCtrl.AutoEpChipDiscardLogic = function(self)
  -- function num : 0_30 , upvalues : _ENV
  local chipDiscardWindow = UIManager:GetWindow(UIWindowTypeID.EpChipDiscard)
  if chipDiscardWindow == nil then
    return 
  end
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local isOverLimit, nowCount, nowLimit = dynPlayer:IsChipOverLimitNum()
  if not isOverLimit then
    if ((CS.WaitNetworkResponse).Instance):ContainWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Exit) then
      return 
    end
    chipDiscardWindow:CloseEpDiscard()
    return 
  end
  local chipDataList = dynPlayer:GetChipList()
  local fightPower = CommonUtil.Int32Max
  local chipData = nil
  for _,tmpChipData in pairs(dynPlayer:GetChipList()) do
    local tmpFightPower = dynPlayer:GetChipOriginFightPower(tmpChipData, true)
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
      chipDiscardWindow:StartDiscardChip(chipData)
      return 
    end
    local currentItemNum = dynPlayer:GetItemCount(chipDiscardWindow.costItemId)
    if chipDiscardWindow.costItemNum <= currentItemNum then
      chipDiscardWindow:AddChipLimit()
      return 
    end
    chipDiscardWindow:StartDiscardChip(chipData)
  end
end

ExplorationAutoCtrl.OnEnterChipReplace = function(self, isFirstOpen)
  -- function num : 0_31 , upvalues : _ENV, ExplorationEnum
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
    if self.__autoWaitTimer ~= nil then
      (self.__autoWaitTimer):Stop()
      self.__autoWaitTimer = nil
    end
    self.__autoTime = ((ConfigData.game_config).autoEpTime).roomOperator
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal, self.__autoTime)
    ;
    (self.epAutoWindow):SetAutoMaskActive(true)
    self.__autoWaitTimer = (TimerManager:GetTimer(1, function()
    -- function num : 0_31_0 , upvalues : self, ExplorationEnum
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal, self.__autoTime)
      return 
    end
    if self.__autoWaitTimer ~= nil then
      (self.__autoWaitTimer):Stop()
      self.__autoWaitTimer = nil
    end
    self:AutoChipReplace()
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
    ;
    (self.epAutoWindow):SetAutoTitleState((ExplorationEnum.eAutoTitleType).Normal)
  end
, nil, false, false, false)):Start()
  else
    self:AutoChipReplace()
  end
end

ExplorationAutoCtrl.AutoChipReplace = function(self)
  -- function num : 0_32 , upvalues : _ENV
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
      if item.quality < (chipData.itemCfg).quality then
        chipData = item
        selectIdex = i
      else
        if (chipData.itemCfg).quality == (item.itemCfg).quality and item:GetCount() < chipData:GetCount() then
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

ExplorationAutoCtrl.OnEpFloorSettle = function(self)
  -- function num : 0_33 , upvalues : _ENV
  if not self:IsAutoModeRunning() then
    return 
  end
  ;
  (self.epAutoWindow):SetAutoMaskActive(true)
  self.__autoWaitTimer = (TimerManager:GetTimer(((ConfigData.game_config).autoEpTime).meaningless, function()
    -- function num : 0_33_0 , upvalues : self, _ENV
    if self.__autoWaitTimer ~= nil then
      (self.__autoWaitTimer):Stop()
      self.__autoWaitTimer = nil
    end
    ExplorationManager:EnterNextSectionExploration()
    ;
    (self.epAutoWindow):SetAutoMaskActive(false)
  end
, nil, true, false, false)):Start()
end

ExplorationAutoCtrl.CalcAutoEpPath = function(self)
  -- function num : 0_34 , upvalues : _ENV
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
  -- function num : 0_35 , upvalues : _ENV
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
  local curRoomData = (self.epCtrl):GetCurrentRoomData()
  ;
  ((self.epCtrl).mapCtrl):RefreshMapShowState((ExplorationManager:GetDynPlayer()):GetOperatorDetail(), curRoomData)
  return true
end

ExplorationAutoCtrl.OnDelete = function(self)
  -- function num : 0_36 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnEpOpStateChanged, self.__onEpOpStateChanged)
  MsgCenter:RemoveListener(eMsgEventId.OnEpOpStateChanged, self.__onEpSceneStateChanged)
  MsgCenter:RemoveListener(eMsgEventId.OnBattleReady, self.__onEpBattleReady)
  MsgCenter:RemoveListener(eMsgEventId.OnExitRoomComplete, self.__onEpExitRoomComplete)
  MsgCenter:RemoveListener(eMsgEventId.OnChipDiscardChanged, self.__onEnterEpChipDiscard)
  self:__ClearAutoData()
  ;
  (base.OnDelete)(self)
end

return ExplorationAutoCtrl

