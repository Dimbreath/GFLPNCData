-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAchievement = class("UIAchievement", UIBaseWindow)
local base = UIBaseWindow
local UICommonItem = require("Game.CommonUI.Item.UICommonItem")
local UIAchivLevelRewardPage = require(
                                   "Game.Achievement.LevelRewardPage.UIAchivLevelRewardPage")
local UIAchivTypeToggle = require("Game.Achievement.UIAchivTypeToggle")
local UIAchivUnitItem = require("Game.Achievement.UIAchivUnitItem")
local UIAchivInfoNode = require("Game.Achievement.AchivInfo.UIAchivInfoNode")
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
UIAchievement.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UICommonItem, UIAchivTypeToggle, UIAchivUnitItem, cs_ResLoader
    ((self.ui).levelRewardItem):SetActive(false);
    ((self.ui).uI_LevelRewardPage):SetActive(false);
    ((self.ui).uI_AchievementInfo):SetActive(false);
    ((self.ui).tog_PageType):SetActive(false);
    ((self.ui).achievementUnitItem):SetActive(false);
    (UIUtil.AddButtonListener)((self.ui).btn_LevelReward, self,
                               self.OnClickAllLevelReward);
    (UIUtil.AddButtonListener)((self.ui).btn_AchieventIcon, self,
                               self.OnClickAchivInfo)
    self.levelRewardItemPool = (UIItemPool.New)(UICommonItem,
                                                (self.ui).levelRewardItem)
    self.achivTypeTogglePool = (UIItemPool.New)(UIAchivTypeToggle,
                                                (self.ui).tog_PageType)
    self.achivItemPool = (UIItemPool.New)(UIAchivUnitItem,
                                          (self.ui).achievementUnitItem)
    self.taskNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Task)
    self.resLoader = (cs_ResLoader.Create)()
    self.__OnTaskUpdate = BindCallback(self, self.OnTaskUpdate)
    self.__OnTaskDelete = BindCallback(self, self.OnTaskDelete)
    self.__OnTaskCommit = BindCallback(self, self.OnTaskCommit)
    self.__onUpdatePlayerLevel = BindCallback(self, self.__UpdateLevelUI)
    self.__onTaskPicked = BindCallback(self, self.OnTaskPicked)
    MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
    MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
    MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
    MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel,
                          self.__onUpdatePlayerLevel)
    MsgCenter:AddListener(eMsgEventId.UpdatePickedAchivTask, self.__onTaskPicked)
    self.uiTopStatus = UIManager:ShowWindow(UIWindowTypeID.TopStatus);
    (self.uiTopStatus):AddReturnEvent(BindCallback(self, self.Delete))
    self:__UpdateLevelUI()
    self.curAchivItemDic = {}
    self:__UpdateAchivUI()
    self:__InitAchievementRedDot()
end

UIAchievement.__InitAchievementRedDot = function(self)
    -- function num : 0_1 , upvalues : _ENV
    self.__onAchivTaskRedDotEvent = function(node)
        -- function num : 0_1_0 , upvalues : self
        local taskType = node.nodeId
        local toggle = (self.achivTypeToggleDic)[taskType]
        if node:GetRedDotCount() <= 0 then
            toggle:ShowAchivTypeToggleRedDot(toggle == nil)
            -- DECOMPILER ERROR: 2 unprocessed JMP targets
        end
    end

    RedDotController:AddListener(RedDotDynPath.AchivTaskPagePath,
                                 self.__onAchivTaskRedDotEvent)
    local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main,
                                                    RedDotStaticTypeId.AchivLevel,
                                                    RedDotStaticTypeId.AchivLevelReward)
    if node:GetRedDotCount() <= 0 then
        ((self.ui).redDotLevelReward):SetActive(not ok)
        self.__onLevelRewardRedDotEvent =
            function(node)
                -- function num : 0_1_1 , upvalues : self
                ((self.ui).redDotLevelReward):SetActive(
                    node:GetRedDotCount() > 0)
                -- DECOMPILER ERROR: 1 unprocessed JMP targets
            end

        RedDotController:AddListener(RedDotDynPath.AchivLevelReward,
                                     self.__onLevelRewardRedDotEvent)
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
end

UIAchievement.__UpdatePageToggleRedDot =
    function(self)
        -- function num : 0_2 , upvalues : _ENV
        for taskType, v in pairs(self.achivTypeToggleDic) do
            local ok, node = RedDotController:GetRedDotNode(
                                 RedDotStaticTypeId.Main,
                                 RedDotStaticTypeId.AchivLevel,
                                 RedDotStaticTypeId.AchivLevelPage, taskType)
            if node:GetRedDotCount() <= 0 then
                do
                    v:ShowAchivTypeToggleRedDot(not ok)
                    -- DECOMPILER ERROR at PC24: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC24: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end

UIAchievement.__UpdateLevelUI = function(self)
    -- function num : 0_3 , upvalues : _ENV
    local maxLevel = (ConfigData.game_config).playerMaxLevel
    local curLevel = (PlayerDataCenter.playerLevel).level;
    ((self.ui).tex_Level):SetIndex(0, tostring(curLevel))
    local levelCfg = (ConfigData.achievement_level)[curLevel]
    if levelCfg == nil then
        error("Can\'t find achievement_level, level = " .. tostring(curLevel))
    else
        local path = PathConsts:GetAchivLevelIconPath(levelCfg.icon)
        local icon = (self.resLoader):LoadABAsset(path) -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'
        ;
        ((self.ui).level_Icon).texture = icon
    end
    do
        if maxLevel <= curLevel then
            ((self.ui).tex_Process):SetIndex(1) -- DECOMPILER ERROR at PC47: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((self.ui).exp_Fill).fillAmount = 1
        else
            local exp = (PlayerDataCenter.playerLevel).exp
            local expCeiling = (PlayerDataCenter.playerLevel):GetNextLevelExp();
            ((self.ui).tex_Process):SetIndex(0, tostring(exp),
                                             tostring(expCeiling)) -- DECOMPILER ERROR at PC70: Confused about usage of register: R6 in 'UnsetPending'
            ;
            ((self.ui).exp_Fill).fillAmount = exp / expCeiling
        end
        do

            (self.levelRewardItemPool):HideAll()
            -- DECOMPILER ERROR at PC79: Confused about usage of register: R4 in 'UnsetPending'

            if maxLevel <= curLevel then
                (((self.ui).tex_Conditions).text).text = ""
            else
                local nextLevel = curLevel + 1
                local nextLevelCfg = (ConfigData.achievement_level)[nextLevel]
                if nextLevelCfg ~= nil then
                    ((self.ui).tex_Conditions):SetIndex(0, tostring(nextLevel))
                    for k, id in ipairs(nextLevelCfg.rewardIds) do
                        local num = (nextLevelCfg.rewardNums)[k]
                        local itemCfg = (ConfigData.item)[id]
                        local rewardItem = (self.levelRewardItemPool):GetOne()
                        rewardItem:InitItem(itemCfg, num)
                        rewardItem:ParentWindowType(UIWindowTypeID.Achievement)
                    end
                end
            end
        end
    end
end

UIAchievement.__UpdateAchivUI = function(self)
    -- function num : 0_4 , upvalues : _ENV
    (self.achivTypeTogglePool):HideAll()
    self.achivTypeToggleDic = {}
    for k, v in ipairs(ConfigData.achievement) do
        local isOn = k == 1
        local toggle = (self.achivTypeTogglePool):GetOne()
        toggle:InitAchivTypeToggle(k, v.name, isOn,
                                   BindCallback(self, self.OnAchivPageChange)) -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'
        ;
        (self.achivTypeToggleDic)[v.task_type] = toggle
    end
    self:__UpdatePageToggleRedDot()
    self.achivPageId = 1
    self:__UpdateAllAchivItem()
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIAchievement.__UpdateAllAchivItem = function(self)
    -- function num : 0_5 , upvalues : _ENV, JumpManager
    self.curAchivItemDic = {};
    (self.achivItemPool):HideAll()
    local taskTypeId = ((ConfigData.achievement)[self.achivPageId]).task_type
    local achivDatas =
        ((PlayerDataCenter.allTaskData).achievementDatas)[taskTypeId]
    if achivDatas == nil then
        error("Can\'t find achivDatas, taskTypeId=" .. tostring(taskTypeId))
        return
    end
    for k, v in ipairs(achivDatas) do
        local achivItem = (self.achivItemPool):GetOne()
        achivItem:InitAchivUnitItem(v, v.stcData, self.resLoader,
                                    BindCallback(self, self.GetAchivReward))
        achivItem:SetJump2Finish(JumpManager, self.uiTopStatus) -- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'
        ;
        (self.curAchivItemDic)[v.id] = achivItem
    end
    self:__UpdateCompletedAchiv()
    self:__SortAchivItem()
end

UIAchievement.__RefreshCompletedCount = function(self)
    -- function num : 0_6 , upvalues : _ENV
    local completedCount = 0
    for k, v in pairs((PlayerDataCenter.achivLevelData).pickedRewardAchivs) do
        completedCount = completedCount + #v
    end
    local allCount = completedCount
    for k, v in pairs(ConfigData.achievement) do
        local datas =
            ((PlayerDataCenter.allTaskData).achievementDatas)[v.task_type]
        if datas ~= nil then allCount = allCount + #datas end
    end
    ((self.ui).tex_Completed):SetIndex(0, tostring(completedCount),
                                       tostring(allCount))
end

UIAchievement.__UpdateCompletedAchiv = function(self)
    -- function num : 0_7 , upvalues : _ENV, JumpManager
    local taskTypeId = ((ConfigData.achievement)[self.achivPageId]).task_type
    local pickedAchivs =
        ((PlayerDataCenter.achivLevelData).pickedRewardAchivs)[taskTypeId]
    for k, v in pairs(pickedAchivs) do
        local achivItem = (self.curAchivItemDic)[v.taskId]
        if achivItem == nil then
            achivItem = (self.achivItemPool):GetOne() -- DECOMPILER ERROR at PC24: Confused about usage of register: R9 in 'UnsetPending'
            ;
            (self.curAchivItemDic)[v.taskId] = achivItem
            local stcData = (ConfigData.task)[v.taskId]
            achivItem:InitAchivUnitItem(nil, stcData, self.resLoader, nil,
                                        v.completedTimestamp)
            achivItem:SetJump2Finish(JumpManager, self.uiTopStatus)
        end
    end
    self:__RefreshCompletedCount()
end

UIAchievement.__SortAchivItem = function(self)
    -- function num : 0_8 , upvalues : _ENV, TaskEnum
    (table.sort)((self.achivItemPool).listItem, function(a, b)
        -- function num : 0_8_0 , upvalues : TaskEnum
        if (a.stcData).id >= (b.stcData).id then
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
    for k, v in ipairs((self.achivItemPool).listItem) do
        (v.transform):SetAsLastSibling()
    end
end

UIAchievement.OnClickAllLevelReward = function(self)
    -- function num : 0_9 , upvalues : UIAchivLevelRewardPage
    if self.levelRewardPage == nil then
        self.levelRewardPage = (UIAchivLevelRewardPage.New)();
        (self.levelRewardPage):Init((self.ui).uI_LevelRewardPage)
    end
    (self.levelRewardPage):Show();
    (self.levelRewardPage):InitAchivLevelRewardPage(self.resLoader)
end

UIAchievement.OnClickAchivInfo = function(self)
    -- function num : 0_10 , upvalues : UIAchivInfoNode
    if self.achivInfoNode == nil then
        self.achivInfoNode = (UIAchivInfoNode.New)();
        (self.achivInfoNode):Init((self.ui).uI_AchievementInfo)
    end
    (self.achivInfoNode):Show();
    (self.achivInfoNode):InitAchivInfo(self.resLoader)
end

UIAchievement.OnAchivPageChange = function(self, pageId)
    -- function num : 0_11
    self.achivPageId = pageId
    self:__UpdateAllAchivItem()
end

UIAchievement.OnTaskUpdate = function(self, taskData)
    -- function num : 0_12 , upvalues : _ENV, JumpManager
    local taskTypeId = ((ConfigData.achievement)[self.achivPageId]).task_type
    if (taskData.stcData).type ~= taskTypeId then return end
    local achivItem = (self.curAchivItemDic)[taskData.id]
    if achivItem == nil then
        achivItem = (self.achivItemPool):GetOne() -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'
        ;
        (self.curAchivItemDic)[taskData.id] = achivItem
    end
    achivItem:InitAchivUnitItem(taskData, taskData.stcData, self.resLoader,
                                BindCallback(self, self.GetAchivReward))
    achivItem:SetJump2Finish(JumpManager, self.uiTopStatus)
    self:__SortAchivItem()
end

UIAchievement.OnTaskDelete = function(self, id)
    -- function num : 0_13
    local achivItem = (self.curAchivItemDic)[id]
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

    if achivItem ~= nil then
        (self.curAchivItemDic)[id] = nil;
        (self.achivItemPool):HideOne(achivItem)
    end
end

UIAchievement.GetAchivReward = function(self, taskData)
    -- function num : 0_14 , upvalues : _ENV, cs_MessageCommon
    local completeTask = true
    for k, v in pairs(taskData.steps) do
        if v.schedule < v.aim then
            completeTask = false
            break
        end
    end
    do
        if completeTask then
            (self.taskNetworkCtrl):SendCommitQuest(taskData)
        else

            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.achievement_taskNotComplete))
        end
    end
end

UIAchievement.OnTaskCommit = function(self, taskStcData)
    -- function num : 0_15 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        -- function num : 0_15_0 , upvalues : taskStcData
        if window == nil then return end
        window:InitRewardsItem(taskStcData.rewardIds, taskStcData.rewardNums)
    end)
end

UIAchievement.OnTaskPicked = function(self)
    -- function num : 0_16
    self:__UpdateCompletedAchiv()
    self:__SortAchivItem()
end

UIAchievement.OnHide = function(self)
    -- function num : 0_17 , upvalues : _ENV, base
    local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWin ~= nil then homeWin:BackFromOtherWin() end
    (base.OnHide)(self)
end

UIAchievement.OnDelete = function(self)
    -- function num : 0_18 , upvalues : _ENV, base
    (self.uiTopStatus):Hide()
    RedDotController:RemoveListener(RedDotDynPath.AchivTaskPagePath,
                                    self.__onAchivTaskRedDotEvent)
    RedDotController:RemoveListener(RedDotDynPath.AchivLevelReward,
                                    self.__onLevelRewardRedDotEvent)
    MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
    MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
    MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
    MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel,
                             self.__onUpdatePlayerLevel)
    MsgCenter:RemoveListener(eMsgEventId.UpdatePickedAchivTask,
                             self.__onTaskPicked)
    if self.levelRewardPage ~= nil then
        (self.levelRewardPage):Delete()
        self.levelRewardPage = nil
    end
    if self.achivInfoNode ~= nil then
        (self.achivInfoNode):Delete()
        self.achivInfoNode = nil
    end
    (self.resLoader):Put2Pool()
    self.resLoader = nil;
    (self.levelRewardItemPool):DeleteAll();
    (self.achivTypeTogglePool):DeleteAll();
    (self.achivItemPool):DeleteAll();
    (base.OnDelete)(self)
end

return UIAchievement

