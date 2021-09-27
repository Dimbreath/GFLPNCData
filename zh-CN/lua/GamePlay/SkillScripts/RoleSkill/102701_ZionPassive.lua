local bs_102701 = class("bs_102701", LuaSkillBase)
local base = LuaSkillBase
bs_102701.config = {effectId_ShieldSj = 10382, buffId_265 = 265, audioId1 = 263, audio_loop = 262}
bs_102701.ctor = function(self)
  -- function num : 0_0
end

bs_102701.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_102701_2", 1, self.OnSetHurt, nil, self.caster)
  self:AddAfterHurtTrigger("bs_102701_3", 1, self.OnAfterHurt, nil, self.caster)
  self.hurt = 0
  self.num = (self.caster).maxHp * (self.arglist)[1] // 1000
  self.maxnum = (self.caster).maxHp
end

bs_102701.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if self.maxnum ~= (self.caster).maxHp then
    self.maxnum = (self.caster).maxHp * (self.arglist)[1] // 1000
  end
  if (self.caster).hp < self.num and (self.caster):GetBuffTier((self.config).buffId_265) <= 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_265, 1)
    LuaSkillCtrl:SetRoleHitAudioHint(self.caster, eHitAuRoleType.Shield)
  end
  if target == self.caster and (self.caster):GetBuffTier((self.config).buffId_265) > 0 then
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_ShieldSj, self)
  end
  if self.num <= (self.caster).hp and (self.caster):GetBuffTier((self.config).buffId_265) > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_265, 0, true)
  end
end

bs_102701.OnSetHurt = function(self, context)
  -- function num : 0_3
  if context.target == self.caster and (self.caster):GetBuffTier((self.config).buffId_265) > 0 then
    local des = (self.caster).skill_intensity * (self.arglist)[2] // 1000
    local real_hurt = context.hurt - des
    if real_hurt < (self.arglist)[3] then
      real_hurt = (self.arglist)[3]
    end
    context.hurt = real_hurt
  end
end

bs_102701.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102701

