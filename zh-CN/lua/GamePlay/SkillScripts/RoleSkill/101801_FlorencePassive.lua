local bs_101801 = class("bs_101801", LuaSkillBase)
local base = LuaSkillBase
bs_101801.config = {buffId_218 = 101802, effectId_pass = 101805}
bs_101801.ctor = function(self)
  -- function num : 0_0
end

bs_101801.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_101801_3", 1, self.OnAfterHurt, self.caster)
  self.time = 0
end

bs_101801.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack then
    self.time = self.time + 1
  end
  if (self.arglist)[1] <= self.time and LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
    self.time = 0
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_pass, self)
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_218, 1, (self.arglist)[2])
  end
end

bs_101801.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101801

