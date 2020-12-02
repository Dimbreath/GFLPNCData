-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_4004 = class("bs_4004", LuaSkillBase)
local base = LuaSkillBase
bs_4004.config = {buffId = 81, buffTier = 10}
bs_4004.ctor = function(self)
  -- function num : 0_0
end

bs_4004.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4004_1", 1, self.OnAfterBattleStart)
end

bs_4004.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier)
end

bs_4004.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_4004

