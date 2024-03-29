local bs_6010 = class("bs_6010", LuaSkillBase)
local base = LuaSkillBase
bs_6010.config = {
heal_config = {baseheal_formula = 10026, heal_number = 0, correct_formula = 9990}
}
bs_6010.ctor = function(self)
  -- function num : 0_0
end

bs_6010.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_6010_3", 1, self.OnAfterHurt, self.caster)
end

bs_6010.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and target ~= self.caster and hurt > 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {hurt}, true, true)
    skillResult:EndResult()
  end
end

bs_6010.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6010

