local bs_60000 = class("bs_60000", LuaSkillBase)
local base = LuaSkillBase
bs_60000.config = {buffId1 = 175, buffId2 = 1033, buffId3 = 198, buffId4 = 88, buffId5 = 3015}
bs_60000.ctor = function(self)
  -- function num : 0_0
end

bs_60000.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_60000_1", 1, self.OnAfterBattleStart)
end

bs_60000.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId3, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId4, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId5, 1, nil, true)
end

bs_60000.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_60000

