ConfigData = {}
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local SectorEnum = require("Game.Sector.SectorEnum")
local cs_GameData = (CS.GameData).instance
local DefineConfigDataFunc = function()
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (((ConfigData.item).__basemetatable).__index).GetHeroResCfg = function(self)
    -- function num : 0_0_0 , upvalues : _ENV
    if self.action_type == eItemActionType.HeroCard or self.action_type == eItemActionType.HeroCardFrag then
      local heroId = (self.arg)[1]
      local heroCfg = (ConfigData.hero_data)[heroId]
      if heroCfg == nil then
        return heroCfg
      end
      local resCfg = (ConfigData.resource_model)[heroCfg.src_id]
      return resCfg
    end
    do
      return nil
    end
  end

  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((ConfigData.hero_data).__basemetatable).__index).GetHeroResCfg = function(self)
    -- function num : 0_0_1 , upvalues : _ENV
    local resCfg = (ConfigData.resource_model)[self.src_id]
    return resCfg
  end

  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((ConfigData.guide).__basemetatable).__index).GetFirstCondition = function(self)
    -- function num : 0_0_2 , upvalues : _ENV
    local firstId = (self.step_list)[1]
    if firstId == nil then
      return 0
    end
    local stepCfg = (ConfigData.guide_step)[firstId]
    if stepCfg == nil then
      error("guide step cfg is null,id:" .. tostring(firstId))
      return 0
    end
    return stepCfg.condition, stepCfg.condition_arg
  end

end

InitSectorStageAvg = function()
  -- function num : 0_1 , upvalues : _ENV, CheckerTypeId
  local avgUnlockDic = {}
  local stageUnlockDic = {}
  local addDependFunc = function(cfg, id, checkerTypeId)
    -- function num : 0_1_0 , upvalues : _ENV, CheckerTypeId, stageUnlockDic, avgUnlockDic
    for k,condition in ipairs(cfg.pre_condition) do
      local para1 = (cfg.pre_para1)[k]
      if condition == CheckerTypeId.CompleteStage then
        local unlockDic = stageUnlockDic[para1]
        if unlockDic == nil then
          unlockDic = {}
          stageUnlockDic[para1] = unlockDic
        end
        unlockDic[id] = checkerTypeId
      else
        do
          do
            if condition == CheckerTypeId.CompleteAvg then
              local unlockDic = avgUnlockDic[para1]
              if unlockDic == nil then
                unlockDic = {}
                avgUnlockDic[para1] = unlockDic
              end
              unlockDic[id] = checkerTypeId
            end
            -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end

  for stageId,stageCfg in pairs(ConfigData.sector_stage) do
    if type(stageId) == "number" then
      addDependFunc(stageCfg, stageId, CheckerTypeId.CompleteStage)
    end
  end
  for avgId,avgCfg in pairs(ConfigData.story_avg) do
    if type(avgId) == "number" or avgCfg.type ~= eAvgTriggerType.MainAvg then
      addDependFunc(avgCfg, avgId, CheckerTypeId.CompleteAvg)
    end
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (ConfigData.sector).avgUnlockDic = avgUnlockDic
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (ConfigData.sector).stageUnlockDic = stageUnlockDic
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.InitConfigData = function(self)
  -- function num : 0_2 , upvalues : DefineConfigDataFunc, _ENV
  self.DynConfigNum = {}
  DefineConfigDataFunc()
  InitSectorStageAvg()
  self.buildinConfig = require("Game.ConfigData.BuildinConfig")
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.game_config).heroMaxCamp = (table.count)(ConfigData.camp)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.game_config).heroMaxCareer = (table.count)(ConfigData.career)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.LoadDynCfg = function(self, type)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if ConfigData[type] == nil then
    ConfigData[type] = require("LuaConfigs." .. type)
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.DynConfigNum)[type] = ((self.DynConfigNum)[type] or 0) + 1
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.ReleaseDynCfg = function(self, type)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.DynConfigNum)[type] = ((self.DynConfigNum)[type] or 0) - 1
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  if (self.DynConfigNum)[type] <= 0 then
    ConfigData[type] = nil
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (package.loaded)["LuaConfigs." .. type] = nil
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.DynConfigNum)[type] = nil
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.ForceReleaseDynCfg = function(self, type)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  ConfigData[type] = nil
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (package.loaded)["LuaConfigs." .. type] = nil
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetCampFetter = function(self, camp, number)
  -- function num : 0_6
  local fetterList = ((self.camp_connection).fetterList)[camp]
  if fetterList == nil then
    return nil
  end
  for i = #fetterList, 1, -1 do
    local curNum = fetterList[i]
    if curNum <= number then
      return ((self.camp_connection)[camp])[curNum]
    end
  end
  return nil
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetCareerIcon = function(self, career)
  -- function num : 0_7
  local careerCfg = (self.career)[career]
  if careerCfg == nil then
    return nil
  end
  return careerCfg.icon
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetCampIcon = function(self, camp)
  -- function num : 0_8
  local campCfg = (self.camp)[camp]
  if campCfg == nil then
    return nil
  end
  return campCfg.icon
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetAudioCategoryCfg = function(self, id)
  -- function num : 0_9 , upvalues : _ENV
  local cfg = (self.audio_category)[id]
  if cfg == nil then
    error("Can\'t find audio_category, id = " .. tostring(id))
    return 
  end
  return cfg.category, cfg.aisac
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetVoicePointRandom = function(self, voPointId)
  -- function num : 0_10 , upvalues : _ENV
  local cfg = (self.audio_voice_point)[voPointId]
  if cfg == nil then
    error("Can\'t get audio_voice_point cfg, voPointId = " .. tostring(voPointId))
    return nil
  end
  local index = (math.random)(#cfg.vo_list)
  return (cfg.vo_list)[index]
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetAttribute = function(self, attrId, value)
  -- function num : 0_11 , upvalues : _ENV
  local cfg = (self.attribute)[attrId]
  if cfg == nil then
    error("Can\'t find attribute, id = " .. tostring(attrId))
    return 
  end
  local name = ((LanguageUtil.GetLocaleText)(cfg.name))
  local valueStr = nil
  if value ~= nil then
    if type(value) == "table" then
      valueStr = {}
      for index,val in ipairs(value) do
        if cfg.num_type == 1 then
          valueStr[index] = tostring(val)
        else
          valueStr[index] = tostring(FormatNum(val / 10)) .. "%"
        end
      end
    else
      do
        if type(value) == "number" then
          if cfg.num_type == 1 then
            valueStr = tostring(value)
          else
            valueStr = tostring(FormatNum(value / 10)) .. "%"
          end
        end
        return name, valueStr, cfg.icon
      end
    end
  end
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetFormulaValue = function(formulaId, tab)
  -- function num : 0_12 , upvalues : _ENV
  local cfg = (ConfigData.attr_combat)[formulaId]
  if cfg == nil or cfg.formula == nil or cfg.formula == "" then
    error("Cant get attr_combat.formula, formulaId = " .. tostring(formulaId))
    return 0
  end
  local formulaFunc = cfg.formula
  if type(formulaFunc) ~= "function" then
    formulaFunc = (load("return function(tab) return " .. formulaFunc .. " end"))()
    cfg.formula = formulaFunc
  end
  local power = formulaFunc(tab)
  return power
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetAddictionCfg = function(self, age)
  -- function num : 0_13 , upvalues : _ENV
  local cfg = nil
  for _,ageRange in ipairs((self.anti_addiction).id_sort_list) do
    if age < ageRange then
      cfg = (self.anti_addiction)[ageRange]
      break
    end
  end
  do
    return cfg
  end
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetTipContent = function(self, id)
  -- function num : 0_14 , upvalues : _ENV
  if type(id) ~= "number" then
    id = 1
  end
  local tipCfg = (ConfigData.tip_language)[id]
  if tipCfg == nil then
    return (LanguageUtil.GetLocaleText)(((ConfigData.tip_language)[1]).content)
  end
  return (LanguageUtil.GetLocaleText)(tipCfg.content)
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetFormationHeroCount = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local count = (ConfigData.game_config).max_stage_hero
  for i = 1, (ConfigData.game_config).max_bench_hero do
    local sysFuncId = proto_csmsg_SystemFunctionID["SystemFunctionID_bench" .. tostring(i)]
    local unlock = FunctionUnlockMgr:ValidateUnlock(sysFuncId)
    if unlock then
      count = count + 1
    end
  end
  return count
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.IsManualOpenGiftItem = function(self, itemCfg)
  -- function num : 0_16 , upvalues : _ENV
  if itemCfg == nil then
    return false
  end
  local action_type = itemCfg.action_type
  do return action_type == proto_csmsg_ItemActionType.ItemActionTypeFixedItem or action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift or action_type == proto_csmsg_ItemActionType.ItemActionTypeRandomReward end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.IsManualOpenItem = function(self, itemCfg)
  -- function num : 0_17
  do return itemCfg.available or 0 > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetChipDescriptionById = function(self, chipId, num, isShowDetail)
  -- function num : 0_18 , upvalues : _ENV, cs_GameData
  local showDetail = isShowDetail == nil or isShowDetail == true
  local description = ""
  local chipCfg = (ConfigData.chip)[chipId]
  if chipCfg == nil then
    error("Can\'t find chip cfg, id = " .. tostring(chipId))
    return description
  end
  if #chipCfg.skill_list > 0 then
    local skillId = (chipCfg.skill_list)[1]
    local skillCfg = (cs_GameData.listBattleSkillDatas):GetDataById(skillId)
    if skillCfg == nil then
      error("Can\'t find skillCfg, id = " .. tostring(skillId))
      return description
    end
    description = skillCfg:GetLevelDescribe(num, false, showDetail)
  elseif #chipCfg.attribute_id > 0 then
    local attrId = (chipCfg.attribute_id)[1]
    local initValue = (chipCfg.attribute_initial)[1]
    local fluenceIntro = ConfigData:GetChipinfluenceIntro(chipCfg.id)
    local increaseVal = (chipCfg.level_increase)[1]
    local attrInfo = (BattleUtil.GetChipAttrInfo)(attrId, initValue, increaseVal, num)
    description = fluenceIntro .. attrInfo
  end
  do return description end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetChipinfluenceIntro = function(self, chipId)
  -- function num : 0_19 , upvalues : _ENV
  local chipCfg = (ConfigData.chip)[chipId]
  if chipCfg == nil then
    return ""
  end
  local introCfg1 = (ConfigData.chip_intro)[chipCfg.influence]
  if introCfg1 == nil then
    return ""
  end
  local intro_type = ((ConfigData.chip_intro).influence_type)[chipCfg.influence]
  local content = ""
  if intro_type == 0 then
    local introCfg2 = introCfg1[chipCfg.arg]
    if introCfg2 ~= nil then
      content = (LanguageUtil.GetLocaleText)(introCfg2.intro)
    end
  else
    do
      if intro_type == 1 then
        local careerCfg = (ConfigData.career)[chipCfg.arg]
        local introCfg2 = introCfg1[0]
        if careerCfg ~= nil and introCfg2 ~= nil then
          content = (string.format)((LanguageUtil.GetLocaleText)(introCfg2.intro), (LanguageUtil.GetLocaleText)(careerCfg.name))
        end
      else
        do
          if intro_type == 2 then
            local campCfg = (ConfigData.camp)[chipCfg.arg]
            local introCfg2 = introCfg1[0]
            if campCfg ~= nil and introCfg2 ~= nil then
              content = (string.format)((LanguageUtil.GetLocaleText)(introCfg2.intro), (LanguageUtil.GetLocaleText)(campCfg.name))
            end
          else
            do
              if intro_type == 3 then
                local heroCfg = (ConfigData.hero_data)[chipCfg.arg]
                local introCfg2 = introCfg1[0]
                if heroCfg ~= nil and introCfg2 ~= nil then
                  content = (string.format)((LanguageUtil.GetLocaleText)(introCfg2.intro), (LanguageUtil.GetLocaleText)(heroCfg.name))
                end
              end
              do
                return content
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetChipQuality = function(self, count)
  -- function num : 0_20 , upvalues : _ENV
  if count <= 0 then
    return eItemQualityType.Blue
  end
  if not eChipLevelToQaulity[count] then
    return eItemQualityType.Orange
  end
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetChipQualityColor = function(self, count)
  -- function num : 0_21 , upvalues : _ENV
  return ItemQualityColor[ConfigData:GetChipQuality(count)]
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetItemType = function(self, itemId)
  -- function num : 0_22 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    return 0
  end
  return itemCfg.type
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetItemName = function(self, itemId)
  -- function num : 0_23 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    return ""
  end
  return (LanguageUtil.GetLocaleText)(itemCfg.name)
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.CalculateEpChipSalePrice = function(self, epRoomId, chipLvl, chipPrice, dynPlayer)
  -- function num : 0_24 , upvalues : _ENV
  local shopCfg = (ConfigData.exploration_shop)[epRoomId]
  if shopCfg == nil then
    error("exploration shop is null,id:" .. tostring(epRoomId))
    return 0
  end
  local levels = shopCfg.discount_level
  local disCount = shopCfg.discount_scale
  local levelCount = #levels
  if dynPlayer ~= nil then
    local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
    local scaleNum = dynPlayer:GetSpecificBuffLogicPerPara((ExplorationEnum.eBuffLogicId).sealChipScale)
    if scaleNum ~= nil and scaleNum ~= 0 then
      return (math.floor)(chipPrice * (scaleNum / 100))
    end
  end
  do
    if levelCount <= 0 then
      return chipPrice
    end
    local index = 1
    for i = 1, levelCount do
      if levels[i] < 0 then
        index = i
        break
      end
      if chipLvl <= levels[i] then
        index = i
        break
      end
    end
    do
      return chipPrice * disCount[index] // 1000
    end
  end
end

-- DECOMPILER ERROR at PC88: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.CalculateEpChipDiscardSalePrice = function(self, discardId, chipLvl, chipPrice, dynPlayer)
  -- function num : 0_25 , upvalues : _ENV
  local discardCfg = (ConfigData.exploration_discard)[discardId]
  if discardCfg == nil then
    error("exploration discard cfg is null,id:" .. tostring(discardId))
    return 0
  end
  local levels = discardCfg.discard_level
  local disCount = discardCfg.discard_scaleValues
  local levelCount = #levels
  if dynPlayer ~= nil then
    local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
    local scaleNum = dynPlayer:GetSpecificBuffLogicPerPara((ExplorationEnum.eBuffLogicId).sealChipScale)
    if scaleNum ~= nil and scaleNum ~= 0 then
      return (math.floor)(chipPrice * (scaleNum / 100))
    end
  end
  do
    if levelCount <= 0 then
      return chipPrice
    end
    local index = 1
    for i = 1, levelCount do
      if levels[i] < 0 then
        index = i
        break
      end
      if chipLvl <= levels[i] then
        index = i
        break
      end
    end
    do
      return chipPrice * disCount[index] // 1000
    end
  end
end

-- DECOMPILER ERROR at PC91: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.CalculateEpChipUpgradePrice = function(self, epRoomId, refreshTimes)
  -- function num : 0_26 , upvalues : _ENV
  local refreshTimeCfg = ((ConfigData.event_upgrade)[epRoomId]).refresh_times
  local price = ((ConfigData.event_upgrade)[epRoomId]).prices
  return self:CalculatePriceGeneralFunc(refreshTimes, refreshTimeCfg, price)
end

-- DECOMPILER ERROR at PC94: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.CalculatePriceGeneralFunc = function(self, currentTime, cfgTimes, cfgPrices)
  -- function num : 0_27
  local currentTime = currentTime + 1
  local refreshTimeCfgCount = #cfgTimes
  for i = 1, refreshTimeCfgCount do
    -- DECOMPILER ERROR at PC12: Unhandled construct in 'MakeBoolean' P1

    if i <= 1 and currentTime <= cfgTimes[1] then
      return cfgPrices[1]
    end
    -- DECOMPILER ERROR at PC21: Unhandled construct in 'MakeBoolean' P1

    if refreshTimeCfgCount <= i and cfgTimes[i - 1] < currentTime then
      return cfgPrices[refreshTimeCfgCount]
    end
    if cfgTimes[i - 1] < currentTime and currentTime <= cfgTimes[i] then
      return cfgPrices[i]
    end
  end
  return cfgPrices[refreshTimeCfgCount]
end

-- DECOMPILER ERROR at PC97: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetPerformanceTypeinfoByName = function(self, name)
  -- function num : 0_28 , upvalues : _ENV
  local id = ((ConfigData.performance_typeinfo).name_index)[name]
  if id == nil then
    error("performance_typeinfo cfg is null,name:" .. tostring(name))
    return nil
  end
  local typeinfoCfg = (ConfigData.performance_typeinfo)[id]
  if typeinfoCfg == nil then
    error("performance_typeinfo cfg is null,id:" .. tostring(id))
  end
  return typeinfoCfg
end

-- DECOMPILER ERROR at PC100: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetResModelCfg = function(self, id)
  -- function num : 0_29 , upvalues : _ENV
  return (ConfigData.resource_model)[id]
end

-- DECOMPILER ERROR at PC103: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetResNameByHeroId = function(self, heroId)
  -- function num : 0_30 , upvalues : _ENV
  local heroCfg = (ConfigData.hero_data)[heroId]
  if heroCfg == nil then
    error("[GetResNameByHeroId] hero cfg is null,id:" .. tostring(heroId))
    return ""
  end
  local resModelCfg = (ConfigData.resource_model)[heroCfg.src_id]
  if resModelCfg == nil then
    error("[GetResNameByHeroId] resource_model cfg is null,id:" .. tostring(heroCfg.src_id))
    return ""
  end
  return resModelCfg.res_Name
end

-- DECOMPILER ERROR at PC106: Confused about usage of register: R5 in 'UnsetPending'

ConfigData.GetSectorIdShow = function(self, sectorId)
  -- function num : 0_31 , upvalues : SectorEnum
  return sectorId ~= SectorEnum.NewbeeSectorId and sectorId or 0
end


