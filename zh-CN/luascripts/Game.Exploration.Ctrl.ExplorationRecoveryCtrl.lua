-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationRecoveryCtrl = class("ExplorationRecoveryCtrl",
                                      ExplorationCtrlBase)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_MessageCommon = CS.MessageCommon
ExplorationRecoveryCtrl.ctor = function(self, epCtrl)
    -- function num : 0_0 , upvalues : _ENV
    self.netWork = NetworkManager:GetNetwork(NetworkTypeID.EventRoom)
    self.__onChoiceItemClick = BindCallback(self, self.OnChoiceItemClick)
    self.epCtrl = epCtrl
    self.__onRecoveryRoomUpdate =
        BindCallback(self, self.__OnRecoveryRoomUpdate)
    MsgCenter:AddListener(eMsgEventId.OnEventAndRecoveryRoomUpdate,
                          self.__onRecoveryRoomUpdate)
end

ExplorationRecoveryCtrl.OnRecoveryRoomOpen =
    function(self, roomData)
        -- function num : 0_1 , upvalues : ExplorationEnum, _ENV
        if (roomData.eventData).eRoomType ~=
            (ExplorationEnum.eRoomType).recovery then
            error("roomData.recoveryData is nil")
            return
        end
        self.currPosition = roomData.position
        self.recoveryData = roomData.eventData
        self.dynPlayer = ExplorationManager:GetDynPlayer()
        self.isLoad = nil
        if (self.recoveryData).param == nil then
            if self.uiWindow == nil then
                UIManager:ShowWindowAsync(UIWindowTypeID.EpEventRoom,
                                          function(window)
                    -- function num : 0_1_0 , upvalues : self
                    if window == nil then return end
                    self.uiWindow = window;
                    (self.uiWindow):InitEpEventRoom(self.recoveryData,
                                                    self.__onChoiceItemClick)
                end)
            else

                (self.uiWindow):InitEpEventRoom(self.recoveryData,
                                                self.__onChoiceItemClick)
            end
        else
            local choicelist = (self.recoveryData).choiceDatalist
            if (choicelist[((self.recoveryData).param).p1 + 1]).catId ==
                (ExplorationEnum.eEventRoomChoiceType).Upgrade then
                local upgradeCfg =
                    (ConfigData.event_upgrade)[((self.recoveryData).param).p2]
                do
                    local refreshTime = ((self.recoveryData).param).p3
                    if self.upgradeWindow == nil then
                        if self.uiWindow ~= nil then
                            (self.uiWindow):CloseWindow()
                            self.uiWindow = nil
                        end
                        UIManager:ShowWindowAsync(UIWindowTypeID.EpUpgradeRoom,
                                                  function(window)
                            -- function num : 0_1_1 , upvalues : self, upgradeCfg, refreshTime
                            window:InitUpgradeRoom(self, upgradeCfg, refreshTime)
                            self.upgradeWindow = window
                        end)
                    else

                        (self.upgradeWindow):InitUpgradeRoom(self, upgradeCfg,
                                                             refreshTime)
                    end
                end
            end
        end
    end

ExplorationRecoveryCtrl.OnChoiceItemClick =
    function(self, choiceCfg, index, isAble, catId)
        -- function num : 0_2 , upvalues : _ENV
        if isAble ~= nil then error("RecoveryRoom choose has isAble") end
        self.choiceCfg = choiceCfg
        self.choiceCatId = catId
        self.waitRefersh = true;
        (self.epCtrl):RecordLastSelectChoiceCtrl(self);
        (self.netWork):CS_EXPLORATION_EVENT_Select(self.currPosition, index)
    end

ExplorationRecoveryCtrl.OnChoiceItemSelectSuccess =
    function(self, msg)
        -- function num : 0_3 , upvalues : _ENV
        if msg.result ~= nil and msg.buff ~= nil then
            self:__ShowItemsMessageTips(msg.result)
            self:__ShowBuffMessageTips(msg.buff)
        end
        if (self.choiceCfg).event_exit then
            (self.uiWindow):CloseWindow()
            self.uiWindow = nil
            self.waitRefersh = false
            MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete)
        end
    end

ExplorationRecoveryCtrl.__ShowItemsMessageTips =
    function(self, itemDic)
        -- function num : 0_4 , upvalues : _ENV, cs_MessageCommon
        local cfg, name, count = nil, nil, nil
        local tipText = ConfigData:GetTipContent(
                            TipContent.exploration_Event_GetItem)
        for id, count in pairs(itemDic) do
            cfg = (ConfigData.item)[id]
            if cfg == nil then
                error("Can`t find itemCfg Data Id:" .. id)
            else
                name = (LanguageUtil.GetLocaleText)(cfg.name)
                count = tostring(count);
                (cs_MessageCommon.ShowMessageTips)(
                    (string.format)(tipText, name, count), true)
            end
        end
    end

ExplorationRecoveryCtrl.__ShowBuffMessageTips =
    function(self, buffDic)
        -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
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

ExplorationRecoveryCtrl.__OnRecoveryRoomUpdate =
    function(self, roomData)
        -- function num : 0_6
        if self.waitRefersh and self.currPosition == roomData.position then
            self:OnRecoveryRoomOpen(roomData)
        end
    end

ExplorationRecoveryCtrl.SendChipUpgrade =
    function(self, chipItem, currencyId, callback)
        -- function num : 0_7 , upvalues : cs_MessageCommon, _ENV
        local chipData = chipItem.chipData
        local price = chipItem.upgradePrice
        if chipData == nil or currencyId == nil or price == nil then
            return
        end
        local money = (self.dynPlayer):GetItemCount(currencyId)
        if price <= money then
            self.waitRefersh = true;
            (self.netWork):CS_EXPLORATION_EVENT_AlgUpgrade(self.currPosition,
                                                           chipData.dataId,
                                                           function()
                -- function num : 0_7_0 , upvalues : cs_MessageCommon, _ENV, callback
                (cs_MessageCommon.ShowMessageTips)(
                    ConfigData:GetTipContent(
                        TipContent.exploration_Upgrade_UpgradeItemSuccess))
                if callback ~= nil then callback() end
            end)
        else
            local currencyName = (LanguageUtil.GetLocaleText)(
                                     ((ConfigData.item)[currencyId]).name);
            (cs_MessageCommon.ShowMessageTips)(
                currencyName ..
                    ConfigData:GetTipContent(
                        TipContent.exploration_Upgrade_UpgradeItemInsufficient))
        end
    end

ExplorationRecoveryCtrl.SendSpecifyExit =
    function(self)
        -- function num : 0_8 , upvalues : _ENV
        (self.netWork):CS_EXPLORATION_EVENT_SpecifyExit(self.currPosition,
                                                        function()
            -- function num : 0_8_0 , upvalues : self, _ENV
            if self.upgradeWindow ~= nil then
                (self.upgradeWindow):Delete()
                self.upgradeWindow = nil
            end
            MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete)
        end)
    end

ExplorationRecoveryCtrl.OnDelete = function(self)
    -- function num : 0_9 , upvalues : _ENV
    MsgCenter:RemoveListener(eMsgEventId.OnRecoveryRoomUpdate,
                             self.__onRecoveryRoomUpdate)
    self.waitRefersh = false
    self.uiWindow = nil
end

return ExplorationRecoveryCtrl

