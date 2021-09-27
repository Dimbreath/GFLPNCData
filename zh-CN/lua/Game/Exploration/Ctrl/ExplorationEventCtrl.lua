local ExplorationEventCtrl = class("ExplorationEventCtrl", ExplorationCtrlBase)
local eChoiceCondition = (require("Game.Exploration.ExplorationEnum")).eChoiceConditionType
local eChoiceDeductType = (require("Game.Exploration.ExplorationEnum")).eChoiceDeductType
local ChipData = require("Game.PlayerData.Item.ChipData")
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
ExplorationEventCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.netWork = NetworkManager:GetNetwork(NetworkTypeID.EventRoom)
  self.__onChoiceItemClick = BindCallback(self, self.OnChoiceItemClick)
  self.epCtrl = epCtrl
  self.waitRefersh = false
  self.__onEventRoomUpdate = BindCallback(self, self.__OnEventRoomUpdate)
  MsgCenter:AddListener(eMsgEventId.OnEventAndRecoveryRoomUpdate, self.__onEventRoomUpdate)
  self.onChipListUpdate = BindCallback(self, self.__onChipListUpdate)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
  self.onCCUpdate = BindCallback(self, self.__OnCCUpdate)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.onCCUpdate)
end

ExplorationEventCtrl.OnEventRoomOpen = function(self, roomData, isFirstOpen)
  -- function num : 0_1 , upvalues : _ENV, ExplorationEnum
  if roomData.eventData == nil then
    error("Can\'t find eRoomData")
    return 
  end
  self.currPosition = roomData.position
  self.eventData = roomData.eventData
  self.dynPlayer = ExplorationManager:GetDynPlayer()
  self:IsEventChoiceAble((self.eventData).choiceDatalist)
  if #(self.eventData).assistHeroes > 0 then
    ((self.epCtrl).epSupportCtrl):EnterSupportRoom((self.eventData).assistHeroes)
    local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
    if eventWindow ~= nil then
      eventWindow:CloseWindow()
    end
  else
    do
      if (self.eventData).param == nil then
        local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
        do
          if eventWindow == nil then
            UIManager:ShowWindowAsync(UIWindowTypeID.EpEventRoom, function(window)
    -- function num : 0_1_0 , upvalues : self, _ENV, roomData, ExplorationEnum
    if window == nil then
      return 
    end
    window:InitEpEventRoom(self.eventData, self.__onChoiceItemClick)
    ;
    ((self.epCtrl).autoCtrl):OnEnterEpEventRoom(self.eventData, true)
    local actionList = ExplorationManager:GetEpGuideActionList(roomData.x, (ExplorationEnum.epGuideMomentType).EnterEpEventRoom)
    if actionList ~= nil and #actionList > 0 then
      local EpGuideUtil = require("Game.Exploration.Util.EpGuideUtil")
      ;
      (EpGuideUtil.ExecuteEpGuideActions)(actionList)
    end
  end
)
          else
            do
              eventWindow:InitEpEventRoom(self.eventData, self.__onChoiceItemClick)
              ;
              ((self.epCtrl).autoCtrl):OnEnterEpEventRoom(self.eventData, false)
              -- DECOMPILER ERROR at PC68: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC68: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      else
        local choicelist = (self.eventData).choiceDatalist
        if (choicelist[((self.eventData).param).p1 + 1]).catId == (ExplorationEnum.eEventRoomChoiceType).Upgrade then
          local upgradeCfg = (ConfigData.event_upgrade)[((self.eventData).param).p2]
          local refreshTime = ((self.eventData).param).p3
          if self.upgradeWindow == nil then
            local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
            if eventWindow ~= nil then
              eventWindow:CloseWindow()
            end
            UIManager:ShowWindowAsync(UIWindowTypeID.EpUpgradeRoom, function(window)
    -- function num : 0_1_1 , upvalues : self, upgradeCfg, refreshTime
    window:InitUpgradeRoom(self, upgradeCfg, refreshTime)
    self.upgradeWindow = window
    ;
    ((self.epCtrl).autoCtrl):OnEnterEpEventRoomUpgrade(self.eventData, true)
  end
)
          else
            do
              ;
              (self.upgradeWindow):InitUpgradeRoom(self, upgradeCfg, refreshTime)
              ;
              ((self.epCtrl).autoCtrl):OnEnterEpEventRoomUpgrade(self.eventData, false)
            end
          end
        end
      end
    end
  end
end

ExplorationEventCtrl.GetEpEventData = function(self)
  -- function num : 0_2
  return self.eventData
end

ExplorationEventCtrl.GetEpEventChoiceCfg = function(self, choiceData)
  -- function num : 0_3 , upvalues : ExplorationEnum, _ENV
  local choiceCfg = nil
  if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Normal then
    choiceCfg = (ConfigData.event_choice)[choiceData.choiceId]
    if choiceCfg == nil then
      error("Can`t find choiceCfg id:" .. tostring(choiceData.choiceId))
      return 
    end
  else
    if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Upgrade then
      choiceCfg = (ConfigData.event_upgrade)[choiceData.choiceId]
    else
      if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Jump then
        choiceCfg = (ConfigData.event_jump)[choiceData.choiceId]
      else
        if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Assist then
          choiceCfg = (ConfigData.event_assist)[choiceData.choiceId]
        end
      end
    end
  end
  return choiceCfg
end

ExplorationEventCtrl.IsEventChoiceAble = function(self, choiceDatalist)
  -- function num : 0_4 , upvalues : _ENV, ExplorationEnum, eChoiceCondition, eChoiceDeductType
  self._hasUpdChip = false
  self.dynPlayData = ExplorationManager:GetDynPlayer()
  local choiceCfg = nil
  for _,choiceData in ipairs(choiceDatalist) do
    if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Upgrade then
      self._hasUpdChip = true
      local allChipMaxLevel = true
      for k,chipData in ipairs((self.dynPlayData).chipList) do
        if not chipData:IsChipFullLevel() and not chipData:IsConsumeSkillChip() then
          allChipMaxLevel = false
          break
        end
      end
      do
        do
          choiceData.isAble = not allChipMaxLevel
          if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Jump or choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Assist then
            choiceData.isAble = true
          else
            choiceCfg = (ConfigData.event_choice)[choiceData.choiceId]
            if choiceCfg == nil then
              error("Can\'t find choiceCfg ID:" .. choiceData.choiceId)
              break
            end
            local isAble = true
            local dataID = nil
            local itemCount = 0
            local dataNum = 0
            if choiceCfg.condition == eChoiceCondition.NotRequired then
              isAble = true
            else
              if choiceCfg.choiceDeductList == nil then
                isAble = true
              else
                for k,deductData in ipairs(choiceCfg.choiceDeductList) do
                  if choiceCfg.condition == eChoiceCondition.Required then
                    dataNum = deductData.dataNum
                  else
                    if choiceCfg.condition == eChoiceCondition.NotRequiredAtLeastOne then
                      dataNum = 1
                    end
                  end
                  dataID = deductData.dataID
                  if deductData.deductType == eChoiceDeductType.Item then
                    itemCount = (self.dynPlayData):GetItemCount(dataID)
                  else
                    if deductData.deductType == eChoiceDeductType.Buff then
                      itemCount = (self.dynPlayData):GetEpBuffCount(dataID)
                    end
                  end
                  if itemCount < dataNum then
                    isAble = false
                  end
                end
              end
            end
            do
              do
                choiceData.isAble = isAble
                -- DECOMPILER ERROR at PC117: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC117: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC117: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC117: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC117: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC117: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC117: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
end

ExplorationEventCtrl.OnChoiceItemClick = function(self, choiceCfg, index, isAble, catId)
  -- function num : 0_5 , upvalues : ExplorationEnum, _ENV, cs_MessageCommon
  do
    if not isAble then
      local msg = nil
      if catId == (ExplorationEnum.eEventRoomChoiceType).Upgrade then
        msg = ConfigData:GetTipContent(1015)
      else
        msg = ConfigData:GetTipContent(TipContent.exploration_Event_NotAchieved)
      end
      ;
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(msg)
      return 
    end
    self.choiceCfg = choiceCfg
    self.waitRefersh = true
    self:RequestEpEventSelect(index)
  end
end

ExplorationEventCtrl.RequestEpEventSelect = function(self, index)
  -- function num : 0_6
  self._eventSelectChoiceIndex = index
  ;
  (self.epCtrl):RecordLastSelectChoiceCtrl(self)
  ;
  (self.netWork):CS_EXPLORATION_EVENT_Select(self.currPosition, index)
end

ExplorationEventCtrl.RegistEventSelectSuccessFunc = function(self, func)
  -- function num : 0_7
  self.__eventSelectSuccessFunc = func
end

ExplorationEventCtrl.CancleEventSelectSuccessFunc = function(self)
  -- function num : 0_8
  self.__eventSelectSuccessFunc = nil
end

ExplorationEventCtrl.OnChoiceItemSelectSuccess = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV, ExplorationEnum
  local completeFunc = function()
    -- function num : 0_9_0 , upvalues : msg, self, _ENV, ExplorationEnum
    do
      if not (self.choiceCfg).choice_showtime then
        local showTime = msg.result == nil or msg.buff == nil or 0
      end
      self:__ShowItemsMessageTips(msg.result, msg.algBack, showTime)
      self:__ShowBuffMessageTips(msg.buff, showTime)
      if (self.choiceCfg).jump then
        return 
      end
      do
        if (self.choiceCfg).event_exit or msg.roleSync ~= nil then
          local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
          if eventWindow ~= nil then
            eventWindow:CloseWindow()
          end
          self.waitRefersh = false
          MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).EventRoom)
        end
        if msg.roleSync ~= nil then
          ((self.epCtrl).epSupportCtrl):ChangeEpHero(msg.roleSync)
        end
      end
    end
  end

  if self.__eventSelectSuccessFunc ~= nil then
    (self.__eventSelectSuccessFunc)(self._eventSelectChoiceIndex, completeFunc)
  else
    completeFunc()
  end
end

ExplorationEventCtrl.JumpEpEventRoomComplete = function(self)
  -- function num : 0_10 , upvalues : _ENV, ExplorationEnum
  local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
  if eventWindow ~= nil then
    eventWindow:CloseWindow()
  end
  self.waitRefersh = false
  ;
  ((self.epCtrl).autoCtrl):OnEpExitRoomComplete((ExplorationEnum.eExitRoomCompleteType).JumpRoomComplete)
end

ExplorationEventCtrl.__ShowItemsMessageTips = function(self, itemDic, algBack, showTime)
  -- function num : 0_11 , upvalues : _ENV, cs_MessageCommon
  self.showAniList = {}
  local cfg, name = nil, nil
  local tipText = ConfigData:GetTipContent(TipContent.exploration_Event_GetItem)
  for id,count in pairs(itemDic) do
    cfg = (ConfigData.item)[id]
    if cfg == nil then
      error("Can`t find itemCfg Data Id:" .. id)
    else
      name = (LanguageUtil.GetLocaleText)(cfg.name)
      ;
      (cs_MessageCommon.ShowMessageTips)((string.format)(tipText, name, tostring(count)), true, showTime)
      if cfg.type == eItemType.GlobalChip then
        (table.insert)(self.showAniList, cfg.id)
      end
    end
  end
  self:__ShowGetAnimation(self.showAniList, algBack)
end

ExplorationEventCtrl.__ShowGetAnimation = function(self, aniList, algBack)
  -- function num : 0_12 , upvalues : _ENV, ChipData
  if #aniList <= 0 then
    return 
  end
  local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateWindow == nil then
    return 
  end
  local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
  if eventWindow == nil then
    return 
  end
  local pos, scale = eventWindow:GetAniItemPosAndScale()
  for _,chipId in pairs(aniList) do
    local chipData = (ChipData.NewChipForLocal)(chipId)
    dungeonStateWindow:ShowGetChipAni(chipData, pos, scale, algBack[chipId] or 0)
  end
end

ExplorationEventCtrl.__ShowBuffMessageTips = function(self, buffDic, showTime)
  -- function num : 0_13 , upvalues : _ENV, cs_MessageCommon
  local cfg, name, count = nil, nil, nil
  local tipText = ConfigData:GetTipContent(TipContent.exploration_Event_GetBuff)
  for id,count in pairs(buffDic) do
    cfg = (ConfigData.exploration_buff)[id]
    if cfg == nil then
      error("Can`t find buffCfg Data Id:" .. id)
    else
      if cfg.is_listshow then
        AudioManager:PlayAudioById(1127)
        name = (LanguageUtil.GetLocaleText)(cfg.name)
        ;
        (cs_MessageCommon.ShowMessageTips)((string.format)(tipText, name), true, showTime)
      end
      if cfg.logic == 4 or cfg.logic == 5 then
        if (cfg.logic_per)[1] > 0 then
          AudioManager:PlayAudioById(1010)
        else
          if (cfg.logic_per)[1] < 0 then
            AudioManager:PlayAudioById(1025)
          end
        end
      end
    end
  end
end

ExplorationEventCtrl.SendRejudge = function(self)
  -- function num : 0_14
  (self.netWork):CS_EXPLORATION_EVENT_Focus(self.currPosition)
end

ExplorationEventCtrl.SetRejudegeOverCallback = function(self, callback)
  -- function num : 0_15
  self.rejudegeOverCallback = callback
end

ExplorationEventCtrl.OnRejudegeOver = function(self, judgeValue)
  -- function num : 0_16 , upvalues : _ENV
  print(judgeValue)
  if self.rejudegeOverCallback ~= nil then
    (self.rejudegeOverCallback)(judgeValue)
  end
end

ExplorationEventCtrl.SendCollectReward = function(self, passNumDes, couldContinue)
  -- function num : 0_17
  self.passNumDes = passNumDes
  self.couldContinue = couldContinue
  self.waitRefersh = true
  ;
  (self.netWork):CS_EXPLORATION_EVENT_RandomConfirm(self.currPosition)
end

ExplorationEventCtrl.OnCollectRewardSuccess = function(self)
  -- function num : 0_18 , upvalues : cs_MessageCommon, _ENV, ExplorationEnum
  (cs_MessageCommon.ShowMessageTips)(self.passNumDes)
  if not self.couldContinue then
    local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
    if eventWindow ~= nil then
      eventWindow:CloseWindow()
    end
    self.waitRefersh = false
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).EventRoom)
  end
end

ExplorationEventCtrl.__OnEventRoomUpdate = function(self, roomData)
  -- function num : 0_19
  if self.waitRefersh and self.currPosition == roomData.position then
    self.waitRefersh = false
    self:OnEventRoomOpen(roomData)
  end
end

ExplorationEventCtrl.__OnCCUpdate = function(self, itemUpdate)
  -- function num : 0_20 , upvalues : _ENV
  local roomData = (self.epCtrl):GetCurrentRoomData()
  if roomData.eventData == nil or roomData.eventData ~= self.eventData then
    return 
  end
  local isNeedUpdate = false
  for index,choiceData in ipairs((self.eventData).choiceDatalist) do
    if choiceData.catId == ConstGlobalItem.EpMoney then
      isNeedUpdate = true
    end
  end
  if not isNeedUpdate then
    return 
  end
  self:IsEventChoiceAble((self.eventData).choiceDatalist)
  local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
  if eventWindow ~= nil then
    eventWindow:UpdEpEventRoom(self.eventData, self.__onChoiceItemClick)
  end
end

ExplorationEventCtrl.__onChipListUpdate = function(self, chipList)
  -- function num : 0_21 , upvalues : _ENV
  local roomData = (self.epCtrl):GetCurrentRoomData()
  if roomData.eventData == nil or roomData.eventData ~= self.eventData then
    return 
  end
  if not self._hasUpdChip then
    return 
  end
  self:IsEventChoiceAble((self.eventData).choiceDatalist)
  local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
  if eventWindow ~= nil then
    eventWindow:UpdEpEventRoom(self.eventData, self.__onChoiceItemClick)
  end
end

ExplorationEventCtrl.SendChipUpgrade = function(self, chipItem, currencyId, callback)
  -- function num : 0_22 , upvalues : _ENV, cs_MessageCommon
  local chipData = chipItem.chipData
  local price = chipItem.upgradePrice
  if chipData == nil or currencyId == nil or price == nil then
    return 
  end
  local money = (self.dynPlayer):GetMoneyCount()
  if price <= money or price <= 0 then
    self:SendMsgChipUpgrade(chipData, callback)
  else
    local currencyName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[currencyId]).name)
    ;
    (cs_MessageCommon.ShowMessageTips)((string.format)(ConfigData:GetTipContent(TipContent.exploration_Upgrade_UpgradeItemInsufficient), currencyName))
  end
end

ExplorationEventCtrl.SendMsgChipUpgrade = function(self, chipData, callback)
  -- function num : 0_23 , upvalues : cs_MessageCommon, _ENV
  self.waitRefersh = true
  ;
  (self.netWork):CS_EXPLORATION_EVENT_AlgUpgrade(self.currPosition, chipData.dataId, function()
    -- function num : 0_23_0 , upvalues : cs_MessageCommon, _ENV, callback
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Upgrade_UpgradeItemSuccess))
    if callback ~= nil then
      callback()
    end
  end
)
end

ExplorationEventCtrl.SendSpecifyExit = function(self)
  -- function num : 0_24 , upvalues : _ENV, ExplorationEnum
  (self.netWork):CS_EXPLORATION_EVENT_SpecifyExit(self.currPosition, function()
    -- function num : 0_24_0 , upvalues : self, _ENV, ExplorationEnum
    if self.upgradeWindow ~= nil then
      (self.upgradeWindow):Delete()
      self.upgradeWindow = nil
    end
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).EventRoom)
  end
)
end

ExplorationEventCtrl.ReqChipUpgradeReturn = function(self)
  -- function num : 0_25 , upvalues : _ENV
  self.waitRefersh = true
  if not self._OnChipUpgradeReturnFunc then
    self._OnChipUpgradeReturnFunc = BindCallback(self, self._OnChipUpgradeReturn)
    ;
    (self.netWork):CS_EXPLORATION_EVENT_AlgUpgradeBack(self.currPosition, self._OnChipUpgradeReturnFunc)
  end
end

ExplorationEventCtrl._OnChipUpgradeReturn = function(self)
  -- function num : 0_26
  if self.upgradeWindow ~= nil then
    (self.upgradeWindow):Delete()
    self.upgradeWindow = nil
  end
end

ExplorationEventCtrl.OnDelete = function(self)
  -- function num : 0_27 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnEventAndRecoveryRoomUpdate, self.__OnEventRoomUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.onCCUpdate)
  self.waitRefersh = false
end

return ExplorationEventCtrl

