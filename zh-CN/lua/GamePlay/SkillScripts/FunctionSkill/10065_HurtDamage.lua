local bs_10065 = class("bs_10065", LuaSkillBase)
local base = LuaSkillBase
bs_10065.config = {
hurt_config = {basehurt_formula = 10007}
, effectId = 1002}
bs_10065.ctor = function(self)
  -- function num : 0_0
end

bs_10065.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_10065_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddSetHurtTrigger("bs_10065_4", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, (self.cskill).dataId)
end

bs_10065.OnSetHurt = function(self, context)
  -- function num : 0_2
  if context.sender == self.caster and context.skill == self.cskill then
    context.isTriggerSet = true
  end
end

bs_10065.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster and not isMiss and sender ~= nil and sender.hp > 0 and self:IsReadyToTake() and skill ~= self.cskill then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender, self.config)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, true)
    LuaSkillCtrl:CallEffect(sender, (self.config).effectId, self)
    self:PlayChipEffect()
    skillResult:EndResult()
    self:OnSkillTake()
  end
end

bs_10065.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10065

