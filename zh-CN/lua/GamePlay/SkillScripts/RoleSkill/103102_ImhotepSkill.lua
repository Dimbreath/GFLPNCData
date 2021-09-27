local bs_103102 = class("bs_103102", LuaSkillBase)
local base = LuaSkillBase
bs_103102.config = {audioId1 = 103103, audioId2 = 103104, effectId_heal = 103104, effectId_trail = 103103, 
hurt_config = {hit_formula = 0, basehurt_formula = 3010}
, 
heal_config = {baseheal_formula = 3021}
}
bs_103102.ctor = function(self)
  -- function num : 0_0
end

bs_103102.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103102.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local last_target = ((self.caster).recordTable).lastAttackRole
  local target = nil
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return 
    end
    target = tempTarget.targetRole
  end
  do
    self:CallCasterWait(15)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    if target ~= nil then
      (self.caster):LookAtTarget(target)
    end
    if target ~= nil then
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1.5, 1, attackTrigger)
      LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
    end
  end
end

bs_103102.OnAttackTrigger = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_trail, self, self.SkillEventFunc)
end

bs_103102.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local target_effect = LuaSkillCtrl:GetTargetWithGrid((target.targetRole).x, (target.targetRole).y)
    local caster_effect = LuaSkillCtrl:GetTargetWithGrid((self.caster).x, (self.caster).y)
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target.targetRole)
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {(self.arglist)[1]})
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(caster_effect, (self.config).effectId_heal, self, self.SkillEventFunc_heal)
    LuaSkillCtrl:CallEffect(target_effect, (self.config).effectId_heal, self, self.SkillEventFunc_heal)
  end
end

bs_103102.SkillEventFunc_heal = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Create then
    local targetList = LuaSkillCtrl:FindAllRolesWithinRange(target, 1, true)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i]
        if role.belongNum == (self.caster).belongNum then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {(self.arglist)[2]})
          skillResult:EndResult()
        end
      end
    end
  end
end

bs_103102.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103102

