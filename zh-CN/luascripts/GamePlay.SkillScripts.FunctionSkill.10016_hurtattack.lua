-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10016 = class("bs_10016", LuaSkillBase)
local base = LuaSkillBase
bs_10016.config = {
hurt_config = {basehurt_formula = 10007}
, effectIdAttack = 10120}
bs_10016.ctor = function(self)
  -- function num : 0_0
end

bs_10016.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10016_3", 1, self.OnAfterHurt)
end

bs_10016.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[2] then
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallEffect(targetList, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
end

bs_10016.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_10016.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10016

