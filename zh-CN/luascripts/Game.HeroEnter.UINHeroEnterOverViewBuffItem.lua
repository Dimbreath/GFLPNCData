-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroEnterOverViewBuffItem = class("UINHeroEnterBuildingBuffInfo",
                                           UIBaseNode)
local base = UIBaseNode
local valueFuncTable = {
    [eBuildingLogic.ResourceLimit] = function(heroScoreRate, newHreoScoreRate,
                                              theSelf)
        -- function num : 0_0 , upvalues : _ENV
        local itemName = (LanguageUtil.GetLocaleText)(
                             ((ConfigData.item)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name)
        local temp = tostring((math.floor)(
                                  ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] *
                                      heroScoreRate));
        ((theSelf.ui).tex_BuildAdd):SetIndex(eBuildingLogic.ResourceLimit,
                                             itemName, temp)
    end,
    [eBuildingLogic.ResourceOutput] = function(heroScoreRate, newHreoScoreRate,
                                               theSelf)
        -- function num : 0_1 , upvalues : _ENV
        local itemName = (LanguageUtil.GetLocaleText)(
                             ((ConfigData.item)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name)
        local speed = ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] *
                          36
        local temp = tostring((math.floor)(speed * heroScoreRate));
        ((theSelf.ui).tex_BuildAdd):SetIndex(eBuildingLogic.ResourceOutput,
                                             itemName, temp)
    end,
    [eBuildingLogic.CampBuff] = function(heroScoreRate, newHreoScoreRate,
                                         theSelf)
        -- function num : 0_2 , upvalues : _ENV
        local campName = (LanguageUtil.GetLocaleText)(
                             ((ConfigData.camp)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name)
        local attrName = (LanguageUtil.GetLocaleText)(
                             ((ConfigData.attribute)[((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID]]).name)
        local attrValue = ((theSelf.levelBuffCfg).buff_para3)[theSelf.buffCfhID]
        local temp = attrName .. "+" .. (math.floor)(attrValue * heroScoreRate);
        ((theSelf.ui).tex_BuildAdd):SetIndex(eBuildingLogic.CampBuff, campName,
                                             temp)
    end,
    [eBuildingLogic.CareerBuff] = function(heroScoreRate, newHreoScoreRate,
                                           theSelf)
        -- function num : 0_3 , upvalues : _ENV
        local careerName = (LanguageUtil.GetLocaleText)(
                               ((ConfigData.career)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name)
        local attrName = (LanguageUtil.GetLocaleText)(
                             ((ConfigData.attribute)[((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID]]).name)
        local attrValue = ((theSelf.levelBuffCfg).buff_para3)[theSelf.buffCfhID]
        local temp = attrName .. "+" .. (math.floor)(attrValue * heroScoreRate);
        ((theSelf.ui).tex_BuildAdd):SetIndex(eBuildingLogic.CareerBuff,
                                             careerName, temp)
    end,
    [eBuildingLogic.FactoryPipelie] = function(heroScoreRate, newHreoScoreRate,
                                               theSelf)
        -- function num : 0_4 , upvalues : _ENV
        local temp = tostring((math.floor)(
                                  ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] *
                                      heroScoreRate));
        ((theSelf.ui).tex_BuildAdd):SetIndex(eBuildingLogic.FactoryPipelie, temp)
    end,
    [eBuildingLogic.GlobalExpCeiling] = function(heroScoreRate,
                                                 newHreoScoreRate, theSelf)
        -- function num : 0_5 , upvalues : _ENV
        local expLimt = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]
        local temp = tostring((math.floor)(expLimt * heroScoreRate));
        ((theSelf.ui).tex_BuildAdd):SetIndex(eBuildingLogic.GlobalExpCeiling,
                                             temp)
    end,
    [eBuildingLogic.StaminaCeiling] = function(heroScoreRate, newHreoScoreRate,
                                               theSelf)
        -- function num : 0_6 , upvalues : _ENV
        local staminaLimt =
            ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]
        local temp = tostring((math.floor)(staminaLimt * heroScoreRate));
        ((theSelf.ui).tex_BuildAdd):SetIndex(eBuildingLogic.StaminaCeiling, temp)
    end,
    [eBuildingLogic.StaminaOutput] = function(heroScoreRate, newHreoScoreRate,
                                              theSelf)
        -- function num : 0_7 , upvalues : _ENV
        local speed = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] *
                          0.036
        local temp = tostring((math.floor)(speed * heroScoreRate));
        ((theSelf.ui).tex_BuildAdd):SetIndex(eBuildingLogic.StaminaOutput, temp)
    end,
    [eBuildingLogic.ResOutputEfficiency] = function(heroScoreRate,
                                                    newHreoScoreRate, theSelf)
        -- function num : 0_8 , upvalues : _ENV
        local itemName = nil
        if ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] == 0 then
            itemName = "全部道具"
        else
            local itemCfg =
                (ConfigData.item)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]
            if itemCfg == nil then
                itemName = "未知道具"
            else
                itemName = (LanguageUtil.GetLocaleText)(itemCfg.name)
            end
        end
        do
            local temp = GetPreciseDecimalStr(
                             ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] /
                                 10 * heroScoreRate, 2) .. "%";
            ((theSelf.ui).tex_BuildAdd):SetIndex(
                eBuildingLogic.ResOutputEfficiency, itemName, temp)
        end
    end,
    [eBuildingLogic.BuildQueue] = function(heroScoreRate, newHreoScoreRate,
                                           theSelf)
        -- function num : 0_9 , upvalues : _ENV
        local listPlace = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]
        local listNum = ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID]
        local temp = tostring((math.floor)(listNum * heroScoreRate))
        if listPlace == 1 then
            ((theSelf.ui).tex_BuildAdd):SetIndex(eBuildingLogic.BuildQueue, temp)
        else

            ((theSelf.ui).tex_BuildAdd):SetIndex(16, temp)
        end
    end,
    [eBuildingLogic.BuildSpeed] = function(heroScoreRate, newHreoScoreRate,
                                           theSelf)
        -- function num : 0_10 , upvalues : _ENV
        local speed = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]
        local temp = GetPreciseDecimalStr(speed / 10 * heroScoreRate, 2) .. "%";
        ((theSelf.ui).tex_BuildAdd):SetIndex(eBuildingLogic.BuildSpeed, temp)
    end,
    [eBuildingLogic.GlobalExpRatio] = function(heroScoreRate, newHreoScoreRate,
                                               theSelf)
        -- function num : 0_11 , upvalues : _ENV
        local rate = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]
        local temp = GetPreciseDecimalStr(rate / 10 * heroScoreRate, 2) .. "%";
        ((theSelf.ui).tex_BuildAdd):SetIndex(eBuildingLogic.GlobalExpRatio, temp)
    end,
    [eBuildingLogic.AllHeroBuff] = function(heroScoreRate, newHreoScoreRate,
                                            theSelf)
        -- function num : 0_12 , upvalues : _ENV
        local attrName = (LanguageUtil.GetLocaleText)(
                             ((ConfigData.attribute)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name)
        local attrValue = ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID]
        local temp = attrName .. "+" .. (math.floor)(attrValue * heroScoreRate);
        ((theSelf.ui).tex_BuildAdd):SetIndex(eBuildingLogic.AllHeroBuff, temp)
    end
}
UINHeroEnterOverViewBuffItem.OnInit = function(self)
    -- function num : 0_13 , upvalues : _ENV
    self.levelBuffCfg = nil
    self.buffCfhID = nil;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINHeroEnterOverViewBuffItem.InitBuff = function(self, levelBuffCfg, buffCfhID)
    -- function num : 0_14
    self.levelBuffCfg = levelBuffCfg
    self.buffCfhID = buffCfhID
end

UINHeroEnterOverViewBuffItem.SetValue = function(self, heroScoreRate,
                                                 newHreoScoreRate)
    -- function num : 0_15 , upvalues : valueFuncTable
    local logic = ((self.levelBuffCfg).buff_logic)[self.buffCfhID];
    (valueFuncTable[logic])(heroScoreRate, newHreoScoreRate, self)
end

UINHeroEnterOverViewBuffItem.OnDelete = function(self)
    -- function num : 0_16 , upvalues : base
    (base.OnDelete)(self)
end

return UINHeroEnterOverViewBuffItem

