-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_200702 = class("bs_200702", LuaSkillBase)
local base = LuaSkillBase
bs_200702.config = {buffId = 1170, buffTier = 1}
bs_200702.ctor = function(self)
  -- function num : 0_0
end

bs_200702.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_200702_1", 1, self.OnAfterBattleStart)
end

bs_200702.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
end

bs_200702.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_200702

