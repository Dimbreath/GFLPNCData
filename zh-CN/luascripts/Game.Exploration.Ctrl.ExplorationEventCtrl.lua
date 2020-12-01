-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationEventCtrl = class("ExplorationEventCtrl", ExplorationCtrlBase)
local eChoiceCondition = (require("Game.Exploration.ExplorationEnum")).eChoiceConditionType
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
  if (self.eventData).param == nil then
    if self.uiWindow == nil then
      UIManager:ShowWindowAsync(UIWindowTypeID.EpEventRoom, function(window)
    -- function num : 0_1_0 , upvalues : self
    if window == nil then
      return 
    end
    self.uiWindow = window
    ;
    (self.uiWindow):InitEpEventRoom(self.eventData, self.__onChoiceItemClick)
    ;
    ((self.epCtrl).autoCtrl):OnEnterEpEventRoom(self.eventData, true)
  end
)
    else
      ;
      (self.uiWindow):InitEpEventRoom(self.eventData, self.__onChoiceItemClick)
      ;
      ((self.epCtrl).autoCtrl):OnEnterEpEventRoom(self.eventData, false)
    end
  else
    local choicelist = (self.eventData).choiceDatalist
    if (choicelist[((self.eventData).param).p1 + 1]).catId == (ExplorationEnum.eEventRoomChoiceType).Upgrade then
      local upgradeCfg = (ConfigData.event_upgrade)[((self.eventData).param).p2]
      do
        local refreshTime = ((self.eventData).param).p3
        if self.upgradeWindow == nil then
          if self.uiWindow ~= nil then
            (self.uiWindow):CloseWindow()
            self.uiWindow = nil
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
          ;
          (self.upgradeWindow):InitUpgradeRoom(self, upgradeCfg, refreshTime)
          ;
          ((self.epCtrl).autoCtrl):OnEnterEpEventRoomUpgrade(self.eventData, false)
        end
      end
    end
  end
end

ExplorationEventCtrl.IsEventChoiceAble = function(self, choiceDatalist)
  -- function num : 0_2 , upvalues : _ENV, ExplorationEnum, eChoiceCondition
  self.dynPlayData = ExplorationManager:GetDynPlayer()
  local choiceCfg = nil
  for _,choiceData in ipairs(choiceDatalist) do
    if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Upgrade then
      choiceData.isAble = true
    else
      if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Jump then
        choiceData.isAble = true
      else
        choiceCfg = (ConfigData.event_choice)[choiceData.choiceId]
        if choiceCfg == nil then
          error("Can\'t find choiceCfg ID:" .. choiceData.choiceId)
          break
        end
        local isAble = true
        local itemId = nil
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
              itemId = deductData.dataID
              itemCount = (self.dynPlayData):GetItemCount(itemId)
              if itemCount < dataNum then
                isAble = false
              end
            end
          end
        end
        do
          do
            choiceData.isAble = isAble
            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

ExplorationEventCtrl.OnChoiceItemClick = function(self, choiceCfg, index, isAble)
  -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
  if not isAble then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Event_NotAchieved))
    return 
  end
  self.choiceCfg = choiceCfg
  self.waitRefersh = true
  ;
  (self.epCtrl):RecordLastSelectChoiceCtrl(self)
  ;
  (self.netWork):CS_EXPLORATION_EVENT_Select(self.currPosition, index)
end

ExplorationEventCtrl.OnChoiceItemSelectSuccess = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV, ExplorationEnum
  if msg.result ~= nil and msg.buff ~= nil then
    self:__ShowItemsMessageTips(msg.result)
    self:__ShowBuffMessageTips(msg.buff)
  end
  if (self.choiceCfg).jump then
    (self.uiWindow):CloseWindow()
    self.uiWindow = nil
    self.waitRefersh = false
    local roomData = (self.epCtrl):GetCurrentRoomData()
    ;
    (self.epCtrl):OnPlayerMoveComplete(roomData)
    return 
  end
  do
    if (self.choiceCfg).event_exit then
      (self.uiWindow):CloseWindow()
      self.uiWindow = nil
      self.waitRefersh = false
      MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).EventRoom)
    end
  end
end

ExplorationEventCtrl.__ShowItemsMessageTips = function(self, itemDic)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
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
      (cs_MessageCommon.ShowMessageTips)((string.format)(tipText, name, tostring(count)), true)
      if cfg.type == eItemType.GlobalChip then
        (table.insert)(self.showAniList, cfg.id)
      end
    end
  end
  self:__ShowGetAnimation(self.showAniList)
end

ExplorationEventCtrl.__ShowGetAnimation = function(self, aniList)
  -- function num : 0_6 , upvalues : _ENV, ChipData
  if #aniList <= 0 then
    return 
  end
  local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateWindow == nil then
    return 
  end
  local id, chipData = nil, nil
  local pos, scale = (self.uiWindow):GetAniItemPosAndScale()
  for i = 1, #aniList do
    id = (table.remove)(aniList, 1)
    chipData = (ChipData.New)(id, 1)
    dungeonStateWindow:ShowGetChipAni(chipData, pos, scale)
  end
end

ExplorationEventCtrl.__ShowBuffMessageTips = function(self, buffDic)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  local cfg, name, count = nil, nil, nil
  local tipText = ConfigData:GetTipContent(TipContent.exploration_Event_GetBuff)
  for id,count in pairs(buffDic) do
    cfg = (ConfigData.exploration_buff)[id]
    if cfg == nil then
      error("Can`t find buffCfg Data Id:" .. id)
    else
      if cfg.is_show then
        name = (LanguageUtil.GetLocaleText)(cfg.name)
        ;
        (cs_MessageCommon.ShowMessageTips)((string.format)(tipText, name), true)
      end
      if cfg.logic == 4 or cfg.logic == 5 then
        if cfg.logic_per > 0 then
          AudioManager:PlayAudioById(1010)
        else
          if cfg.logic_per < 0 then
            AudioManager:PlayAudioById(1025)
          end
        end
      end
    end
  end
end

ExplorationEventCtrl.SendRejudge = function(self)
  -- function num : 0_8
  (self.netWork):CS_EXPLORATION_EVENT_Focus(self.currPosition)
end

ExplorationEventCtrl.SetRejudegeOverCallback = function(self, callback)
  -- function num : 0_9
  self.rejudegeOverCallback = callback
end

ExplorationEventCtrl.OnRejudegeOver = function(self, judgeValue)
  -- function num : 0_10 , upvalues : _ENV
  print(judgeValue)
  if self.rejudegeOverCallback ~= nil then
    (self.rejudegeOverCallback)(judgeValue)
  end
end

ExplorationEventCtrl.SendCollectReward = function(self, passNumDes, couldContinue)
  -- function num : 0_11
  self.passNumDes = passNumDes
  self.couldContinue = couldContinue
  self.waitRefersh = true
  ;
  (self.netWork):CS_EXPLORATION_EVENT_RandomConfirm(self.currPosition)
end

ExplorationEventCtrl.OnCollectRewardSuccess = function(self)
  -- function num : 0_12 , upvalues : cs_MessageCommon, _ENV, ExplorationEnum
  (cs_MessageCommon.ShowMessageTips)(self.passNumDes)
  if not self.couldContinue then
    (self.uiWindow):CloseWindow()
    self.uiWindow = nil
    self.waitRefersh = false
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).EventRoom)
  end
end

ExplorationEventCtrl.__OnEventRoomUpdate = function(self, roomData)
  -- function num : 0_13
  if self.waitRefersh and self.currPosition == roomData.position then
    self.waitRefersh = false
    self:OnEventRoomOpen(roomData)
  end
end

ExplorationEventCtrl.SendChipUpgrade = function(self, chipItem, currencyId, callback)
  -- function num : 0_14 , upvalues : _ENV, cs_MessageCommon
  local chipData = chipItem.chipData
  local price = chipItem.upgradePrice
  if chipData == nil or currencyId == nil or price == nil then
    return 
  end
  local money = (self.dynPlayer):GetItemCount(currencyId)
  if price <= money then
    self:SendMsgChipUpgrade(chipData, callback)
  else
    local currencyName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[currencyId]).name)
    ;
    (cs_MessageCommon.ShowMessageTips)(currencyName .. ConfigData:GetTipContent(TipContent.exploration_Upgrade_UpgradeItemInsufficient))
  end
end

ExplorationEventCtrl.SendMsgChipUpgrade = function(self, chipData, callback)
  -- function num : 0_15 , upvalues : cs_MessageCommon, _ENV
  self.waitRefersh = true
  ;
  (self.netWork):CS_EXPLORATION_EVENT_AlgUpgrade(self.currPosition, chipData.dataId, function()
    -- function num : 0_15_0 , upvalues : cs_MessageCommon, _ENV, callback
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Upgrade_UpgradeItemSuccess))
    if callback ~= nil then
      callback()
    end
  end
)
end

ExplorationEventCtrl.SendSpecifyExit = function(self)
  -- function num : 0_16 , upvalues : _ENV, ExplorationEnum
  (self.netWork):CS_EXPLORATION_EVENT_SpecifyExit(self.currPosition, function()
    -- function num : 0_16_0 , upvalues : self, _ENV, ExplorationEnum
    if self.upgradeWindow ~= nil then
      (self.upgradeWindow):Delete()
      self.upgradeWindow = nil
    end
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).EventRoom)
  end
)
end

ExplorationEventCtrl.OnDelete = function(self)
  -- function num : 0_17 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnEventAndRecoveryRoomUpdate, self.__OnEventRoomUpdate)
  self.waitRefersh = false
  self.uiWindow = nil
end

return ExplorationEventCtrl

-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationEventCtrl = class("ExplorationEventCtrl", ExplorationCtrlBase)
local eChoiceCondition =
    (require("Game.Exploration.ExplorationEnum")).eChoiceConditionType
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
    MsgCenter:AddListener(eMsgEventId.OnEventAndRecoveryRoomUpdate,
                          self.__onEventRoomUpdate)
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
    if (self.eventData).param == nil then
        if self.uiWindow == nil then
            UIManager:ShowWindowAsync(UIWindowTypeID.EpEventRoom,
                                      function(window)
                -- function num : 0_1_0 , upvalues : self
                if window == nil then return end
                self.uiWindow = window;
                (self.uiWindow):InitEpEventRoom(self.eventData,
                                                self.__onChoiceItemClick);
                ((self.epCtrl).autoCtrl):OnEnterEpEventRoom(self.eventData, true)
            end)
        else

            (self.uiWindow):InitEpEventRoom(self.eventData,
                                            self.__onChoiceItemClick);
            ((self.epCtrl).autoCtrl):OnEnterEpEventRoom(self.eventData, false)
        end
    else
        local choicelist = (self.eventData).choiceDatalist
        if (choicelist[((self.eventData).param).p1 + 1]).catId ==
            (ExplorationEnum.eEventRoomChoiceType).Upgrade then
            local upgradeCfg =
                (ConfigData.event_upgrade)[((self.eventData).param).p2]
            do
                local refreshTime = ((self.eventData).param).p3
                if self.upgradeWindow == nil then
                    if self.uiWindow ~= nil then
                        (self.uiWindow):CloseWindow()
                        self.uiWindow = nil
                    end
                    UIManager:ShowWindowAsync(UIWindowTypeID.EpUpgradeRoom,
                                              function(window)
                        -- function num : 0_1_1 , upvalues : self, upgradeCfg, refreshTime
                        window:InitUpgradeRoom(self, upgradeCfg, refreshTime)
                        self.upgradeWindow = window;
                        ((self.epCtrl).autoCtrl):OnEnterEpEventRoomUpgrade(
                            self.eventData, true)
                    end)
                else

                    (self.upgradeWindow):InitUpgradeRoom(self, upgradeCfg,
                                                         refreshTime);
                    ((self.epCtrl).autoCtrl):OnEnterEpEventRoomUpgrade(
                        self.eventData, false)
                end
            end
        end
    end
end

ExplorationEventCtrl.IsEventChoiceAble =
    function(self, choiceDatalist)
        -- function num : 0_2 , upvalues : _ENV, ExplorationEnum, eChoiceCondition
        self.dynPlayData = ExplorationManager:GetDynPlayer()
        local choiceCfg = nil
        for _, choiceData in ipairs(choiceDatalist) do
            if choiceData.catId ==
                (ExplorationEnum.eEventRoomChoiceType).Upgrade then
                choiceData.isAble = true
            else
                if choiceData.catId ==
                    (ExplorationEnum.eEventRoomChoiceType).Jump then
                    choiceData.isAble = true
                else
                    choiceCfg = (ConfigData.event_choice)[choiceData.choiceId]
                    if choiceCfg == nil then
                        error("Can\'t find choiceCfg ID:" .. choiceData.choiceId)
                        break
                    end
                    local isAble = true
                    local itemId = nil
                    local itemCount = 0
                    local dataNum = 0
                    if choiceCfg.condition == eChoiceCondition.NotRequired then
                        isAble = true
                    else
                        if choiceCfg.choiceDeductList == nil then
                            isAble = true
                        else
                            for k, deductData in
                                ipairs(choiceCfg.choiceDeductList) do
                                if choiceCfg.condition ==
                                    eChoiceCondition.Required then
                                    dataNum = deductData.dataNum
                                else
                                    if choiceCfg.condition ==
                                        eChoiceCondition.NotRequiredAtLeastOne then
                                        dataNum = 1
                                    end
                                end
                                itemId = deductData.dataID
                                itemCount =
                                    (self.dynPlayData):GetItemCount(itemId)
                                if itemCount < dataNum then
                                    isAble = false
                                end
                            end
                        end
                    end
                    do
                        do
                            choiceData.isAble = isAble
                            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

                        end
                    end
                end
            end
        end
    end

ExplorationEventCtrl.OnChoiceItemClick =
    function(self, choiceCfg, index, isAble)
        -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
        if not isAble then
            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(
                    TipContent.exploration_Event_NotAchieved))
            return
        end
        self.choiceCfg = choiceCfg
        self.waitRefersh = true;
        (self.epCtrl):RecordLastSelectChoiceCtrl(self);
        (self.netWork):CS_EXPLORATION_EVENT_Select(self.currPosition, index)
    end

ExplorationEventCtrl.OnChoiceItemSelectSuccess =
    function(self, msg)
        -- function num : 0_4 , upvalues : _ENV, ExplorationEnum
        if msg.result ~= nil and msg.buff ~= nil then
            self:__ShowItemsMessageTips(msg.result)
            self:__ShowBuffMessageTips(msg.buff)
        end
        if (self.choiceCfg).jump then
            (self.uiWindow):CloseWindow()
            self.uiWindow = nil
            self.waitRefersh = false
            local roomData = (self.epCtrl):GetCurrentRoomData();
            (self.epCtrl):OnPlayerMoveComplete(roomData)
            return
        end
        do
            if (self.choiceCfg).event_exit then
                (self.uiWindow):CloseWindow()
                self.uiWindow = nil
                self.waitRefersh = false
                MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete,
                                    (ExplorationEnum.eExitRoomCompleteType).EventRoom)
            end
        end
    end

ExplorationEventCtrl.__ShowItemsMessageTips =
    function(self, itemDic)
        -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
        self.showAniList = {}
        local cfg, name = nil, nil
        local tipText = ConfigData:GetTipContent(
                            TipContent.exploration_Event_GetItem)
        for id, count in pairs(itemDic) do
            cfg = (ConfigData.item)[id]
            if cfg == nil then
                error("Can`t find itemCfg Data Id:" .. id)
            else
                name = (LanguageUtil.GetLocaleText)(cfg.name);
                (cs_MessageCommon.ShowMessageTips)(
                    (string.format)(tipText, name, tostring(count)), true)
                if cfg.type == eItemType.GlobalChip then
                    (table.insert)(self.showAniList, cfg.id)
                end
            end
        end
        self:__ShowGetAnimation(self.showAniList)
    end

ExplorationEventCtrl.__ShowGetAnimation =
    function(self, aniList)
        -- function num : 0_6 , upvalues : _ENV, ChipData
        if #aniList <= 0 then return end
        local dungeonStateWindow = UIManager:GetWindow(
                                       UIWindowTypeID.DungeonStateInfo)
        if dungeonStateWindow == nil then return end
        local id, chipData = nil, nil
        local pos, scale = (self.uiWindow):GetAniItemPosAndScale()
        for i = 1, #aniList do
            id = (table.remove)(aniList, 1)
            chipData = (ChipData.New)(id, 1)
            dungeonStateWindow:ShowGetChipAni(chipData, pos, scale)
        end
    end

ExplorationEventCtrl.__ShowBuffMessageTips =
    function(self, buffDic)
        -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
        local cfg, name, count = nil, nil, nil
        local tipText = ConfigData:GetTipContent(
                            TipContent.exploration_Event_GetBuff)
        for id, count in pairs(buffDic) do
            cfg = (ConfigData.exploration_buff)[id]
            if cfg == nil then
                error("Can`t find buffCfg Data Id:" .. id)
            else
                if cfg.is_show then
                    name = (LanguageUtil.GetLocaleText)(cfg.name);
                    (cs_MessageCommon.ShowMessageTips)(
                        (string.format)(tipText, name), true)
                end
                if cfg.logic == 4 or cfg.logic == 5 then
                    if cfg.logic_per > 0 then
                        AudioManager:PlayAudioById(1010)
                    else
                        if cfg.logic_per < 0 then
                            AudioManager:PlayAudioById(1025)
                        end
                    end
                end
            end
        end
    end

ExplorationEventCtrl.SendRejudge = function(self)
    -- function num : 0_8
    (self.netWork):CS_EXPLORATION_EVENT_Focus(self.currPosition)
end

ExplorationEventCtrl.SetRejudegeOverCallback =
    function(self, callback)
        -- function num : 0_9
        self.rejudegeOverCallback = callback
    end

ExplorationEventCtrl.OnRejudegeOver = function(self, judgeValue)
    -- function num : 0_10 , upvalues : _ENV
    print(judgeValue)
    if self.rejudegeOverCallback ~= nil then
        (self.rejudegeOverCallback)(judgeValue)
    end
end

ExplorationEventCtrl.SendCollectReward =
    function(self, passNumDes, couldContinue)
        -- function num : 0_11
        self.passNumDes = passNumDes
        self.couldContinue = couldContinue
        self.waitRefersh = true;
        (self.netWork):CS_EXPLORATION_EVENT_RandomConfirm(self.currPosition)
    end

ExplorationEventCtrl.OnCollectRewardSuccess =
    function(self)
        -- function num : 0_12 , upvalues : cs_MessageCommon, _ENV, ExplorationEnum
        (cs_MessageCommon.ShowMessageTips)(self.passNumDes)
        if not self.couldContinue then
            (self.uiWindow):CloseWindow()
            self.uiWindow = nil
            self.waitRefersh = false
            MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete,
                                (ExplorationEnum.eExitRoomCompleteType).EventRoom)
        end
    end

ExplorationEventCtrl.__OnEventRoomUpdate =
    function(self, roomData)
        -- function num : 0_13
        if self.waitRefersh and self.currPosition == roomData.position then
            self.waitRefersh = false
            self:OnEventRoomOpen(roomData)
        end
    end

ExplorationEventCtrl.SendChipUpgrade = function(self, chipItem, currencyId,
                                                callback)
    -- function num : 0_14 , upvalues : _ENV, cs_MessageCommon
    local chipData = chipItem.chipData
    local price = chipItem.upgradePrice
    if chipData == nil or currencyId == nil or price == nil then return end
    local money = (self.dynPlayer):GetItemCount(currencyId)
    if price <= money then
        self:SendMsgChipUpgrade(chipData, callback)
    else
        local currencyName = (LanguageUtil.GetLocaleText)(
                                 ((ConfigData.item)[currencyId]).name);
        (cs_MessageCommon.ShowMessageTips)(
            currencyName ..
                ConfigData:GetTipContent(
                    TipContent.exploration_Upgrade_UpgradeItemInsufficient))
    end
end

ExplorationEventCtrl.SendMsgChipUpgrade =
    function(self, chipData, callback)
        -- function num : 0_15 , upvalues : cs_MessageCommon, _ENV
        self.waitRefersh = true;
        (self.netWork):CS_EXPLORATION_EVENT_AlgUpgrade(self.currPosition,
                                                       chipData.dataId,
                                                       function()
            -- function num : 0_15_0 , upvalues : cs_MessageCommon, _ENV, callback
            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(
                    TipContent.exploration_Upgrade_UpgradeItemSuccess))
            if callback ~= nil then callback() end
        end)
    end

ExplorationEventCtrl.SendSpecifyExit = function(self)
    -- function num : 0_16 , upvalues : _ENV, ExplorationEnum
    (self.netWork):CS_EXPLORATION_EVENT_SpecifyExit(self.currPosition,
                                                    function()
        -- function num : 0_16_0 , upvalues : self, _ENV, ExplorationEnum
        if self.upgradeWindow ~= nil then
            (self.upgradeWindow):Delete()
            self.upgradeWindow = nil
        end
        MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete,
                            (ExplorationEnum.eExitRoomCompleteType).EventRoom)
    end)
end

ExplorationEventCtrl.OnDelete = function(self)
    -- function num : 0_17 , upvalues : _ENV
    MsgCenter:RemoveListener(eMsgEventId.OnEventAndRecoveryRoomUpdate,
                             self.__OnEventRoomUpdate)
    self.waitRefersh = false
    self.uiWindow = nil
end

return ExplorationEventCtrl

