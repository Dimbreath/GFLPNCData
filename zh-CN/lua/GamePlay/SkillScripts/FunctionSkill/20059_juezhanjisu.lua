local bs_20059 = class("bs_20059", LuaSkillBase)
local base = LuaSkillBase
bs_20059.config = {}
bs_20059.ctor = function(self)
  -- function num : 0_0
end

bs_20059.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20059_1", 1, self.OnAfterBattleStart)
end

bs_20059.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local Value = (self.caster).maxHp * (self.arglist)[1] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, Value)
end

bs_20059.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20059

