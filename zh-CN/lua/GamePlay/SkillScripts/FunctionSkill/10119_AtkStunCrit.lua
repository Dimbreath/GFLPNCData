local bs_10119 = class("bs_10119", LuaSkillBase)
local base = LuaSkillBase
bs_10119.config = {featureType = eBuffFeatureType.Stun}
bs_10119.ctor = function(self)
  -- function num : 0_0
end

bs_10119.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10119_2", 1, self.OnSetHurt, self.caster)
end

bs_10119.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and not context.isMiss and LuaSkillCtrl:RoleContainsCtrlBuff(context.target) then
    self:PlayChipEffect()
    if context.isCrit then
      context.hurt = (1000 + (self.caster).critDamage + (self.arglist)[1]) * context.hurt // (1000 + (self.caster).critDamage)
    else
      context.isCrit = true
      context.hurt = (1000 + (self.caster).critDamage + (self.arglist)[1]) * context.hurt // 1000
    end
  end
end

bs_10119.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10119

