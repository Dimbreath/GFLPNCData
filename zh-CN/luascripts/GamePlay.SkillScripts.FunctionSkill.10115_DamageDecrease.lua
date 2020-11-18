-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10115 = class("bs_10115", LuaSkillBase)
local base = LuaSkillBase
bs_10115.config = {buffId = 1015}
bs_10115.ctor = function(self)
  -- function num : 0_0
end

bs_10115.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10115_1", 1, self.OnAfterBattleStart)
end

bs_10115.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1])
end

bs_10115.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10115

