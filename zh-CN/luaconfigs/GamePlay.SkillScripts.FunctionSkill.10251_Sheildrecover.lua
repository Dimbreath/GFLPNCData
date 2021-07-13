-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10251 = class("bs_10251", LuaSkillBase)
local base = LuaSkillBase
bs_10251.config = {
heal_config = {baseheal_formula = 10139}
}
bs_10251.ctor = function(self)
  -- function num : 0_0
end

bs_10251.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_100501_1", 1, self.OnAfterBattleStart)
end

bs_10251.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], self.Callback, self, -1)
end

bs_10251.Callback = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local sheild = LuaSkillCtrl:GetShield(self.caster, 0)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {sheild}, false, true)
  skillResult:EndResult()
end

bs_10251.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10251

