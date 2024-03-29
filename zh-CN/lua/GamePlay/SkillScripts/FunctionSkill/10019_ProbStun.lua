local bs_10019 = class("bs_10019", LuaSkillBase)
local base = LuaSkillBase
bs_10019.config = {buffId = 66, buffTier = 1}
bs_10019.ctor = function(self)
  -- function num : 0_0
end

bs_10019.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_10019_3", 1, self.OnAfterHurt, self.caster)
end

bs_10019.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] and not isTriggerSet then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, (self.arglist)[2])
  end
end

bs_10019.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10019

