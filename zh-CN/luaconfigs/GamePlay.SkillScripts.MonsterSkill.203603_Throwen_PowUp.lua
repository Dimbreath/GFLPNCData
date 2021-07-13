-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_203603 = class("bs_203603", LuaSkillBase)
local base = LuaSkillBase
bs_203603.config = {buffId = 1172, buffTier = 1}
bs_203603.ctor = function(self)
  -- function num : 0_0
end

bs_203603.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_203603_1", 1, self.OnAfterBattleStart)
end

bs_203603.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
end

bs_203603.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_203603

