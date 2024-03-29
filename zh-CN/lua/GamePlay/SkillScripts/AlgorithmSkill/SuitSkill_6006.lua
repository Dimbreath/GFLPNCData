local bs_6006 = class("bs_6006", LuaSkillBase)
local base = LuaSkillBase
bs_6006.config = {buffId = 127, formulaID = 10023}
bs_6006.ctor = function(self)
  -- function num : 0_0
end

bs_6006.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_6006_1", 1, self.OnAfterBattleStart)
end

bs_6006.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
end

bs_6006.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6006

