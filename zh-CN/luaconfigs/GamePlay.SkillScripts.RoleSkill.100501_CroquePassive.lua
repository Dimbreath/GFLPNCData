-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100501 = class("bs_100501", LuaSkillBase)
local base = LuaSkillBase
bs_100501.config = {
heal_config = {baseheal_formula = 10087}
, buffId = 118, heal_time = 15}
bs_100501.ctor = function(self)
  -- function num : 0_0
end

bs_100501.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_100501_1", 1, self.OnAfterBattleStart)
end

bs_100501.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(nil, (self.config).heal_time, self.Callback, self, -1)
  if (self.arglist)[2] > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, nil, true)
  end
end

bs_100501.Callback = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, true)
  skillResult:EndResult()
end

bs_100501.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100501

