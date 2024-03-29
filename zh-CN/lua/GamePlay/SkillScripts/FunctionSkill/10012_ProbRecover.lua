local bs_10012 = class("bs_10012", LuaSkillBase)
local base = LuaSkillBase
bs_10012.config = {
heal_config = {baseheal_formula = 10006, correct_formula = 9990, heal_number = 0}
, effectId = 1008}
bs_10012.ctor = function(self)
  -- function num : 0_0
end

bs_10012.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_10012_3", 1, self.OnAfterHurt, self.caster)
  self.heal_config = {}
end

bs_10012.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[2] and not isTriggerSet then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillBack)
  end
end

bs_10012.SkillBack = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, self.caster)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, true)
    skillResult:EndResult()
  end
end

bs_10012.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10012

