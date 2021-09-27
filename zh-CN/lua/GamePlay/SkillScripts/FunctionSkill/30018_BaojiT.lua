local bs_30018 = class("bs_30018", LuaSkillBase)
local base = LuaSkillBase
bs_30018.config = {}
bs_30018.ctor = function(self)
  -- function num : 0_0
end

bs_30018.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_30018_1", 1, self.OnAfterPlaySkill)
  self:AddSetHurtTrigger("bs_30018_2", 2, self.OnSetHurt, self.caster)
  self.flag = false
end

bs_30018.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2
  if skill.maker == self.caster and not skill.isCommonAttack then
    self.flag = true
  end
end

bs_30018.OnSetHurt = function(self, context)
  -- function num : 0_3
  if (context.skill).maker == self.caster and (context.skill).isCommonAttack and self.flag == true then
    self.flag = false
    context.isCrit = true
    context.hurt = (1000 + (self.caster).critDamage) * context.hurt // 1000
  end
end

bs_30018.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30018

