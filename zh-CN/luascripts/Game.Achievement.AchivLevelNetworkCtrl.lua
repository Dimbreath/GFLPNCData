-- params : ...
-- function num : 0 , upvalues : _ENV
local AchivLevelNetworkCtrl = class("AchivLevelNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
AchivLevelNetworkCtrl.ctor = function(self)
    -- function num : 0_0
end

AchivLevelNetworkCtrl.InitNetwork = function(self)
    -- function num : 0_1 , upvalues : _ENV
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_Detail, self,
                         proto_csmsg.SC_ACHIEVEMENT_Detail,
                         self.OnRecv_ACHIEVEMENT_Detail)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_LevelReward,
                         self, proto_csmsg.SC_ACHIEVEMENT_LevelReward,
                         self.OnRecv_ACHIEVEMENT_LevelReward)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_SyncUpdateDiff,
                         self, proto_csmsg.SC_ACHIEVEMENT_SyncUpdateDiff,
                         self.OnRecv_ACHIEVEMENT_SyncUpdateDiff)
end

AchivLevelNetworkCtrl.Send_ACHIEVEMENT_Detail =
    function(self)
        -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
        self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_Detail,
                     proto_csmsg.CS_ACHIEVEMENT_Detail, table.emptytable)
        cs_WaitNetworkResponse:StartOrAddWait(
            proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_Detail,
            proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_Detail)
    end

AchivLevelNetworkCtrl.OnRecv_ACHIEVEMENT_Detail =
    function(self, msg)
        -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
        do
            if msg.ret ~= proto_csmsg_ErrorCode.None then
                local err = "OnRecv_ACHIEVEMENT_Detail error:" ..
                                tostring(msg.ret)
                error(err)
                if isGameDev then
                    (cs_MessageCommon.ShowMessageTips)(err)
                end
                cs_WaitNetworkResponse:RemoveWait(
                    proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_Detail)
                return
            end
            if msg.data ~= nil then
                (PlayerDataCenter.achivLevelData):InitPickedLevels(
                    (msg.data).levelRewradsPicked);
                (PlayerDataCenter.achivLevelData):InitPickedAchivs(
                    (msg.data).questFinishedRecords)
            end
        end
    end

AchivLevelNetworkCtrl.Send_ACHIEVEMENT_LevelReward =
    function(self, level)
        -- function num : 0_4 , upvalues : _ENV
        local tabMsg = {lv = level}
        self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_LevelReward,
                     proto_csmsg.CS_ACHIEVEMENT_LevelReward, tabMsg)
    end

AchivLevelNetworkCtrl.OnRecv_ACHIEVEMENT_LevelReward =
    function(self, msg)
        -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
        do
            if msg.ret ~= proto_csmsg_ErrorCode.None then
                local err = "OnRecv_ACHIEVEMENT_LevelReward error:" ..
                                tostring(msg.ret)
                error(err)
                if isGameDev then
                    (cs_MessageCommon.ShowMessageTips)(err)
                end
                return
            end
            MsgCenter:Broadcast(eMsgEventId.GetAchivLevelRewardComplete,
                                msg.rewards)
        end
    end

AchivLevelNetworkCtrl.OnRecv_ACHIEVEMENT_SyncUpdateDiff =
    function(self, msg)
        -- function num : 0_6 , upvalues : _ENV
        if msg.levelRewradsPicked ~= nil then
            (PlayerDataCenter.achivLevelData):AddPickedLevel(
                msg.levelRewradsPicked)
        end
        if msg.questFinishedRecords ~= nil then
            (PlayerDataCenter.achivLevelData):AddPickedAchivs(
                msg.questFinishedRecords)
        end
    end

AchivLevelNetworkCtrl.Reset = function(self)
    -- function num : 0_7
end

return AchivLevelNetworkCtrl

