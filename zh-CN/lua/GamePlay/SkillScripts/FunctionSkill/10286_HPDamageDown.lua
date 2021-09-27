local bs_10286 = class("bs_10286", LuaSkillBase)
local base = LuaSkillBase
bs_10286.config = {buffId = 1194, buffTier = 1}
bs_10286.ctor = function(self)
  -- function num : 0_0
end

bs_10286.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10286_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddAfterHealTrigger("bs_10286_5", 1, self.OnAfterHeal, nil, self.caster)
end

bs_10286.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and (self.caster).hp < (self.caster).maxHp * (self.arglist)[1] // 1000 and (self.caster):GetBuffTier((self.config).buffId) < 1 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  end
end

bs_10286.OnAfterHeal = function(self, sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster and target.maxHp * (self.arglist)[1] // 1000 < target.hp then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
  end
end

bs_10286.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10286

