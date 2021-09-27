local bs_10032 = class("bs_10032", LuaSkillBase)
local base = LuaSkillBase
bs_10032.config = {buffId = 81}
bs_10032.ctor = function(self)
  -- function num : 0_0
end

bs_10032.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10032_1", 1, self.OnAfterBattleStart)
end

bs_10032.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], nil, true)
end

bs_10032.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10032

