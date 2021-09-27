local bs_30026 = class("bs_30026", LuaSkillBase)
local base = LuaSkillBase
bs_30026.config = {buffId = 1188}
bs_30026.ctor = function(self)
  -- function num : 0_0
end

bs_30026.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnChipSuitInvoke, self.OnChipSuitInvoke)
end

bs_30026.OnChipSuitInvoke = function(self, sender, targetRole)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1])
end

bs_30026.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30026

