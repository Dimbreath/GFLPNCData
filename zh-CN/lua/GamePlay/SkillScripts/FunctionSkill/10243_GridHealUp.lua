local bs_10243 = class("bs_10243", LuaSkillBase)
local base = LuaSkillBase
bs_10243.config = {
heal_config = {baseheal_formula = 10118, heal_number = 0, correct_formula = 9990}
}
bs_10243.ctor = function(self)
  -- function num : 0_0
end

bs_10243.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_10243_1", 1, self.OnAfterBattleStart)
end

bs_10243.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], self.RealPlaySkill, self, -1)
end

bs_10243.RealPlaySkill = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if LuaSkillCtrl:GetRoleEfcGrid(self.caster) ~= 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config)
    skillResult:EndResult()
  end
end

bs_10243.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10243

