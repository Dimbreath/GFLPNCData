local bs_10177 = class("bs_10177", LuaSkillBase)
local base = LuaSkillBase
bs_10177.config = {sheildBuffId = 174, buffIdYuan = 1047, shieldKey = "50002_HuDun", effectIdYuan = 10371}
bs_10177.ctor = function(self)
  -- function num : 0_0
end

bs_10177.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10177_1", 100, self.OnSetHurt, self.caster)
end

bs_10177.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (self.caster).attackRange == 1 and LuaSkillCtrl:GetShield(context.target, eShieldType.LongRange) > 0 then
    context.hurt = context.hurt * (1000 + (self.arglist)[1]) // 1000
  end
end

bs_10177.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10177

