local bs_10209 = class("bs_10209", LuaSkillBase)
local base = LuaSkillBase
bs_10209.config = {buffId = 1059, effectId = 135}
bs_10209.ctor = function(self)
  -- function num : 0_0
end

bs_10209.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10209_1", 2, self.OnSetHurt, self.caster)
end

bs_10209.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and not (context.skill).isCommonAttack and not context.isMiss and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] and not context.isTriggerSet and context.hurt_type == 1 and (self.arglist)[3] > 0 and (self.arglist)[4] > 0 then
    local tier = 1
    self:PlayChipEffect()
    local time = (self.arglist)[4]
    local pre_tier = (context.target):GetBuffTier((self.config).buffId)
    if (self.arglist)[3] <= pre_tier then
      LuaSkillCtrl:DispelBuff(context.target, (self.config).buffId, tier)
    end
    LuaSkillCtrl:CallBuff(self, context.target, (self.config).buffId, tier, time)
  end
end

bs_10209.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10209

