local bs_30008 = class("bs_30008", LuaSkillBase)
local base = LuaSkillBase
bs_30008.config = {effectIdAttack = 10254, 
hurt_config = {hit_formula = 0, basehurt_formula = 10032, crit_formula = 0}
}
bs_30008.ctor = function(self)
  -- function num : 0_0
end

bs_30008.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_30008_3", 1, self.OnAfterHurt, nil, nil, (self.caster).belongNum)
end

bs_30008.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender.belongNum == (self.caster).belongNum and skill.isCommonAttack and not isMiss and not isTriggerSet and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
    LuaSkillCtrl:CallEffect(target, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
end

bs_30008.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_30008.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30008

