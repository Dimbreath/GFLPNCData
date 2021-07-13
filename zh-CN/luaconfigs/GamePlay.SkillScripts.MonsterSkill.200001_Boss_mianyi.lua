-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_200001 = class("bs_200001", LuaSkillBase)
local base = LuaSkillBase
bs_200001.config = {buffId_198 = 198}
bs_200001.ctor = function(self)
  -- function num : 0_0
end

bs_200001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_200001_1", 1, self.OnAfterBattleStart)
end

bs_200001.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_198, 1, nil, true)
end

bs_200001.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_200001

