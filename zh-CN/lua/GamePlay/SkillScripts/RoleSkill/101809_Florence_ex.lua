local bs_101809 = class("bs_101809", LuaSkillBase)
local base = LuaSkillBase
bs_101809.config = {buffId_262 = 101803}
bs_101809.ctor = function(self)
  -- function num : 0_0
end

bs_101809.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_101809_2", 99, self.OnSetHurt, nil, self.caster)
end

bs_101809.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster then
    local tier = (self.caster):GetBuffTier((self.config).buffId_262)
    context.hurt = context.hurt * (1000 - (self.arglist)[1] * tier) // 1000
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_262, 1)
  end
end

bs_101809.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101809

