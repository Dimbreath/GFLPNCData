local bs_30004 = class("bs_30004", LuaSkillBase)
local base = LuaSkillBase
bs_30004.config = {
heal_config = {baseheal_formula = 10139}
}
bs_30004.ctor = function(self)
  -- function num : 0_0
end

bs_30004.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30004_1", 1, self.OnAfterBattleStart)
end

bs_30004.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], self.Callback, self, -1)
end

bs_30004.Callback = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local sheild = LuaSkillCtrl:GetShield(self.caster, eShieldType.Normal) + LuaSkillCtrl:GetShield(self.caster, eShieldType.LongRange) + LuaSkillCtrl:GetShield(self.caster, eShieldType.NoRange)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {sheild}, false, true)
  skillResult:EndResult()
end

bs_30004.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30004

