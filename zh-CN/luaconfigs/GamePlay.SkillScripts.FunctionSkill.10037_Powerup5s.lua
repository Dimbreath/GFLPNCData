-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10037 = class("bs_10037", LuaSkillBase)
local base = LuaSkillBase
bs_10037.config = {buffId = 1005}
bs_10037.ctor = function(self)
  -- function num : 0_0
end

bs_10037.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10037_1", 1, self.OnAfterBattleStart)
end

bs_10037.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], (self.arglist)[2], true)
end

bs_10037.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10037

