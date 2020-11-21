-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorTask = class("UISectorTask", UIBaseNode)
local base = UIBaseNode
local UISectorTaskItem = require("Game.Sector.SectorTask.UISectorTaskItem")
local UISectorAchivItem = require("Game.Sector.SectorTask.UISectorAchivItem")
local UILevelRewardsItem = require("Game.Sector.LevelDetail.UILevelRewardsItem")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_MessageCommon = CS.MessageCommon
local SectorEnum = require("Game.Sector.SectorEnum")
UISectorTask.Create = function(gameObject)
    -- function num : 0_0 , upvalues : UISectorTask
    local node = (UISectorTask.New)()
    node:Init(gameObject)
    return node
end

UISectorTask.OnInit = function(self)
    -- function num : 0_1 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).mask_Close, self, self.__OnClickClose);
    (UIUtil.AddButtonListener)((self.ui).closeShowReward, self,
                               self.__OnClickCloseShowReward);
    ((self.ui).taskItem):SetActive(false);
    ((self.ui).treasureItem):SetActive(false);
    ((self.ui).showReward):SetActive(false);
    ((self.ui).showRewardItem):SetActive(false)
    self.taskNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Task)
    self.sectorNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
    self.__taskItems = {}
    self.__taskItemPool = {}
    self.__achivItems = {}
    self.__rewardItems = {}
    self.__rewardItemPool = {}
    self.__OnTaskUpdate = BindCallback(self, self.OnTaskUpdate)
    self.__OnTaskDelete = BindCallback(self, self.OnTaskDelete)
    self.__OnTaskCommit = BindCallback(self, self.OnTaskCommit)
    self.__OnPickedAchivItem = BindCallback(self, self.OnPickedAchivItem)
end

UISectorTask.OnShow = function(self)
    -- function num : 0_2 , upvalues : base, _ENV
    (base.OnShow)(self)
    MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
    MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
    MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
    MsgCenter:AddListener(eMsgEventId.SectorPickReward, self.__OnPickedAchivItem)
end

UISectorTask.OnHide = function(self)
    -- function num : 0_3 , upvalues : _ENV
    MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
    MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
    MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
    MsgCenter:RemoveListener(eMsgEventId.SectorPickReward,
                             self.__OnPickedAchivItem)
end

UISectorTask.InitSectorTask = function(self, sectorId, sectorCfg)
    -- function num : 0_4 , upvalues : _ENV
    self.sectorId = sectorId
    self.type = sectorCfg.achievement
    self.achivCfg = (ConfigData.sectorAchievement)[sectorId]
    if self.achivCfg == nil then self.achivCfg = {} end
    self:UpdateAllTask()
    self:OnSectorAchivUpdate(sectorId, (PlayerDataCenter.sectorDatas)[sectorId])
end

UISectorTask.UpdateAllTask = function(self)
    -- function num : 0_5 , upvalues : _ENV
    local taskDatas =
        ((PlayerDataCenter.allTaskData).sectorTaskDatas)[self.type]
    for k, v in pairs(taskDatas) do
        local taskItem = (self.__taskItems)[k]
        if taskItem == nil then
            taskItem = self:__GetTaskItem() -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'
            ;
            (self.__taskItems)[k] = taskItem
        end
        taskItem:InitSectorTaskItem(v, v.stcData)
    end
    self:__SortTask()
end

UISectorTask.__GetTaskItem = function(self)
    -- function num : 0_6 , upvalues : _ENV, UISectorTaskItem
    local taskItem = nil
    if #self.__taskItemPool > 0 then
        taskItem = (table.remove)(self.__taskItemPool)
    else
        local go = ((self.ui).taskItem):Instantiate()
        taskItem = (UISectorTaskItem.Create)(go)
    end
    do
        taskItem:Show()
        taskItem.OnClickEvent = BindCallback(self, self.__OnClickTask)
        return taskItem
    end
end

UISectorTask.__SortTask = function(self)
    -- function num : 0_7 , upvalues : _ENV, TaskEnum
    local sortTab = {}
    for k, v in pairs(self.__taskItems) do (table.insert)(sortTab, v) end
    (table.sort)(sortTab, function(a, b)
        -- function num : 0_7_0 , upvalues : TaskEnum
        if a.id >= b.id then
            do return a.state ~= b.state end
            if a.state == (TaskEnum.eTaskState).Completed then
                return true
            elseif b.state == (TaskEnum.eTaskState).Completed then
                return false
            elseif a.state == (TaskEnum.eTaskState).InProgress then
                return true
            elseif b.state == (TaskEnum.eTaskState).InProgress then
                return false
            end
            -- DECOMPILER ERROR: 6 unprocessed JMP targets
        end
    end)
    for k, v in ipairs(sortTab) do (v.transform):SetAsLastSibling() end
end

UISectorTask.OnTaskUpdate = function(self, taskData)
    -- function num : 0_8
    if (taskData.stcData).type ~= self.type then return end
    local taskItem = (self.__taskItems)[taskData.id]
    if taskItem == nil then
        taskItem = self:__GetTaskItem() -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (self.__taskItems)[taskData.id] = taskItem
    end
    taskItem:InitSectorTaskItem(taskData, taskData.stcData)
    self:__SortTask()
end

UISectorTask.OnTaskDelete = function(self, id)
    -- function num : 0_9 , upvalues : _ENV
    local taskItem = (self.__taskItems)[id]
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

    if taskItem ~= nil then
        (self.__taskItems)[id] = nil
        taskItem:Hide();
        (table.insert)(self.__taskItemPool, taskItem)
        self:__SortTask()
    end
end

UISectorTask.OnTaskCommit = function(self, taskCfg)
    -- function num : 0_10 , upvalues : _ENV
    self:__ShowRewardItems(taskCfg)
    self:OnSectorAchivUpdate(self.sectorId,
                             (PlayerDataCenter.sectorDatas)[self.sectorId])
end

UISectorTask.__OnClickTask = function(self, data)
    -- function num : 0_11 , upvalues : _ENV, cs_MessageCommon
    local completeTask = true
    for k, v in pairs(data.steps) do
        if v.schedule < v.aim then
            completeTask = false
            break
        end
    end
    do
        if completeTask then
            (self.taskNetworkCtrl):SendCommitQuest(data)
        else

            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.SectorTask_TaskUndone))
        end
    end
end

UISectorTask.OnSectorAchivUpdate = function(self, sectorId, sectorData)
    -- function num : 0_12 , upvalues : _ENV, UISectorAchivItem, SectorEnum
    if sectorId ~= self.sectorId then return end
    local completed = sectorData.completed
    local boxPicked = sectorData.boxPicked
    if #self.achivCfg == 0 or #((self.achivCfg)[1]).conditionIds == 0 then
        return
    end
    local starId = (((self.achivCfg)[1]).conditionIds)[1]
    local starCount = PlayerDataCenter:GetItemCount(starId);
    ((self.ui).currentCount):SetIndex(0, tostring(starCount))
    local starTotalCount = (((self.achivCfg)[#self.achivCfg]).conditionNums)[1]
    local progress = starCount / starTotalCount -- DECOMPILER ERROR at PC42: Confused about usage of register: R9 in 'UnsetPending'
    ;
    ((self.ui).achivProgressFill).fillAmount = progress -- DECOMPILER ERROR at PC45: Confused about usage of register: R9 in 'UnsetPending'
    ;
    ((self.ui).img_ProgressFill).fillAmount = progress;
    ((self.ui).tex_Progress):SetIndex(0, tostring(starCount),
                                      tostring(starTotalCount))
    for i = 1, #self.achivCfg do
        local achivCfg = (self.achivCfg)[i]
        local achivItem = (self.__achivItems)[achivCfg.id]
        do
            if achivItem == nil then
                local go = ((self.ui).treasureItem):Instantiate()
                go:SetActive(true)
                achivItem = (UISectorAchivItem.Create)(go)
                achivItem:InitSectorAchivItem(achivCfg)
                achivItem.OnClickEvent =
                    BindCallback(self, self.__OnClickAchivItem) -- DECOMPILER ERROR at PC90: Confused about usage of register: R16 in 'UnsetPending'
                ;
                (self.__achivItems)[achivCfg.id] = achivItem
            end
            do
                local state = nil
                if boxPicked ~= nil and boxPicked[i] ~= nil then
                    state = (SectorEnum.eSectorAchivState).Picked
                else
                    if ((PlayerDataCenter.sectorDatas).CheckAchivCondition)(
                        achivCfg) then
                        state = (SectorEnum.eSectorAchivState).Completed
                    else
                        state = (SectorEnum.eSectorAchivState).Normal
                    end
                end
                achivItem:UpdateSectorAchivItem(state)
                -- DECOMPILER ERROR at PC115: LeaveBlock: unexpected jumping out DO_STMT

            end
        end
    end
    if completed == nil then return end
    local needSort = false
    for taskId, v in pairs(completed) do
        local taskItem = (self.__taskItems)[taskId]
        if taskItem == nil then
            taskItem = self:__GetTaskItem() -- DECOMPILER ERROR at PC132: Confused about usage of register: R16 in 'UnsetPending'
            ;
            (self.__taskItems)[taskId] = taskItem
            local stcData = (ConfigData.task)[taskId]
            taskItem:InitSectorTaskItem(nil, stcData)
            needSort = true
        end
    end
    if needSort then self:__SortTask() end
end

UISectorTask.__OnClickAchivItem = function(self, id)
    -- function num : 0_13 , upvalues : _ENV, SectorEnum, cs_MessageCommon
    local achivItem = (self.__achivItems)[id]
    if achivItem == nil then
        print("warning: UISectorTask:__OnClickAchivItem, achivItem == nil ")
        return
    end
    if achivItem.state == (SectorEnum.eSectorAchivState).Normal then
        local achivCfg = (self.achivCfg)[id]
        local msg = ConfigData:GetTipContent(
                        TipContent.SectorTask_CanObtainReward)
        for i = 1, #achivCfg.achivRewardIds do
            local rewardId = (achivCfg.achivRewardIds)[i]
            local rewardNum = (achivCfg.achivRewardNums)[i]
            local item = (ConfigData.item)[rewardId]
            msg = msg .. "\n" .. (LanguageUtil.GetLocaleText)(item.name) ..
                      " x " .. tostring(rewardNum)
        end
        (cs_MessageCommon.ShowMessageBox)(msg)
    else
        do
            if achivItem.state == (SectorEnum.eSectorAchivState).Completed then
                (self.sectorNetworkCtrl):SendPickReward(self.sectorId, id)
            else
                if achivItem.state == (SectorEnum.eSectorAchivState).Picked then
                    (cs_MessageCommon.ShowMessageTips)(
                        ConfigData:GetTipContent(
                            TipContent.SectorTask_ObtainedReward))
                end
            end
        end
    end
end

UISectorTask.OnPickedAchivItem = function(self, sectorId, id)
    -- function num : 0_14 , upvalues : _ENV
    if sectorId ~= self.sectorId then return end
    local achivCfg = (self.achivCfg)[id]
    local rewardIds = {}
    local rewardNums = {}
    for i = 1, #achivCfg.achivRewardIds do
        local rewardId = (achivCfg.achivRewardIds)[i]
        local rewardNum = (achivCfg.achivRewardNums)[i]
        local item = (ConfigData.item)[rewardId];
        (table.insert)(rewardIds, (achivCfg.achivRewardIds)[i]);
        (table.insert)(rewardNums, (achivCfg.achivRewardNums)[i])
    end
    self:OnSectorAchivUpdate(sectorId, (PlayerDataCenter.sectorDatas)[sectorId])
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        -- function num : 0_14_0 , upvalues : rewardIds, rewardNums
        if window == nil then return end
        window:InitRewardsItem(rewardIds, rewardNums)
    end)
end

UISectorTask.__OnClickClose = function(self)
    -- function num : 0_15
    self:Hide()
end

UISectorTask.__ShowRewardItems = function(self, taskCfg, isPreview)
    -- function num : 0_16 , upvalues : _ENV
    local rewardIds = {}
    local rewardNums = {}
    for i = 1, #taskCfg.rewardIds do
        (table.insert)(rewardIds, (taskCfg.rewardIds)[i]);
        (table.insert)(rewardNums, (taskCfg.rewardNums)[i])
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        -- function num : 0_16_0 , upvalues : rewardIds, rewardNums
        if window == nil then return end
        window:InitRewardsItem(rewardIds, rewardNums)
    end)
end

UISectorTask.__RecycleShowRewardItems = function(self)
    -- function num : 0_17 , upvalues : _ENV
    for k, v in pairs(self.__rewardItems) do
        v:Hide();
        (table.insert)(self.__rewardItemPool, v)
    end
    self.__rewardItems = {}
end

UISectorTask.__OnClickCloseShowReward = function(self)
    -- function num : 0_18
    ((self.ui).showReward):SetActive(false)
end

UISectorTask.OnDelete = function(self)
    -- function num : 0_19 , upvalues : _ENV, base
    for k, v in ipairs(self.__taskItemPool) do v:OnDelete() end
    self.__taskItemPool = {}
    for k, v in pairs(self.__taskItems) do v:OnDelete() end
    self.__taskItems = {}
    for k, v in ipairs(self.__rewardItemPool) do v:Delete() end
    self.__rewardItemPool = {}
    for k, v in pairs(self.__rewardItems) do v:Delete() end
    self.__rewardItems = {};
    (base.OnDelete)(self)
end

return UISectorTask

