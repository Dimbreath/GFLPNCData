-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202002 = class("bs_202002", LuaSkillBase)
local base = LuaSkillBase
bs_202002.config = {buffId = 1153}
bs_202002.ctor = function(self)
  -- function num : 0_0
end

bs_202002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_202002_1", 1, self.OnAfterBattleStart)
end

bs_202002.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:RegisterRoleHpCostEvent(self, self.caster, {800, 600, 400, 200}, self.OnHpSubCost, false)
end

bs_202002.OnHpSubCost = function(self, curHp, TargetValue)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, (self.arglist)[2], true)
end

bs_202002.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202002

