-- params : ...
-- function num : 0 , upvalues : _ENV
local ObjectNetworkCtrl = class("ObjectNetworkCtrl", NetworkCtrlBase)
ObjectNetworkCtrl.ctor = function(self)
    -- function num : 0_0
end

ObjectNetworkCtrl.InitNetwork = function(self)
    -- function num : 0_1 , upvalues : _ENV
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SyncUserData, self,
                         proto_csmsg.SC_SyncUserData, self.SC_SyncUserData)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FUNCTION_SyncUpdateDiff,
                         self, proto_csmsg.SC_FUNCTION_SyncUpdateDiff,
                         self.SC_FUNCTION_SyncUpdateDiff)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SyncUserBaseDiff, self,
                         proto_csmsg.SC_SyncUserBaseDiff,
                         self.SC_SyncUserBaseDiff)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_RESOURCE_SyncUpdateDiff,
                         self, proto_csmsg.SC_RESOURCE_SyncUpdateDiff,
                         self.SC_RESOURCE_SyncUpdateDiff)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_SyncUpdateDiff, self,
                         proto_csmsg.SC_HERO_SyncUpdateDiff,
                         self.SC_HERO_SyncUpdateDiff)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_UserNameModify, self,
                         proto_csmsg.SC_User_UserNameModify,
                         self.SC_User_UserNameModify)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_GUIDE_TriggerComplete, self,
                         proto_csmsg.SC_GUIDE_TriggerComplete,
                         self.SC_GUIDE_TriggerComplete)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_ModifyShowGirl, self,
                         proto_csmsg.SC_User_ModifyShowGirl,
                         self.SC_User_ModifyShowGirl)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_ClientLastSectorMention,
                         self, proto_csmsg.SC_User_ClientLastSectorMention,
                         self.SC_User_ClientLastSectorMention)
end

ObjectNetworkCtrl.WaitUserPreData = function(self)
    -- function num : 0_2 , upvalues : _ENV
    ((CS.WaitNetworkResponse).Instance):StartWait(
        proto_csmsg_MSG_ID.MSG_SC_SyncUserData, function(listObj)
            -- function num : 0_2_0 , upvalues : _ENV
            PlayerDataCenter:OnPreDataRecvComplete()
        end, proto_csmsg_MSG_ID.MSG_SC_SyncUserData,
        proto_csmsg_MSG_ID.MSG_SC_BUILDING_Detail,
        proto_csmsg_MSG_ID.MSG_SC_SECTOR_Detail,
        proto_csmsg_MSG_ID.MSG_SC_EFFECTOR_ResourceGenerator)
end

ObjectNetworkCtrl.SC_SyncUserData = function(self, msg)
    -- function num : 0_3 , upvalues : _ENV
    PlayerDataCenter:SyncUserData(msg);
    ((CS.NetworkManager).Instance):SetTimeHeartActive(true)
end

ObjectNetworkCtrl.SC_FUNCTION_SyncUpdateDiff =
    function(self, msg)
        -- function num : 0_4 , upvalues : _ENV
        local funcUnLockCrtl = ControllerManager:GetController(
                                   ControllerTypeId.FunctionUnlock, true)
        for k, v in pairs(msg.updates) do
            local openCfg = (ConfigData.system_open)[k]
            if openCfg ~= nil and openCfg.screening then
                do
                    funcUnLockCrtl:AddUnlockFunction(k)
                    -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
        for k, v in pairs(msg.deletes) do
            funcUnLockCrtl:RemoveUnlockFunction(k)
        end
    end

ObjectNetworkCtrl.SC_SyncUserBaseDiff = function(self, msg)
    -- function num : 0_5 , upvalues : _ENV
    if msg.stm ~= nil and (msg.stm).stm ~= nil then
        (PlayerDataCenter.stamina):UpdateStamina((msg.stm).stm)
    end
    if msg.level ~= nil then
        (PlayerDataCenter.playerLevel):UpdatePlayerLevelData((msg.level).level,
                                                             (msg.level).exp)
    end
end

ObjectNetworkCtrl.SC_RESOURCE_SyncUpdateDiff =
    function(self, msg)
        -- function num : 0_6 , upvalues : _ENV
        PlayerDataCenter:SyncItemUpdateDiff(msg)
    end

ObjectNetworkCtrl.SC_HERO_SyncUpdateDiff =
    function(self, msg)
        -- function num : 0_7 , upvalues : _ENV
        PlayerDataCenter:SyncHeroUpdateDiff(msg)
    end

ObjectNetworkCtrl.CS_User_UserNameModify =
    function(self, name, successAction)
        -- function num : 0_8 , upvalues : _ENV
        local createMsg = {name = name}
        self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_UserNameModify,
                     proto_csmsg.CS_User_UserNameModify, createMsg);
        ((CS.WaitNetworkResponse).Instance):StartWait(
            proto_csmsg_MSG_ID.MSG_CS_User_UserNameModify, function()
                -- function num : 0_8_0 , upvalues : _ENV, name, successAction
                PlayerDataCenter:UpdateUserNameData(name)
                if successAction ~= nil then successAction() end
            end, proto_csmsg_MSG_ID.MSG_SC_User_UserNameModify)
    end

ObjectNetworkCtrl.SC_User_UserNameModify =
    function(self, msg)
        -- function num : 0_9 , upvalues : _ENV
        if msg.ret ~= proto_csmsg_ErrorCode.None or msg.ret ==
            proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
            ((CS.MessageCommon).ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.name_Illegal));
            ((CS.WaitNetworkResponse).Instance):RemoveWait(
                proto_csmsg_MSG_ID.MSG_CS_User_UserNameModify)
        else
            local err = "ObjectNetworkCtrl:SC_User_UserNameModify error:" ..
                            tostring(msg.ret)
            error(err)
            if isGameDev then
                ((CS.MessageCommon).ShowMessageTips)(err)
            end
            ((CS.WaitNetworkResponse).Instance):RemoveWait(
                proto_csmsg_MSG_ID.MSG_CS_User_UserNameModify)
        end
    end

ObjectNetworkCtrl.CS_User_ModifyShowGirl =
    function(self, id)
        -- function num : 0_10 , upvalues : _ENV
        local msg = {id = id}
        -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

        PlayerDataCenter.showGirlId = id
        self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_ModifyShowGirl,
                     proto_csmsg.CS_User_ModifyShowGirl, msg);
        ((CS.WaitNetworkResponse).Instance):StartWait(
            proto_csmsg_MSG_ID.MSG_CS_User_ModifyShowGirl,
            proto_csmsg_MSG_ID.MSG_SC_User_ModifyShowGirl)
    end

ObjectNetworkCtrl.SC_User_ModifyShowGirl =
    function(self, msg)
        -- function num : 0_11 , upvalues : _ENV
        if msg.ret ~= proto_csmsg_ErrorCode.None then
            local err = "ObjectNetworkCtrl:SC_User_ModifyShowGirl error:" ..
                            tostring(msg.ret)
            error(err)
            if isGameDev then
                ((CS.MessageCommon).ShowMessageTips)(err)
            end
            ((CS.WaitNetworkResponse).Instance):RemoveWait(
                proto_csmsg_MSG_ID.MSG_CS_User_ModifyShowGirl)
        end
    end

ObjectNetworkCtrl.CS_GUIDE_TriggerComplete =
    function(self, guideId)
        -- function num : 0_12 , upvalues : _ENV
        local sendMsg = {id = guideId}
        self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_GUIDE_TriggerComplete,
                     proto_csmsg.CS_GUIDE_TriggerComplete, sendMsg)
    end

ObjectNetworkCtrl.SC_GUIDE_TriggerComplete =
    function(self, msg)
        -- function num : 0_13
    end

ObjectNetworkCtrl.CS_User_ClientLastSectorMention =
    function(self, sectorMentionId, callback)
        -- function num : 0_14 , upvalues : _ENV
        local msg = {id = sectorMentionId}
        self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_ClientLastSectorMention,
                     proto_csmsg.CS_User_ClientLastSectorMention, msg);
        ((CS.WaitNetworkResponse).Instance):StartWait(
            proto_csmsg_MSG_ID.MSG_CS_User_ClientLastSectorMention, callback,
            proto_csmsg_MSG_ID.MSG_SC_User_ClientLastSectorMention)
    end

ObjectNetworkCtrl.SC_User_ClientLastSectorMention =
    function(self, msg)
        -- function num : 0_15 , upvalues : _ENV
        if msg.ret ~= proto_csmsg_ErrorCode.None then
            local err =
                "ObjectNetworkCtrl:SC_User_ClientLastSectorMention error:" ..
                    tostring(msg.ret)
            error(err)
            if isGameDev then
                ((CS.MessageCommon).ShowMessageTips)(err)
            end
            ((CS.WaitNetworkResponse).Instance):RemoveWait(
                proto_csmsg_MSG_ID.MSG_CS_User_ClientLastSectorMention)
        end
    end

ObjectNetworkCtrl.Reset = function(self)
    -- function num : 0_16
end

return ObjectNetworkCtrl

