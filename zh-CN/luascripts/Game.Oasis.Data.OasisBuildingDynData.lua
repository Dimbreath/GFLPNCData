-- params : ...
-- function num : 0 , upvalues : _ENV
local OasisBuildingDynData = class("OasisBuildingDynData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local CheckerTypeId, CheckerGlobalConfig =
    (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
OasisBuildingDynData.Initialize = function(self, stcData)
    -- function num : 0_0 , upvalues : _ENV, BuildingBelong
    self.stcData = stcData
    self.id = stcData.build_id
    self.levelConfig = (ConfigData.buildingLevel)[self.id]
    if self.levelConfig == nil then
        error("Can\'t find buildingLevel, build_id : " .. tostring(self.id))
    end
    self.maxLevel = ((ConfigData.buildingLevel).maxLevelDic)[self.id]
    self.name = (LanguageUtil.GetLocaleText)(stcData.name)
    self.nameEn = (LanguageUtil.GetLocaleText)(stcData.name_en)
    self.upgradeEffectPath = stcData.upgrading_effect
    self.area = 1
    self.icon_res = stcData.icon_res
    self.position = (Vector2.New)()
    if #stcData.coord_base == 3 then
        self.area = (stcData.coord_base)[1] -- DECOMPILER ERROR at PC53: Confused about usage of register: R2 in 'UnsetPending'
        ;
        (self.position).x = (stcData.coord_base)[2] -- DECOMPILER ERROR at PC57: Confused about usage of register: R2 in 'UnsetPending'
        ;
        (self.position).y = (stcData.coord_base)[3]
    end
    self.size = stcData.size
    self.height = stcData.height
    if self.height == nil then
        error("Oasis building" .. stcData.name .. ":没有配置 height")
    end
    self.belong = (BuildingBelong.CheckBelong)(stcData.type)
    if self.belong == BuildingBelong.Sector then
        self.sectorId = nil
        for _, id in ipairs((ConfigData.sector).id_sort_list) do
            local sectorCfg = (ConfigData.sector)[id]
            for _, builtId in ipairs(sectorCfg.building) do
                if builtId == stcData.build_id then
                    self.sectorId = id
                    break
                end
            end
        end
    end
end

OasisBuildingDynData.UpdateLockAndBuild =
    function(self)
        -- function num : 0_1 , upvalues : CheckerTypeId, _ENV
        self.unlock = self:Unlock()
        if not self.unlock then
            local level1Cfg = (self.levelConfig)[1]
            for i = 1, #level1Cfg.pre_condition do
                if (level1Cfg.pre_condition)[i] == CheckerTypeId.BuildingLevel and
                    (level1Cfg.pre_para1)[i] == eBuildingId.OasisMainBuilding then
                    self.mainBdUnlockLevel = (level1Cfg.pre_para2)[i]
                    self.mainBdName =
                        (((PlayerDataCenter.AllBuildingData).builtSort)[1]).name
                    break
                end
            end
        end
        do self.canbuild = self:CanBuild() end
    end

OasisBuildingDynData.Unlock = function(self)
    -- function num : 0_2 , upvalues : _ENV
    local level1Cfg = (self.levelConfig)[1]
    if not (CheckCondition.CheckLua)(level1Cfg.pre_condition,
                                     level1Cfg.pre_para1, level1Cfg.pre_para2) then
        return false
    end
    return true
end

OasisBuildingDynData.CanBuild = function(self)
    -- function num : 0_3 , upvalues : _ENV
    if (PlayerDataCenter.AllBuildingData):FullBuildQue(self.belong) then
        return false
    end
    local level1Cfg = (self.levelConfig)[1]
    if not (CheckCondition.CheckLua)(level1Cfg.pre_condition,
                                     level1Cfg.pre_para1, level1Cfg.pre_para2) then
        return false
    end
    for k, v in ipairs(level1Cfg.consumeIds) do
        local resId = v
        local count = PlayerDataCenter:GetItemCount(resId)
        local cost = (level1Cfg.consumeNums)[k]
        if count < cost then return false end
    end
    return true
end

OasisBuildingDynData.GetLevelCostItem = function(self, lvl)
    -- function num : 0_4 , upvalues : _ENV
    local nextLvlCfg = (self.levelConfig)[lvl]
    if nextLvlCfg == nil then return end
    local resNeedItems = {}
    for i = 1, #nextLvlCfg.consumeIds do
        local resId = (nextLvlCfg.consumeIds)[i]
        local resCount = (nextLvlCfg.consumeNums)[i]
        local count = PlayerDataCenter:GetItemCount(resId)
        local name = (LanguageUtil.GetLocaleText)(
                         ((ConfigData.item)[resId]).name)
        resNeedItems[i] = {} -- DECOMPILER ERROR at PC29: Confused about usage of register: R12 in 'UnsetPending'
        ;
        (resNeedItems[i]).name = name -- DECOMPILER ERROR at PC31: Confused about usage of register: R12 in 'UnsetPending'
        ;
        (resNeedItems[i]).count = count -- DECOMPILER ERROR at PC33: Confused about usage of register: R12 in 'UnsetPending'
        ;
        (resNeedItems[i]).resCount = resCount -- DECOMPILER ERROR at PC35: Confused about usage of register: R12 in 'UnsetPending'
        ;
        (resNeedItems[i]).resId = resId
    end
    return resNeedItems
end

OasisBuildingDynData.GetPreBuildingLvlInfo =
    function(self, targetLvl)
        -- function num : 0_5 , upvalues : _ENV
        local tarLvlCfg = (self.levelConfig)[targetLvl]
        if #tarLvlCfg.pre_para1 <= 0 then return nil end
        local preConditionDict = {}
        for i = 1, #tarLvlCfg.pre_para1 do
            local buildingId = (tarLvlCfg.pre_para1)[i]
            local stcData = (ConfigData.building)[buildingId]
            if stcData == nil then
                error("找不到前置建筑ID:" .. tostring(buildingId))
            end
            local name = (LanguageUtil.GetLocaleText)(stcData.name)
            local needLevel = (tarLvlCfg.pre_para2)[i]
            local currentLevel = 0
            preConditionDict[name] = {} -- DECOMPILER ERROR at PC41: Confused about usage of register: R13 in 'UnsetPending'
            ;
            (preConditionDict[name]).currentLevel = currentLevel or 0 -- DECOMPILER ERROR at PC46: Confused about usage of register: R13 in 'UnsetPending'
            ;
            (preConditionDict[name]).needLevel = needLevel or 0
            for k, v in pairs((PlayerDataCenter.AllBuildingData).built) do
                -- DECOMPILER ERROR at PC58: Confused about usage of register: R18 in 'UnsetPending'

                if v.id == buildingId then
                    (preConditionDict[name]).currentLevel = v.level
                end
            end
        end
        return preConditionDict
    end

OasisBuildingDynData.GetTargetLevelNeedTime =
    function(self, tarlvl)
        -- function num : 0_6 , upvalues : _ENV
        local levelCfg = (self.levelConfig)[tarlvl]
        if levelCfg == nil then return end
        return (math.ceil)(levelCfg.time /
                               (1 +
                                   (PlayerDataCenter.playerBonus):GetBuildSpeed() /
                                   1000))
    end

OasisBuildingDynData.GetBuffItems = function(self, level, getNext)
    -- function num : 0_7 , upvalues : _ENV
    local levelCfg = (self.levelConfig)[level]
    if levelCfg == nil then return end
    local buffDict = {}
    local nextlvlCfg = nil
    if getNext and level < self.maxLevel then
        nextlvlCfg = (self.levelConfig)[level + 1]
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
                                     (LanguageUtil.GetLocaleText)(itemCfg.name),
                                     tostring(speed))
            buffDict[i] = {} -- DECOMPILER ERROR at PC55: Confused about usage of register: R15 in 'UnsetPending'
            ;
            (buffDict[i]).currentInfo = describ_text
            if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] ==
                eBuildingLogic.ResourceOutput then
                local nextItemCfg = (ConfigData.item)[(nextlvlCfg.para1)[i]]
                local speed = (nextlvlCfg.para2)[i] * 36 -- DECOMPILER ERROR at PC80: Confused about usage of register: R17 in 'UnsetPending'
                ;
                (buffDict[i]).nextInfoValue = tostring(speed) .. "/小时"
            end
        else
            do
                if logic == eBuildingLogic.FactoryPipelie then
                    local describ = ((ConfigData.buildingBuff)[logic]).buff_text
                    local describ_text =
                        (string.format)((LanguageUtil.GetLocaleText)(describ),
                                        tostring((levelCfg.para1)[i]))
                    buffDict[i] = {} -- DECOMPILER ERROR at PC104: Confused about usage of register: R13 in 'UnsetPending'
                    ;
                    (buffDict[i]).currentInfo = describ_text
                    -- DECOMPILER ERROR at PC120: Confused about usage of register: R13 in 'UnsetPending'

                    if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] ==
                        eBuildingLogic.FactoryPipelie then
                        (buffDict[i]).nextInfoValue =
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
                                    (LanguageUtil.GetLocaleText)(itemCfg.name),
                                    tostring((levelCfg.para2)[i]))
                            buffDict[i] = {} -- DECOMPILER ERROR at PC153: Confused about usage of register: R14 in 'UnsetPending'
                            ;
                            (buffDict[i]).currentInfo = describ_text
                            -- DECOMPILER ERROR at PC169: Confused about usage of register: R14 in 'UnsetPending'

                            if getNext and nextlvlCfg ~= nil and
                                (nextlvlCfg.logic)[i] ==
                                eBuildingLogic.ResourceLimit then
                                (buffDict[i]).nextInfoValue =
                                    tostring((nextlvlCfg.para2)[i])
                            end
                        else
                            do
                                if logic == eBuildingLogic.GlobalExpCeiling then
                                    local describ =
                                        ((ConfigData.buildingBuff)[logic]).buff_text
                                    local describ_text =
                                        (string.format)(
                                            (LanguageUtil.GetLocaleText)(describ),
                                            tostring((levelCfg.para1)[i]))
                                    buffDict[i] = {} -- DECOMPILER ERROR at PC193: Confused about usage of register: R13 in 'UnsetPending'
                                    ;
                                    (buffDict[i]).currentInfo = describ_text
                                    -- DECOMPILER ERROR at PC209: Confused about usage of register: R13 in 'UnsetPending'

                                    if getNext and nextlvlCfg ~= nil and
                                        (nextlvlCfg.logic)[i] ==
                                        eBuildingLogic.GlobalExpCeiling then
                                        (buffDict[i]).nextInfoValue =
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
                                                        (levelCfg.para1)[i]))
                                            buffDict[i] = {} -- DECOMPILER ERROR at PC233: Confused about usage of register: R13 in 'UnsetPending'
                                            ;
                                            (buffDict[i]).currentInfo =
                                                describ_text
                                            -- DECOMPILER ERROR at PC249: Confused about usage of register: R13 in 'UnsetPending'

                                            if getNext and nextlvlCfg ~= nil and
                                                (nextlvlCfg.logic)[i] ==
                                                eBuildingLogic.StaminaCeiling then
                                                (buffDict[i]).nextInfoValue =
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
                                                            tostring(speed))
                                                    buffDict[i] = {} -- DECOMPILER ERROR at PC275: Confused about usage of register: R14 in 'UnsetPending'
                                                    ;
                                                    (buffDict[i]).currentInfo =
                                                        describ_text
                                                    -- DECOMPILER ERROR at PC292: Confused about usage of register: R14 in 'UnsetPending'

                                                    if getNext and nextlvlCfg ~=
                                                        nil and
                                                        (nextlvlCfg.logic)[i] ==
                                                        eBuildingLogic.StaminaOutput then
                                                        (buffDict[i]).nextInfoValue =
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
                                                                local efficiency =
                                                                    (levelCfg.para2)[i] *
                                                                        0.1
                                                                local describ =
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
                                                                            efficiency))
                                                                buffDict[i] = {} -- DECOMPILER ERROR at PC324: Confused about usage of register: R15 in 'UnsetPending'
                                                                ;
                                                                (buffDict[i]).currentInfo =
                                                                    describ_text
                                                                -- DECOMPILER ERROR at PC343: Confused about usage of register: R15 in 'UnsetPending'

                                                                if getNext and
                                                                    nextlvlCfg ~=
                                                                    nil and
                                                                    (nextlvlCfg.logic)[i] ==
                                                                    eBuildingLogic.ResOutputEfficiency then
                                                                    (buffDict[i]).nextInfoValue =
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
                                                                                    efficiency))
                                                                        buffDict[i] =
                                                                            {} -- DECOMPILER ERROR at PC374: Confused about usage of register: R15 in 'UnsetPending'
                                                                        ;
                                                                        (buffDict[i]).currentInfo =
                                                                            describ_text
                                                                        -- DECOMPILER ERROR at PC393: Confused about usage of register: R15 in 'UnsetPending'

                                                                        if getNext and
                                                                            nextlvlCfg ~=
                                                                            nil and
                                                                            (nextlvlCfg.logic)[i] ==
                                                                            eBuildingLogic.ResOutputEfficiency then
                                                                            (buffDict[i]).nextInfoValue =
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
                                                                                        (levelCfg.para2)[i]))
                                                                            buffDict[i] =
                                                                                {} -- DECOMPILER ERROR at PC428: Confused about usage of register: R14 in 'UnsetPending'
                                                                            ;
                                                                            (buffDict[i]).currentInfo =
                                                                                describ_text
                                                                            -- DECOMPILER ERROR at PC444: Confused about usage of register: R14 in 'UnsetPending'

                                                                            if getNext and
                                                                                nextlvlCfg ~=
                                                                                nil and
                                                                                (nextlvlCfg.logic)[i] ==
                                                                                eBuildingLogic.BuildQueue then
                                                                                (buffDict[i]).nextInfoValue =
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
                                                                                            speed))
                                                                                buffDict[i] =
                                                                                    {} -- DECOMPILER ERROR at PC470: Confused about usage of register: R14 in 'UnsetPending'
                                                                                ;
                                                                                (buffDict[i]).currentInfo =
                                                                                    describ_text
                                                                                -- DECOMPILER ERROR at PC489: Confused about usage of register: R14 in 'UnsetPending'

                                                                                if getNext and
                                                                                    nextlvlCfg ~=
                                                                                    nil and
                                                                                    (nextlvlCfg.logic)[i] ==
                                                                                    eBuildingLogic.BuildSpeed then
                                                                                    (buffDict[i]).nextInfoValue =
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
                                                                                                    ratio))
                                                                                        buffDict[i] =
                                                                                            {} -- DECOMPILER ERROR at PC515: Confused about usage of register: R14 in 'UnsetPending'
                                                                                        ;
                                                                                        (buffDict[i]).currentInfo =
                                                                                            describ_text
                                                                                        -- DECOMPILER ERROR at PC534: Confused about usage of register: R14 in 'UnsetPending'

                                                                                        if getNext and
                                                                                            nextlvlCfg ~=
                                                                                            nil and
                                                                                            (nextlvlCfg.logic)[i] ==
                                                                                            eBuildingLogic.GlobalExpRatio then
                                                                                            (buffDict[i]).nextInfoValue =
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
                                                                                                        valueDes)
                                                                                                buffDict[i] =
                                                                                                    {} -- DECOMPILER ERROR at PC565: Confused about usage of register: R17 in 'UnsetPending'
                                                                                                ;
                                                                                                (buffDict[i]).currentInfo =
                                                                                                    describ_text
                                                                                                if getNext and
                                                                                                    nextlvlCfg ~=
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
                                                                                                            nextValue) -- DECOMPILER ERROR at PC587: Confused about usage of register: R20 in 'UnsetPending'
                                                                                                    ;
                                                                                                    (buffDict[i]).nextInfoValue =
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
                                                                                                                    level))
                                                                                                        buffDict[i] =
                                                                                                            {} -- DECOMPILER ERROR at PC625: Confused about usage of register: R16 in 'UnsetPending'
                                                                                                        ;
                                                                                                        (buffDict[i]).currentInfo =
                                                                                                            describ_text
                                                                                                        -- DECOMPILER ERROR at PC641: Confused about usage of register: R16 in 'UnsetPending'

                                                                                                        if getNext and
                                                                                                            nextlvlCfg ~=
                                                                                                            nil and
                                                                                                            (nextlvlCfg.logic)[i] ==
                                                                                                            eBuildingLogic.OverClock then
                                                                                                            (buffDict[i]).nextInfoValue =
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
                                                                                                                            freeNum))
                                                                                                                buffDict[i] =
                                                                                                                    {} -- DECOMPILER ERROR at PC666: Confused about usage of register: R14 in 'UnsetPending'
                                                                                                                ;
                                                                                                                (buffDict[i]).currentInfo =
                                                                                                                    describ_text
                                                                                                                -- DECOMPILER ERROR at PC682: Confused about usage of register: R14 in 'UnsetPending'

                                                                                                                if getNext and
                                                                                                                    nextlvlCfg ~=
                                                                                                                    nil and
                                                                                                                    (nextlvlCfg.logic)[i] ==
                                                                                                                    eBuildingLogic.OverClockFreeNum then
                                                                                                                    (buffDict[i]).nextInfoValue =
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
                                                                                                                                    skillUpgradeSpeed))
                                                                                                                        buffDict[i] =
                                                                                                                            {} -- DECOMPILER ERROR at PC708: Confused about usage of register: R14 in 'UnsetPending'
                                                                                                                        ;
                                                                                                                        (buffDict[i]).currentInfo =
                                                                                                                            describ_text
                                                                                                                        -- DECOMPILER ERROR at PC727: Confused about usage of register: R14 in 'UnsetPending'

                                                                                                                        if getNext and
                                                                                                                            nextlvlCfg ~=
                                                                                                                            nil and
                                                                                                                            (nextlvlCfg.logic)[i] ==
                                                                                                                            eBuildingLogic.DynSkillUpgrade then
                                                                                                                            (buffDict[i]).nextInfoValue =
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
                                                                                                                                            chipCount))
                                                                                                                                buffDict[i] =
                                                                                                                                    {} -- DECOMPILER ERROR at PC752: Confused about usage of register: R14 in 'UnsetPending'
                                                                                                                                ;
                                                                                                                                (buffDict[i]).currentInfo =
                                                                                                                                    describ_text
                                                                                                                                -- DECOMPILER ERROR at PC768: Confused about usage of register: R14 in 'UnsetPending'

                                                                                                                                if getNext and
                                                                                                                                    nextlvlCfg ~=
                                                                                                                                    nil and
                                                                                                                                    (nextlvlCfg.logic)[i] ==
                                                                                                                                    eBuildingLogic.DynChipCountMax then
                                                                                                                                    (buffDict[i]).nextInfoValue =
                                                                                                                                        tostring(
                                                                                                                                            (nextlvlCfg.para1)[i])
                                                                                                                                end
                                                                                                                            end
                                                                                                                            do
                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out DO_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                                                                -- DECOMPILER ERROR at PC769: LeaveBlock: unexpected jumping out IF_STMT

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
    return buffDict
end

return OasisBuildingDynData

