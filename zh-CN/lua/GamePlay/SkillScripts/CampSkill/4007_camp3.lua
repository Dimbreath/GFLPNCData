local bs_4007 = class("bs_4007", LuaSkillBase)
local base = LuaSkillBase
bs_4007.config = {buffId = 81, buffTier = 40}
bs_4007.ctor = function(self)
  -- function num : 0_0
end

bs_4007.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4007_1", 1, self.OnAfterBattleStart)
end

bs_4007.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier)
end

bs_4007.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_4007

