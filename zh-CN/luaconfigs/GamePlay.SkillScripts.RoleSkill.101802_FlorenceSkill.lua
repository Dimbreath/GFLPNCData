-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101802 = class("bs_101802", LuaSkillBase)
local base = LuaSkillBase
bs_101802.config = {buffId_262 = 262, effectId_skill = 10670, 
heal_config = {baseheal_formula = 10145}
, shield_ex_Formula = 10088, skill_time = 34, start_time = 12, actionId = 1002, action_speed = 1, skill_select = 30}
bs_101802.ctor = function(self)
  -- function num : 0_0
end

bs_101802.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.time = {}
end

bs_101802.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local target = self:GetMoveSelectTarget()
  if target ~= nil then
    target = target.targetRole
  end
  if target ~= nil then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    ;
    (self.caster):LookAtTarget(target)
    self:CallCasterWait((self.config).skill_time)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
  end
end

bs_101802.OnAttackTrigger = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  if target.hp > 0 then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_skill, self, self.SkillEventFunc)
  end
  if target.hp <= 0 then
    local target_new = LuaSkillCtrl:CallTargetSelect(self, 30, 0)
    if target_new.Count > 0 then
      LuaSkillCtrl:CallEffect((target_new[0]).targetRole, (self.config).effectId_skill, self, self.SkillEventFunc)
    end
  end
end

bs_101802.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if effect.dataId == (self.config).effectId_skill and eventId == eBattleEffectEvent.Trigger then
    local num = ((target.targetRole).maxHp - (target.targetRole).hp) * 1000 // (target.targetRole).maxHp // (self.arglist)[2] * (self.arglist)[3]
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {num})
    skillResult:EndResult()
    if (self.arglist)[4] > 0 then
      LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId_262, (self.arglist)[5], nil)
    end
  end
end

bs_101802.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101802

