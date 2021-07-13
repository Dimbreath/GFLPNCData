-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10240 = class("bs_10240", LuaSkillBase)
local base = LuaSkillBase
bs_10240.config = {
realDamageConfig = {basehurt_formula = 10076}
, buffId2 = 1125}
bs_10240.ctor = function(self)
  -- function num : 0_0
end

bs_10240.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10240_2", 1000, self.OnSetHurt, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10240_1", 2, self.OnAfterBattleStart)
end

bs_10240.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, nil, true)
end

bs_10240.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.sender == self.caster and context.isCrit and not context.isTriggerSet and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallRealDamage(self, context.target, nil, (self.config).realDamageConfig, nil, true)
  end
end

bs_10240.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10240

