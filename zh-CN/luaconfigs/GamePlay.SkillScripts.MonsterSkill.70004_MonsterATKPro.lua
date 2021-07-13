-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_70004 = class("bs_70004", LuaSkillBase)
local base = LuaSkillBase
bs_70004.config = {buffId = 1146, buffId2 = 1147, buffId3 = 198, buffTier = 1}
bs_70004.ctor = function(self)
  -- function num : 0_0
end

bs_70004.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_70004_1", 1, self.OnAfterBattleStart)
end

bs_70004.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, (self.config).buffTier, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId3, (self.config).buffTier, nil, true)
end

bs_70004.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_70004

