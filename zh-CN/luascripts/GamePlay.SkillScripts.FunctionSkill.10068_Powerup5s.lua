-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10068 = class("bs_10068", LuaSkillBase)
local base = LuaSkillBase
bs_10068.config = {buffId = 1009}
bs_10068.ctor = function(self)
  -- function num : 0_0
end

bs_10068.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10068_1", 1, self.OnAfterBattleStart)
end

bs_10068.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], (self.arglist)[2])
end

bs_10068.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10068

