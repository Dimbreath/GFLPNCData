local bs_10076 = class("bs_10076", LuaSkillBase)
local base = LuaSkillBase
bs_10076.config = {buffId = 26, buffTier = 1}
bs_10076.ctor = function(self)
  -- function num : 0_0
end

bs_10076.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_10076_3", 1, self.OnAfterHurt, self.caster)
end

bs_10076.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss and skill.isCommonAttack and not isTriggerSet and LuaSkillCtrl:CallRange(1, 100) <= (self.arglist)[1] then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, (self.arglist)[2])
  end
end

bs_10076.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10076

