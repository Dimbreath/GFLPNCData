local bs_30028 = class("bs_30028", LuaSkillBase)
local base = LuaSkillBase
bs_30028.config = {
heal_config = {baseheal_formula = 10106, heal_number = 0, correct_formula = 9990}
}
bs_30028.ctor = function(self)
  -- function num : 0_0
end

bs_30028.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_30028_2", 1, self.OnBreakShield)
end

bs_30028.OnBreakShield = function(self, shieldType, sender, target)
  -- function num : 0_2 , upvalues : _ENV
  if target.belongNum == (self.caster).belongNum and shieldType ~= eShieldType.Beelneith and self:IsReadyToTake() then
    self:OnSkillTake()
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, true, true)
    skillResult:EndResult()
  end
end

bs_30028.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30028

