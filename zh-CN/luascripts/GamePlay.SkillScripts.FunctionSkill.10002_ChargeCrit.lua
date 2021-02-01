-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10002 = class("bs_10002", LuaSkillBase)
local base = LuaSkillBase
bs_10002.config = {crit_formula = 10003, buffId = 1034, effectCreat = 64, effectBoom = 64}
bs_10002.ctor = function(self)
  -- function num : 0_0
end

bs_10002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_10002_3", 1, self.OnAfterHurt)
end

bs_10002.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isTriggerSet and not isCrit then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], nil, true)
  end
  if sender == self.caster and isCrit and not isMiss then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
  end
end

bs_10002.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10002

