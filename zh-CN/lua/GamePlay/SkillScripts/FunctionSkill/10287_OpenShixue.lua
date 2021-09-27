local bs_10287 = class("bs_10287", LuaSkillBase)
local base = LuaSkillBase
bs_10287.config = {buffId_shixue = 257}
bs_10287.ctor = function(self)
  -- function num : 0_0
end

bs_10287.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10287_2", 2, self.OnAfterBattleStart)
end

bs_10287.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_shixue, (self.arglist)[1])
end

bs_10287.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10287

