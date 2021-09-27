local bs_10051 = class("bs_10051", LuaSkillBase)
local base = LuaSkillBase
bs_10051.config = {buffId = 1014}
bs_10051.ctor = function(self)
  -- function num : 0_0
end

bs_10051.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10051_1", 1, self.OnAfterBattleStart)
end

bs_10051.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], nil, true)
end

bs_10051.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10051

