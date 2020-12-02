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
  self:AddLuaTrigger(eSkillLuaTrigger.OnSheldBroken, self.OnSheldBroken)
end

bs_10180.OnSheldBroken = function(self, sender, targetRole)
  -- function num : 0_2 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).heal_config)
  skillResult:HealResult((self.config).heal_config)
  skillResult:EndResult()
end

bs_10180.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10180

