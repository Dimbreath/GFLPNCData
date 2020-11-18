-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10123 = class("bs_10123", LuaSkillBase)
local base = LuaSkillBase
bs_10123.config = {effectId = 10171, buffId = 1018}
bs_10123.ctor = function(self)
  -- function num : 0_0
end

bs_10123.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10123_1", 1, self.OnAfterHurt)
end

bs_10123.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss and not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1])
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    self:PlayChipEffect()
  end
end

bs_10123.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10123

