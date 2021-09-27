local bs_20088 = class("bs_20088", LuaSkillBase)
local base = LuaSkillBase
bs_20088.config = {buffId = 1214}
bs_20088.ctor = function(self)
  -- function num : 0_0
end

bs_20088.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20088_1", 1, self.OnAfterBattleStart)
end

bs_20088.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
end

bs_20088.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20088

