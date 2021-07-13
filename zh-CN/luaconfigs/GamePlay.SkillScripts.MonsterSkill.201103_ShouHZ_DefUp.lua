-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_201103 = class("bs_201103", LuaSkillBase)
local base = LuaSkillBase
bs_201103.config = {buffId = 1171, buffTier = 1}
bs_201103.ctor = function(self)
  -- function num : 0_0
end

bs_201103.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_201103_1", 1, self.OnAfterBattleStart)
end

bs_201103.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
end

bs_201103.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_201103

