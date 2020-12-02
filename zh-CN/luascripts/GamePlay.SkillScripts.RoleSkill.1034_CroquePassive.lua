-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1034 = class("bs_1034", LuaSkillBase)
local base = LuaSkillBase
bs_1034.config = {
heal_config = {baseheal_formula = 1079, heal_number = 0, correct_formula = 9990}
, buffId = 118}
bs_1034.ctor = function(self)
  -- function num : 0_0
end

bs_1034.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1034_1", 1, self.OnAfterBattleStart)
end

bs_1034.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(self, 15, self.Callback, self, -1)
  if (self.arglist)[2] > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
  end
end

bs_1034.Callback = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config)
  skillResult:EndResult()
end

bs_1034.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1034

