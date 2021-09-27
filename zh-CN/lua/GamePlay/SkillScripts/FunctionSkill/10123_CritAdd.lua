local bs_10123 = class("bs_10123", LuaSkillBase)
local base = LuaSkillBase
bs_10123.config = {effectId = 10171, buffId = 1117}
bs_10123.ctor = function(self)
  -- function num : 0_0
end

bs_10123.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10123_1", 1, self.OnAfterHurt, self.caster)
end

bs_10123.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss and skill.isCommonAttack and self:IsReadyToTake() and not isTriggerSet then
    if (self.caster):GetBuffTier((self.config).buffId) < (self.arglist)[2] then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, nil, true)
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
      self:PlayChipEffect()
    else
      if (self.arglist)[2] < (self.caster):GetBuffTier((self.config).buffId) then
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[2], nil, true)
      end
    end
    self:OnSkillTake()
  end
  if sender == self.caster and not isMiss and skill.isCommonAttack and isCrit and not ((self.caster).recordTable)["30033_Flag"] then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
  end
end

bs_10123.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10123

