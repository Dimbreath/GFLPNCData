local bs_30038 = class("bs_30038", LuaSkillBase)
local base = LuaSkillBase
bs_30038.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0}
, effectIdAttack = 10254}
bs_30038.ctor = function(self)
  -- function num : 0_0
end

bs_30038.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_30038_3", 1, self.OnAfterHurt, nil, nil, nil, (self.caster).belongNum)
end

bs_30038.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target.belongNum == (self.caster).belongNum and isMiss and (self.caster).career ~= 4 then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(sender, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
end

bs_30038.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, true)
    skillResult:EndResult()
  end
end

bs_30038.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30038

