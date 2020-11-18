-- params : ...
-- function num : 0 , upvalues : _ENV
ConfigData = {}
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
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
  (((ConfigData.camp_connection).__basemetatable).__index).GetDescribe = function(self)
    -- function num : 0_0_2 , upvalues : _ENV
    return (GR.StringFormatIntArray)((LanguageUtil.GetLocaleText)(self.text), self.para)
  end

  -- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((ConfigData.guide).__basemetatable).__index).GetFirstCondition = function(self)
    -- function num : 0_0_3 , upvalues : _ENV
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

-- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

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

-- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

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

-- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

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

-- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

ConfigData.ForceReleaseDynCfg = function(self, type)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  ConfigData[type] = nil
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (package.loaded)["LuaConfigs." .. type] = nil
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

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

-- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

ConfigData.GetCareerIcon = function(self, career)
  -- function num : 0_7
  local careerCfg = (self.career)[career]
  if careerCfg == nil then
    return nil
  end
  return careerCfg.icon
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

ConfigData.GetCampIcon = function(self, camp)
  -- function num : 0_8
  local campCfg = (self.camp)[camp]
  if campCfg == nil then
    return nil
  end
  return campCfg.icon
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

ConfigData.GetAudioCfg = function(self, audioId)
  -- function num : 0_9 , upvalues : _ENV
  local cfg = (self.audio)[audioId]
  if cfg == nil then
    error("Can\'t find audioCfg, id = " .. tostring(audioId))
    return 
  end
  return cfg.name, ((self.audio).sheetList)[cfg.sheet], cfg.type
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

ConfigData.GetAudioCategoryCfg = function(self, id)
  -- function num : 0_10 , upvalues : _ENV
  local cfg = (self.audio_category)[id]
  if cfg == nil then
    error("Can\'t find audio_category, id = " .. tostring(id))
    return 
  end
  return cfg.category, cfg.aisac
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

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
    if cfg.num_type == 1 then
      valueStr = tostring(value)
    else
      valueStr = tostring(FormatNum(value / 10)) .. "%"
    end
  end
  return name, valueStr, cfg.icon
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

ConfigData.GetAddictionCfg = function(self, age)
  -- function num : 0_12 , upvalues : _ENV
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

-- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

ConfigData.GetTipContent = function(self, id)
  -- function num : 0_13 , upvalues : _ENV
  if type(id) ~= "number" then
    id = 1
  end
  local tipCfg = (ConfigData.tip_language)[id]
  if tipCfg == nil then
    return (LanguageUtil.GetLocaleText)(((ConfigData.tip_language)[1]).content)
  end
  return (LanguageUtil.GetLocaleText)(tipCfg.content)
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

ConfigData.GetFormationHeroCount = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local count = (ConfigData.game_config).max_stage_hero
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  for i = 1, (ConfigData.game_config).max_bench_hero do
    local sysFuncId = proto_csmsg_SystemFunctionID["SystemFunctionID_bench" .. tostring(i)]
    local unlock = funcUnLockCrtl:ValidateUnlock(sysFuncId)
    if unlock then
      count = count + 1
    end
  end
  return count
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R3 in 'UnsetPending'

ConfigData.GetChipinfluenceIntro = function(self, chipId)
  -- function num : 0_15 , upvalues : _ENV
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

-- DECOMPILER ERROR at PC55: Confused about usage of register: R3 in 'UnsetPending'

ConfigData.GetItemType = function(self, itemId)
  -- function num : 0_16 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    return 0
  end
  return itemCfg.type
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R3 in 'UnsetPending'

ConfigData.CalculateEpChipSalePrice = function(self, epRoomId, chipLvl, chipPrice)
  -- function num : 0_17 , upvalues : _ENV
  local levels = ((ConfigData.exploration_shop)[epRoomId]).discount_level
  local disCount = ((ConfigData.exploration_shop)[epRoomId]).discount_scale
  local levelCount = #levels
  for i = 1, levelCount do
    -- DECOMPILER ERROR at PC22: Unhandled construct in 'MakeBoolean' P1

    if i <= 1 and chipLvl <= levels[1] then
      return chipPrice * disCount[1] * chipLvl // 1000
    end
    -- DECOMPILER ERROR at PC34: Unhandled construct in 'MakeBoolean' P1

    if levelCount <= i and levels[i - 1] < chipLvl then
      return chipPrice * disCount[i] * chipLvl // 1000
    end
    if levels[i - 1] < chipLvl and chipLvl <= levels[i] then
      return chipPrice * disCount[i] * chipLvl // 1000
    end
  end
  return chipPrice
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R3 in 'UnsetPending'

ConfigData.CalculateEpChipUpgradePrice = function(self, epRoomId, refreshTimes)
  -- function num : 0_18 , upvalues : _ENV
  local currentTime = refreshTimes + 1
  local refreshTimeCfg = ((ConfigData.event_upgrade)[epRoomId]).refresh_times
  local price = ((ConfigData.event_upgrade)[epRoomId]).prices
  local refreshTimeCfgCount = #refreshTimeCfg
  for i = 1, refreshTimeCfgCount do
    -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

    if i <= 1 and currentTime <= refreshTimeCfg[1] then
      return price[1]
    end
    -- DECOMPILER ERROR at PC29: Unhandled construct in 'MakeBoolean' P1

    if refreshTimeCfgCount <= i and refreshTimeCfg[i - 1] < currentTime then
      return price[refreshTimeCfgCount]
    end
    if refreshTimeCfg[i - 1] < currentTime and currentTime <= refreshTimeCfg[i] then
      return price[i]
    end
  end
  return price[refreshTimeCfgCount]
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R3 in 'UnsetPending'

ConfigData.GetResModelCfg = function(self, id)
  -- function num : 0_19 , upvalues : _ENV
  return (ConfigData.resource_model)[id]
end


