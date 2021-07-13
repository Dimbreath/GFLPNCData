-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10017 = class("bs_10017", LuaSkillBase)
local base = LuaSkillBase
bs_10017.config = {
hurt_config = {basehurt_formula = 10007}
, effectIdAttack = 1006}
bs_10017.ctor = function(self)
  -- function num : 0_0
end

bs_10017.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHealTrigger("bs_10017_5", 1, self.OnAfterHeal, nil, self.caster)
end

bs_10017.OnAfterHeal = function(self, sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[2] and not isTriggerSet then
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallEffect(targetList, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
end

bs_10017.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, true)
    skillResult:EndResult()
  end
end

bs_10017.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10017

