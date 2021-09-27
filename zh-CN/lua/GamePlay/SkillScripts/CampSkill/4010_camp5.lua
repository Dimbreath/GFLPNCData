local bs_4010 = class("bs_4010", LuaSkillBase)
local base = LuaSkillBase
bs_4010.config = {buffId = 80, buffTier = 22}
bs_4010.ctor = function(self)
  -- function num : 0_0
end

bs_4010.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4010_1", 1, self.OnAfterBattleStart)
end

bs_4010.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier)
end

bs_4010.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_4010

