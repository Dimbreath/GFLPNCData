-- params : ...
-- function num : 0 , upvalues : _ENV
local HeroSkillData = class("HeroSkillData")
local cs_GameData_ins = (CS.GameData).instance
HeroSkillData.ctor = function(self, dataId, heroData)
  -- function num : 0_0 , upvalues : _ENV, cs_GameData_ins
  self.dataId = dataId
  self.level = 0
  self.heroData = heroData
  local skillCfg = (ConfigData.hero_skill)[dataId]
  if skillCfg == nil then
    error("skill cfg is null,Id:" .. tostring(dataId))
    return 
  end
  self.skillCfg = skillCfg
  self.type = skillCfg.type
  if self.type ~= eHeroSkillType.LifeSkill then
    self.battleSkillCfg = (cs_GameData_ins.listBattleSkillDatas):GetDataById(skillCfg.para)
    if self.battleSkillCfg == nil then
      error("battle_skill cfg is null,Id:" .. tostring(skillCfg.para))
    end
  else
    self.lifeSkillCfg = (ConfigData.life_skill)[skillCfg.para]
    if self.lifeSkillCfg == nil then
      error("life_skill cfg is null,Id:" .. tostring(skillCfg.para))
    end
  end
end

HeroSkillData.UpdateSkill = function(self, level)
  -- function num : 0_1
  self.level = level
end

HeroSkillData.GetIsUnlock = function(self)
  -- function num : 0_2
  do return self.level > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HeroSkillData.GetLogicSkillId = function(self)
  -- function num : 0_3
  return (self.skillCfg).para
end

HeroSkillData.GetOpenStar = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local rankCfg = (ConfigData.hero_rank)[(self.skillCfg).open_star]
  if rankCfg == nil then
    error("Cant find rankCfg,rank = " .. tostring((self.skillCfg).open_star))
    return 
  end
  return rankCfg.rare, rankCfg.star
end

HeroSkillData.GetMaxLevel = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (math.min)((self.skillCfg).lv, (ConfigData.hero_rank).maxSkillLevel)
end

HeroSkillData.IsFullLevel = function(self)
  -- function num : 0_6
  do return self:GetMaxLevel() <= self.level end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HeroSkillData.GetNextLevelRankCfg = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local nextLevel = self.level + 1
  for i = (self.heroData).rank, (ConfigData.hero_rank).maxRank do
    local rankCfg = (ConfigData.hero_rank)[i]
    if nextLevel <= rankCfg.skill_level_max then
      return rankCfg
    end
  end
  return 0
end

HeroSkillData.GetIcon = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.type ~= eHeroSkillType.LifeSkill then
    return (self.battleSkillCfg).Icon
  else
    return ((self.lifeSkillCfg)[self.level]).icon
  end
end

HeroSkillData.GetBattleSkillTypeColor = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.type ~= eHeroSkillType.LifeSkill then
    return (self.battleSkillCfg).TypeColor
  end
end

HeroSkillData.GetName = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if self.type ~= eHeroSkillType.LifeSkill then
    return (self.battleSkillCfg).Name
  else
    return (LanguageUtil.GetLocaleText)(((self.lifeSkillCfg)[self.level]).name)
  end
end

HeroSkillData.GetSkillTag = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if self.type ~= eHeroSkillType.LifeSkill then
    return (self.battleSkillCfg).SkillTag
  end
end

HeroSkillData.GetDescribe = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if self.type ~= eHeroSkillType.LifeSkill then
    return (self.battleSkillCfg).Describe
  else
    return ""
  end
end

HeroSkillData.GetLevelDescribe = function(self, level)
  -- function num : 0_13 , upvalues : _ENV
  if self.type ~= eHeroSkillType.LifeSkill then
    return (self.battleSkillCfg):GetLevelDescribe(level)
  else
    return (LanguageUtil.GetLocaleText)(((self.lifeSkillCfg)[self.level]).describe)
  end
end

HeroSkillData.GetCurLevelDescribe = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local curLevel = (math.max)(self.level, 1)
  if self.type ~= eHeroSkillType.LifeSkill then
    return self:GetLevelDescribe(curLevel)
  else
    return (LanguageUtil.GetLocaleText)(((self.lifeSkillCfg)[curLevel]).describe)
  end
end

HeroSkillData.GetColorLevelDescribe = function(self, level, color)
  -- function num : 0_15 , upvalues : _ENV
  if self.type ~= eHeroSkillType.LifeSkill then
    return (self.battleSkillCfg):GetClolorfulLevelDescribe(level, color)
  else
    return (LanguageUtil.GetLocaleText)(((self.lifeSkillCfg)[self.level]).describe)
  end
end

HeroSkillData.GetConsumeId = function(self)
  -- function num : 0_16
  return (self.skillCfg).consume_id
end

HeroSkillData.GetSkillLevelCfg = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local consumeId = self:GetConsumeId()
  local consumeCfg = (ConfigData.hero_skill_level)[consumeId]
  if consumeCfg == nil then
    error("hero skill level cfg is null,consumeId:" .. tostring(consumeId))
    return nil
  end
  local levelCfg = consumeCfg[self.level]
  return levelCfg
end

HeroSkillData.IsUniqueSkill = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self.type ~= eHeroSkillType.LifeSkill then
    return (self.battleSkillCfg):IsUltSkill()
  else
    return false
  end
end

HeroSkillData.IsCommonAttack = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if self.type ~= eHeroSkillType.LifeSkill then
    return (self.battleSkillCfg):IsCommonAttack()
  else
    return false
  end
end

HeroSkillData.IsPassiveSkill = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if self.type ~= eHeroSkillType.LifeSkill then
    return (self.battleSkillCfg):IsPassiveSkill()
  else
    return false
  end
end

HeroSkillData.CanUpgrade = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if not self:GetIsUnlock() or self:IsFullLevel() then
    return false
  end
  local needRank = self:GetNextLevelRankCfg()
  local requireRare = needRank.rare
  local requireStar = needRank.star
  local isHaveEnoughItem = true
  local consume = self:GetSkillLevelCfg()
  for index,itemId in ipairs(consume.itemIdList) do
    local num = (consume.countList)[index]
    if PlayerDataCenter:GetItemCount(itemId) < num then
      isHaveEnoughItem = false
    end
  end
  local rare = requireRare <= (self.heroData).rare
  local star = requireStar <= (self.heroData).star
  do return not rare or not star or isHaveEnoughItem, rare, star, isHaveEnoughItem end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

return HeroSkillData

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeroSkillData = class("HeroSkillData")
local cs_GameData_ins = (CS.GameData).instance
HeroSkillData.ctor = function(self, dataId, heroData)
    -- function num : 0_0 , upvalues : _ENV, cs_GameData_ins
    self.dataId = dataId
    self.level = 0
    self.heroData = heroData
    local skillCfg = (ConfigData.hero_skill)[dataId]
    if skillCfg == nil then
        error("skill cfg is null,Id:" .. tostring(dataId))
        return
    end
    self.skillCfg = skillCfg
    self.type = skillCfg.type
    if self.type ~= eHeroSkillType.LifeSkill then
        self.battleSkillCfg =
            (cs_GameData_ins.listBattleSkillDatas):GetDataById(skillCfg.para)
        if self.battleSkillCfg == nil then
            error("battle_skill cfg is null,Id:" .. tostring(skillCfg.para))
        end
    else
        self.lifeSkillCfg = (ConfigData.life_skill)[skillCfg.para]
        if self.lifeSkillCfg == nil then
            error("life_skill cfg is null,Id:" .. tostring(skillCfg.para))
        end
    end
end

HeroSkillData.UpdateSkill = function(self, level)
    -- function num : 0_1
    self.level = level
end

HeroSkillData.GetIsUnlock = function(self)
    -- function num : 0_2
    do return self.level > 0 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HeroSkillData.GetLogicSkillId = function(self)
    -- function num : 0_3
    return (self.skillCfg).para
end

HeroSkillData.GetOpenStar = function(self)
    -- function num : 0_4 , upvalues : _ENV
    local rankCfg = (ConfigData.hero_rank)[(self.skillCfg).open_star]
    if rankCfg == nil then
        error("Cant find rankCfg,rank = " .. tostring((self.skillCfg).open_star))
        return
    end
    return rankCfg.rare, rankCfg.star
end

HeroSkillData.GetMaxLevel = function(self)
    -- function num : 0_5 , upvalues : _ENV
    return (math.min)((self.skillCfg).lv, (ConfigData.hero_rank).maxSkillLevel)
end

HeroSkillData.IsFullLevel = function(self)
    -- function num : 0_6
    do return self:GetMaxLevel() <= self.level end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HeroSkillData.GetNextLevelRankCfg = function(self)
    -- function num : 0_7 , upvalues : _ENV
    local nextLevel = self.level + 1
    for i = (self.heroData).rank, (ConfigData.hero_rank).maxRank do
        local rankCfg = (ConfigData.hero_rank)[i]
        if nextLevel <= rankCfg.skill_level_max then return rankCfg end
    end
    return 0
end

HeroSkillData.GetIcon = function(self)
    -- function num : 0_8 , upvalues : _ENV
    if self.type ~= eHeroSkillType.LifeSkill then
        return (self.battleSkillCfg).Icon
    else
        return ((self.lifeSkillCfg)[self.level]).icon
    end
end

HeroSkillData.GetBattleSkillTypeColor = function(self)
    -- function num : 0_9 , upvalues : _ENV
    if self.type ~= eHeroSkillType.LifeSkill then
        return (self.battleSkillCfg).TypeColor
    end
end

HeroSkillData.GetName = function(self)
    -- function num : 0_10 , upvalues : _ENV
    if self.type ~= eHeroSkillType.LifeSkill then
        return (self.battleSkillCfg).Name
    else
        return (LanguageUtil.GetLocaleText)(
                   ((self.lifeSkillCfg)[self.level]).name)
    end
end

HeroSkillData.GetSkillTag = function(self)
    -- function num : 0_11 , upvalues : _ENV
    if self.type ~= eHeroSkillType.LifeSkill then
        return (self.battleSkillCfg).SkillTag
    end
end

HeroSkillData.GetDescribe = function(self)
    -- function num : 0_12 , upvalues : _ENV
    if self.type ~= eHeroSkillType.LifeSkill then
        return (self.battleSkillCfg).Describe
    else
        return ""
    end
end

HeroSkillData.GetLevelDescribe = function(self, level)
    -- function num : 0_13 , upvalues : _ENV
    if self.type ~= eHeroSkillType.LifeSkill then
        return (self.battleSkillCfg):GetLevelDescribe(level)
    else
        return (LanguageUtil.GetLocaleText)(
                   ((self.lifeSkillCfg)[self.level]).describe)
    end
end

HeroSkillData.GetCurLevelDescribe = function(self)
    -- function num : 0_14 , upvalues : _ENV
    local curLevel = (math.max)(self.level, 1)
    if self.type ~= eHeroSkillType.LifeSkill then
        return self:GetLevelDescribe(curLevel)
    else
        return (LanguageUtil.GetLocaleText)(
                   ((self.lifeSkillCfg)[curLevel]).describe)
    end
end

HeroSkillData.GetColorLevelDescribe = function(self, level, color)
    -- function num : 0_15 , upvalues : _ENV
    if self.type ~= eHeroSkillType.LifeSkill then
        return (self.battleSkillCfg):GetClolorfulLevelDescribe(level, color)
    else
        return (LanguageUtil.GetLocaleText)(
                   ((self.lifeSkillCfg)[self.level]).describe)
    end
end

HeroSkillData.GetConsumeId = function(self)
    -- function num : 0_16
    return (self.skillCfg).consume_id
end

HeroSkillData.GetSkillLevelCfg = function(self)
    -- function num : 0_17 , upvalues : _ENV
    local consumeId = self:GetConsumeId()
    local consumeCfg = (ConfigData.hero_skill_level)[consumeId]
    if consumeCfg == nil then
        error("hero skill level cfg is null,consumeId:" .. tostring(consumeId))
        return nil
    end
    local levelCfg = consumeCfg[self.level]
    return levelCfg
end

HeroSkillData.IsUniqueSkill = function(self)
    -- function num : 0_18 , upvalues : _ENV
    if self.type ~= eHeroSkillType.LifeSkill then
        return (self.battleSkillCfg):IsUltSkill()
    else
        return false
    end
end

HeroSkillData.IsCommonAttack = function(self)
    -- function num : 0_19 , upvalues : _ENV
    if self.type ~= eHeroSkillType.LifeSkill then
        return (self.battleSkillCfg):IsCommonAttack()
    else
        return false
    end
end

HeroSkillData.IsPassiveSkill = function(self)
    -- function num : 0_20 , upvalues : _ENV
    if self.type ~= eHeroSkillType.LifeSkill then
        return (self.battleSkillCfg):IsPassiveSkill()
    else
        return false
    end
end

HeroSkillData.CanUpgrade = function(self)
    -- function num : 0_21 , upvalues : _ENV
    if not self:GetIsUnlock() or self:IsFullLevel() then return false end
    local needRank = self:GetNextLevelRankCfg()
    local requireRare = needRank.rare
    local requireStar = needRank.star
    local isHaveEnoughItem = true
    local consume = self:GetSkillLevelCfg()
    for index, itemId in ipairs(consume.itemIdList) do
        local num = (consume.countList)[index]
        if PlayerDataCenter:GetItemCount(itemId) < num then
            isHaveEnoughItem = false
        end
    end
    local rare = requireRare <= (self.heroData).rare
    local star = requireStar <= (self.heroData).star
    do
        return not rare or not star or isHaveEnoughItem, rare, star,
               isHaveEnoughItem
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

return HeroSkillData

