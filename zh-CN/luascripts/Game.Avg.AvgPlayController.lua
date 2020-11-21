-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgPlayController = class("AvgPlayController", ControllerBase)
local TaskEnum = require("Game.Task.TaskEnum")
local CheckerTypeId, CheckerGlobalConfig =
    (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
AvgPlayController.ctor = function(self)
    -- function num : 0_0
end

AvgPlayController.OnInit = function(self)
    -- function num : 0_1 , upvalues : _ENV
    self.__onRecvNewAvgTask = BindCallback(self, self.OnRecvNewAvgTask)
    MsgCenter:AddListener(eMsgEventId.TaskReceived, self.__onRecvNewAvgTask)
end

AvgPlayController.InitAllAvgPlayed = function(self, avgGroup)
    -- function num : 0_2
    if avgGroup == nil then
        self.avgPlayedDic = {}
    else
        self.avgPlayedDic = avgGroup.data
    end
end

AvgPlayController.RecordAvgPlayed = function(self, avgId)
    -- function num : 0_3 , upvalues : _ENV, CheckerTypeId
    if self.avgPlayedDic == nil then
        error("avgPlayedDic is not initialize")
        return
    end -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'
    
    (self.avgPlayedDic)[avgId] = true
    self:UpdateMainAvgRedDot(avgId)
    local unlockDic = ((ConfigData.sector).avgUnlockDic)[avgId]
    if unlockDic ~= nil then
        for id, checkerTypeId in pairs(unlockDic) do
            if checkerTypeId == CheckerTypeId.CompleteStage then
                (PlayerDataCenter.sectorStage):UpdateSctStageItemRedDot(id)
            else
                if checkerTypeId == CheckerTypeId.CompleteAvg then
                    self:UpdateMainAvgRedDot(id)
                end
            end
        end
    end
end

AvgPlayController.TryPlayTaskAvg = function(self, param1, callBack,
                                            onlyAvgCallBack)
    -- function num : 0_4 , upvalues : _ENV
    local avgCfg = self:CheckTaskAvgPlayable(param1)
    if avgCfg ~= nil then
        (ControllerManager:GetController(ControllerTypeId.Avg, true)):StartAvg(
            avgCfg.script_id, avgCfg.id, callBack)
    else
        if not onlyAvgCallBack and callBack ~= nil then callBack() end
    end
end

AvgPlayController.TryPlayAvg = function(self, avgTriggerType, place, param1,
                                        param2, callBack)
    -- function num : 0_5 , upvalues : _ENV
    local avgCfg = self:CkeckAvgPlayable(avgTriggerType, place, param1, param2)
    if avgCfg ~= nil then
        (ControllerManager:GetController(ControllerTypeId.Avg, true)):StartAvg(
            avgCfg.script_id, avgCfg.id, callBack)
    else
        if callBack ~= nil then callBack() end
    end
end

AvgPlayController.CheckTaskAvgPlayable =
    function(self, param1)
        -- function num : 0_6 , upvalues : _ENV
        local taskIdDic = ((ConfigData.story_avg).avgTaskParamDic)[param1]
        if taskIdDic == nil then return end
        for taskId, avgId in pairs(taskIdDic) do
            local avgCfg = self:CkeckAvgPlayable(eAvgTriggerType.AvgTask,
                                                 taskId, param1)
            if avgCfg ~= nil then return avgCfg end
        end
    end

AvgPlayController.CkeckAvgPlayable = function(self, avgTriggerType, place,
                                              param1, param2)
    -- function num : 0_7 , upvalues : _ENV
    local avgCfg = self:TryGetAvgCfg(avgTriggerType, place, param1, param2)
    if avgCfg == nil then return end
    if self:IsAvgPlayed(avgCfg.id) then return end
    if not self:IsAvgUnlock(avgCfg.id) then return end
    do
        if avgCfg.type == eAvgTriggerType.AvgTask then
            local taskData =
                ((PlayerDataCenter.allTaskData).taskDatas)[avgCfg.set_place]
            if taskData == nil or taskData:CheckComplete() then
                return
            end
        end
        return avgCfg
    end
end

AvgPlayController.TryGetAvgCfg = function(self, avgTriggerType, place, param1,
                                          param2)
    -- function num : 0_8 , upvalues : _ENV
    local triggerCfg = ((ConfigData.story_avg).triggerTypeDic)[avgTriggerType]
    if triggerCfg == nil then return end
    local triggerParam1Cfg = triggerCfg[place]
    if triggerParam1Cfg == nil then return end
    local triggerParam2Cfg = triggerParam1Cfg[param1 or 0]
    if triggerParam2Cfg == nil then return end
    local avgId = triggerParam2Cfg[param2 or 0]
    if avgId == nil then return end
    local avgCfg = (ConfigData.story_avg)[avgId]
    if avgCfg == nil then
        error("Cant get avgCfg, avgId = " .. tostring(avgId))
        return
    end
    return avgCfg
end

AvgPlayController.IsAvgPlayed = function(self, avgId)
    -- function num : 0_9 , upvalues : _ENV
    local avgCfg = (ConfigData.story_avg)[avgId]
    if avgCfg == nil then
        error("Cant get avgCfg, avgId = " .. tostring(avgId))
        return true
    end
    if self.avgPlayedDic == nil then
        error("avgPlayedDic is not initialize")
        return true
    end
    if (self.avgPlayedDic)[avgId] ~= nil then return true end
end

AvgPlayController.OnRecvNewAvgTask = function(self, newTaskDataList)
    -- function num : 0_10 , upvalues : _ENV, TaskEnum
    local avgTaskList = nil
    for k, taskData in ipairs(newTaskDataList) do
        if (taskData.stcData).type == (TaskEnum.eTaskType).AvgTask then
            if avgTaskList == nil then avgTaskList = {} end
            (table.insert)(avgTaskList, taskData)
        end
    end
    if avgTaskList == nil then return end
    do
        for k, taskData in ipairs(avgTaskList) do
            local avgId = (taskData.stcData).story
            local story2guide_condition =
                (taskData.stcData).story2guide_condition
            local avgCfg = (ConfigData.story_avg)[avgId]
            if avgCfg == nil then
                error("Can\'t find avgCfg, avgId = " .. tostring(avgId))
            else
                if not self:IsAvgPlayed(avgId) and self:IsAvgUnlock(avgCfg.id) then
                    self:TryPlayTaskAvg(0, function()
                        -- function num : 0_10_0 , upvalues : story2guide_condition, _ENV
                        if story2guide_condition > 0 then
                            GuideManager:TryTriggerGuide(story2guide_condition)
                        end
                    end, true)
                end
            end
        end
    end
end

AvgPlayController.IsAvgUnlock = function(self, avgId)
    -- function num : 0_11 , upvalues : _ENV
    local avgCfg = (ConfigData.story_avg)[avgId]
    if avgCfg == nil then
        error("Can\'t find avgCfg, avgId = " .. tostring(avgId))
        return true
    end
    return (CheckCondition.CheckLua)(avgCfg.pre_condition, avgCfg.pre_para1,
                                     avgCfg.pre_para2)
end

AvgPlayController.InitAvgRedDot = function(self)
    -- function num : 0_12 , upvalues : _ENV
    local mainAvgTriggerCfg =
        ((ConfigData.story_avg).triggerTypeDic)[eAvgTriggerType.MainAvg]
    if mainAvgTriggerCfg ~= nil then
        for set_place, param1Cfg in pairs(mainAvgTriggerCfg) do
            local stageCfg = (ConfigData.sector_stage)[set_place]
            if stageCfg == nil then
                error("Cant find sector_stage cfg, id = " .. tostring(set_place))
            else
                RedDotController:AddRedDotNodeWithPath(
                    RedDotDynPath.SectorLevelDifficultPath,
                    RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector,
                    stageCfg.sector, stageCfg.difficulty)
                for param1, param2Cfg in pairs(param1Cfg) do
                    for param2, avgId in pairs(param2Cfg) do
                        local node = RedDotController:AddRedDotNodeWithPath(
                                         RedDotDynPath.SectorMainAvgPath,
                                         RedDotStaticTypeId.Main,
                                         RedDotStaticTypeId.Sector,
                                         stageCfg.sector, stageCfg.difficulty,
                                         RedDotStaticTypeId.MainAvg, avgId)
                        local count = 0
                        if self:IsAvgUnlock(avgId) and
                            not self:IsAvgPlayed(avgId) then
                            count = 1
                        end
                        node:SetRedDotCount(count)
                    end
                end
            end
        end
    end
end

AvgPlayController.UpdateMainAvgRedDot = function(self, avgId)
    -- function num : 0_13 , upvalues : _ENV
    local avgCfg = (ConfigData.story_avg)[avgId]
    if avgCfg == nil then
        error("Cant get avgCfg, avgId = " .. tostring(avgId))
        return
    end
    if avgCfg.type ~= eAvgTriggerType.MainAvg then return end
    local stageCfg = (ConfigData.sector_stage)[avgCfg.set_place]
    if stageCfg == nil then
        error("Cant find sector_stage cfg, id = " .. tostring(avgCfg.set_place))
        return
    end
    local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main,
                                                    RedDotStaticTypeId.Sector,
                                                    stageCfg.sector,
                                                    stageCfg.difficulty,
                                                    RedDotStaticTypeId.MainAvg,
                                                    avgId)
    if ok then
        local count = 0
        if self:IsAvgUnlock(avgId) and not self:IsAvgPlayed(avgId) then
            count = 1
        end
        node:SetRedDotCount(count)
    end
end

AvgPlayController.OnDelete = function(self)
    -- function num : 0_14 , upvalues : _ENV
    MsgCenter:RemoveListener(eMsgEventId.TaskReceived, self.__onRecvNewAvgTask)
end

return AvgPlayController

