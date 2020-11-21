-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorBuildingItem = class("UISectorBuildingItem", UIBaseNode)
local base = UIBaseNode
local logicIndex1 = 1
local logicIndex2 = 2
local CheckerTypeId, CheckerGlobalConfig =
    (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
UISectorBuildingItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.OnClickEvent = nil;
    (UIUtil.AddButtonListener)((self.ui).button, self, self.__OnClickItem)
    self.stateBgColors = {};
    (UIUtil.LuaUIBindingTable)((self.ui).state, self.stateBgColors)
    self.costInfoState = 0
    self:__ShowProgress(false)
    self.accelerateNode = nil
    self.unlockText = {}
end

UISectorBuildingItem.InitSectorBdItem = function(self, buildingData, built,
                                                 resLoader)
    -- function num : 0_1 , upvalues : _ENV
    self.id = buildingData.id
    self.buildingData = buildingData
    self.resloader = resLoader -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = buildingData.name
    self:UpdateData(buildingData, built)
    self:UpdateUI()
    if buildingData.state == proto_object_BuildingState.BuildingStateCreate or
        buildingData.state == proto_object_BuildingState.BuildingStateUpgrade then
        self:UpdateProgressUI(buildingData.progress,
                              TimestampToTime(buildingData.remainSecond))
    end
end

UISectorBuildingItem.Update = function(self, timestamp, isSecond)
    -- function num : 0_2
    if self.accelerateNode ~= nil and (self.accelerateNode).active then
        local progress, remainSecond = (self.buildingData):GetProcess(timestamp);
        (self.accelerateNode):UpdateTime(remainSecond)
    end
end

UISectorBuildingItem.UpdateProgressUI = function(self, progress, remainTimeText,
                                                 waitConfirmOver)
    -- function num : 0_3
    if waitConfirmOver then
        self:UpdateUI()
        return
    end -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'
    
    ((self.ui).tex_RemainTime).text = remainTimeText
end

UISectorBuildingItem.UpdateData = function(self, buildingData, built)
    -- function num : 0_4
    self.built = built
    self.buildingData = buildingData
end

UISectorBuildingItem.UpdateUI = function(self)
    -- function num : 0_5 , upvalues : _ENV
    local buildingData = self.buildingData
    local canLevelUp = false
    local showProgress = false
    local upgradingPage = false;
    ((self.ui).state):SetActive(false);
    ((self.ui).img_isMax):SetActive(false);
    ((self.ui).completed):SetActive(false);
    (((self.ui).img_CanLevelUp).gameObject):SetActive(false);
    (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath(
                                          "SectorBuilding"),
                                      function(spriteAtlas)
        -- function num : 0_5_0 , upvalues : self, buildingData
        if spriteAtlas == nil then return end -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
        
        ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(
                                          buildingData.icon_res)
    end)
    if not self.built then
        ((self.ui).tex_Level):SetIndex(1);
        ((self.ui).tex_State):SetIndex(1)
        canLevelUp = buildingData:CanBuild()
        if canLevelUp then
            (((self.ui).img_CanLevelUp).gameObject):SetActive(true);
            ((self.ui).upGradeStateText):SetIndex(1)
        end
        self.costInfoState = 1
        if not buildingData:Unlock() then
            local level1Cfg = (buildingData.levelConfig)[1]
            local textIndex = 1
            self.unlockText = {}
            for k, v in ipairs(level1Cfg.pre_condition) do
                local isFulfillCondition =
                    ((CheckCondition.CheckLua)({v}, {(level1Cfg.pre_para1)[k]},
                                               {(level1Cfg.pre_para2)[k]}))
                local fillConditionText = nil
                if not isFulfillCondition then
                    fillConditionText = (CheckCondition.GetUnlockInfoLua)({v},
                                                                          {
                        (level1Cfg.pre_para1)[k]
                    }, {(level1Cfg.pre_para2)[k]})
                end
                -- DECOMPILER ERROR at PC111: Confused about usage of register: R14 in 'UnsetPending'

                if fillConditionText ~= nil then
                    (self.unlockText)[textIndex] = fillConditionText
                    textIndex = textIndex + 1
                end
            end
            ((self.ui).state):SetActive(true)
            -- DECOMPILER ERROR at PC132: Confused about usage of register: R7 in 'UnsetPending'

            if self.unlockText ~= nil and (self.unlockText)[1] ~= nil then
                (((self.ui).tex_State).text).text = (self.unlockText)[1]
            end
            self:__setStateBgColor(false)
        else
            do
                self:__setStateBgColor(true) -- DECOMPILER ERROR at PC144: Confused about usage of register: R5 in 'UnsetPending'
                ;
                ((self.ui).img_Button).color = (self.ui).lockBtnColor
                self:__setTextColor(false)
                self.costInfoState = 0 -- DECOMPILER ERROR at PC154: Confused about usage of register: R5 in 'UnsetPending'
                ;
                ((self.ui).img_Button).color = (self.ui).normalBtnColor;
                ((self.ui).tex_Level):SetIndex(0, tostring(buildingData.level));
                ((self.ui).tex_State):SetIndex(2)
                if buildingData.state ==
                    proto_object_BuildingState.BuildingStateNormal then
                    if self.accelerateNode ~= nil and
                        (self.accelerateNode).active then
                        (self.accelerateNode):Hide()
                    end
                    self:__setStateBgColor(false)
                    self:__setTextColor(true)
                    if buildingData.maxLevel == buildingData.level then
                        ((self.ui).img_isMax):SetActive(true)
                    else
                        canLevelUp = buildingData:CanUpgrade()
                        if canLevelUp then
                            (((self.ui).img_CanLevelUp).gameObject):SetActive(
                                true);
                            ((self.ui).upGradeStateText):SetIndex(0)
                        end
                    end
                else
                    if buildingData.waitConfirmOver then
                        upgradingPage = true;
                        ((self.ui).completed):SetActive(true)
                        showProgress = true
                        self:UpdateProgressUI(1, TimestampToTime(0))
                    else

                        ((self.ui).state):SetActive(true)
                        self:__setTextColor(true)
                        self:__setStateBgColor(true)
                        if buildingData.state ==
                            proto_object_BuildingState.BuildingStateCreate then
                            self.costInfoState = 3;
                            ((self.ui).tex_State):SetIndex(3)
                        else
                            self.costInfoState = 2;
                            ((self.ui).tex_State):SetIndex(4)
                        end
                        upgradingPage = true
                        showProgress = true
                    end
                end
                self:__ShowProgress(showProgress)
                self:__UpdateLogic()
            end
        end
    end
end

UISectorBuildingItem.__UpdateLogic = function(self)
    -- function num : 0_6 , upvalues : _ENV, logicIndex1, logicIndex2
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).tex_Description).text = ""
    local levelCfg, nextlvlCfg = nil, nil
    local lvl = 1
    if not self.built then
        levelCfg = ((self.buildingData).levelConfig)[1]
        nextlvlCfg = nil
        lvl = 1
    else
        local builtData = self.buildingData
        levelCfg = (builtData.levelConfig)[builtData.level]
        nextlvlCfg = (builtData.levelConfig)[builtData.level + 1]
        lvl = builtData.level
    end
    do
        if levelCfg == nil or (levelCfg.logic).Count == 0 then return end
        if (self.buildingData).maxLevel <= lvl or nextlvlCfg == nil then
            nextlvlCfg = nil
        end
        for i = 1, #levelCfg.logic do
            local logic = (levelCfg.logic)[i]
            if logic == eBuildingLogic.ResourceOutput then
                local itemCfg = (ConfigData.item)[(levelCfg.para1)[i]]
                local speed = (levelCfg.para2)[i]
                speed = speed * 36
                local describ = ((ConfigData.buildingBuff)[logic]).buff_text
                local describ_text = (string.format)(
                                         (LanguageUtil.GetLocaleText)(describ),
                                         (LanguageUtil.GetLocaleText)(
                                             itemCfg.name), tostring(speed)) -- DECOMPILER ERROR at PC76: Confused about usage of register: R13 in 'UnsetPending'
                ;
                ((self.ui).tex_Description).text = describ_text
                if nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] ==
                    eBuildingLogic.ResourceOutput then
                    local nextItemCfg = (ConfigData.item)[(nextlvlCfg.para1)[i]]
                    local speed = (nextlvlCfg.para2)[i] * 36
                    self.nextDescription = tostring(speed) .. "/小时"
                end
            else
                do
                    if logic == eBuildingLogic.FactoryPipelie then
                        local describ =
                            ((ConfigData.buildingBuff)[logic]).buff_text
                        local describ_text =
                            (string.format)(
                                (LanguageUtil.GetLocaleText)(describ),
                                tostring((levelCfg.para1)[i])) -- DECOMPILER ERROR at PC121: Confused about usage of register: R11 in 'UnsetPending'
                        ;
                        ((self.ui).tex_Description).text = describ_text
                        if nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] ==
                            eBuildingLogic.FactoryPipelie then
                            self.nextDescription =
                                tostring((nextlvlCfg.para1)[i])
                        end
                    else
                        do
                            if logic == eBuildingLogic.ResourceLimit then
                                local itemCfg =
                                    (ConfigData.item)[(levelCfg.para1)[i]]
                                local describ =
                                    ((ConfigData.buildingBuff)[logic]).buff_text
                                local describ_text =
                                    (string.format)(
                                        (LanguageUtil.GetLocaleText)(describ),
                                        (LanguageUtil.GetLocaleText)(
                                            itemCfg.name),
                                        tostring((levelCfg.para2)[i])) -- DECOMPILER ERROR at PC166: Confused about usage of register: R12 in 'UnsetPending'
                                ;
                                ((self.ui).tex_Description).text = describ_text
                                if nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] ==
                                    eBuildingLogic.ResourceLimit then
                                    self.nextDescription =
                                        tostring((nextlvlCfg.para2)[i])
                                end
                            else
                                do
                                    if logic == eBuildingLogic.GlobalExpCeiling then
                                        local describ =
                                            ((ConfigData.buildingBuff)[logic]).buff_text
                                        local describ_text =
                                            (string.format)(
                                                (LanguageUtil.GetLocaleText)(
                                                    describ),
                                                tostring((levelCfg.para1)[i])) -- DECOMPILER ERROR at PC202: Confused about usage of register: R11 in 'UnsetPending'
                                        ;
                                        ((self.ui).tex_Description).text =
                                            describ_text
                                        if nextlvlCfg ~= nil and
                                            (nextlvlCfg.logic)[i] ==
                                            eBuildingLogic.GlobalExpCeiling then
                                            self.nextDescription =
                                                tostring((nextlvlCfg.para1)[i])
                                        end
                                    else
                                        do
                                            if logic ==
                                                eBuildingLogic.StaminaCeiling then
                                                local describ =
                                                    ((ConfigData.buildingBuff)[logic]).buff_text
                                                local describ_text =
                                                    (string.format)(
                                                        (LanguageUtil.GetLocaleText)(
                                                            describ), tostring(
                                                            (levelCfg.para1)[i])) -- DECOMPILER ERROR at PC238: Confused about usage of register: R11 in 'UnsetPending'
                                                ;
                                                ((self.ui).tex_Description).text =
                                                    describ_text
                                                if nextlvlCfg ~= nil and
                                                    (nextlvlCfg.logic)[i] ==
                                                    eBuildingLogic.StaminaCeiling then
                                                    self.nextDescription =
                                                        tostring(
                                                            (nextlvlCfg.para1)[i])
                                                end
                                            else
                                                do
                                                    if logic ==
                                                        eBuildingLogic.StaminaOutput then
                                                        local speed =
                                                            (levelCfg.para1)[i] *
                                                                0.0006
                                                        local describ =
                                                            ((ConfigData.buildingBuff)[logic]).buff_text
                                                        local describ_text =
                                                            (string.format)(
                                                                (LanguageUtil.GetLocaleText)(
                                                                    describ),
                                                                tostring(speed)) -- DECOMPILER ERROR at PC276: Confused about usage of register: R12 in 'UnsetPending'
                                                        ;
                                                        ((self.ui).tex_Description).text =
                                                            describ_text
                                                        if nextlvlCfg ~= nil and
                                                            (nextlvlCfg.logic)[i] ==
                                                            eBuildingLogic.StaminaOutput then
                                                            self.nextDescription =
                                                                tostring(
                                                                    (nextlvlCfg.para1)[i] *
                                                                        0.0006)
                                                        end
                                                    else
                                                        do
                                                            if logic ==
                                                                eBuildingLogic.ResOutputEfficiency then
                                                                if (levelCfg.para1)[i] ==
                                                                    0 then
                                                                    local 
                                                                        efficiency =
                                                                        (levelCfg.para2)[i] *
                                                                            0.1
                                                                    local 
                                                                        describ =
                                                                        ((ConfigData.buildingBuff)[logic]).buff_text
                                                                    local text =
                                                                        (LanguageUtil.GetLocaleText)(
                                                                            describ)
                                                                    local 
                                                                        describ_text =
                                                                        (string.format)(
                                                                            text,
                                                                            "全部道具",
                                                                            tostring(
                                                                                efficiency)) -- DECOMPILER ERROR at PC321: Confused about usage of register: R13 in 'UnsetPending'
                                                                    ;
                                                                    ((self.ui).tex_Description).text =
                                                                        describ_text
                                                                    if nextlvlCfg ~=
                                                                        nil and
                                                                        (nextlvlCfg.logic)[i] ==
                                                                        eBuildingLogic.ResOutputEfficiency then
                                                                        self.nextDescription =
                                                                            tostring(
                                                                                (nextlvlCfg.para2)[i] *
                                                                                    0.1) ..
                                                                                "%"
                                                                    end
                                                                else
                                                                    do
                                                                        local 
                                                                            itemCfg =
                                                                            (ConfigData.item)[(levelCfg.para1)[i]]
                                                                        local 
                                                                            efficiency =
                                                                            (levelCfg.para2)[i] *
                                                                                0.1
                                                                        local 
                                                                            describ =
                                                                            ((ConfigData.buildingBuff)[logic]).buff_text
                                                                        do
                                                                            local 
                                                                                describ_text =
                                                                                (string.format)(
                                                                                    (LanguageUtil.GetLocaleText)(
                                                                                        describ),
                                                                                    (LanguageUtil.GetLocaleText)(
                                                                                        itemCfg.name),
                                                                                    tostring(
                                                                                        efficiency)) -- DECOMPILER ERROR at PC367: Confused about usage of register: R13 in 'UnsetPending'
                                                                            ;
                                                                            ((self.ui).tex_Description).text =
                                                                                describ_text
                                                                            if nextlvlCfg ~=
                                                                                nil and
                                                                                (nextlvlCfg.logic)[i] ==
                                                                                eBuildingLogic.ResOutputEfficiency then
                                                                                self.nextDescription =
                                                                                    tostring(
                                                                                        (nextlvlCfg.para2)[i] *
                                                                                            0.1) ..
                                                                                        "%"
                                                                            end
                                                                            if (levelCfg.para1)[i] ~=
                                                                                eBuildQueueType.Oasis or
                                                                                not "绿洲" then
                                                                                local 
                                                                                    buildingBelongText =
                                                                                    logic ~=
                                                                                        eBuildingLogic.BuildQueue or
                                                                                        "扇区"
                                                                            end
                                                                            local 
                                                                                describ =
                                                                                ((ConfigData.buildingBuff)[logic]).buff_text
                                                                            do
                                                                                local 
                                                                                    describ_text =
                                                                                    (string.format)(
                                                                                        (LanguageUtil.GetLocaleText)(
                                                                                            describ),
                                                                                        buildingBelongText,
                                                                                        tostring(
                                                                                            (levelCfg.para2)[i])) -- DECOMPILER ERROR at PC417: Confused about usage of register: R12 in 'UnsetPending'
                                                                                ;
                                                                                ((self.ui).tex_Description).text =
                                                                                    describ_text
                                                                                if nextlvlCfg ~=
                                                                                    nil and
                                                                                    (nextlvlCfg.logic)[i] ==
                                                                                    eBuildingLogic.BuildQueue then
                                                                                    self.nextDescription =
                                                                                        tostring(
                                                                                            (nextlvlCfg.para2)[i])
                                                                                end
                                                                                if logic ==
                                                                                    eBuildingLogic.BuildSpeed then
                                                                                    local 
                                                                                        speed =
                                                                                        (levelCfg.para1)[i] *
                                                                                            0.1
                                                                                    local 
                                                                                        describ =
                                                                                        ((ConfigData.buildingBuff)[logic]).buff_text
                                                                                    local 
                                                                                        describ_text =
                                                                                        (string.format)(
                                                                                            (LanguageUtil.GetLocaleText)(
                                                                                                describ),
                                                                                            tostring(
                                                                                                speed)) -- DECOMPILER ERROR at PC455: Confused about usage of register: R12 in 'UnsetPending'
                                                                                    ;
                                                                                    ((self.ui).tex_Description).text =
                                                                                        describ_text
                                                                                    if nextlvlCfg ~=
                                                                                        nil and
                                                                                        (nextlvlCfg.logic)[i] ==
                                                                                        eBuildingLogic.BuildSpeed then
                                                                                        self.nextDescription =
                                                                                            tostring(
                                                                                                (nextlvlCfg.para1)[i] *
                                                                                                    0.1) ..
                                                                                                "%"
                                                                                    end
                                                                                else
                                                                                    do
                                                                                        if logic ==
                                                                                            eBuildingLogic.GlobalExpRatio then
                                                                                            local 
                                                                                                ratio =
                                                                                                (levelCfg.para1)[i] *
                                                                                                    0.1
                                                                                            local 
                                                                                                describ =
                                                                                                ((ConfigData.buildingBuff)[logic]).buff_text
                                                                                            local 
                                                                                                describ_text =
                                                                                                (string.format)(
                                                                                                    (LanguageUtil.GetLocaleText)(
                                                                                                        describ),
                                                                                                    tostring(
                                                                                                        ratio)) -- DECOMPILER ERROR at PC496: Confused about usage of register: R12 in 'UnsetPending'
                                                                                            ;
                                                                                            ((self.ui).tex_Description).text =
                                                                                                describ_text
                                                                                            if nextlvlCfg ~=
                                                                                                nil and
                                                                                                (nextlvlCfg.logic)[i] ==
                                                                                                eBuildingLogic.GlobalExpRatio then
                                                                                                self.nextDescription =
                                                                                                    tostring(
                                                                                                        (nextlvlCfg.para1)[i] *
                                                                                                            0.1) ..
                                                                                                        "%"
                                                                                            end
                                                                                        else
                                                                                            do
                                                                                                if logic ==
                                                                                                    eBuildingLogic.AllHeroBuff then
                                                                                                    local 
                                                                                                        attrId =
                                                                                                        (levelCfg.para1)[i]
                                                                                                    local 
                                                                                                        value =
                                                                                                        (levelCfg.para2)[i]
                                                                                                    local 
                                                                                                        attrDes,
                                                                                                        valueDes =
                                                                                                        ConfigData:GetAttribute(
                                                                                                            attrId,
                                                                                                            value)
                                                                                                    local 
                                                                                                        describ =
                                                                                                        ((ConfigData.buildingBuff)[logic]).buff_text
                                                                                                    local 
                                                                                                        describ_text =
                                                                                                        (string.format)(
                                                                                                            (LanguageUtil.GetLocaleText)(
                                                                                                                describ),
                                                                                                            attrDes,
                                                                                                            valueDes) -- DECOMPILER ERROR at PC542: Confused about usage of register: R15 in 'UnsetPending'
                                                                                                    ;
                                                                                                    ((self.ui).tex_Description).text =
                                                                                                        describ_text
                                                                                                    if nextlvlCfg ~=
                                                                                                        nil and
                                                                                                        (nextlvlCfg.logic)[i] ==
                                                                                                        eBuildingLogic.AllHeroBuff then
                                                                                                        local 
                                                                                                            nextValue =
                                                                                                            (nextlvlCfg.para2)[i]
                                                                                                        local 
                                                                                                            nextAttrDes,
                                                                                                            nextValueDes =
                                                                                                            ConfigData:GetAttribute(
                                                                                                                attrId,
                                                                                                                nextValue)
                                                                                                        self.nextDescription =
                                                                                                            tostring(
                                                                                                                nextValueDes)
                                                                                                    end
                                                                                                else
                                                                                                    do
                                                                                                        if logic ==
                                                                                                            eBuildingLogic.OverClock then
                                                                                                            local 
                                                                                                                id =
                                                                                                                (levelCfg.para1)[i]
                                                                                                            local 
                                                                                                                level =
                                                                                                                (levelCfg.para2)[i]
                                                                                                            local 
                                                                                                                name =
                                                                                                                (LanguageUtil.GetLocaleText)(
                                                                                                                    (((ConfigData.overclock)[id])[level]).name)
                                                                                                            local 
                                                                                                                describ =
                                                                                                                ((ConfigData.buildingBuff)[logic]).buff_text
                                                                                                            local 
                                                                                                                describ_text =
                                                                                                                (string.format)(
                                                                                                                    (LanguageUtil.GetLocaleText)(
                                                                                                                        describ),
                                                                                                                    tostring(
                                                                                                                        name),
                                                                                                                    tostring(
                                                                                                                        level)) -- DECOMPILER ERROR at PC598: Confused about usage of register: R14 in 'UnsetPending'
                                                                                                            ;
                                                                                                            ((self.ui).tex_Description).text =
                                                                                                                describ_text
                                                                                                            if nextlvlCfg ~=
                                                                                                                nil and
                                                                                                                (nextlvlCfg.logic)[i] ==
                                                                                                                eBuildingLogic.OverClock then
                                                                                                                self.nextDescription =
                                                                                                                    tostring(
                                                                                                                        (nextlvlCfg.para2)[i])
                                                                                                            end
                                                                                                        else
                                                                                                            do
                                                                                                                if logic ==
                                                                                                                    eBuildingLogic.OverClockFreeNum then
                                                                                                                    local 
                                                                                                                        freeNum =
                                                                                                                        (levelCfg.para1)[i]
                                                                                                                    local 
                                                                                                                        describ =
                                                                                                                        ((ConfigData.buildingBuff)[logic]).buff_text
                                                                                                                    local 
                                                                                                                        describ_text =
                                                                                                                        (string.format)(
                                                                                                                            (LanguageUtil.GetLocaleText)(
                                                                                                                                describ),
                                                                                                                            tostring(
                                                                                                                                freeNum)) -- DECOMPILER ERROR at PC635: Confused about usage of register: R12 in 'UnsetPending'
                                                                                                                    ;
                                                                                                                    ((self.ui).tex_Description).text =
                                                                                                                        describ_text
                                                                                                                    if nextlvlCfg ~=
                                                                                                                        nil and
                                                                                                                        (nextlvlCfg.logic)[i] ==
                                                                                                                        eBuildingLogic.OverClockFreeNum then
                                                                                                                        self.nextDescription =
                                                                                                                            tostring(
                                                                                                                                (nextlvlCfg.para1)[i])
                                                                                                                    end
                                                                                                                else
                                                                                                                    do
                                                                                                                        if logic ==
                                                                                                                            eBuildingLogic.DynSkillUpgrade then
                                                                                                                            local 
                                                                                                                                skillUpgradeSpeed =
                                                                                                                                (levelCfg.para1)[i] *
                                                                                                                                    0.01
                                                                                                                            local 
                                                                                                                                describ =
                                                                                                                                ((ConfigData.buildingBuff)[logic]).buff_text
                                                                                                                            local 
                                                                                                                                describ_text =
                                                                                                                                (string.format)(
                                                                                                                                    (LanguageUtil.GetLocaleText)(
                                                                                                                                        describ),
                                                                                                                                    tostring(
                                                                                                                                        skillUpgradeSpeed)) -- DECOMPILER ERROR at PC673: Confused about usage of register: R12 in 'UnsetPending'
                                                                                                                            ;
                                                                                                                            ((self.ui).tex_Description).text =
                                                                                                                                describ_text
                                                                                                                            if nextlvlCfg ~=
                                                                                                                                nil and
                                                                                                                                (nextlvlCfg.logic)[i] ==
                                                                                                                                eBuildingLogic.DynSkillUpgrade then
                                                                                                                                self.nextDescription =
                                                                                                                                    tostring(
                                                                                                                                        (nextlvlCfg.para1)[i] *
                                                                                                                                            0.01) ..
                                                                                                                                        "%"
                                                                                                                            end
                                                                                                                        else
                                                                                                                            do
                                                                                                                                if logic ==
                                                                                                                                    eBuildingLogic.DynChipCountMax then
                                                                                                                                    local 
                                                                                                                                        chipCount =
                                                                                                                                        (levelCfg.para1)[i]
                                                                                                                                    local 
                                                                                                                                        describ =
                                                                                                                                        ((ConfigData.buildingBuff)[logic]).buff_text
                                                                                                                                    local 
                                                                                                                                        describ_text =
                                                                                                                                        (string.format)(
                                                                                                                                            (LanguageUtil.GetLocaleText)(
                                                                                                                                                describ),
                                                                                                                                            tostring(
                                                                                                                                                chipCount)) -- DECOMPILER ERROR at PC713: Confused about usage of register: R12 in 'UnsetPending'
                                                                                                                                    ;
                                                                                                                                    ((self.ui).tex_Description).text =
                                                                                                                                        describ_text
                                                                                                                                    if nextlvlCfg ~=
                                                                                                                                        nil and
                                                                                                                                        (nextlvlCfg.logic)[i] ==
                                                                                                                                        eBuildingLogic.DynChipCountMax then
                                                                                                                                        self.nextDescription =
                                                                                                                                            tostring(
                                                                                                                                                (nextlvlCfg.para1)[i])
                                                                                                                                    end
                                                                                                                                else
                                                                                                                                    do
                                                                                                                                        if logic ==
                                                                                                                                            eBuildingLogic.CareerBuff then
                                                                                                                                            local 
                                                                                                                                                logicIndex1 =
                                                                                                                                                1
                                                                                                                                            local 
                                                                                                                                                logicIndex2 =
                                                                                                                                                2
                                                                                                                                            local 
                                                                                                                                                careerId =
                                                                                                                                                (levelCfg.para1)[logicIndex1]
                                                                                                                                            local 
                                                                                                                                                attrId =
                                                                                                                                                (levelCfg.para2)[logicIndex1]
                                                                                                                                            local 
                                                                                                                                                attibuteCfg =
                                                                                                                                                (ConfigData.attribute)[attrId]
                                                                                                                                            if attibuteCfg ==
                                                                                                                                                nil then
                                                                                                                                                error(
                                                                                                                                                    "Can\'t find attibuteCfg, id = " ..
                                                                                                                                                        tostring(
                                                                                                                                                            attrId))
                                                                                                                                                return
                                                                                                                                            end
                                                                                                                                            local 
                                                                                                                                                attrName =
                                                                                                                                                (LanguageUtil.GetLocaleText)(
                                                                                                                                                    attibuteCfg.name)
                                                                                                                                            local 
                                                                                                                                                isRatio =
                                                                                                                                                attibuteCfg.num_type ==
                                                                                                                                                    2
                                                                                                                                            local 
                                                                                                                                                careerCfg =
                                                                                                                                                (ConfigData.career)[careerId]
                                                                                                                                            if careerCfg ==
                                                                                                                                                nil then
                                                                                                                                                error(
                                                                                                                                                    "can\'t find career, id=" ..
                                                                                                                                                        tostring(
                                                                                                                                                            careerId))
                                                                                                                                                return
                                                                                                                                            end
                                                                                                                                            local 
                                                                                                                                                count =
                                                                                                                                                (levelCfg.para3)[logicIndex1]
                                                                                                                                            local 
                                                                                                                                                content =
                                                                                                                                                ""
                                                                                                                                            if isRatio then
                                                                                                                                                content =
                                                                                                                                                    (LanguageUtil.GetLocaleText)(
                                                                                                                                                        careerCfg.name) ..
                                                                                                                                                        attrName ..
                                                                                                                                                        "提升" ..
                                                                                                                                                        tostring(
                                                                                                                                                            count /
                                                                                                                                                                10) ..
                                                                                                                                                        "%"
                                                                                                                                            else
                                                                                                                                                content =
                                                                                                                                                    (LanguageUtil.GetLocaleText)(
                                                                                                                                                        careerCfg.name) ..
                                                                                                                                                        attrName ..
                                                                                                                                                        "提升" ..
                                                                                                                                                        tostring(
                                                                                                                                                            count)
                                                                                                                                            end
                                                                                                                                            local 
                                                                                                                                                hasAtrr2 =
                                                                                                                                                #levelCfg.para1 >=
                                                                                                                                                    2
                                                                                                                                            if hasAtrr2 then
                                                                                                                                                local 
                                                                                                                                                    attrId =
                                                                                                                                                    (levelCfg.para2)[logicIndex2]
                                                                                                                                                local 
                                                                                                                                                    attibuteCfg =
                                                                                                                                                    (ConfigData.attribute)[attrId]
                                                                                                                                                if attibuteCfg ==
                                                                                                                                                    nil then
                                                                                                                                                    error(
                                                                                                                                                        "Can\'t find attibuteCfg, id = " ..
                                                                                                                                                            tostring(
                                                                                                                                                                attrId))
                                                                                                                                                    return
                                                                                                                                                end
                                                                                                                                                local 
                                                                                                                                                    isRatio2 =
                                                                                                                                                    attibuteCfg.num_type ==
                                                                                                                                                        2
                                                                                                                                                local 
                                                                                                                                                    count2 =
                                                                                                                                                    (levelCfg.para3)[logicIndex2]
                                                                                                                                                if isRatio2 then
                                                                                                                                                    content =
                                                                                                                                                        content ..
                                                                                                                                                            ",并额外提升" ..
                                                                                                                                                            tostring(
                                                                                                                                                                count2 /
                                                                                                                                                                    10) ..
                                                                                                                                                            "%"
                                                                                                                                                else
                                                                                                                                                    content =
                                                                                                                                                        content ..
                                                                                                                                                            ",并额外提升" ..
                                                                                                                                                            tostring(
                                                                                                                                                                count2)
                                                                                                                                                end
                                                                                                                                            end -- DECOMPILER ERROR at PC851: Confused about usage of register: R20 in 'UnsetPending'
                                                                                                                                            
                                                                                                                                            ((self.ui).tex_Description).text =
                                                                                                                                                content ..
                                                                                                                                                    "(全局生效)"
                                                                                                                                            self.description =
                                                                                                                                                content
                                                                                                                                            if nextlvlCfg ~=
                                                                                                                                                nil and
                                                                                                                                                (nextlvlCfg.logic)[i] ==
                                                                                                                                                eBuildingLogic.CareerBuff then
                                                                                                                                                local 
                                                                                                                                                    nextCount =
                                                                                                                                                    (nextlvlCfg.para3)[logicIndex1]
                                                                                                                                                if isRatio then
                                                                                                                                                    self.nextDescription =
                                                                                                                                                        tostring(
                                                                                                                                                            nextCount /
                                                                                                                                                                10) ..
                                                                                                                                                            "%"
                                                                                                                                                else
                                                                                                                                                    self.nextDescription =
                                                                                                                                                        tostring(
                                                                                                                                                            nextCount)
                                                                                                                                                end
                                                                                                                                            end
                                                                                                                                        elseif logic ==
                                                                                                                                            eBuildingLogic.CampBuff then
                                                                                                                                            local 
                                                                                                                                                campId =
                                                                                                                                                (levelCfg.para1)[logicIndex1]
                                                                                                                                            local 
                                                                                                                                                attrId =
                                                                                                                                                (levelCfg.para2)[logicIndex1]
                                                                                                                                            local 
                                                                                                                                                attibuteCfg =
                                                                                                                                                (ConfigData.attribute)[attrId]
                                                                                                                                            if attibuteCfg ==
                                                                                                                                                nil then
                                                                                                                                                error(
                                                                                                                                                    "Can\'t find attibuteCfg, id = " ..
                                                                                                                                                        tostring(
                                                                                                                                                            attrId))
                                                                                                                                                return
                                                                                                                                            end
                                                                                                                                            local 
                                                                                                                                                attrName =
                                                                                                                                                (LanguageUtil.GetLocaleText)(
                                                                                                                                                    attibuteCfg.name)
                                                                                                                                            local 
                                                                                                                                                isRatio =
                                                                                                                                                attibuteCfg.num_type ==
                                                                                                                                                    2
                                                                                                                                            local 
                                                                                                                                                campCfg =
                                                                                                                                                (ConfigData.career)[campId]
                                                                                                                                            if campCfg ==
                                                                                                                                                nil then
                                                                                                                                                error(
                                                                                                                                                    "can\'t find career, id=" ..
                                                                                                                                                        tostring(
                                                                                                                                                            campId))
                                                                                                                                                return
                                                                                                                                            end
                                                                                                                                            local 
                                                                                                                                                count =
                                                                                                                                                (levelCfg.para3)[logicIndex1]
                                                                                                                                            local 
                                                                                                                                                content =
                                                                                                                                                ""
                                                                                                                                            if isRatio then
                                                                                                                                                content =
                                                                                                                                                    (LanguageUtil.GetLocaleText)(
                                                                                                                                                        campCfg.name) ..
                                                                                                                                                        attrName ..
                                                                                                                                                        "提升" ..
                                                                                                                                                        tostring(
                                                                                                                                                            count /
                                                                                                                                                                10) ..
                                                                                                                                                        "%"
                                                                                                                                            else
                                                                                                                                                content =
                                                                                                                                                    (LanguageUtil.GetLocaleText)(
                                                                                                                                                        campCfg.name) ..
                                                                                                                                                        attrName ..
                                                                                                                                                        "提升" ..
                                                                                                                                                        tostring(
                                                                                                                                                            count)
                                                                                                                                            end
                                                                                                                                            local 
                                                                                                                                                hasAtrr2 =
                                                                                                                                                #levelCfg.para1 >=
                                                                                                                                                    2
                                                                                                                                            if hasAtrr2 then
                                                                                                                                                local 
                                                                                                                                                    attrId =
                                                                                                                                                    (levelCfg.para2)[logicIndex2]
                                                                                                                                                local 
                                                                                                                                                    attibuteCfg =
                                                                                                                                                    (ConfigData.attribute)[attrId]
                                                                                                                                                if attibuteCfg ==
                                                                                                                                                    nil then
                                                                                                                                                    error(
                                                                                                                                                        "Can\'t find attibuteCfg, id = " ..
                                                                                                                                                            tostring(
                                                                                                                                                                attrId))
                                                                                                                                                    return
                                                                                                                                                end
                                                                                                                                                local 
                                                                                                                                                    isRatio2 =
                                                                                                                                                    attibuteCfg.num_type ==
                                                                                                                                                        2
                                                                                                                                                local 
                                                                                                                                                    count2 =
                                                                                                                                                    (levelCfg.para3)[logicIndex2]
                                                                                                                                                if isRatio2 then
                                                                                                                                                    content =
                                                                                                                                                        content ..
                                                                                                                                                            "并额外提升" ..
                                                                                                                                                            tostring(
                                                                                                                                                                count2 /
                                                                                                                                                                    10) ..
                                                                                                                                                            "%"
                                                                                                                                                else
                                                                                                                                                    content =
                                                                                                                                                        content ..
                                                                                                                                                            "并额外提升" ..
                                                                                                                                                            tostring(
                                                                                                                                                                count2)
                                                                                                                                                end
                                                                                                                                            end -- DECOMPILER ERROR at PC1000: Confused about usage of register: R18 in 'UnsetPending'
                                                                                                                                            
                                                                                                                                            ((self.ui).tex_Description).text =
                                                                                                                                                content
                                                                                                                                            self.description =
                                                                                                                                                content
                                                                                                                                            if nextlvlCfg ~=
                                                                                                                                                nil and
                                                                                                                                                (nextlvlCfg.logic)[i] ==
                                                                                                                                                eBuildingLogic.CampBuff then
                                                                                                                                                local 
                                                                                                                                                    nextCount =
                                                                                                                                                    (nextlvlCfg.para3)[logicIndex1]
                                                                                                                                                if isRatio then
                                                                                                                                                    self.nextDescription =
                                                                                                                                                        tostring(
                                                                                                                                                            nextCount /
                                                                                                                                                                10) ..
                                                                                                                                                            "%"
                                                                                                                                                else
                                                                                                                                                    self.nextDescription =
                                                                                                                                                        tostring(
                                                                                                                                                            nextCount)
                                                                                                                                                end
                                                                                                                                            end
                                                                                                                                        end
                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                        -- DECOMPILER ERROR at PC1026: LeaveBlock: unexpected jumping out IF_STMT

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
            end
        end
        self.description = ((self.ui).tex_Description).text
        -- DECOMPILER ERROR: 23 unprocessed JMP targets
    end
end

UISectorBuildingItem.__ShowProgress = function(self, show)
    -- function num : 0_7
    (((self.ui).tex_RemainTime).gameObject):SetActive(show)
end

UISectorBuildingItem.__OnClickItem = function(self)
    -- function num : 0_8
    if self.OnClickEvent ~= nil then (self.OnClickEvent)(self.id) end
end

UISectorBuildingItem.__setTextColor = function(self, isIdle)
    -- function num : 0_9 , upvalues : _ENV
    if not isIdle or not Color.black then local targetColor = Color.white end -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'
    
    ((self.ui).tex_Name).color = targetColor -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (((self.ui).tex_Level).text).color = targetColor -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).tex_Description).color = targetColor
end

UISectorBuildingItem.__setStateBgColor =
    function(self, isActive)
        -- function num : 0_10
        if not isActive or not (self.stateBgColors).activeColor then
            local bgColor = (self.stateBgColors).disactiveColor
        end -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'
        
        ((self.ui).img_StateBg).color = bgColor
    end

UISectorBuildingItem.GetSctBuildItemStateInfo =
    function(self)
        -- function num : 0_11 , upvalues : _ENV
        local strText = nil
        if self.unlockText ~= nil then
            for k, v in ipairs(self.unlockText) do
                if not (string.IsNullOrEmpty)(strText) then
                    strText = strText .. "\n" .. v
                else
                    strText = v
                end
            end
        end
        do return strText end
    end

UISectorBuildingItem.OnDelete = function(self)
    -- function num : 0_12 , upvalues : base
    if self.accelerateNode ~= nil then (self.accelerateNode):Hide() end
    self.resloader = nil
    self.unlockText = nil;
    (base.OnDelete)(self)
end

return UISectorBuildingItem

