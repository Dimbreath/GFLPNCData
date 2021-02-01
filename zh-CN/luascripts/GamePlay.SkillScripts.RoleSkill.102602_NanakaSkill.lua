-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102602 = class("bs_102602", LuaSkillBase)
local base = LuaSkillBase
bs_102602.config = {buffId = 232, buffId2 = 233, effectId = 10721, effectId2 = 10724, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10077, crit_formula = 0}
}
bs_102602.ctor = function(self)
  -- function num : 0_0
end

bs_102602.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_102602_3", 1, self.OnAfterHurt)
end

bs_102602.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(30)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 15, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
end

bs_102602.OnAttackTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, (self.arglist)[1], true)
end

bs_102602.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_4 , upvalues : _ENV
  if sender == self.caster and target ~= self.caster and (self.caster):GetBuffTier((self.config).buffId) > 0 and hurt > 0 and skill.dataId ~= 102602 and skill.isCommonAttack then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self, self.SkillEventFunc)
  end
end

bs_102602.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    if (self.arglist)[3] > 0 then
      LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId2, 1, (self.arglist)[5])
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
  end
end

bs_102602.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102602

