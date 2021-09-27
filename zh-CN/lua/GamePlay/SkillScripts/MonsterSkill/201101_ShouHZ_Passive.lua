local bs_40027 = class("bs_40027", LuaSkillBase)
local base = LuaSkillBase
bs_40027.config = {buffId_1035 = 1035}
bs_40027.ctor = function(self)
  -- function num : 0_0
end

bs_40027.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_40027_3", 10, self.OnAfterHurt, nil, self.caster)
  self:AddAfterHealTrigger("bs_40027_4", 10, self.OnAfterHeal, nil, self.caster)
end

bs_40027.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and target.hp < target.maxHp * (self.arglist)[1] // 1000 and target:GetBuffTier((self.config).buffId_1035) == 0 then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_1035, 1, nil, true)
  end
end

bs_40027.OnAfterHeal = function(self, sender, target, skill, heal)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster and target.maxHp * (self.arglist)[1] // 1000 < target.hp and target:GetBuffTier((self.config).buffId_1035) == 1 then
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId_1035, 1, true)
  end
end

bs_40027.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40027

