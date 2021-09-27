local bs_10178 = class("bs_10178", LuaSkillBase)
local base = LuaSkillBase
bs_10178.config = {sheildBuffId = 174, buffIdJin = 1048, shieldKey = "50003_HuDun", effectIdJin = 10373}
bs_10178.ctor = function(self)
  -- function num : 0_0
end

bs_10178.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10178_1", 100, self.OnSetHurt, self.caster)
end

bs_10178.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (self.caster).attackRange > 1 and LuaSkillCtrl:GetShield(context.target, eShieldType.NoRange) > 0 then
    context.hurt = context.hurt * (1000 + (self.arglist)[1]) // 1000
  end
end

bs_10178.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10178

