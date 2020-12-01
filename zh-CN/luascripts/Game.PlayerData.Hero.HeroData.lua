-- params : ...
-- function num : 0 , upvalues : _ENV
local HeroData = class("HeroData")
local HeroSkillData = require("Game.PlayerData.Skill.HeroSkillData")
local attrIdOffset = 100
HeroData.ctor = function(self, data)
  -- function num : 0_0 , upvalues : _ENV, HeroSkillData
  local baseData = data.basic
  self.dataId = baseData.id
  self.level = baseData.level
  self.curExp = baseData.exp
  self.ts = baseData.ts
  self.rank = baseData.star
  self:UpdateHeroRank(self.rank)
  local heroCfg = (ConfigData.hero_data)[self.dataId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(self.dataId))
    return 
  end
  self.heroCfg = heroCfg
  self.camp = heroCfg.camp
  self.career = heroCfg.career
  self:__UpdateBaseArriDic()
  self.skillDic = {}
  self.skillList = {}
  for k,skillId in ipairs(heroCfg.skill_list) do
    local skillData = (HeroSkillData.New)(skillId, self)
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.skillDic)[skillId] = skillData
    ;
    (table.insert)(self.skillList, skillData)
  end
  ;
  (table.sort)(self.skillList, function(skillData1, skillData2)
    -- function num : 0_0_0
    local isCommonAttack1 = skillData1:IsCommonAttack()
    local isCommonAttack2 = skillData2:IsCommonAttack()
    local isPassive1 = skillData1:IsPassiveSkill()
    local isPassive2 = skillData2:IsPassiveSkill()
    local isUskill1 = skillData2:IsUniqueSkill()
    local isUskill2 = skillData2:IsUniqueSkill()
    if isPassive1 == isPassive2 then
      if isUskill1 == isUskill2 then
        if skillData1.dataId >= skillData2.dataId then
          do return isCommonAttack1 ~= isCommonAttack2 end
          do return not isUskill1 end
          do return isPassive1 end
          do return isCommonAttack1 end
          -- DECOMPILER ERROR: 5 unprocessed JMP targets
        end
      end
    end
  end
)
  if data.skill ~= nil then
    for skillId,skillLevel in pairs((data.skill).data) do
      local skillData = (self.skillDic)[skillId]
      if skillData ~= nil then
        skillData:UpdateSkill(skillLevel)
      end
    end
  end
  do
    self.fragId = heroCfg.fragment
    local resCfg = (ConfigData.resource_model)[heroCfg.src_id]
    if resCfg == nil then
      error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    end
    self.resCfg = resCfg
  end
end

HeroData.UpdateHeroData = function(self, data)
  -- function num : 0_1 , upvalues : _ENV
  local baseData = data.basic
  if baseData.level == self.level and self.rank == baseData.star then
    do
      local attrChange = baseData == nil
      self.level = baseData.level
      self.curExp = baseData.exp
      self.rank = baseData.star
      self:UpdateHeroRank(self.rank)
      self.ts = baseData.ts
      if attrChange then
        self:__UpdateBaseArriDic()
      end
      if data.skill ~= nil then
        for skillId,skillLevel in pairs((data.skill).data) do
          local skillData = (self.skillDic)[skillId]
          if skillData ~= nil then
            skillData:UpdateSkill(skillLevel)
          end
        end
      end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
end

HeroData.GetAttr = function(self, attrId, withoutAth, dontWarning)
  -- function num : 0_2 , upvalues : attrIdOffset, _ENV
  local athHeroId = self.dataId
  if withoutAth then
    athHeroId = nil
  end
  local baseAttrId = attrId + attrIdOffset
  local atrValue = (self.baseAttrDic)[attrId]
  atrValue = (PlayerDataCenter.attributeBonus):AtrBonusAdd(atrValue, attrId, baseAttrId, self.camp, self.career, athHeroId)
  local ratioAttrId = baseAttrId + attrIdOffset
  atrValue = (PlayerDataCenter.attributeBonus):AtrBonusAdd(atrValue, attrId, ratioAttrId, self.camp, self.career, athHeroId)
  atrValue = atrValue + ((self.heroStarCfg)[attrId] or 0)
  atrValue = (PlayerDataCenter.attributeBonus):AtrBonusAdd(atrValue, attrId, attrId, self.camp, self.career, athHeroId)
  if isGameDev and not dontWarning and not withoutAth then
    (PlayerDataCenter.heroAttrChecker):DirtyPlayerHeroAttri(self.dataId, attrId, atrValue)
  end
  return atrValue
end

HeroData.GetNewLevelAttr = function(self, attrId, newLevel, newRank)
  -- function num : 0_3
  self:__UpdateBaseArriDic(newLevel, newRank)
  local answer = self:GetAttr(attrId, nil, true)
  self:__UpdateBaseArriDic()
  return answer
end

HeroData.__UpdateBaseArriDic = function(self, newLevel, newRank)
  -- function num : 0_4 , upvalues : _ENV
  if not newRank then
    local rank = self.rank
  end
  if not newLevel then
    local level = self.level
  end
  local baseAttrDic = setmetatable({}, {__index = function(tab, key)
    -- function num : 0_4_0
    return 0
  end
})
  self.baseAttrDic = baseAttrDic
  if (ConfigData.hero_star)[self.dataId] == nil or ((ConfigData.hero_star)[self.dataId])[self.rank] == nil then
    error((string.format)("Can\'t get heroStarCfg, heroId = %s,rank = %s", self.dataId, self.rank))
    return 
  end
  local heroStarCfg = ((ConfigData.hero_star)[self.dataId])[rank]
  self.heroStarCfg = heroStarCfg
  local heroLevelCfg = (ConfigData.hero_level)[level]
  if heroLevelCfg == nil then
    error("Can\'t find heroLevelCfg, level = " .. tostring(self.level))
    return 
  end
  for k,v in pairs(heroStarCfg.atrGrowthDic) do
    baseAttrDic[k - 100] = v * heroLevelCfg.level_growth // 1000000 + ((heroStarCfg.atrExtraDic)[k] or 0)
  end
  for k,v in pairs(heroStarCfg.atrBaseDic) do
    local id = k - 100
    baseAttrDic[id] = baseAttrDic[id] + v
  end
  baseAttrDic[8] = (self.heroCfg).move_spd
  baseAttrDic[16] = (self.heroCfg).range
end

HeroData.GetName = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.heroCfg).name)
end

HeroData.GetResName = function(self)
  -- function num : 0_6
  return (self.resCfg).res_Name
end

HeroData.GetExtendResName = function(self)
  -- function num : 0_7
  return (self.resCfg).extend_res
end

HeroData.GetEnName = function(self)
  -- function num : 0_8 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.heroCfg).name_en)
end

HeroData.GetTag = function(self)
  -- function num : 0_9
  return (self.heroCfg).tag
end

HeroData.GetCareerCfg = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local careerCfg = (ConfigData.career)[self.career]
  return careerCfg
end

HeroData.GetCampCfg = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local campCfg = (ConfigData.camp)[self.camp]
  return campCfg
end

HeroData.GetHeroFragCount = function(self)
  -- function num : 0_12 , upvalues : _ENV
  return PlayerDataCenter:GetItemCount((self.heroCfg).fragment)
end

HeroData.IsFullRank = function(self)
  -- function num : 0_13 , upvalues : _ENV
  do return (ConfigData.hero_rank).maxRank <= self.rank end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HeroData.UpdateHeroRank = function(self, rank)
  -- function num : 0_14 , upvalues : _ENV
  local rankCfg = (ConfigData.hero_rank)[rank]
  if rankCfg == nil then
    error("Can\'t find rankCfg, id = " .. tostring(rank))
    return 
  end
  self.rankCfg = rankCfg
  self.star = rankCfg.star
  self.rare = rankCfg.rare
end

HeroData.StarNeedFrag = function(self)
  -- function num : 0_15
  if self:IsFullRank() then
    return 0
  end
  return (self.rankCfg).upgrade_star_frag_cost
end

HeroData.StarNeedCurrencyNum = function(self)
  -- function num : 0_16
  if self:IsFullRank() then
    return 0
  end
  local extra_cost = (self.rankCfg).upgrade_star_extra_cost
  if extra_cost[1] ~= nil then
    return (extra_cost[1]).itemId, (extra_cost[1]).num
  end
end

HeroData.StarNeedItemNum = function(self)
  -- function num : 0_17
  if self:IsFullRank() then
    return 0
  end
  local extra_cost = (self.rankCfg).upgrade_star_extra_cost
  if extra_cost[2] ~= nil then
    return (extra_cost[2]).itemId, (extra_cost[2]).num
  end
end

HeroData.AbleUpLevel = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self:IsFullLevel() then
    return false
  end
  for _,id in ipairs(((ConfigData.item).growUpIds)[eItemActionType.HeroExp]) do
    if (PlayerDataCenter.itemDic)[id] ~= nil then
      return true
    end
  end
  return false
end

HeroData.AbleUpgradeStar = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if self:IsFullRank() then
    return false
  end
  local id, num = nil, nil
  local fitFrag = self:StarNeedFrag() <= self:GetHeroFragCount()
  local fitCurrency, fitItem = nil, nil
  id = self:StarNeedCurrencyNum()
  if num > PlayerDataCenter:GetItemCount(id) then
    fitCurrency = id == nil
    fitCurrency = true
    -- DECOMPILER ERROR at PC34: Overwrote pending register: R2 in 'AssignReg'

    id = self:StarNeedItemNum()
    if num > PlayerDataCenter:GetItemCount(id) then
      fitItem = id == nil
      fitItem = true
      do return not fitFrag or not fitCurrency or fitItem, fitFrag, fitCurrency, fitItem end
      -- DECOMPILER ERROR: 8 unprocessed JMP targets
    end
  end
end

HeroData.GetDifferAttrWhenRankUp = function(self, newRank, newLevel)
  -- function num : 0_20 , upvalues : _ENV
  local changeList = {}
  for _,attrId in pairs((ConfigData.attribute).baseAttrIds) do
    local oldAttr = self:GetAttr(attrId, nil, false)
    local newAttr = self:GetNewLevelAttr(attrId, newLevel, newRank)
    if oldAttr ~= newAttr then
      (table.insert)(changeList, {attrId = attrId, property = ((ConfigData.attribute)[attrId]).attribute_priority, oldAttr = oldAttr, newAttr = newAttr})
    end
  end
  return changeList
end

HeroData.IsFullLevel = function(self)
  -- function num : 0_21 , upvalues : _ENV
  do return (PlayerDataCenter.playerBonus):GetHeroLevelCeiling() <= self.level end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HeroData.GetExpRatio = function(self)
  -- function num : 0_22
  local totalExp = self:GetLevelTotalExp()
  if totalExp == 0 then
    return 0
  end
  return self.curExp / totalExp
end

HeroData.GetExpByLevel = function(self, level)
  -- function num : 0_23 , upvalues : _ENV
  local levelCfg = (ConfigData.hero_level)[level]
  if levelCfg ~= nil then
    return levelCfg.exp
  end
  return 0
end

HeroData.GetLevelTotalExp = function(self)
  -- function num : 0_24
  return self:GetExpByLevel(self.level)
end

HeroData.GetUpgradeLevelProcess = function(self, oldLevel, oldExp, getExp)
  -- function num : 0_25 , upvalues : _ENV
  local fromlist = {}
  local tolist = {}
  if getExp <= 0 then
    return fromlist, tolist
  end
  getExp = getExp + oldExp
  local heroMaxLevel = (PlayerDataCenter.playerBonus):GetHeroLevelCeiling()
  for i = oldLevel, heroMaxLevel - 1 do
    local levelCfg = (ConfigData.hero_level)[i]
    if levelCfg == nil then
      error("hero level cfg is null,id:" .. tostring(i))
      break
    end
    local curLevelTotalExp = levelCfg.exp
    if i == oldLevel then
      (table.insert)(fromlist, oldExp)
    else
      ;
      (table.insert)(fromlist, 0)
    end
    if getExp < curLevelTotalExp then
      (table.insert)(tolist, getExp)
      break
    else
      if getExp == curLevelTotalExp then
        (table.insert)(tolist, curLevelTotalExp)
        ;
        (table.insert)(fromlist, 0)
        ;
        (table.insert)(tolist, 0)
        break
      else
        getExp = getExp - curLevelTotalExp
        ;
        (table.insert)(tolist, curLevelTotalExp)
        if i + 1 == heroMaxLevel then
          (table.insert)(fromlist, 0)
          ;
          (table.insert)(tolist, 0)
          break
        end
      end
    end
  end
  do
    return fromlist, tolist
  end
end

HeroData.AddTestExp = function(self, exp)
  -- function num : 0_26 , upvalues : _ENV
  local nextExp = 0
  local nextTotalExp = self:GetLevelTotalExp()
  local overflowExp = 0
  local testExp = exp + self.curExp
  local testLevel = self.level
  local heroMaxLevel = (PlayerDataCenter.playerBonus):GetHeroLevelCeiling()
  for i = self.level, heroMaxLevel - 1 do
    local levelCfg = (ConfigData.hero_level)[i]
    if levelCfg == nil then
      error("hero level cfg is null,level:" .. tostring(i))
      return testLevel, nextExp, nextTotalExp, overflowExp
    end
    nextTotalExp = levelCfg.exp
    if testExp >= levelCfg.exp then
      do
        testExp = testExp - levelCfg.exp
        testLevel = i + 1
        -- DECOMPILER ERROR at PC39: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC39: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  if testLevel == heroMaxLevel then
    nextExp = 0
    overflowExp = testExp
  else
    nextExp = testExp
    overflowExp = 0
  end
  return testLevel, nextExp, nextTotalExp, overflowExp
end

HeroData.GetHeroExpAddFromLevel = function(self, fromLevel, fromExp)
  -- function num : 0_27 , upvalues : _ENV
  if fromLevel == self.level then
    return self.curExp - fromExp
  end
  local needExp = 0
  for i = fromLevel, self.level do
    local levelCfg = (ConfigData.hero_level)[i]
    if levelCfg == nil then
      error("hero level cfg is null,level:" .. tostring(i))
      return 0
    end
    if i == fromLevel then
      needExp = needExp + levelCfg.exp - fromExp
    else
      if i == self.level then
        needExp = needExp + self.curExp
      else
        needExp = needExp + levelCfg.exp
      end
    end
  end
  return needExp
end

HeroData.GetAthSlotList = function(self, fullSpace)
  -- function num : 0_28 , upvalues : _ENV
  local athslotList = {}
  local level = self.level
  local rank = self.rank
  local athSlotLevel = (PlayerDataCenter.allAthData):GetHeroAthSlotInfo(self.dataId)
  if fullSpace then
    level = (PlayerDataCenter.playerBonus):GetHeroLevelCeiling()
    rank = (ConfigData.hero_rank).maxRank
    athSlotLevel = (ConfigData.ath_efficiency).maxLevel
  end
  local baseSpaceCfg = (self.heroCfg).algorithm_space
  local levelSpaceCfg = ((ConfigData.hero_level)[level]).algorithm_space
  local starSpaceCfg = (((ConfigData.hero_star)[self.dataId])[rank]).algorithm_space
  local athEfccSpaceCfg = ((ConfigData.ath_efficiency)[athSlotLevel]).algorithm_space
  if #baseSpaceCfg ~= #starSpaceCfg or #baseSpaceCfg ~= #levelSpaceCfg or #baseSpaceCfg ~= #athEfccSpaceCfg then
    error("Hero algorithm_space Config error, heroId = " .. tostring(self.dataId))
    return athslotList
  end
  if (ConfigData.game_config).athSlotCount < #baseSpaceCfg then
    error("Hero algorithm_space Config error, heroId = " .. tostring(self.dataId))
    return athslotList
  end
  for k,v in ipairs(baseSpaceCfg) do
    local space = v + levelSpaceCfg[k] + starSpaceCfg[k] + athEfccSpaceCfg[k]
    athslotList[k] = space
  end
  return athslotList
end

HeroData.AbleUpgradeSkill = function(self)
  -- function num : 0_29 , upvalues : _ENV
  for _,skillData in ipairs(self.skillList) do
    if skillData:CanUpgrade() then
      return true
    end
  end
  return false
end

HeroData.GetFormulaAttr = function(self, attrEnum)
  -- function num : 0_30 , upvalues : _ENV
  local attrId = (GR.EnumToInt)(attrEnum)
  if attrId == eHeroAttr.hp then
    return self:GetAttr(eHeroAttr.maxHp, nil, true)
  else
    if attrId == eHeroAttr.intensity then
      return (self.heroCfg).intensity
    else
      if attrId == eHeroAttr.attack_range then
        return (self.heroCfg).range
      else
        return self:GetAttr(attrId, self.__getFmlAttrWithoutAth, true)
      end
    end
  end
end

HeroData.GetSkillFightingPower = function(self)
  -- function num : 0_31 , upvalues : _ENV
  local fightingPower = 0
  for k,skill in pairs(self.skillDic) do
    if skill.type ~= eHeroSkillType.LifeSkill and skill:GetIsUnlock() and (skill.battleSkillCfg).combatFormula ~= nil then
      fightingPower = fightingPower + ((((skill.battleSkillCfg).combatFormula):BindData(((CS.BattleFormula).eFormulaBindType).SkillLevel, ((CS.FormulaOperand).OperandValue)(skill.level))):GetValue(self, self)):AsLong()
    end
  end
  return fightingPower
end

HeroData.GetFightingPower = function(self, withoutAth)
  -- function num : 0_32 , upvalues : _ENV
  self.__getFmlAttrWithoutAth = withoutAth
  local fightingPower = ((((CS.BattleConsts).BattleRoleFightPowerFormula).battleFormula):GetValue(self, self)):AsLong()
  fightingPower = fightingPower + self:GetSkillFightingPower()
  return fightingPower
end

HeroData.GetUltimateSkillLevel = function(self)
  -- function num : 0_33 , upvalues : _ENV
  return ((ConfigData.hero_rank)[self.rank]).ultimateskill_level
end

return HeroData

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeroData = class("HeroData")
local HeroSkillData = require("Game.PlayerData.Skill.HeroSkillData")
local attrIdOffset = 100
HeroData.ctor = function(self, data)
    -- function num : 0_0 , upvalues : _ENV, HeroSkillData
    local baseData = data.basic
    self.dataId = baseData.id
    self.level = baseData.level
    self.curExp = baseData.exp
    self.ts = baseData.ts
    self.rank = baseData.star
    self:UpdateHeroRank(self.rank)
    local heroCfg = (ConfigData.hero_data)[self.dataId]
    if heroCfg == nil then
        error("hero cfg is null,id:" .. tostring(self.dataId))
        return
    end
    self.heroCfg = heroCfg
    self.camp = heroCfg.camp
    self.career = heroCfg.career
    self:__UpdateBaseArriDic()
    self.skillDic = {}
    self.skillList = {}
    for k, skillId in ipairs(heroCfg.skill_list) do
        local skillData = (HeroSkillData.New)(skillId, self) -- DECOMPILER ERROR at PC48: Confused about usage of register: R10 in 'UnsetPending'
        ;
        (self.skillDic)[skillId] = skillData;
        (table.insert)(self.skillList, skillData)
    end
    (table.sort)(self.skillList, function(skillData1, skillData2)
        -- function num : 0_0_0
        local isCommonAttack1 = skillData1:IsCommonAttack()
        local isCommonAttack2 = skillData2:IsCommonAttack()
        local isPassive1 = skillData1:IsPassiveSkill()
        local isPassive2 = skillData2:IsPassiveSkill()
        local isUskill1 = skillData2:IsUniqueSkill()
        local isUskill2 = skillData2:IsUniqueSkill()
        if isPassive1 == isPassive2 then
            if isUskill1 == isUskill2 then
                if skillData1.dataId >= skillData2.dataId then
                    do
                        return isCommonAttack1 ~= isCommonAttack2
                    end
                    do return not isUskill1 end
                    do return isPassive1 end
                    do return isCommonAttack1 end
                    -- DECOMPILER ERROR: 5 unprocessed JMP targets
                end
            end
        end
    end)
    if data.skill ~= nil then
        for skillId, skillLevel in pairs((data.skill).data) do
            local skillData = (self.skillDic)[skillId]
            if skillData ~= nil then
                skillData:UpdateSkill(skillLevel)
            end
        end
    end
    do
        self.fragId = heroCfg.fragment
        local resCfg = (ConfigData.resource_model)[heroCfg.src_id]
        if resCfg == nil then
            error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
        end
        self.resCfg = resCfg
    end
end

HeroData.UpdateHeroData = function(self, data)
    -- function num : 0_1 , upvalues : _ENV
    local baseData = data.basic
    if baseData.level == self.level and self.rank == baseData.star then
        do
            local attrChange = baseData == nil
            self.level = baseData.level
            self.curExp = baseData.exp
            self.rank = baseData.star
            self:UpdateHeroRank(self.rank)
            self.ts = baseData.ts
            if attrChange then self:__UpdateBaseArriDic() end
            if data.skill ~= nil then
                for skillId, skillLevel in pairs((data.skill).data) do
                    local skillData = (self.skillDic)[skillId]
                    if skillData ~= nil then
                        skillData:UpdateSkill(skillLevel)
                    end
                end
            end
            -- DECOMPILER ERROR: 4 unprocessed JMP targets
        end
    end
end

HeroData.GetAttr = function(self, attrId, withoutAth, dontWarning)
    -- function num : 0_2 , upvalues : attrIdOffset, _ENV
    local athHeroId = self.dataId
    if withoutAth then athHeroId = nil end
    local baseAttrId = attrId + attrIdOffset
    local atrValue = (self.baseAttrDic)[attrId]
    atrValue = (PlayerDataCenter.attributeBonus):AtrBonusAdd(atrValue, attrId,
                                                             baseAttrId,
                                                             self.camp,
                                                             self.career,
                                                             athHeroId)
    local ratioAttrId = baseAttrId + attrIdOffset
    atrValue = (PlayerDataCenter.attributeBonus):AtrBonusAdd(atrValue, attrId,
                                                             ratioAttrId,
                                                             self.camp,
                                                             self.career,
                                                             athHeroId)
    atrValue = atrValue + ((self.heroStarCfg)[attrId] or 0)
    atrValue = (PlayerDataCenter.attributeBonus):AtrBonusAdd(atrValue, attrId,
                                                             attrId, self.camp,
                                                             self.career,
                                                             athHeroId)
    if isGameDev and not dontWarning and not withoutAth then
        (PlayerDataCenter.heroAttrChecker):DirtyPlayerHeroAttri(self.dataId,
                                                                attrId, atrValue)
    end
    return atrValue
end

HeroData.GetNewLevelAttr = function(self, attrId, newLevel, newRank)
    -- function num : 0_3
    self:__UpdateBaseArriDic(newLevel, newRank)
    local answer = self:GetAttr(attrId, nil, true)
    self:__UpdateBaseArriDic()
    return answer
end

HeroData.__UpdateBaseArriDic = function(self, newLevel, newRank)
    -- function num : 0_4 , upvalues : _ENV
    if not newRank then local rank = self.rank end
    if not newLevel then local level = self.level end
    local baseAttrDic = setmetatable({}, {
        __index = function(tab, key)
            -- function num : 0_4_0
            return 0
        end
    })
    self.baseAttrDic = baseAttrDic
    if (ConfigData.hero_star)[self.dataId] == nil or
        ((ConfigData.hero_star)[self.dataId])[self.rank] == nil then
        error((string.format)("Can\'t get heroStarCfg, heroId = %s,rank = %s",
                              self.dataId, self.rank))
        return
    end
    local heroStarCfg = ((ConfigData.hero_star)[self.dataId])[rank]
    self.heroStarCfg = heroStarCfg
    local heroLevelCfg = (ConfigData.hero_level)[level]
    if heroLevelCfg == nil then
        error("Can\'t find heroLevelCfg, level = " .. tostring(self.level))
        return
    end
    for k, v in pairs(heroStarCfg.atrGrowthDic) do
        baseAttrDic[k - 100] = v * heroLevelCfg.level_growth // 1000000 +
                                   ((heroStarCfg.atrExtraDic)[k] or 0)
    end
    for k, v in pairs(heroStarCfg.atrBaseDic) do
        local id = k - 100
        baseAttrDic[id] = baseAttrDic[id] + v
    end
    baseAttrDic[8] = (self.heroCfg).move_spd
    baseAttrDic[16] = (self.heroCfg).range
end

HeroData.GetName = function(self)
    -- function num : 0_5 , upvalues : _ENV
    return (LanguageUtil.GetLocaleText)((self.heroCfg).name)
end

HeroData.GetResName = function(self)
    -- function num : 0_6
    return (self.resCfg).res_Name
end

HeroData.GetExtendResName = function(self)
    -- function num : 0_7
    return (self.resCfg).extend_res
end

HeroData.GetEnName = function(self)
    -- function num : 0_8 , upvalues : _ENV
    return (LanguageUtil.GetLocaleText)((self.heroCfg).name_en)
end

HeroData.GetTag = function(self)
    -- function num : 0_9
    return (self.heroCfg).tag
end

HeroData.GetCareerCfg = function(self)
    -- function num : 0_10 , upvalues : _ENV
    local careerCfg = (ConfigData.career)[self.career]
    return careerCfg
end

HeroData.GetCampCfg = function(self)
    -- function num : 0_11 , upvalues : _ENV
    local campCfg = (ConfigData.camp)[self.camp]
    return campCfg
end

HeroData.GetHeroFragCount = function(self)
    -- function num : 0_12 , upvalues : _ENV
    return PlayerDataCenter:GetItemCount((self.heroCfg).fragment)
end

HeroData.IsFullRank = function(self)
    -- function num : 0_13 , upvalues : _ENV
    do return (ConfigData.hero_rank).maxRank <= self.rank end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HeroData.UpdateHeroRank = function(self, rank)
    -- function num : 0_14 , upvalues : _ENV
    local rankCfg = (ConfigData.hero_rank)[rank]
    if rankCfg == nil then
        error("Can\'t find rankCfg, id = " .. tostring(rank))
        return
    end
    self.rankCfg = rankCfg
    self.star = rankCfg.star
    self.rare = rankCfg.rare
end

HeroData.StarNeedFrag = function(self)
    -- function num : 0_15
    if self:IsFullRank() then return 0 end
    return (self.rankCfg).upgrade_star_frag_cost
end

HeroData.StarNeedCurrencyNum = function(self)
    -- function num : 0_16
    if self:IsFullRank() then return 0 end
    local extra_cost = (self.rankCfg).upgrade_star_extra_cost
    if extra_cost[1] ~= nil then
        return (extra_cost[1]).itemId, (extra_cost[1]).num
    end
end

HeroData.StarNeedItemNum = function(self)
    -- function num : 0_17
    if self:IsFullRank() then return 0 end
    local extra_cost = (self.rankCfg).upgrade_star_extra_cost
    if extra_cost[2] ~= nil then
        return (extra_cost[2]).itemId, (extra_cost[2]).num
    end
end

HeroData.AbleUpLevel = function(self)
    -- function num : 0_18 , upvalues : _ENV
    if self:IsFullLevel() then return false end
    for _, id in ipairs(((ConfigData.item).growUpIds)[eItemActionType.HeroExp]) do
        if (PlayerDataCenter.itemDic)[id] ~= nil then return true end
    end
    return false
end

HeroData.AbleUpgradeStar = function(self)
    -- function num : 0_19 , upvalues : _ENV
    if self:IsFullRank() then return false end
    local id, num = nil, nil
    local fitFrag = self:StarNeedFrag() <= self:GetHeroFragCount()
    local fitCurrency, fitItem = nil, nil
    id = self:StarNeedCurrencyNum()
    if num > PlayerDataCenter:GetItemCount(id) then
        fitCurrency = id == nil
        fitCurrency = true
        -- DECOMPILER ERROR at PC34: Overwrote pending register: R2 in 'AssignReg'

        id = self:StarNeedItemNum()
        if num > PlayerDataCenter:GetItemCount(id) then
            fitItem = id == nil
            fitItem = true
            do
                return not fitFrag or not fitCurrency or fitItem, fitFrag,
                       fitCurrency, fitItem
            end
            -- DECOMPILER ERROR: 8 unprocessed JMP targets
        end
    end
end

HeroData.GetDifferAttrWhenRankUp = function(self, newRank, newLevel)
    -- function num : 0_20 , upvalues : _ENV
    local changeList = {}
    for _, attrId in pairs((ConfigData.attribute).baseAttrIds) do
        local oldAttr = self:GetAttr(attrId, nil, false)
        local newAttr = self:GetNewLevelAttr(attrId, newLevel, newRank)
        if oldAttr ~= newAttr then
            (table.insert)(changeList, {
                attrId = attrId,
                property = ((ConfigData.attribute)[attrId]).attribute_priority,
                oldAttr = oldAttr,
                newAttr = newAttr
            })
        end
    end
    return changeList
end

HeroData.IsFullLevel = function(self)
    -- function num : 0_21 , upvalues : _ENV
    do
        return (PlayerDataCenter.playerBonus):GetHeroLevelCeiling() <=
                   self.level
    end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HeroData.GetExpRatio = function(self)
    -- function num : 0_22
    local totalExp = self:GetLevelTotalExp()
    if totalExp == 0 then return 0 end
    return self.curExp / totalExp
end

HeroData.GetExpByLevel = function(self, level)
    -- function num : 0_23 , upvalues : _ENV
    local levelCfg = (ConfigData.hero_level)[level]
    if levelCfg ~= nil then return levelCfg.exp end
    return 0
end

HeroData.GetLevelTotalExp = function(self)
    -- function num : 0_24
    return self:GetExpByLevel(self.level)
end

HeroData.GetUpgradeLevelProcess = function(self, oldLevel, oldExp, getExp)
    -- function num : 0_25 , upvalues : _ENV
    local fromlist = {}
    local tolist = {}
    if getExp <= 0 then return fromlist, tolist end
    getExp = getExp + oldExp
    local heroMaxLevel = (PlayerDataCenter.playerBonus):GetHeroLevelCeiling()
    for i = oldLevel, heroMaxLevel - 1 do
        local levelCfg = (ConfigData.hero_level)[i]
        if levelCfg == nil then
            error("hero level cfg is null,id:" .. tostring(i))
            break
        end
        local curLevelTotalExp = levelCfg.exp
        if i == oldLevel then
            (table.insert)(fromlist, oldExp)
        else

            (table.insert)(fromlist, 0)
        end
        if getExp < curLevelTotalExp then
            (table.insert)(tolist, getExp)
            break
        else
            if getExp == curLevelTotalExp then
                (table.insert)(tolist, curLevelTotalExp);
                (table.insert)(fromlist, 0);
                (table.insert)(tolist, 0)
                break
            else
                getExp = getExp - curLevelTotalExp;
                (table.insert)(tolist, curLevelTotalExp)
                if i + 1 == heroMaxLevel then
                    (table.insert)(fromlist, 0);
                    (table.insert)(tolist, 0)
                    break
                end
            end
        end
    end
    do return fromlist, tolist end
end

HeroData.AddTestExp = function(self, exp)
    -- function num : 0_26 , upvalues : _ENV
    local nextExp = 0
    local nextTotalExp = self:GetLevelTotalExp()
    local overflowExp = 0
    local testExp = exp + self.curExp
    local testLevel = self.level
    local heroMaxLevel = (PlayerDataCenter.playerBonus):GetHeroLevelCeiling()
    for i = self.level, heroMaxLevel - 1 do
        local levelCfg = (ConfigData.hero_level)[i]
        if levelCfg == nil then
            error("hero level cfg is null,level:" .. tostring(i))
            return testLevel, nextExp, nextTotalExp, overflowExp
        end
        nextTotalExp = levelCfg.exp
        if testExp >= levelCfg.exp then
            do
                testExp = testExp - levelCfg.exp
                testLevel = i + 1
                -- DECOMPILER ERROR at PC39: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC39: LeaveBlock: unexpected jumping out IF_STMT

            end
        end
    end
    if testLevel == heroMaxLevel then
        nextExp = 0
        overflowExp = testExp
    else
        nextExp = testExp
        overflowExp = 0
    end
    return testLevel, nextExp, nextTotalExp, overflowExp
end

HeroData.GetHeroExpAddFromLevel = function(self, fromLevel, fromExp)
    -- function num : 0_27 , upvalues : _ENV
    if fromLevel == self.level then return self.curExp - fromExp end
    local needExp = 0
    for i = fromLevel, self.level do
        local levelCfg = (ConfigData.hero_level)[i]
        if levelCfg == nil then
            error("hero level cfg is null,level:" .. tostring(i))
            return 0
        end
        if i == fromLevel then
            needExp = needExp + levelCfg.exp - fromExp
        else
            if i == self.level then
                needExp = needExp + self.curExp
            else
                needExp = needExp + levelCfg.exp
            end
        end
    end
    return needExp
end

HeroData.GetAthSlotList = function(self, fullSpace)
    -- function num : 0_28 , upvalues : _ENV
    local athslotList = {}
    local level = self.level
    local rank = self.rank
    local athSlotLevel = (PlayerDataCenter.allAthData):GetHeroAthSlotInfo(
                             self.dataId)
    if fullSpace then
        level = (PlayerDataCenter.playerBonus):GetHeroLevelCeiling()
        rank = (ConfigData.hero_rank).maxRank
        athSlotLevel = (ConfigData.ath_efficiency).maxLevel
    end
    local baseSpaceCfg = (self.heroCfg).algorithm_space
    local levelSpaceCfg = ((ConfigData.hero_level)[level]).algorithm_space
    local starSpaceCfg =
        (((ConfigData.hero_star)[self.dataId])[rank]).algorithm_space
    local athEfccSpaceCfg =
        ((ConfigData.ath_efficiency)[athSlotLevel]).algorithm_space
    if #baseSpaceCfg ~= #starSpaceCfg or #baseSpaceCfg ~= #levelSpaceCfg or
        #baseSpaceCfg ~= #athEfccSpaceCfg then
        error("Hero algorithm_space Config error, heroId = " ..
                  tostring(self.dataId))
        return athslotList
    end
    if (ConfigData.game_config).athSlotCount < #baseSpaceCfg then
        error("Hero algorithm_space Config error, heroId = " ..
                  tostring(self.dataId))
        return athslotList
    end
    for k, v in ipairs(baseSpaceCfg) do
        local space = v + levelSpaceCfg[k] + starSpaceCfg[k] +
                          athEfccSpaceCfg[k]
        athslotList[k] = space
    end
    return athslotList
end

HeroData.AbleUpgradeSkill = function(self)
    -- function num : 0_29 , upvalues : _ENV
    for _, skillData in ipairs(self.skillList) do
        if skillData:CanUpgrade() then return true end
    end
    return false
end

HeroData.GetFormulaAttr = function(self, attrEnum)
    -- function num : 0_30 , upvalues : _ENV
    local attrId = (GR.EnumToInt)(attrEnum)
    if attrId == eHeroAttr.hp then
        return self:GetAttr(eHeroAttr.maxHp, nil, true)
    else
        if attrId == eHeroAttr.intensity then
            return (self.heroCfg).intensity
        else
            if attrId == eHeroAttr.attack_range then
                return (self.heroCfg).range
            else
                return self:GetAttr(attrId, self.__getFmlAttrWithoutAth, true)
            end
        end
    end
end

HeroData.GetSkillFightingPower = function(self)
    -- function num : 0_31 , upvalues : _ENV
    local fightingPower = 0
    for k, skill in pairs(self.skillDic) do
        if skill.type ~= eHeroSkillType.LifeSkill and skill:GetIsUnlock() and
            (skill.battleSkillCfg).combatFormula ~= nil then
            fightingPower = fightingPower +
                                ((((skill.battleSkillCfg).combatFormula):BindData(
                                    ((CS.BattleFormula).eFormulaBindType).SkillLevel,
                                    ((CS.FormulaOperand).OperandValue)(
                                        skill.level))):GetValue(self, self)):AsLong()
        end
    end
    return fightingPower
end

HeroData.GetFightingPower = function(self, withoutAth)
    -- function num : 0_32 , upvalues : _ENV
    self.__getFmlAttrWithoutAth = withoutAth
    local fightingPower =
        ((((CS.BattleConsts).BattleRoleFightPowerFormula).battleFormula):GetValue(
            self, self)):AsLong()
    fightingPower = fightingPower + self:GetSkillFightingPower()
    return fightingPower
end

HeroData.GetUltimateSkillLevel = function(self)
    -- function num : 0_33 , upvalues : _ENV
    return ((ConfigData.hero_rank)[self.rank]).ultimateskill_level
end

return HeroData

