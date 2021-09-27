local bs_10198 = class("bs_10198", LuaSkillBase)
local base = LuaSkillBase
bs_10198.config = {damageFormula = 10011}
bs_10198.ctor = function(self)
  -- function num : 0_0
end

bs_10198.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10198_2", 1, self.OnSetHurt, nil, self.caster, eBattleRoleBelong.neutral)
end

bs_10198.OnSetHurt = function(self, context)
  -- function num : 0_2
  if (context.sender).belongNum == 0 and context.target == self.caster and not context.isTriggerSet then
    context.hurt = context.hurt + context.hurt * (self.arglist)[1] // 1000
    self:PlayChipEffect()
  end
end

bs_10198.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10198

