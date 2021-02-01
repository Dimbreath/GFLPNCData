-- params : ...
-- function num : 0 , upvalues : _ENV
local SpecificHeroDataRuler = class("SpecificHeroDataRuler")
SpecificHeroDataRuler.eSpecificHeroRuler = {customLevel = 1, customStar = 2, customPotential = 3, isSkillFullLevel = 4, isRemoveAllBounce = 5}
SpecificHeroDataRuler.ctorWithChallengeCfg = function(cfg)
  -- function num : 0_0 , upvalues : SpecificHeroDataRuler
  local data = (SpecificHeroDataRuler.New)(cfg.hero_level, cfg.hero_star, cfg.hero_rank, true, true)
  return data
end

SpecificHeroDataRuler.ctor = function(self, customLevel, customStar, customPotential, isSkillFullLevel, isRemoveAllBounce)
  -- function num : 0_1 , upvalues : SpecificHeroDataRuler
  self.ruler = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customLevel] = customLevel
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customStar] = customStar
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customPotential] = customPotential
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).isSkillFullLevel] = isSkillFullLevel
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).isRemoveAllBounce] = isRemoveAllBounce
end

SpecificHeroDataRuler.CampareTo = function(self, otherRuler)
  -- function num : 0_2 , upvalues : _ENV, SpecificHeroDataRuler
  for key,value in pairs(SpecificHeroDataRuler.eSpecificHeroRuler) do
    if (self.ruler)[key] ~= (otherRuler.ruler)[key] then
      return false
    end
  end
  return true
end

return SpecificHeroDataRuler

