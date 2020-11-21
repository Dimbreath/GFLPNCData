-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorBuilding = class("UISectorBuilding", UIBaseWindow)
local base = UIBaseWindow
local UINSectorBuildingGroup = require(
                                   "Game.Sector.Building.UINSectorBuildingGroup")
local UpgradeCostItem = require("Game.Oasis.UI.UIOasisBuildingUpgradeCostItem")
local UINOBUAccelerateNode = require(
                                 "Game.Oasis.UI.Accelerate.UINOBUAccelerateNode")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
UISectorBuilding.OnInit = function(self)
    -- function num : 0_0 , upvalues : cs_ResLoader, _ENV
    self.resloader = (cs_ResLoader.Create)()
    self.buildingNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Building)
    self.controller = ControllerManager:GetController(
                          ControllerTypeId.SectorController)
    if self.controller ~= nil then
        (self.controller):SetUIBuildingWindow(self)
    end
    (UIUtil.AddButtonListener)((self.ui).btn_Back, self,
                               self.__OnClickReturnButton);
    ((self.ui).buildIngGroup):SetActive(false)
    self.buildingItemDic = {}
    self.__ConfirmOver = BindCallback(self, self.ConfirmOver)
    MsgCenter:AddListener(eMsgEventId.BuildingUpgradeComplete,
                          self.__ConfirmOver)
    self.__UpdateProcessEvent = BindCallback(self, self.UpdateProcessEvent)
    MsgCenter:AddListener(eMsgEventId.UpdateBuildingProcess,
                          self.__UpdateProcessEvent)
    self.__OnClickBuildingItem = BindCallback(self, self.OnClickBuildingItem)
end

UISectorBuilding.InitBuilding = function(self, buildingIdList, returnFunc,
                                         sectorCfg)
    -- function num : 0_1 , upvalues : _ENV, UINSectorBuildingGroup
    self.sectorCfg = sectorCfg
    self.buildingIdList = buildingIdList
    self.returnFunc = returnFunc;
    ((self.ui).titleText):SetIndex(0, (LanguageUtil.GetLocaleText)(
                                       (self.sectorCfg).name))
    local buildIdGroupDic = {}
    for _, id in ipairs(buildingIdList) do
        local buildCfg = (ConfigData.building)[id]
        if buildCfg == nil then
            error("Cant find buildingCfg, id = " .. tostring(id))
        else
            if buildIdGroupDic[buildCfg.type] == nil then
                buildIdGroupDic[buildCfg.type] = {}
            end
            (table.insert)(buildIdGroupDic[buildCfg.type], id)
        end
    end
    local buildIdGroupList = {}
    for k, v in pairs(buildIdGroupDic) do
        (table.insert)(buildIdGroupList, {buildType = k, buildIdList = v})
    end
    (table.sort)(buildIdGroupList, function(a, b)
        -- function num : 0_1_0
        do return a.buildType < b.buildType end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
    self.buildGroupDic = {}
    for k, v in ipairs(buildIdGroupList) do
        local buildType = v.buildType
        local buildIdList = v.buildIdList
        local buildGroup = (UINSectorBuildingGroup.New)(self)
        local go = ((self.ui).buildIngGroup):Instantiate()
        go.name = tostring(buildType)
        go:SetActive(true)
        buildGroup:Init(go)
        buildGroup:InitSctBuildGroup(buildIdList, buildType, self.resloader,
                                     self.__OnClickBuildingItem) -- DECOMPILER ERROR at PC97: Confused about usage of register: R15 in 'UnsetPending'
        ;
        (self.buildGroupDic)[buildType] = buildGroup
    end
    self:UpdateBuiltPersent()
end

UISectorBuilding.Update = function(self, timestamp, isSecond)
    -- function num : 0_2 , upvalues : _ENV
    for k, v in pairs(self.buildingItemDic) do v:Update(timestamp, isSecond) end
end

UISectorBuilding.UpdateBuiltPersent = function(self)
    -- function num : 0_3 , upvalues : _ENV
    local totalCurrentLevel = 0
    local builingMaxLevel = 0
    for _, id in ipairs(self.buildingIdList) do
        local builtData = ((PlayerDataCenter.AllBuildingData).sectorBuilt)[id]
        do
            if builtData ~= nil then
                if builtData.state ~=
                    proto_object_BuildingState.BuildingStateCreate or not 0 then
                    local level = builtData.level
                end
                totalCurrentLevel = totalCurrentLevel + level
            end
            do
                local maxLevel = ((ConfigData.buildingLevel).maxLevelDic)[id]
                builingMaxLevel = builingMaxLevel + maxLevel
                -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out DO_STMT

            end
        end
    end
    self.buildPercent = (totalCurrentLevel) / (builingMaxLevel) * 100;
    ((self.ui).tex_Rate):SetIndex(0, GetPreciseDecimalStr(self.buildPercent, 2))
end

UISectorBuilding.__UpdateAllItemUI = function(self)
    -- function num : 0_4 , upvalues : _ENV
    for k, v in pairs(self.buildingItemDic) do v:UpdateUI() end
    self:UpdateBuiltPersent()
end

UISectorBuilding.OnClickBuildingItem = function(self, id)
    -- function num : 0_5 , upvalues : cs_MessageCommon, _ENV, UINOBUAccelerateNode
    local item = (self.buildingItemDic)[id]
    self.clickedBdItem = item
    if not item.built then
        if (item.buildingData):Unlock() then
            self:__ShowUpgradeWindow()
            self:__UpgradeBuilding(item)
        else
            local textTable = item:GetSctBuildItemStateInfo();
            (cs_MessageCommon.ShowMessageTips)(textTable)
        end
    else
        do
            if (item.buildingData).maxLevel <= (item.buildingData).level then
                (cs_MessageCommon.ShowMessageTips)(
                    ConfigData:GetTipContent(TipContent.Building_LevelFull))
                return
            else
                if (item.buildingData).waitConfirmOver then
                    (self.buildingNetworkCtrl):SendBuildingConfirmOver(
                        (item.buildingData).id)
                else
                    if (item.buildingData).state ==
                        proto_object_BuildingState.BuildingStateCreate or
                        (item.buildingData).state ==
                        proto_object_BuildingState.BuildingStateUpgrade then
                        if self.accelerateNode == nil then
                            self.accelerateNode = (UINOBUAccelerateNode.New)();
                            (self.accelerateNode):Init((self.ui).accUpgraded)
                        end
                        if self.accLevel ~= nil then
                            (self.accelerateNode):UpdateWithData(self.accLevel,
                                                                 self.accLevel +
                                                                     1)
                        end
                        (self.accelerateNode):Show()
                        item.accelerateNode = self.accelerateNode;
                        (self.accelerateNode):InitAccelerateNode(
                            (item.buildingData).remainSecond,
                            BindCallback(self, self.__SendConfimAcc),
                            (item.buildingData).id, function()
                                -- function num : 0_5_0 , upvalues : self
                                ((self.ui).buildIngList):SetActive(true)
                            end);
                        ((self.ui).buildIngList):SetActive(false)
                        return
                    end
                    self:__ShowUpgradeWindow()
                    self:__UpgradeBuilding(item)
                end
            end
        end
    end
end

UISectorBuilding.__SendConfimAcc = function(self, id, cost)
    -- function num : 0_6
    (self.buildingNetworkCtrl):SendBuildingAccelerate(id, cost)
end

UISectorBuilding.__SendConfimOver = function(self, id)
    -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
    local builtData = ((PlayerDataCenter.AllBuildingData).built)[id]
    if not builtData.waitConfirmOver then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Building_Incomplete))
        return
    end
    (self.buildingNetworkCtrl):SendBuildingConfirmOver(id)
end

UISectorBuilding.ConfirmOver = function(self, id)
    -- function num : 0_8 , upvalues : _ENV
    local buildingData = ((PlayerDataCenter.AllBuildingData).built)[id]
    local buildingItem = (self.buildingItemDic)[buildingData.id]
    if buildingItem ~= nil then self:__UpdateAllItemUI() end
end

UISectorBuilding.UpdateProcessEvent = function(self, id, progress,
                                               remainTimeText, waitConfirmOver)
    -- function num : 0_9 , upvalues : _ENV
    local buildingData = ((PlayerDataCenter.AllBuildingData).built)[id]
    local buildingItem = (self.buildingItemDic)[buildingData.id]
    if buildingItem ~= nil then
        buildingItem:UpdateProgressUI(progress, remainTimeText, waitConfirmOver)
        if waitConfirmOver and self.accelerateNode ~= nil and
            (self.accelerateNode).active and (self.accelerateNode).buildingId ==
            id then (self.accelerateNode):OnClickReturn() end
    end
end

UISectorBuilding.__ShowUpgradeWindow = function(self)
    -- function num : 0_10 , upvalues : UpgradeCostItem, _ENV
    if self.upgradeWindow == nil then
        self.upgradeWindow = (UpgradeCostItem.New)();
        (self.upgradeWindow):Init((self.ui).upgraded);
        (self.upgradeWindow):InjectData(self.resloader) -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'
        ;
        (self.upgradeWindow).closeEvent =
            BindCallback(self, function()
                -- function num : 0_10_0 , upvalues : self
                ((self.ui).buildIngList):SetActive(true)
            end)
    end
    ((self.ui).buildIngList):SetActive(false)
end

UISectorBuilding.UpdateResCost = function(self, curLvl, nextLvl, nextLevelCfg,
                                          costStateIndex)
    -- function num : 0_11 , upvalues : _ENV
    if self.upgradeWindow == nil then return end
    local resNeedItems = {}
    local resNeedItemIndex = 0
    local itemDatas = self.itemDatas
    for i = 1, #nextLevelCfg.consumeIds do
        local resId = (nextLevelCfg.consumeIds)[i]
        local resCount = (nextLevelCfg.consumeNums)[i]
        local count = PlayerDataCenter:GetItemCount(resId)
        local name = (LanguageUtil.GetLocaleText)(
                         ((ConfigData.item)[resId]).name)
        resNeedItemIndex = resNeedItemIndex + 1
        resNeedItems[resNeedItemIndex] = {} -- DECOMPILER ERROR at PC31: Confused about usage of register: R16 in 'UnsetPending'
        ;
        (resNeedItems[resNeedItemIndex]).name = name -- DECOMPILER ERROR at PC33: Confused about usage of register: R16 in 'UnsetPending'
        ;
        (resNeedItems[resNeedItemIndex]).count = count -- DECOMPILER ERROR at PC35: Confused about usage of register: R16 in 'UnsetPending'
        ;
        (resNeedItems[resNeedItemIndex]).resCount = resCount -- DECOMPILER ERROR at PC37: Confused about usage of register: R16 in 'UnsetPending'
        ;
        (resNeedItems[resNeedItemIndex]).resId = resId
    end
    (table.sort)(resNeedItems, function(a, b)
        -- function num : 0_11_0
        do return a.resId < b.resId end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
    local remainTime = (math.ceil)(nextLevelCfg.time /
                                       (1 +
                                           (PlayerDataCenter.playerBonus):GetBuildSpeed() /
                                           1000));
    (self.upgradeWindow):UpdateWithData(resNeedItems,
                                        TimestampToTime(remainTime), curLvl,
                                        nextLvl);
    (self.upgradeWindow):SetState(costStateIndex)
end

UISectorBuilding.__ConstrctConfirm = function(self)
    -- function num : 0_12 , upvalues : _ENV, cs_MessageCommon
    if (PlayerDataCenter.AllBuildingData):FullSectorBuildQue() then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Building_ConstructQueueFull))
        return
    end
    if not ((self.clickedBdItem).buildingData):CanBuild() then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(
                TipContent.Building_NotFillConstructCodition))
        return
    end
    (self.buildingNetworkCtrl):SendBuildingConstruct((self.clickedBdItem).id)
end

UISectorBuilding.ConstructComplete = function(self, id)
    -- function num : 0_13 , upvalues : _ENV, cs_MessageCommon
    local buildingData = ((PlayerDataCenter.AllBuildingData).built)[id];
    (cs_MessageCommon.ShowMessageTips)((string.format)(
                                           ConfigData:GetTipContent(
                                               TipContent.Oasis_Building_StartConstruct),
                                           buildingData.name))
    local item = (self.buildingItemDic)[buildingData.id]
    item:UpdateData(buildingData, true)
    self:__UpdateAllItemUI()
end

UISectorBuilding.__UpgradeBuilding = function(self, item)
    -- function num : 0_14 , upvalues : _ENV
    local builtData = item.buildingData
    local isbuilt = item.built
    if self.upgradeWindow == nil then return end
    if not isbuilt then
        local level1Cfg = (builtData.levelConfig)[1]
        self:UpdateResCost(0, 1, level1Cfg, item.costInfoState)
        self.accLevel = 0 -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'
        ;
        (self.upgradeWindow).clickEvent =
            BindCallback(self, self.__ConstrctConfirm)
    else
        do
            do
                local nextLevelCfg =
                    (builtData.levelConfig)[builtData.level + 1]
                self:UpdateResCost(builtData.level, builtData.level + 1,
                                   nextLevelCfg, item.costInfoState)
                self.accLevel = builtData.level -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'
                ;
                (self.upgradeWindow).clickEvent =
                    BindCallback(self, self.__UpgradeConfirm) -- DECOMPILER ERROR at PC47: Confused about usage of register: R4 in 'UnsetPending'
                ;
                (((self.upgradeWindow).ui).tex_Describe).text = item.description;
                (self.upgradeWindow):SetTitle(
                    (LanguageUtil.GetLocaleText)(builtData.name));
                (self.upgradeWindow):Show()
            end
        end
    end
end

UISectorBuilding.__UpgradeConfirm = function(self)
    -- function num : 0_15 , upvalues : _ENV, cs_MessageCommon
    local builtData = (self.clickedBdItem).buildingData
    if (PlayerDataCenter.AllBuildingData):FullSectorBuildQue() then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Building_ConstructQueueFull))
        return
    end
    if not builtData:CanUpgrade() then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(
                TipContent.Building_NotFillConstructCodition))
        return
    end
    local nextLevel = builtData.level + 1
    if builtData.maxLevel < nextLevel then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Building_LevelFull))
        return
    end
    (self.buildingNetworkCtrl):SendBuildingUpgrade(builtData.id)
end

UISectorBuilding.UpgradeComplete = function(self, id)
    -- function num : 0_16 , upvalues : _ENV, cs_MessageCommon
    local builtData = ((PlayerDataCenter.AllBuildingData).built)[id];
    (cs_MessageCommon.ShowMessageTips)((string.format)(
                                           ConfigData:GetTipContent(
                                               TipContent.Oasis_Building_StartUpgrade),
                                           builtData.name))
    self:__UpdateAllItemUI()
end

UISectorBuilding.__SendCancelEvent = function(self)
    -- function num : 0_17
    (self.buildingNetworkCtrl):SendBuildingCancel((self.clickedBdItem).id)
end

UISectorBuilding.CancelComplete = function(self, id, oldState)
    -- function num : 0_18 , upvalues : _ENV
    local item = (self.buildingItemDic)[id]
    if oldState == proto_object_BuildingState.BuildingStateCreate then
        local unbuiltData = ((PlayerDataCenter.AllBuildingData).unbuilt)[id]
        item:UpdateData(unbuiltData, false)
    else
        do
            do
                if oldState == proto_object_BuildingState.BuildingStateUpgrade then
                    local builtData =
                        ((PlayerDataCenter.AllBuildingData).built)[id]
                    item:UpdateData(builtData, true)
                end
                self:__UpdateAllItemUI()
            end
        end
    end
end

UISectorBuilding.UpdateBuilding = function(self, id)
    -- function num : 0_19 , upvalues : _ENV
    local buildingData = ((PlayerDataCenter.AllBuildingData).built)[id]
    local item = (self.buildingItemDic)[buildingData.id]
    item:UpdateData(buildingData, true)
    self:__UpdateAllItemUI()
end

UISectorBuilding.__OnClickReturnButton =
    function(self)
        -- function num : 0_20
        if self.returnFunc ~= nil then (self.returnFunc)() end
    end

UISectorBuilding.AddSctBuildItem = function(self, k, UISectorBuildingItem)
    -- function num : 0_21
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

    (self.buildingItemDic)[k] = UISectorBuildingItem
end

UISectorBuilding.OnDelete = function(self)
    -- function num : 0_22 , upvalues : _ENV, base
    MsgCenter:RemoveListener(eMsgEventId.BuildingUpgradeComplete,
                             self.__ConfirmOver)
    MsgCenter:RemoveListener(eMsgEventId.UpdateBuildingProcess,
                             self.__UpdateProcessEvent)
    for k, v in pairs(self.buildGroupDic) do v:OnDelete() end
    if self.upgradeWindow ~= nil then
        (self.upgradeWindow):Delete()
        self.upgradeWindow = nil
    end
    if self.controller ~= nil then (self.controller):SetUIBuildingWindow(nil) end
    if not IsNull(self.resloader) then
        (self.resloader):Put2Pool()
        self.resloader = nil
    end
    if self.accelerateNode ~= nil then (self.accelerateNode):Delete() end
    (base.OnDelete)(self)
end

return UISectorBuilding

