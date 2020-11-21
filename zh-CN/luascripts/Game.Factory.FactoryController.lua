-- params : ...
-- function num : 0 , upvalues : _ENV
local FactoryController = class("FactoryController", ControllerBase)
local base = ControllerBase
local OneCycleTime = 60
local ShutdownCycleCount = 480
local LineStopTime = CommonUtil.UInt32Max
FactoryController.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.network = NetworkManager:GetNetwork(NetworkTypeID.Factory)
    self.__onUpdateSecond = BindCallback(self, self.OnUpdateSecond)
end

local FactoryLineEntityCompare = function(lineData1, lineData2)
    -- function num : 0_1
    if lineData1.periodOver >= lineData2.periodOver then
        do return lineData1.periodOver == lineData2.periodOver end
        do return lineData1.uid < lineData2.uid end
        -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
end

local FactoryLineCompare = function(lineData1, lineData2)
    -- function num : 0_2
    do return lineData1.uid < lineData2.uid end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local RefreshLineRate = function(lineData, timestamp)
    -- function num : 0_3 , upvalues : _ENV, OneCycleTime
    if lineData.state ~= proto_object_LineState.LineStateRunning then
        lineData.cycleRate = 0
    else
        local passTime = lineData.period * OneCycleTime +
                             (math.max)(timestamp + OneCycleTime -
                                            lineData.periodOver, 0)
        lineData.cycleRate = passTime / lineData.cycleTime
    end
end

FactoryController.OnFactoryOpen = function(self)
    -- function num : 0_4 , upvalues : _ENV
    (self.network):CS_FACTORY_DETAIL()
    self.__onUpdateSecondTimer = TimerManager:GetTimer(1, self.OnUpdateSecond,
                                                       self, false, false, true);
    (self.__onUpdateSecondTimer):Start()
    self.factoryOpen = true
    self.factoryData = {
        lineCategory = nil,
        lineCount = 0,
        sortLineList = nil,
        lineDic = nil,
        resource = nil,
        finalResource = nil
    }
    self.tmpSortAgainLines = {}
end

FactoryController.OnFactoryClose = function(self)
    -- function num : 0_5
    if self.__onUpdateSecondTimer ~= nil then
        (self.__onUpdateSecondTimer):Stop()
        self.__onUpdateSecondTimer = nil
    end
    self.factoryOpen = false
    self.factoryData = nil
    self.tmpSortAgainLines = nil
end

FactoryController.RecvFactoryDetail = function(self, msg)
    -- function num : 0_6 , upvalues : _ENV
    if msg.ret ~= proto_csmsg_ErrorCode.None then
        ((CS.MessageCommon).ShowMessageTips)(
            "Network RecvFactoryDetail error,code:" .. tostring(msg.ret))
        return
    end
    if not self.factoryOpen then return end
    if msg.detail == nil then return end
    self:RefreshFactoryLineData(msg.detail)
    local uiFactory = UIManager:GetWindow(UIWindowTypeID.Factory)
    if uiFactory ~= nil then
        uiFactory:RefreshFactoryAllData((self.factoryData).lineCategory,
                                        (self.factoryData).resource,
                                        (self.factoryData).finalResource)
    end
end

FactoryController.RefreshFactoryLineData =
    function(self, detail)
        -- function num : 0_7 , upvalues : _ENV, ShutdownCycleCount, OneCycleTime, RefreshLineRate, FactoryLineCompare, FactoryLineEntityCompare
        local resource = detail.resource
        local finalReward = detail.finalReward
        local lineCount = 0
        local lineCategory = {}
        local sortLineList = {}
        local lineDic = {}
        local finalResource = {}
        for uid, v in pairs(finalReward) do
            finalResource[v.itemId] = (finalResource[v.itemId] or 0) + v.itemNum
        end
        for k, lineData in pairs(detail.running) do
            local id = lineData.id
            local factoryLine = lineCategory[id]
            if factoryLine == nil then
                local factoryCfg = (ConfigData.factory)[id]
                if factoryCfg == nil then
                    error("factory cfg is null,Id:" .. tostring(id))
                end
                local productId = factoryCfg.productId
                local itemCfg = (ConfigData.item)[productId]
                if itemCfg == nil then
                    error("item cfg is null,id:" .. tostring(productId))
                end
                local isFinalProduct = itemCfg.type ~= eItemType.FactoryRes
                factoryLine = {
                    cfg = factoryCfg,
                    cycle = factoryCfg.cycle,
                    isFinalProduct = isFinalProduct,
                    itemCfg = itemCfg,
                    count = 0,
                    lines = {}
                }
                lineCategory[id] = factoryLine
                -- DECOMPILER ERROR at PC79: Confused about usage of register: R20 in 'UnsetPending'

                if isFinalProduct then
                    (lineCategory[id]).totalCycle =
                        ShutdownCycleCount // factoryCfg.cycle
                end
            end
            local isFinalProduct = factoryLine.isFinalProduct
            do
                do
                    if isFinalProduct then
                        local finalRewardData = finalReward[lineData.uid]
                        if finalRewardData == nil then
                            lineData.total = 0
                            lineData.itemNum = 0
                        else
                            lineData.total = finalRewardData.total
                            lineData.itemNum = finalRewardData.itemNum
                        end
                    end
                    lineData.isSetCycle = lineData.presetCycle ~= 0
                    if lineData.isSetCycle and lineData.presetCycle <=
                        lineData.curCycle then
                        lineData.isSetCycle = nil
                    end -- DECOMPILER ERROR at PC112: Confused about usage of register: R17 in 'UnsetPending'
                    
                    (lineCategory[id]).count = (lineCategory[id]).count + 1;
                    (table.insert)((lineCategory[id]).lines, lineData);
                    (table.insert)(sortLineList, lineData)
                    lineDic[lineData.uid] = lineData
                    lineCount = lineCount + 1
                    lineData.cycleTime = OneCycleTime * factoryLine.cycle
                    lineData.RefreshLineRate = RefreshLineRate
                    -- DECOMPILER ERROR at PC133: LeaveBlock: unexpected jumping out DO_STMT

                end
            end
        end
        for k, factoryLine in pairs(lineCategory) do
            (table.sort)(factoryLine.lines, FactoryLineCompare)
        end
        (table.sort)(sortLineList, FactoryLineEntityCompare) -- DECOMPILER ERROR at PC152: Confused about usage of register: R9 in 'UnsetPending'
        ;
        (self.factoryData).resource = resource -- DECOMPILER ERROR at PC154: Confused about usage of register: R9 in 'UnsetPending'
        ;
        (self.factoryData).lineCount = lineCount -- DECOMPILER ERROR at PC156: Confused about usage of register: R9 in 'UnsetPending'
        ;
        (self.factoryData).sortLineList = sortLineList -- DECOMPILER ERROR at PC158: Confused about usage of register: R9 in 'UnsetPending'
        ;
        (self.factoryData).lineDic = lineDic -- DECOMPILER ERROR at PC160: Confused about usage of register: R9 in 'UnsetPending'
        ;
        (self.factoryData).lineCategory = lineCategory -- DECOMPILER ERROR at PC162: Confused about usage of register: R9 in 'UnsetPending'
        ;
        (self.factoryData).finalResource = finalResource
        -- DECOMPILER ERROR: 8 unprocessed JMP targets
    end

FactoryController.GetLineInstallAndAllCount =
    function(self)
        -- function num : 0_8 , upvalues : _ENV
        return (self.factoryData).lineCount,
               (PlayerDataCenter.playerBonus):GetFactoryPipelieCount()
    end

FactoryController.SendFactoryLineInstall =
    function(self, id, cycle)
        -- function num : 0_9 , upvalues : _ENV
        if (PlayerDataCenter.playerBonus):GetFactoryPipelieCount() <=
            (self.factoryData).lineCount then
            ((CS.MessageCommon).ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.factory_LineNumReachMax))
            return
        end
        (self.network):CS_FACTORY_LineInstall(id, cycle)
    end

FactoryController.RecvFactoryLineInstall =
    function(self, msg)
        -- function num : 0_10 , upvalues : _ENV
        if msg.ret ~= proto_csmsg_ErrorCode.None then
            ((CS.MessageCommon).ShowMessageTips)(
                "Network RecvFactoryLineInstall error,code:" ..
                    tostring(msg.ret))
            return
        end
        if not self.factoryOpen then return end
        if msg.detail == nil then return end
        self:RefreshFactoryLineData(msg.detail)
        local uiFactory = UIManager:GetWindow(UIWindowTypeID.Factory)
        if uiFactory ~= nil then
            uiFactory:RefreshFactoryAllData((self.factoryData).lineCategory,
                                            (self.factoryData).resource,
                                            (self.factoryData).finalResource)
        end
    end

FactoryController.SendFactoryLineDestruct =
    function(self, id)
        -- function num : 0_11 , upvalues : _ENV
        if self.factoryData == nil or (self.factoryData).lineCategory == nil then
            return
        end
        local factoryLine = ((self.factoryData).lineCategory)[id]
        if factoryLine == nil or #factoryLine.lines == 0 then return end
        local lineData = (factoryLine.lines)[1]
        for k, v in ipairs(factoryLine.lines) do
            if v.period < lineData.period or v.period == lineData.period and
                lineData.periodOver < v.periodOver then lineData = v end
        end
        (self.network):CS_FACTORY_LineDestruct(lineData.uid)
    end

FactoryController.RecvFactoryLineDestruct =
    function(self, msg)
        -- function num : 0_12 , upvalues : _ENV
        if msg.ret ~= proto_csmsg_ErrorCode.None then
            ((CS.MessageCommon).ShowMessageTips)(
                "Network RecvFactoryLineDestruct error,code:" ..
                    tostring(msg.ret))
            return
        end
        if not self.factoryOpen then return end
        if not self.factoryOpen then return end
        if msg.detail == nil then return end
        self:RefreshFactoryLineData(msg.detail)
        local uiFactory = UIManager:GetWindow(UIWindowTypeID.Factory)
        if uiFactory ~= nil then
            uiFactory:RefreshFactoryAllData((self.factoryData).lineCategory,
                                            (self.factoryData).resource,
                                            (self.factoryData).finalResource)
        end
    end

FactoryController.SendFactoryRewardPick =
    function(self, id)
        -- function num : 0_13
        if ((self.factoryData).finalResource)[id] == nil or
            ((self.factoryData).finalResource)[id] <= 0 then return end
        (self.network):CS_FACTORY_LineFinalRewardPick(id)
    end

FactoryController.RecvFactoryRewardPick =
    function(self, msg)
        -- function num : 0_14 , upvalues : _ENV
        if msg.ret ~= proto_csmsg_ErrorCode.None then
            ((CS.MessageCommon).ShowMessageTips)(
                "Network RecvFactoryRewardPick error,code:" .. tostring(msg.ret))
            return
        end
        if not self.factoryOpen then return end
        if msg.detail == nil then return end
        self:RefreshFactoryLineData(msg.detail)
        local uiFactory = UIManager:GetWindow(UIWindowTypeID.Factory)
        if uiFactory ~= nil then
            uiFactory:RefreshFactoryAllData((self.factoryData).lineCategory,
                                            (self.factoryData).resource,
                                            (self.factoryData).finalResource)
        end
    end

FactoryController.OnUpdateSecond = function(self)
    -- function num : 0_15 , upvalues : _ENV, LineStopTime, OneCycleTime
    if not self.factoryOpen then return end
    if self.factoryData == nil then return end
    local needRefresh = false
    local hasProduct = false
    local needRefreshLine = false
    local timestamp = (math.floor)(PlayerDataCenter.timestamp)
    while 1 do
        if #(self.factoryData).sortLineList > 0 then
            local lineData = ((self.factoryData).sortLineList)[1]
            if timestamp > lineData.periodOver then
                needRefresh = true
                lineData = (table.remove)((self.factoryData).sortLineList, 1)
                local factoryLine =
                    ((self.factoryData).lineCategory)[lineData.id]
                lineData.period = lineData.period + 1
                if factoryLine.cycle <= lineData.period then
                    local productId = (factoryLine.cfg).productId
                    local productNum = (factoryLine.cfg).productNum
                    -- DECOMPILER ERROR at PC62: Confused about usage of register: R9 in 'UnsetPending'

                    if not ((self.factoryData).finalResource)[productId] then
                        do
                            ((self.factoryData).finalResource)[productId] =
                                (not factoryLine.isFinalProduct or 0) +
                                    productNum
                            lineData.itemNum = lineData.itemNum + productNum
                            lineData.total = lineData.total + 1 -- DECOMPILER ERROR at PC79: Confused about usage of register: R9 in 'UnsetPending'
                            ;
                            ((self.factoryData).resource)[productId] =
                                (((self.factoryData).resource)[productId] or 0) +
                                    productNum
                            hasProduct = true
                            lineData.period = 0
                            if factoryLine.isFinalProduct and
                                factoryLine.totalCycle <= lineData.total then
                                lineData.state =
                                    proto_object_LineState.LineStateOutputOver
                                lineData.periodOver = LineStopTime
                            else
                                if lineData.isSetCycle then
                                    lineData.curCycle = lineData.curCycle + 1
                                    if lineData.presetCycle <= lineData.curCycle then
                                        lineData.isSetCycle = nil
                                        needRefreshLine = true
                                        break
                                    end
                                end
                                local isAbleRun = true
                                for k1, consumeId in
                                    ipairs((factoryLine.cfg).consumeIds) do
                                    local consumeNum =
                                        ((factoryLine.cfg).consumeNums)[k1]
                                    if ((self.factoryData).resource)[consumeId] ==
                                        nil or
                                        ((self.factoryData).resource)[consumeId] <
                                        consumeNum then
                                        isAbleRun = false
                                        break
                                    end
                                end
                                do
                                    do
                                        do
                                            if isAbleRun and lineData.isSetCycle ~=
                                                nil then
                                                for k1, consumeId in
                                                    ipairs(
                                                        (factoryLine.cfg).consumeIds) do
                                                    local consumeNum =
                                                        ((factoryLine.cfg).consumeNums)[k1] -- DECOMPILER ERROR at PC150: Confused about usage of register: R14 in 'UnsetPending'
                                                    ;
                                                    ((self.factoryData).resource)[consumeId] =
                                                        ((self.factoryData).resource)[consumeId] -
                                                            consumeNum
                                                end
                                                lineData.periodOver =
                                                    lineData.periodOver +
                                                        OneCycleTime
                                            else
                                                lineData.state =
                                                    proto_object_LineState.LineStateInDonwTime
                                                lineData.periodOver =
                                                    LineStopTime
                                            end
                                            (table.insert)(
                                                self.tmpSortAgainLines, lineData)
                                            -- DECOMPILER ERROR at PC168: LeaveBlock: unexpected jumping out DO_STMT

                                            -- DECOMPILER ERROR at PC168: LeaveBlock: unexpected jumping out DO_STMT

                                            -- DECOMPILER ERROR at PC168: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                            -- DECOMPILER ERROR at PC168: LeaveBlock: unexpected jumping out IF_STMT

                                            -- DECOMPILER ERROR at PC168: LeaveBlock: unexpected jumping out DO_STMT

                                            -- DECOMPILER ERROR at PC168: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                            -- DECOMPILER ERROR at PC168: LeaveBlock: unexpected jumping out IF_STMT

                                            -- DECOMPILER ERROR at PC168: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                            -- DECOMPILER ERROR at PC168: LeaveBlock: unexpected jumping out IF_STMT

                                            -- DECOMPILER ERROR at PC168: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                            -- DECOMPILER ERROR at PC168: LeaveBlock: unexpected jumping out IF_STMT

                                            -- DECOMPILER ERROR at PC168: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                            -- DECOMPILER ERROR at PC168: LeaveBlock: unexpected jumping out IF_STMT

                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if needRefreshLine then
        (self.network):CS_FACTORY_DETAIL()
        return
    end
    do
        if not needRefresh then
            local uiFactory = UIManager:GetWindow(UIWindowTypeID.Factory)
            if uiFactory ~= nil then
                uiFactory:RefreshLineEntityRate((self.factoryData).lineDic)
            end
            return
        end
        if hasProduct then
            local k = 1
            while 1 do
                while 1 do
                    if k <= #(self.factoryData).sortLineList then
                        local tmpLineData = ((self.factoryData).sortLineList)[k]
                        local needSortAgain = false
                        if tmpLineData.state ==
                            proto_object_LineState.LineStateInDonwTime then
                            local tmpFactoryLine =
                                ((self.factoryData).lineCategory)[tmpLineData.id]
                            local isAbleRun = true
                            for k1, consumeId in
                                ipairs((tmpFactoryLine.cfg).consumeIds) do
                                local consumeNum =
                                    ((tmpFactoryLine.cfg).consumeNums)[k1]
                                if ((self.factoryData).resource)[consumeId] ==
                                    nil or
                                    ((self.factoryData).resource)[consumeId] <
                                    consumeNum then
                                    isAbleRun = false
                                    break
                                end
                            end
                            do
                                do
                                    if isAbleRun then
                                        needSortAgain = true
                                        for k1, consumeId in
                                            ipairs(
                                                (tmpFactoryLine.cfg).consumeIds) do
                                            local consumeNum =
                                                ((tmpFactoryLine.cfg).consumeNums)[k1] -- DECOMPILER ERROR at PC250: Confused about usage of register: R16 in 'UnsetPending'
                                            ;
                                            ((self.factoryData).resource)[consumeId] =
                                                ((self.factoryData).resource)[consumeId] -
                                                    consumeNum
                                        end
                                        tmpLineData.state =
                                            proto_object_LineState.LineStateRunning
                                        tmpLineData.periodOver =
                                            timestamp + OneCycleTime
                                    end
                                    if needSortAgain then
                                        (table.insert)(self.tmpSortAgainLines,
                                                       (table.remove)(
                                                           (self.factoryData).sortLineList,
                                                           k))
                                        -- DECOMPILER ERROR at PC271: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                        -- DECOMPILER ERROR at PC271: LeaveBlock: unexpected jumping out IF_STMT

                                        -- DECOMPILER ERROR at PC271: LeaveBlock: unexpected jumping out DO_STMT

                                        -- DECOMPILER ERROR at PC271: LeaveBlock: unexpected jumping out DO_STMT

                                        -- DECOMPILER ERROR at PC271: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                        -- DECOMPILER ERROR at PC271: LeaveBlock: unexpected jumping out IF_STMT

                                        -- DECOMPILER ERROR at PC271: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                        -- DECOMPILER ERROR at PC271: LeaveBlock: unexpected jumping out IF_STMT

                                    end
                                end
                            end
                        end
                    end
                end
                k = k + 1
            end
        end
        do
            local i = 1
            while 1 do
                if #self.tmpSortAgainLines > 0 then
                    local lineData = (table.remove)(self.tmpSortAgainLines, 1)
                    local k = 1
                    local isInsert = false
                    while 1 do
                        while 1 do
                            if k <= #(self.factoryData).sortLineList then
                                local tmpLineData =
                                    ((self.factoryData).sortLineList)[k]
                                if lineData.periodOver < tmpLineData.periodOver or
                                    lineData.periodOver ==
                                    tmpLineData.periodOver and lineData.uid <
                                    tmpLineData.uid then
                                    (table.insert)(
                                        (self.factoryData).sortLineList, k,
                                        lineData)
                                    isInsert = true
                                    -- DECOMPILER ERROR at PC315: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC315: LeaveBlock: unexpected jumping out IF_STMT

                                    -- DECOMPILER ERROR at PC315: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC315: LeaveBlock: unexpected jumping out IF_STMT

                                end
                            end
                        end
                        k = k + 1
                    end
                    do
                        do
                            if not isInsert then
                                (table.insert)((self.factoryData).sortLineList,
                                               lineData)
                            end
                            -- DECOMPILER ERROR at PC326: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC326: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC326: LeaveBlock: unexpected jumping out IF_STMT

                        end
                    end
                end
            end
            local uiFactory = UIManager:GetWindow(UIWindowTypeID.Factory)
            if uiFactory ~= nil then
                uiFactory:RefreshLineEntityAndResource(
                    (self.factoryData).lineCategory,
                    (self.factoryData).resource,
                    (self.factoryData).finalResource)
            end
        end
    end
end

FactoryController.OnDelete = function(self)
    -- function num : 0_16 , upvalues : base
    (base.OnDelete)(self)
end

return FactoryController

