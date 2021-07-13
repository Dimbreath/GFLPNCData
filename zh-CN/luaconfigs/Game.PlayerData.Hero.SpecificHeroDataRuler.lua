-- params : ...
-- function num : 0 , upvalues : _ENV
local SpecificHeroDataRuler = class("SpecificHeroDataRuler")
SpecificHeroDataRuler.eSpecificHeroRuler = {customLevel = 1, customStar = 2, customPotential = 3, isSkillFullLevel = 4, isRemoveAllBounce = 5, customSkillLevel = 6}
SpecificHeroDataRuler.ctorWithChallengeCfg = function(cfg)
  -- function num : 0_0 , upvalues : SpecificHeroDataRuler
  local data = (SpecificHeroDataRuler.New)(cfg.hero_level, cfg.hero_star, cfg.hero_rank, true, true)
  return data
end

SpecificHeroDataRuler.ctor = function(self, customLevel, customStar, customPotential, isSkillFullLevel, isRemoveAllBounce)
  -- function num : 0_1 , upvalues : SpecificHeroDataRuler
  self.ruler = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customLevel] = {customLevel, customLevel}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customStar] = {customStar, customStar}
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customPotential] = {customPotential, customPotential}
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).isSkillFullLevel] = isSkillFullLevel or false
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).isRemoveAllBounce] = isRemoveAllBounce or false
end

SpecificHeroDataRuler.ctorWithWeeklyChallengeCfg = function(cfg, weeklyData)
  -- function num : 0_2 , upvalues : SpecificHeroDataRuler
  local data = (SpecificHeroDataRuler.New)()
  local heroIds = weeklyData.heroIdList
  local buffDic = weeklyData.buffDic
  data.heroIds = heroIds
  data.weeklyData = weeklyData
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (data.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customLevel] = {cfg.hero_level_min, cfg.hero_level_max}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (data.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customStar] = {cfg.hero_star_min, cfg.hero_star_max}
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (data.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customPotential] = {cfg.hero_rank_min, cfg.hero_rank_max}
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (data.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customSkillLevel] = {cfg.hero_skill_level_min, cfg.hero_skill_level_max}
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (data.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).isSkillFullLevel] = false
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (data.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).isRemoveAllBounce] = true
  return data
end

SpecificHeroDataRuler.CampareTo = function(self, otherRuler)
  -- function num : 0_3
  return self:__CampareCheckData(self.ruler, otherRuler.ruler)
end

SpecificHeroDataRuler.__CampareCheckData = function(self, table1, table2)
  -- function num : 0_4 , upvalues : _ENV
  if table1 ~= table2 then
    do return table1 ~= nil and table2 ~= nil end
    if (table.count)(table1) ~= (table.count)(table2) then
      return false
    end
    for k1,v1 in pairs(table1) do
      local v2 = table2[k1]
      if type(v1) == "table" and not self:__CampareCheckData(v1, v2) then
        return false
      end
      if v1 ~= v2 then
        return false
      end
    end
    do return true end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

SpecificHeroDataRuler.GetWCDuffDic = function(self)
  -- function num : 0_5
  return (self.weeklyData).buffDic
end

SpecificHeroDataRuler.GetWCData = function(self)
  -- function num : 0_6
  return self.weeklyData
end

return SpecificHeroDataRuler

