-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10217 = class("bs_10217", LuaSkillBase)
local base = LuaSkillBase
bs_10217.config = {buffId = 1114}
bs_10217.ctor = function(self)
  -- function num : 0_0
end

bs_10217.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10217_1", 1, self.OnAfterBattleStart)
end

bs_10217.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, nil, true)
end

bs_10217.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10217

