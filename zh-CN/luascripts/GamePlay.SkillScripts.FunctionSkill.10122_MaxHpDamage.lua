-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10122 = class("bs_10122", LuaSkillBase)
local base = LuaSkillBase
bs_10122.config = {
hurt_config = {basehurt_formula = 10006}
, effectId = 1002}
bs_10122.ctor = function(self)
  -- function num : 0_0
end

bs_10122.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10122_1", 1, self.OnAfterHurt)
end

bs_10122.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and not isMiss then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(sender, (self.config).effectId, self, self.SkillEventFunc)
  end
end

bs_10122.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_10122.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10122

