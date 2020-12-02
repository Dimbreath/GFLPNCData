-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10149 = class("bs_10149", LuaSkillBase)
local base = LuaSkillBase
bs_10149.config = {
hurt_config = {basehurt_formula = 10076}
, effectIdAttack = 10254}
bs_10149.ctor = function(self)
  -- function num : 0_0
end

bs_10149.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10149_3", 1, self.OnAfterHurt)
end

bs_10149.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if target.belongNum == (self.caster).belongNum and isMiss then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(sender, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
end

bs_10149.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_10149.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10149

