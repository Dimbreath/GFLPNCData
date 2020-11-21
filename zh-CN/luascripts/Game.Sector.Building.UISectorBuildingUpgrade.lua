-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorBuildingUpgrade = class("UISectorBuildingUpgrade", UIBaseWindow)
local base = UIBaseWindow
local ResNeedItem = require("Game.Oasis.UI.UIOasisResNeedItem")
local cs_MessageCommon = CS.MessageCommon
local logicIndex1 = 1
local logicIndex2 = 2
UISectorBuildingUpgrade.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.ConfirmEvent = nil
    self.CancelEvent = nil
    self.CloseEvent = nil;
    ((self.ui).resItemPrefab):SetActive(false);
    (UIUtil.AddButtonListener)((self.ui).btn_Construct, self,
                               self.OnClickConfirmButton);
    (UIUtil.AddButtonListener)((self.ui).closeConstruct, self,
                               self.OnClickCloseButton);
    (UIUtil.AddButtonListener)((self.ui).closeUpgrade, self,
                               self.OnClickCloseButton);
    (UIUtil.AddButtonListener)((self.ui).cancelUpgrade, self,
                               self.OnClickCancelButton)
    self.resNeedItems = {}
    self.__UpdateProcessEvent = BindCallback(self, self.UpdateProcessEvent)
    MsgCenter:AddListener(eMsgEventId.UpdateBuildingProcess,
                          self.__UpdateProcessEvent)
end

UISectorBuildingUpgrade.Update = function(self, timestamp, isSecond)
    -- function num : 0_1
    if not self.active then return end
    if self.__forceUpdateProcess then
        self.__forceUpdateProcess = false
        self:__ForceUpdateProcess(timestamp)
    end
end

UISectorBuildingUpgrade.__ForceUpdateProcess =
    function(self, timestamp)
        -- function num : 0_2 , upvalues : _ENV
        local progress, remainSecond = (self.buildingData):GetProcess(timestamp)
        local remainTimeText = TimestampToTime(remainSecond)
        self:UpdateProcessEvent((self.buildingData).id, progress, remainTimeText)
    end

UISectorBuildingUpgrade.UpdateProcessEvent =
    function(self, id, progress, remainTimeText, waitConfimOver)
        -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
        if id ~= (self.buildingData).id or not self.active then return end
        if waitConfimOver then
            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.Sector_BuildingConfirmFinish))
            self:OnClickCloseButton()
        end -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'
        
        ((self.ui).img_Process).fillAmount = progress;
        ((self.ui).tex_Process):SetIndex(0,
                                         tostring((math.floor)(progress * 100)))
        local color = (Color.Lerp)((self.ui).fillLeftColor,
                                   (self.ui).fillRightColor, progress) -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'
        ;
        ((self.ui).img_Process).color = color;
        ((self.ui).tex_RemainTime):SetIndex(0, remainTimeText)
    end

UISectorBuildingUpgrade.RefreshUpgrade =
    function(self, buildingData, isUnbuilt)
        -- function num : 0_4 , upvalues : _ENV
        self.buildingData = buildingData
        if isUnbuilt then
            ((self.ui).confirm_Text):SetIndex(0)
            self:__ShowPage(false)
            self:__UpdateUpgradePage(buildingData, 1);
            ((self.ui).tex_BulidLevel):SetIndex(2);
            ((self.ui).tex_InfoSdate):SetIndex(2)
        else
            if buildingData.state ==
                proto_object_BuildingState.BuildingStateNormal then
                ((self.ui).confirm_Text):SetIndex(1)
                self:__ShowPage(false)
                self:__UpdateUpgradePage(buildingData, buildingData.level + 1)
                if buildingData.level < buildingData.maxLevel then
                    ((self.ui).tex_BulidLevel):SetIndex(1, tostring(
                                                            buildingData.level));
                    ((self.ui).tex_InfoSdate):SetIndex(1)
                else

                    ((self.ui).tex_BulidLevel):SetIndex(3);
                    ((self.ui).tex_InfoSdate):SetIndex(3)
                end
            else
                self:__ShowPage(true)
                self.__forceUpdateProcess = true
            end
        end
        self:__UpdateLogic(isUnbuilt)
    end

UISectorBuildingUpgrade.__ShowPage = function(self, isUpgrading)
    -- function num : 0_5
    ((self.ui).upgradePage):SetActive(not isUpgrading);
    ((self.ui).upgradingPage):SetActive(isUpgrading)
end

UISectorBuildingUpgrade.__UpdateUpgradePage =
    function(self, buildingData, level)
        -- function num : 0_6 , upvalues : _ENV
        -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

        ((self.ui).tex_BulidName).text =
            (LanguageUtil.GetLocaleText)((buildingData.stcData).name)
        local levelCfg = (buildingData.levelConfig)[level]
        local resNeedItemIndex = 0
        for i = 1, #levelCfg.pre_para1 do
            local buildingId = (levelCfg.pre_para1)[i]
            local stcData = (ConfigData.building)[buildingId]
            if stcData == nil then
                error("找不到建筑ID:" .. tostring(buildingId))
            end
            local name = (LanguageUtil.GetLocaleText)(stcData.name)
            local needLevel = (levelCfg.pre_para2)[i]
            local currentLevel = 0
            for k, v in pairs((PlayerDataCenter.AllBuildingData).built) do
                if v.id == buildingId then
                    currentLevel = v.level
                    break
                end
            end
            do
                resNeedItemIndex = resNeedItemIndex + 1
                do
                    local resItem = (self.resNeedItems)[resNeedItemIndex]
                    if resItem == nil then
                        resItem = self:__GetResNeedItem(resNeedItemIndex)
                    end
                    resItem:Show()
                    resItem:UpdateUI(name, currentLevel, needLevel, true)
                    -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out DO_STMT

                end
            end
        end
        for i = 1, #levelCfg.consumeIds do
            local resId = (levelCfg.consumeIds)[i]
            local resCount = (levelCfg.consumeNums)[i]
            local count = PlayerDataCenter:GetItemCount(resId)
            local itemCfg = (ConfigData.item)[resId]
            local name = nil
            if itemCfg == nil then
                error("item cfg is null,id:" .. tostring(resId))
                name = ""
            else
                name = (LanguageUtil.GetLocaleText)(itemCfg.name)
            end
            resNeedItemIndex = resNeedItemIndex + 1
            local resItem = (self.resNeedItems)[resNeedItemIndex]
            if resItem == nil then
                resItem = self:__GetResNeedItem(resNeedItemIndex)
            end
            resItem:Show()
            resItem:UpdateUI(name, count, resCount)
        end
        for i = resNeedItemIndex + 1, #self.resNeedItems do
            ((self.resNeedItems)[i]):Hide()
        end
        local totalTime = (math.ceil)(levelCfg.time /
                                          (1 +
                                              (PlayerDataCenter.playerBonus):GetBuildSpeed() /
                                              1000))
        local needTime = TimestampToTime(totalTime);
        ((self.ui).tex_NeedTime):SetIndex(0, needTime)
    end

UISectorBuildingUpgrade.__UpdateLogic = function(self, isUnbuilt)
    -- function num : 0_7 , upvalues : logicIndex1, _ENV
    local buildingData = self.buildingData
    local levelCfg, nextLevelCfg = nil, nil
    if isUnbuilt then
        levelCfg = (buildingData.levelConfig)[1]
    else
        levelCfg = (buildingData.levelConfig)[buildingData.level]
        if buildingData.level < buildingData.maxLevel then
            nextLevelCfg = (buildingData.levelConfig)[buildingData.level + 1]
        end
    end
    if #levelCfg.logic == 0 then return end
    local logic = (levelCfg.logic)[logicIndex1]
    if logic == eBuildingLogic.ResourceOutput then
        local id = (levelCfg.para1)[logicIndex1]
        local itemCfg = (ConfigData.item)[id]
        if itemCfg == nil then
            error("item cfg is null,id=" .. tostring(id))
            return
        end
        local output = (math.floor)((levelCfg.para2)[logicIndex1] * 36)
        local outputStr = tostring(output) .. "/小时";
        ((self.ui).tex_Info):SetIndex(1, (LanguageUtil.GetLocaleText)(
                                          itemCfg.name))
        if isUnbuilt then
            local originOutputStr = "0/小时";
            ((self.ui).tex_InfoNum):SetIndex(1, originOutputStr, outputStr)
        else
            do
                if nextLevelCfg ~= nil and #nextLevelCfg.logic > 0 then
                    local nextOutput = (math.floor)(
                                           (nextLevelCfg.para2)[logicIndex1] *
                                               36)
                    local nextOutputStr = tostring(nextOutput) .. "/小时";
                    ((self.ui).tex_InfoNum):SetIndex(1, outputStr, nextOutputStr)
                else
                    do
                        do

                            ((self.ui).tex_InfoNum):SetIndex(3, outputStr)
                            if logic == eBuildingLogic.CampBuff then
                                local campId = (levelCfg.para1)[logicIndex1]
                                local attrId = (levelCfg.para2)[logicIndex1]
                                local attibuteCfg =
                                    (ConfigData.attribute)[attrId]
                                if attibuteCfg == nil then
                                    error(
                                        "Can\'t find attibuteCfg, id = " ..
                                            tostring(attrId))
                                    return
                                end
                                local attrName =
                                    (LanguageUtil.GetLocaleText)(
                                        attibuteCfg.name)
                                local isRatio = attibuteCfg.num_type == 2
                                local campCfg = (ConfigData.camp)[campId]
                                if campCfg == nil then
                                    error(
                                        "can\'t find camp, id=" ..
                                            tostring(campId))
                                    return
                                end
                                ((self.ui).tex_Info):SetIndex(2,
                                                              (LanguageUtil.GetLocaleText)(
                                                                  campCfg.name),
                                                              attrName)
                                self:__SetTextInfoNum(isUnbuilt, isRatio,
                                                      levelCfg, nextLevelCfg)
                            elseif logic == eBuildingLogic.CareerBuff then
                                local careerId = (levelCfg.para1)[logicIndex1]
                                local attrId = (levelCfg.para2)[logicIndex1]
                                local attibuteCfg =
                                    (ConfigData.attribute)[attrId]
                                if attibuteCfg == nil then
                                    error(
                                        "Can\'t find attibuteCfg, id = " ..
                                            tostring(attrId))
                                    return
                                end
                                local attrName =
                                    (LanguageUtil.GetLocaleText)(
                                        attibuteCfg.name)
                                local isRatio = attibuteCfg.num_type == 2
                                local careerCfg = (ConfigData.career)[careerId]
                                if careerCfg == nil then
                                    error(
                                        "can\'t find career, id=" ..
                                            tostring(careerId))
                                    return
                                end
                                ((self.ui).tex_Info):SetIndex(3,
                                                              (LanguageUtil.GetLocaleText)(
                                                                  careerCfg.name),
                                                              attrName)
                                self:__SetTextInfoNum(isUnbuilt, isRatio,
                                                      levelCfg, nextLevelCfg)
                            elseif logic == eBuildingLogic.AllHeroBuff then
                                local attrId = (levelCfg.para1)[logicIndex1]
                                local value = (levelCfg.para2)[logicIndex1]
                                local attrName, valueDes =
                                    ConfigData:GetAttribute(attrId, value);
                                ((self.ui).tex_Info):SetIndex(4, attrName)
                                if isUnbuilt then
                                    local originOutputStr = "0";
                                    ((self.ui).tex_InfoNum):SetIndex(1,
                                                                     originOutputStr,
                                                                     valueDes)
                                elseif nextLevelCfg ~= nil and
                                    #nextLevelCfg.logic > 0 then
                                    local newxtValue =
                                        (nextLevelCfg.para2)[logicIndex1]
                                    local _, nextValueDes =
                                        ConfigData:GetAttribute(attrId,
                                                                newxtValue);
                                    ((self.ui).tex_InfoNum):SetIndex(1,
                                                                     valueDes,
                                                                     nextValueDes)
                                else
                                    ((self.ui).tex_InfoNum):SetIndex(3, valueDes)
                                end
                            end
                            -- DECOMPILER ERROR: 10 unprocessed JMP targets
                        end
                    end
                end
            end
        end
    end
end

UISectorBuildingUpgrade.__SetTextInfoNum =
    function(self, isUnbuilt, isRatio, levelCfg, nextLevelCfg)
        -- function num : 0_8 , upvalues : logicIndex1, _ENV, logicIndex2
        local count = (levelCfg.para3)[logicIndex1]
        local countStr = nil
        if isRatio then
            countStr = tostring(count / 10) .. "%"
        else
            countStr = tostring(count)
        end
        local hasAtrr2 = #levelCfg.para1 >= 2
        local countStr2, isRatio2 = nil, nil
        if hasAtrr2 then
            local attrId = (levelCfg.para2)[logicIndex2]
            local attibuteCfg = (ConfigData.attribute)[attrId]
            if attibuteCfg == nil then
                error("Can\'t find attibuteCfg, id = " .. tostring(attrId))
                return
            end
            isRatio2 = attibuteCfg.num_type == 2
            local count2 = (levelCfg.para3)[logicIndex2]
            if isRatio2 then
                countStr2 = tostring(count2 / 10) .. "%"
            else
                countStr2 = tostring(count2)
            end
        end
        if isUnbuilt then
            if hasAtrr2 then
                ((self.ui).tex_InfoNum):SetIndex(2, "0", countStr, "0",
                                                 countStr2)
            else
                ((self.ui).tex_InfoNum):SetIndex(1, "0", countStr)
            end
        elseif nextLevelCfg ~= nil and #nextLevelCfg.logic > 0 then
            local nextCount = (nextLevelCfg.para3)[logicIndex1]
            local nextCountStr = nil
            if isRatio then
                nextCountStr = tostring(nextCount / 10) .. "%"
            else
                nextCountStr = tostring(nextCount)
            end
            hasAtrr2 = #nextLevelCfg.para1 >= 2
            if hasAtrr2 then
                local attrId = (nextLevelCfg.para2)[logicIndex2]
                local attibuteCfg = (ConfigData.attribute)[attrId]
                if attibuteCfg == nil then
                    error("Can\'t find attibuteCfg, id = " .. tostring(attrId))
                    return
                end
                isRatio2 = attibuteCfg.num_type == 2
                local nextCount2 = (nextLevelCfg.para3)[logicIndex2]
                local nextCountStr2 = nil
                if isRatio2 then
                    nextCountStr2 = tostring(nextCount2 / 10) .. "%"
                else
                    nextCountStr2 = tostring(nextCount2)
                end
                if countStr2 == nil then countStr2 = "0" end
                ((self.ui).tex_InfoNum):SetIndex(2, countStr, nextCountStr,
                                                 countStr2, nextCountStr2)
            else
                ((self.ui).tex_InfoNum):SetIndex(1, countStr, nextCountStr)
            end
        elseif hasAtrr2 then
            ((self.ui).tex_InfoNum):SetIndex(4, countStr, countStr2)
        else
            ((self.ui).tex_InfoNum):SetIndex(3, countStr)
        end
        -- DECOMPILER ERROR: 19 unprocessed JMP targets
    end

UISectorBuildingUpgrade.__GetResNeedItem =
    function(self, index)
        -- function num : 0_9 , upvalues : ResNeedItem
        local go = ((self.ui).resItemPrefab):Instantiate()
        go:SetActive(true)
        local resItem = (ResNeedItem.New)()
        resItem:Init(go) -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'
        ;
        (self.resNeedItems)[index] = resItem
        return resItem
    end

UISectorBuildingUpgrade.OnClickConfirmButton =
    function(self)
        -- function num : 0_10
        if self.ConfirmEvent ~= nil then (self.ConfirmEvent)() end
    end

UISectorBuildingUpgrade.OnClickCancelButton =
    function(self)
        -- function num : 0_11
        if self.CancelEvent ~= nil then (self.CancelEvent)() end
    end

UISectorBuildingUpgrade.OnClickCloseButton =
    function(self)
        -- function num : 0_12
        if self.CloseEvent ~= nil then (self.CloseEvent)() end
    end

UISectorBuildingUpgrade.OnDelete = function(self)
    -- function num : 0_13 , upvalues : _ENV, base
    MsgCenter:RemoveListener(eMsgEventId.UpdateBuildingProcess,
                             self.__UpdateProcessEvent);
    (base.OnDelete)(self)
end

return UISectorBuildingUpgrade

