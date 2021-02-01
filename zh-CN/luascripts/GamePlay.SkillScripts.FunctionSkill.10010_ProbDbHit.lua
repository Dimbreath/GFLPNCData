-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10010 = class("bs_10010", LuaSkillBase)
local base = LuaSkillBase
bs_10010.config = {
hurt_config = {basehurt_formula = 10076}
, effectIdAttack = 1006}
bs_10010.ctor = function(self)
  -- function num : 0_0
end

bs_10010.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_10010_3", 1, self.OnAfterHurt)
end

bs_10010.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[2] and not isTriggerSet then
    local targetL = ((self.caster).recordTable).lastAttackRole
    if targetL ~= nil then
      self:PlayChipEffect()
      ;
      (self.caster):LookAtTarget(targetL)
      LuaSkillCtrl:CallEffect(targetL, (self.config).effectIdAttack, self, self.SkillEventFunc)
    end
  end
end

bs_10010.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config, nil, true)
    skillResult:EndResult()
  end
end

bs_10010.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10010

