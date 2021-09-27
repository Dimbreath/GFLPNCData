local bs_20080 = class("bs_20080", LuaSkillBase)
local base = LuaSkillBase
bs_20080.config = {}
bs_20080.ctor = function(self)
  -- function num : 0_0
end

bs_20080.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20080_1", 1, self.OnAfterBattleStart)
end

bs_20080.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, 1193, 1, 999)
end

bs_20080.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20080

