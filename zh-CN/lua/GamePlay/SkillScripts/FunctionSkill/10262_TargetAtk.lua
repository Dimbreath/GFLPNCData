local bs_10262 = class("bs_10262", LuaSkillBase)
local base = LuaSkillBase
bs_10262.config = {buffId = 1177, buffTier = 1}
bs_10262.ctor = function(self)
  -- function num : 0_0
end

bs_10262.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10262_3", 1, self.OnAfterHurt, self.caster)
end

bs_10262.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and target.hp * 1000 // target.maxHp <= (self.arglist)[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  else
    if sender == self.caster and (self.arglist)[1] < target.hp * 1000 // target.maxHp then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    end
  end
end

bs_10262.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10262

