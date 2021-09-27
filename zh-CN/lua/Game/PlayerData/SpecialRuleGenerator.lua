local SpecialRuleGenerator = class("SpecialRuleGenerator")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local SpecificHeroDataRuler = require("Game.PlayerData.Hero.SpecificHeroDataRuler")
SpecialRuleGenerator.SetSpeicalRuler = function(self, specialRuler)
  -- function num : 0_0
  self.specialRuler = specialRuler
  self.specificHeroDataCacheDic = {}
end

SpecialRuleGenerator.GetSpecificHeroData = function(self, heroId, specificHeroDataRuler)
  -- function num : 0_1 , upvalues : _ENV
  if specificHeroDataRuler == nil then
    error("specificHeroDataRuler is empty")
    return nil
  end
  local isSameple = false
  if self.specialRuler ~= nil then
    isSameple = (self.specialRuler):CampareTo(specificHeroDataRuler)
  end
  if isSameple then
    local heroData = (self.specificHeroDataCacheDic)[heroId]
    if heroData == nil then
      heroData = self:CreateSpecificHeroData(heroId, specificHeroDataRuler)
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.specificHeroDataCacheDic)[heroId] = heroData
    end
    return heroData
  else
    do
      do return self:CreateSpecificHeroData(heroId, specificHeroDataRuler) end
    end
  end
end

SpecialRuleGenerator.CancelSpeicalRulerCache = function(self)
  -- function num : 0_2
  self.specialRuler = nil
  self.specificHeroDataCacheDic = {}
end

SpecialRuleGenerator.CreateSpecificHeroData = function(self, heroId, specificHeroDataRuler)
  -- function num : 0_3 , upvalues : SpecificHeroDataRuler, _ENV, HeroData
  local customLevel = (specificHeroDataRuler.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customLevel]
  local customStar = (specificHeroDataRuler.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customStar]
  local customPotential = (specificHeroDataRuler.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customPotential]
  local customSkillLevelRange = (specificHeroDataRuler.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).customSkillLevelRange]
  local isSkillFullLevel = (specificHeroDataRuler.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).isSkillFullLevel]
  local isRemoveAllBounce = (specificHeroDataRuler.ruler)[(SpecificHeroDataRuler.eSpecificHeroRuler).isRemoveAllBounce]
  local OringHeroData = (PlayerDataCenter.heroDic)[heroId]
  local heroCfg = (ConfigData.hero_data)[heroId]
  local heroData = (HeroData.New)({
basic = {id = heroId, level = customLevel[1], exp = 0, star = customStar[1], potentialLvl = customPotential[1], ts = OringHeroData.ts, career = OringHeroData.career, company = OringHeroData.company, skinId = ((((((((((((OringHeroData ~= nil and (math.clamp)(OringHeroData.level, customLevel[1], customLevel[2])) or OringHeroData ~= nil) and (math.clamp)(OringHeroData.rank, customStar[1], customStar[2])) or OringHeroData ~= nil) and (math.clamp)(OringHeroData.potential, customPotential[1], customPotential[2])) or not OringHeroData) and -1) or not OringHeroData) and heroCfg.career) or not OringHeroData) and heroCfg.camp) or OringHeroData ~= nil) and OringHeroData.skinId or nil}
})
  if isSkillFullLevel then
    for _,skillData in ipairs(heroData.skillList) do
      if (skillData.skillCfg).open_star <= heroData.rank then
        skillData:UpdateSkill((skillData.skillCfg).lv)
      end
    end
  else
    do
      if customSkillLevelRange ~= nil then
        if OringHeroData ~= nil then
          for skillId,OringSkillData in pairs(OringHeroData.skillDic) do
            if ((ConfigData.hero_skill)[skillId]).open_star <= heroData.rank then
              local skillData = (heroData.skillDic)[skillId]
              skillData:UpdateSkill((math.clamp)(OringSkillData.level, customSkillLevelRange[1], customSkillLevelRange[2]))
            end
          end
        else
          do
            for _,skillData in ipairs(heroData.skillList) do
              if (skillData.skillCfg).open_star <= heroData.rank then
                skillData:UpdateSkill(customSkillLevelRange[1])
              end
            end
            do
              if OringHeroData ~= nil then
                for skillId,OringSkillData in pairs(OringHeroData.skillDic) do
                  if ((ConfigData.hero_skill)[skillId]).open_star <= heroData.rank then
                    local skillData = (heroData.skillDic)[skillId]
                    skillData:UpdateSkill(OringSkillData.level)
                  end
                end
              end
              do
                heroData.isRemoveAllBounce = isRemoveAllBounce
                return heroData
              end
            end
          end
        end
      end
    end
  end
end

return SpecialRuleGenerator

