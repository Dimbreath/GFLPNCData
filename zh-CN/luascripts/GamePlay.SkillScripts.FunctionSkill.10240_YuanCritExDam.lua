-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10240 = class("bs_10240", LuaSkillBase)
local base = LuaSkillBase
bs_10240.config = {
realDamageConfig = {damageFormula = 10076}
}
bs_10240.ctor = function(self)
  -- function num : 0_0
end

bs_10240.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_10240_2", 1000, self.OnSetHurt)
end

bs_10240.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and context.isCrit and not context.isTriggerSet and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallRealDamage(self, context.target, nil, (self.config).realDamageConfig, nil, true)
  end
end

bs_10240.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10240

