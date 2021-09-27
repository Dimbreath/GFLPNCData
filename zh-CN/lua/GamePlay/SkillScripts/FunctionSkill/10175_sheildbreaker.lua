local bs_10175 = class("bs_10175", LuaSkillBase)
local base = LuaSkillBase
bs_10175.config = {sheildBuffId = 174, shieldKeyYuan = "50002_HuDun", shieldKeyJin = "50003_HuDun"}
bs_10175.ctor = function(self)
  -- function num : 0_0
end

bs_10175.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10175_3", 1000, self.OnSetHurt, self.caster)
end

bs_10175.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (self.caster).attackRange > 1 and (context.target):GetShield(eShieldType.LongRange) > 0 then
    context.hurt = context.hurt * (1000 + (self.arglist)[1]) // 1000
  end
  if context.sender == self.caster and (self.caster).attackRange == 1 and (context.target):GetShield(eShieldType.NoRange) > 0 then
    context.hurt = context.hurt * (1000 + (self.arglist)[1]) // 1000
  end
end

bs_10175.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10175

