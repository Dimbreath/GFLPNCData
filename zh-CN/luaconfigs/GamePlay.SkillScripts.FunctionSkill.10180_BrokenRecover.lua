-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10180 = class("bs_10180", LuaSkillBase)
local base = LuaSkillBase
bs_10180.config = {
heal_config = {baseheal_formula = 10006, heal_number = 0, correct_formula = 9990}
}
bs_10180.ctor = function(self)
  -- function num : 0_0
end

bs_10180.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_10180_22", 1, self.OnBreakShield)
end

bs_10180.OnBreakShield = function(self, shieldType, sender, target)
  -- function num : 0_2 , upvalues : _ENV
  if target.belongNum ~= (self.caster).belongNum then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).heal_config)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config)
    skillResult:EndResult()
  end
end

bs_10180.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10180

