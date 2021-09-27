local bs_10185 = class("bs_10185", LuaSkillBase)
local base = LuaSkillBase
bs_10185.config = {sheildBuffId = 174, 
hurt_config = {basehurt_formula = 10007}
}
bs_10185.ctor = function(self)
  -- function num : 0_0
end

bs_10185.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10185_2", 1, self.OnSetHurt, self.caster)
end

bs_10185.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and not context.isTriggerSet and self:IsReadyToTake() then
    local value = LuaSkillCtrl:GetShield(context.target, eShieldType.NoRange)
    local value2 = LuaSkillCtrl:GetShield(context.target, eShieldType.LongRange)
    if value > 0 or value2 > 0 then
      self:OnSkillTake()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, true)
      skillResult:EndResult()
    end
  end
end

bs_10185.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10185

