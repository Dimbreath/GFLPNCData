-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFactory = class("UIFactory", UIBaseWindow)
local base = UIBaseWindow
local UINFactoryLine = require("Game.Factory.UI.UINFactoryLine")
local UINFactoryResProduceItem = require(
                                     "Game.Factory.UI.UINFactoryResProduceItem")
local UINFactoryLineEntity = require("Game.Factory.UI.UINFactoryLineEntity")
local UINFactoryRewardItem = require("Game.Factory.UI.UINFactoryRewardItem")
local HeroEnterSlot = require("Game.HeroEnter.UINHeroEnterSlotItem")
local UIHeroEnterSelect = require("Game.HeroEnter.UIHeroEnterSelect")
local UINHeroEnterBuildingBuffInfo = require(
                                         "Game.HeroEnter.UINHeroEnterBuildingBuffInfo")
local HeroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")
local UIFactorySetMaxCycleBox = require(
                                    "Game.Factory.UI.UIFactorySetMaxCycleBox")
local cs_ResLoader = CS.ResLoader
UIFactory.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINFactoryLineEntity, UINFactoryRewardItem, UIFactorySetMaxCycleBox, cs_ResLoader
    (UIUtil.AddButtonListener)((self.ui).btn_OpenFormula, self,
                               self.OnBtnOpenFactoryLine);
    (UIUtil.AddButtonListener)((self.ui).btn_CloseFormula, self,
                               self.OnBtnCloseFactoryLine);
    ((self.ui).factoryLineItemGO):SetActive(false);
    ((self.ui).resourceItemGO):SetActive(false);
    ((self.ui).rewardItemGO):SetActive(false);
    ((self.ui).lineEntityItem):SetActive(false);
    ((self.ui).tex_EmptyInfo):SetActive(false)
    self.dicFactoryLine = {}
    self.dicFactoryResItem = {}
    self.poolFactoryLineEntity = (UIItemPool.New)(UINFactoryLineEntity,
                                                  (self.ui).lineEntityItem)
    self.poolFactoryRewardItem = (UIItemPool.New)(UINFactoryRewardItem,
                                                  (self.ui).rewardItemGO)
    self.SetMaxCycleBox = (UIFactorySetMaxCycleBox.New)();
    (self.SetMaxCycleBox):Init((self.ui).setMaxCycleBox);
    (self.SetMaxCycleBox):InitSetMaxCycleBox(self)
    self.__onResProduceSelect = BindCallback(self, self.OnResProduceSelect)
    self.__onFactoryRewardClicked = BindCallback(self,
                                                 self.OnFactoryRewardClicked)
    local uiTopStatus = UIManager:ShowWindow(UIWindowTypeID.TopStatus)
    uiTopStatus:AddReturnEvent(BindCallback(self, self.Delete))
    self.ctrl = ControllerManager:GetController(ControllerTypeId.Factory, true);
    (self.ctrl):OnFactoryOpen()
    self:ShowAllFactoryRes()
    self.__resloader = (cs_ResLoader.Create)()
    local funcUnLockCrtl = ControllerManager:GetController(
                               ControllerTypeId.FunctionUnlock, true)
    local isStaffInfoUnlock = not funcUnLockCrtl:ValidateUnlock(
                                  proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter) or
                                  (((PlayerDataCenter.AllBuildingData).oasisBuilt)[eBuildingId.OasisFactory] ~=
                                      nil and
                                      (((PlayerDataCenter.AllBuildingData).oasisBuilt)[eBuildingId.OasisFactory]).state ~=
                                      proto_object_BuildingState.BuildingStateCreate)
    self:OnStaffInfoUnlock(isStaffInfoUnlock)
    self.__UpdateStaffInfo = BindCallback(self, self.UpdateStaffInfo)
    MsgCenter:AddListener(eMsgEventId.OnHeroEnterDataUpdate,
                          self.__UpdateStaffInfo)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIFactory.ShowAllFactoryRes = function(self)
    -- function num : 0_1 , upvalues : _ENV, UINFactoryResProduceItem
    self.allResSortList = {}
    for k, itemId in ipairs((ConfigData.factory).res_list) do
        (table.insert)(self.allResSortList, itemId)
    end
    for k, itemId in ipairs(self.allResSortList) do
        local itemCfg = (ConfigData.item)[itemId]
        if itemCfg ~= nil then
            local go = ((self.ui).resourceItemGO):Instantiate()
            go:SetActive(true)
            local resItem = (UINFactoryResProduceItem.New)()
            resItem:Init(go)
            resItem:InitResProduce(itemCfg, 0, 0, self.__onResProduceSelect) -- DECOMPILER ERROR at PC43: Confused about usage of register: R9 in 'UnsetPending'
            ;
            (self.dicFactoryResItem)[itemId] = resItem
        end
    end
end

UIFactory.ShowAllFactoryLine = function(self)
    -- function num : 0_2 , upvalues : _ENV, UINFactoryLine
    if self.lastSelectProduceItem ~= nil then
        (self.lastSelectProduceItem):SetProduceSelect(false)
    end
    for k, dataId in ipairs((ConfigData.factory).id_sort_list) do
        local factoryCfg = (ConfigData.factory)[dataId]
        local lineItem = (self.dicFactoryLine)[dataId]
        if lineItem == nil then
            local go = ((self.ui).factoryLineItemGO):Instantiate()
            go:SetActive(true)
            lineItem = (UINFactoryLine.New)()
            lineItem:Init(go)
            local isUnlock = (CheckCondition.CheckLua)(factoryCfg.pre_condition,
                                                       factoryCfg.pre_para1,
                                                       factoryCfg.pre_para2)
            lineItem:InitLineFormula(factoryCfg, isUnlock, self) -- DECOMPILER ERROR at PC45: Confused about usage of register: R10 in 'UnsetPending'
            ;
            (self.dicFactoryLine)[dataId] = lineItem;
            (lineItem.transform):SetSiblingIndex(k)
        else
            do
                lineItem:Show()
                lineItem:SetHighlightItem()
                local isUnlock = lineItem.isUnlock
                do
                    if isUnlock and ((self.ctrl).factoryData).lineCategory ~=
                        nil then
                        local lineData =
                            (((self.ctrl).factoryData).lineCategory)[dataId]
                        if lineData ~= nil then
                            lineItem:SetOpenNumber(lineData.count)
                        else
                            lineItem:SetOpenNumber(0)
                        end
                    end
                    -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
    end
end

UIFactory.OnBtnOpenFactoryLine = function(self)
    -- function num : 0_3
    ((self.ui).LineSidebarTween):DOPlayForward()
    self:ShowAllFactoryLine()
end

UIFactory.OnBtnCloseFactoryLine = function(self)
    -- function num : 0_4
    ((self.ui).LineSidebarTween):DOPlayBackwards()
end

UIFactory.SetFactoryLineMaxCycle = function(self, lineItem)
    -- function num : 0_5
    if self.SetMaxCycleBox ~= nil then
        (self.SetMaxCycleBox):ShowSetMaxCycleBox(lineItem)
    end
end

UIFactory.RequestAddOneFactoryLine = function(self, lineItem, cycle)
    -- function num : 0_6
    (self.ctrl):SendFactoryLineInstall((lineItem.factoryCfg).id, cycle)
end

UIFactory.RequestSubOneFactoryLine = function(self, lineItem)
    -- function num : 0_7
    (self.ctrl):SendFactoryLineDestruct((lineItem.factoryCfg).id)
end

UIFactory.OnResProduceSelect = function(self, resProduceItem)
    -- function num : 0_8 , upvalues : _ENV, UINFactoryLine
    if self.lastSelectProduceItem ~= nil then
        (self.lastSelectProduceItem):SetProduceSelect(false)
    end
    self.lastSelectProduceItem = resProduceItem;
    (self.lastSelectProduceItem):SetProduceSelect(true)
    local curItemId = (self.lastSelectProduceItem).id
    for k, dataId in ipairs((ConfigData.factory).id_sort_list) do
        local factoryCfg = (ConfigData.factory)[dataId]
        local isContianItem = false
        if (table.contain)(factoryCfg.consumeIds, curItemId) or
            factoryCfg.productId == curItemId then isContianItem = true end
        local lineItem = (self.dicFactoryLine)[dataId]
        if isContianItem then
            if lineItem == nil then
                local go = ((self.ui).factoryLineItemGO):Instantiate()
                go:SetActive(true)
                lineItem = (UINFactoryLine.New)()
                lineItem:Init(go)
                local isUnlock = (CheckCondition.CheckLua)(
                                     factoryCfg.pre_condition,
                                     factoryCfg.pre_para1, factoryCfg.pre_para2)
                lineItem:InitLineFormula(factoryCfg, isUnlock, self) -- DECOMPILER ERROR at PC66: Confused about usage of register: R13 in 'UnsetPending'
                ;
                (self.dicFactoryLine)[dataId] = lineItem;
                (lineItem.transform):SetSiblingIndex(k)
                local factoryLine =
                    (((self.ctrl).factoryData).lineCategory)[dataId]
                if factoryLine ~= nil then
                    lineItem:SetOpenNumber(factoryLine.count)
                else
                    lineItem:SetOpenNumber(0)
                end
            else
                do
                    do
                        lineItem:Show()
                        if lineItem ~= nil then
                            lineItem:Hide()
                        end
                        if lineItem ~= nil and lineItem.active then
                            lineItem:SetHighlightItem(curItemId)
                        end
                        -- DECOMPILER ERROR at PC100: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC100: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC100: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC100: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC100: LeaveBlock: unexpected jumping out IF_STMT

                    end
                end
            end
        end
    end
    ((self.ui).LineSidebarTween):DOPlayForward()
end

UIFactory.RefreshFactoryAllData = function(self, lineCategory, allResource,
                                           finalResource)
    -- function num : 0_9 , upvalues : _ENV
    for lineId, lineItem in pairs(self.dicFactoryLine) do
        if lineItem.isUnlock then lineItem:SetOpenNumber(0) end
    end
    local resProduce = {}
    for lineId, factoryLine in pairs(lineCategory) do
        local lineItem = (self.dicFactoryLine)[lineId]
        local factoryCfg = factoryLine.cfg
        if lineItem ~= nil then lineItem:SetOpenNumber(factoryLine.count) end
        local productId = factoryCfg.productId
        local productNum = factoryCfg.productNum
        if resProduce[productId] == nil then resProduce[productId] = 0 end
        resProduce[productId] = resProduce[productId] + productNum *
                                    factoryLine.count / factoryCfg.cycle
        for k, consumeId in ipairs(factoryCfg.consumeIds) do
            local consumeNum = (factoryCfg.consumeNums)[k]
            if resProduce[consumeId] == nil then
                resProduce[consumeId] = 0
            end
            resProduce[consumeId] = resProduce[consumeId] - consumeNum *
                                        factoryLine.count
        end
    end
    (table.sort)(self.allResSortList, function(itemId1, itemId2)
        -- function num : 0_9_0 , upvalues : resProduce
        if resProduce[itemId1] ~= nil and resProduce[itemId2] == nil then
            return true
        end
        if resProduce[itemId1] == nil and resProduce[itemId2] ~= nil then
            return false
        end
        do return itemId1 < itemId2 end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
    for k, itemId in pairs(self.allResSortList) do
        local itemStockNum = 0
        if allResource[itemId] ~= nil then
            itemStockNum = itemStockNum + allResource[itemId]
        else
            if finalResource[itemId] ~= nil then
                itemStockNum = itemStockNum + finalResource[itemId]
            end
        end
        local itemOutput = resProduce[itemId] or 0
        local resItem = (self.dicFactoryResItem)[itemId]
        if resItem ~= nil then
            resItem:RefreshResNum(itemStockNum, itemOutput)
        end
        (resItem.transform):SetSiblingIndex(k)
    end
    local installLineCount, allLineCount =
        (self.ctrl):GetLineInstallAndAllCount();
    ((self.ui).tex_FreeQueue):SetIndex(0, tostring(
                                           allLineCount - installLineCount),
                                       tostring(allLineCount))
    if installLineCount == 0 then
        ((self.ui).tex_EmptyInfo):SetActive(true)
    else

        ((self.ui).tex_EmptyInfo):SetActive(false)
    end
    self:RefreshLineEntityAndResource(lineCategory, allResource, finalResource)
end

UIFactory.RefreshLineEntityAndResource =
    function(self, lineCategory, allResource, finalResource)
        -- function num : 0_10 , upvalues : _ENV
        (self.poolFactoryLineEntity):HideAll()
        local timestamp = (math.floor)(PlayerDataCenter.timestamp)
        for id, factoryLine in pairs(lineCategory) do
            for k, lineData in ipairs(factoryLine.lines) do
                lineData:RefreshLineRate(timestamp)
                local lineEntityItem = (self.poolFactoryLineEntity):GetOne()
                local count = 0
                if factoryLine.isFinalProduct then
                    count = lineData.itemNum
                else
                    count = allResource[(factoryLine.itemCfg).id] or 0
                end
                lineEntityItem:InitFactoryLineEntity(lineData, factoryLine,
                                                     allResource, count)
            end
        end
        self:RefreshResourceCount(allResource, finalResource)
    end

UIFactory.RefreshResourceCount = function(self, allResource, finalResource)
    -- function num : 0_11 , upvalues : _ENV
    for itemId, resProduceItem in pairs(self.dicFactoryResItem) do
        local itemStockNum = 0
        if allResource[itemId] ~= nil then
            itemStockNum = itemStockNum + allResource[itemId]
        else
            if finalResource[itemId] ~= nil then
                itemStockNum = itemStockNum + finalResource[itemId]
            end
        end
        resProduceItem:RefreshStockNum(itemStockNum)
    end
    (self.poolFactoryRewardItem):HideAll()
    for itemId, ItemCount in pairs(finalResource) do
        local factoryRewardItem = (self.poolFactoryRewardItem):GetOne()
        local itemCfg = (ConfigData.item)[itemId]
        factoryRewardItem:InitFactoryRewardItem(itemCfg, ItemCount,
                                                self.__onFactoryRewardClicked)
    end
end

UIFactory.RefreshLineEntityRate = function(self)
    -- function num : 0_12 , upvalues : _ENV
    local timestamp = (math.floor)(PlayerDataCenter.timestamp)
    for k, lineEntityItem in ipairs((self.poolFactoryLineEntity).listItem) do
        local lineData = lineEntityItem.lineData
        if lineData ~= nil then
            lineData:RefreshLineRate(timestamp)
            lineEntityItem:RefreshFactoryLine()
        end
    end
end

UIFactory.OnFactoryRewardClicked = function(self, rewardItem)
    -- function num : 0_13
    (self.ctrl):SendFactoryRewardPick(rewardItem.itemId)
end

UIFactory.OnStaffInfoUnlock = function(self, active)
    -- function num : 0_14 , upvalues : _ENV, HeroEnterSlot, UINHeroEnterBuildingBuffInfo, UIHeroEnterSelect
    ((self.ui).staffInfo):SetActive(active)
    self.HeroEnterSlotPool = (UIItemPool.New)(HeroEnterSlot,
                                              (self.ui).HeroEnterSlot);
    ((self.ui).HeroEnterSlot):SetActive(false)
    self.buildingBuffPool = (UIItemPool.New)(UINHeroEnterBuildingBuffInfo,
                                             (self.ui).Item_buffItem);
    ((self.ui).Item_buffItem):SetActive(false)
    self.buildingBuffList = {}
    if active then
        (UIHeroEnterSelect.CreateBuffItems)(self, eBuildingId.OasisFactory)
        self:UpdateStaffInfo()
    end
end

UIFactory.UpdateStaffInfo = function(self)
    -- function num : 0_15 , upvalues : _ENV, HeroEnterDataUtil
    (self.HeroEnterSlotPool):HideAll()
    local slotList = {}
    local buildingData =
        ((PlayerDataCenter.AllBuildingData).built)[eBuildingId.OasisFactory]
    if buildingData == nil then
        error("无建筑数据" .. eBuildingId.OasisFactory)
        return
    end
    local allEnterData = PlayerDataCenter.allEnterData
    local level = buildingData.level
    local UnlockedSlotNum = ((buildingData.levelConfig)[level]).hero_job_slot
    local heroScoreRate = 0
    for i = 1, UnlockedSlotNum do
        do
            do
                local enterSlot = (self.HeroEnterSlotPool):GetOne(true)
                enterSlot:SetSlotClickEvent(
                    function(isUnlock, heroId)
                        -- function num : 0_15_0 , upvalues : _ENV, slotList, i
                        if isUnlock then
                            UIManager:ShowWindowAsync(UIWindowTypeID.HeroEnter,
                                                      function(window)
                                -- function num : 0_15_0_0 , upvalues : _ENV, slotList, i
                                window:InitHeroEnterSelect(nil,
                                                           eBuildingId.OasisFactory,
                                                           slotList, i)
                            end)
                        end
                    end)
                if allEnterData[eBuildingId.OasisFactory] ~= nil then
                    local heros = (table.keys)(
                                      (allEnterData[eBuildingId.OasisFactory]).data)
                    heroScoreRate = heroScoreRate +
                                        HeroEnterDataUtil:CalRateById(heros[i])
                    enterSlot:InitHeroEnterSlot(self.__resloader, true, heros[i]);
                    (table.insert)(slotList,
                                   {isUnlock = true, heroID = heros[i]})
                else
                    do
                        enterSlot:InitHeroEnterSlot(self.__resloader, true);
                        (table.insert)(slotList, {isUnlock = true})
                    end
                end
                -- DECOMPILER ERROR at PC79: LeaveBlock: unexpected jumping out DO_STMT

            end
        end
    end
    for _, Item in ipairs(self.buildingBuffList) do
        Item:SetValue(heroScoreRate)
    end
end

UIFactory.OnHide = function(self)
    -- function num : 0_16 , upvalues : _ENV, base
    local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWin ~= nil then homeWin:BackFromOtherWin() end
    (base.OnHide)(self)
end

UIFactory.OnDelete = function(self)
    -- function num : 0_17 , upvalues : _ENV, base
    UIManager:HideWindow(UIWindowTypeID.TopStatus);
    (self.ctrl):OnFactoryClose()
    MsgCenter:RemoveListener(eMsgEventId.OnHeroEnterDataUpdate,
                             self.__UpdateStaffInfo);
    (base.OnDelete)(self)
end

return UIFactory

