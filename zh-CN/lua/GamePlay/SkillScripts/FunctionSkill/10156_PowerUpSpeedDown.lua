local bs_10156 = class("bs_10156", LuaSkillBase)
local base = LuaSkillBase
bs_10156.config = {buffId1 = 1031, buffId2 = 1030}
bs_10156.ctor = function(self)
  -- function num : 0_0
end

bs_10156.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10156_1", 1, self.OnAfterBattleStart)
end

bs_10156.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, (self.arglist)[1], nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, (self.arglist)[2], nil, true)
end

bs_10156.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10156

