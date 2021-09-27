local bs_10061 = class("bs_10061", LuaSkillBase)
local base = LuaSkillBase
bs_10061.config = {
realDamageConfig = {basehurt_formula = 10034}
, effectId = 10163}
bs_10061.ctor = function(self)
  -- function num : 0_0
end

bs_10061.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddSetHurtTrigger("bs_10061_1", 1, self.OnSetHurt, self.caster)
end

bs_10061.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and not context.isMiss and not context.isTriggerSet then
    LuaSkillCtrl:CallEffect(context.target, (self.config).effectId, self, self.SkillEventFunc)
  end
end

bs_10061.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallRealDamage(self, target, nil, (self.config).realDamageConfig, nil, true)
  end
end

bs_10061.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10061

