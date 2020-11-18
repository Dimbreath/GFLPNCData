-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40021 = class("bs_40021", LuaSkillBase)
local base = LuaSkillBase
bs_40021.config = {buffId1 = 1021, buffId2 = 1022}
bs_40021.ctor = function(self)
  -- function num : 0_0
end

bs_40021.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_40021_1", 1, self.OnAfterBattleStart)
end

bs_40021.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, (self.arglist)[1])
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, (self.arglist)[1])
end

bs_40021.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40021

