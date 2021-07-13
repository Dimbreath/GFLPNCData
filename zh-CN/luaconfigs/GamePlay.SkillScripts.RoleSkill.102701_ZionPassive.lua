-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102701 = class("bs_102701", LuaSkillBase)
local base = LuaSkillBase
bs_102701.config = {effectId_ShieldSj = 10382, buffId_265 = 265}
bs_102701.ctor = function(self)
  -- function num : 0_0
end

bs_102701.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  if (self.arglist)[4] > 0 then
    self:AddSetHurtTrigger("bs_102701_2", 1, self.OnSetHurt, nil, self.caster)
  end
  self:AddAfterHurtTrigger("bs_102701_3", 1, self.OnAfterHurt, nil, self.caster)
  self.hurt = 0
  self.num = (self.caster).maxHp * (self.arglist)[1] // 1000
end

bs_102701.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster then
    self.hurt = self.hurt + hurt
    if self.num < self.hurt then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_265, 1, (self.arglist)[2])
      LuaSkillCtrl:SetRoleHitAudioHint(self.caster, eHitAuRoleType.Shield)
      LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    LuaSkillCtrl:SetRoleHitAudioHint(self.caster, nil)
  end
)
      self.hurt = 0
    end
    if (self.caster):GetBuffTier((self.config).buffId_265) > 0 then
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_ShieldSj, self)
    end
  end
end

bs_102701.OnSetHurt = function(self, context)
  -- function num : 0_3
  if context.target == self.caster and (self.caster):GetBuffTier((self.config).buffId_265) > 0 then
    local des = (self.caster).skill_intensity * (self.arglist)[5] // 1000
    local real_hurt = context.hurt - des
    if real_hurt < (self.arglist)[6] then
      real_hurt = (self.arglist)[6]
    end
    context.hurt = real_hurt
  end
end

bs_102701.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102701

