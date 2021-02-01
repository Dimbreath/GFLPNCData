-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_203001 = class("bs_203001", LuaSkillBase)
local base = LuaSkillBase
bs_203001.config = {buffId = 209, effectId = 10577, 
HurtConfig = {hit_formula = 0, def_formula = 0, basehurt_formula = 10019, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 0}
}
bs_203001.ctor = function(self)
  -- function num : 0_0
end

bs_203001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_202901_3", 1, self.OnAfterHurt)
end

bs_203001.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self:CallCasterWait(10 + (self.arglist)[4] + 12)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1008, 1, 10, attackTrigger)
end

bs_203001.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBuffRepeated(self, self.caster, (self.config).buffId, 1, (self.arglist)[4], false, self.OnBuffExecute)
end

bs_203001.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_4 , upvalues : _ENV
  local heal = (self.caster).maxHp * (self.arglist)[2] // 1000
  LuaSkillCtrl:CallHeal(heal, self, self.caster)
end

bs_203001.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_5 , upvalues : _ENV
  if target == self.caster and target:GetBuffTier((self.config).buffId) > 0 and isTriggerSet ~= true then
    LuaSkillCtrl:CallEffect(sender, (self.config).effectId, self, self.SkillEventFunc)
  end
end

bs_203001.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_6 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
  end
end

bs_203001.OnBreakSkill = function(self, role)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnBreakSkill)(self, role)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    LuaSkillCtrl:CallRoleAction(self.caster, 100)
    self:CancleCasterWait()
  end
end

bs_203001.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_203001

