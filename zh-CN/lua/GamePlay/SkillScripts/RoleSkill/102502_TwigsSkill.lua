local bs_102502 = class("bs_102502", LuaSkillBase)
local base = LuaSkillBase
bs_102502.config = {skill_time = 31, start_time = 17, actionId = 1002, action_speed = 1, audioId1 = 251, audioId_hit = 253, buffId_Hua = 102502, buffId_CH = 102501, buffId_170 = 170, 
Aoe = {effect_shape = 3, aoe_select_code = 4, aoe_range = 10}
, effectId_trail = 102503, effectId_P = 102506, effectId_hit2 = 102505, effectId_new = 102507, 
HurtConfig = {hit_formula = 0, basehurt_formula = 3000, crit_formula = 0, crithur_ratio = 0}
, ex_hurttime = 3, buffId_170 = 170, buffId_tip = 102503}
bs_102502.ctor = function(self)
  -- function num : 0_0
end

bs_102502.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).skill_arg = (self.arglist)[2]
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).cs_Skill = self.cskill
  self:AddBuffDieTrigger("bs_102502_buff_die", 1, self.OnBuffDie, nil, nil, (self.config).buffId_Hua)
end

bs_102502.PlaySkill = function(self, data)
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
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    ;
    (self.caster):LookAtTarget(target)
    self:CallCasterWait((self.config).skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
  end
end

bs_102502.OnAttackTrigger = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_170, 1, (self.arglist)[1])
  LuaSkillCtrl:StartShowSkillDurationTime(self, (self.arglist)[1])
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_Hua, 1, (self.arglist)[1], false)
  local cusEffect = LuaSkillCtrl:CallEffect(target, (self.config).effectId_P, self)
  local collisionTrigger = BindCallback(self, self.OnCollision, target)
  LuaSkillCtrl:CallCircledEmissionStraightlyWithThreeExtraChild(self, self.caster, target, 15, 10, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, 16, true, true, nil, nil)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_new, self)
end

bs_102502.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_4 , upvalues : _ENV
  if buff.dataId == (self.config).buffId_Hua and removeType == eBuffRemoveType.Timeout then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).Aoe)
    if (skillResult.roleList).Count > 0 then
      for i = 0, (skillResult.roleList).Count - 1 do
        local role = (skillResult.roleList)[i]
        if role:GetBuffTier((self.config).buffId_CH) > 0 then
          LuaSkillCtrl:DispelBuff(role, (self.config).buffId_CH, 0)
        end
      end
    end
    do
      skillResult:EndResult()
    end
  end
end

bs_102502.OnCollision = function(self, target, collider, index, entity)
  -- function num : 0_5 , upvalues : _ENV
  if self.caster == nil or (self.caster).hp <= 0 or entity:GetBuffTier((self.config).buffId_tip) > 0 then
    return 
  end
  local arg1 = ((self.caster).recordTable).skill_arg
  LuaSkillCtrl:CallEffect(entity, (self.config).effectId_hit2, self)
  local _Cskill = ((self.caster).recordTable).cs_Skill
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(_Cskill, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {arg1})
  skillResult:EndResult()
  LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId_tip, 1, 1)
  LuaSkillCtrl:PlayAuSource(entity, (self.config).audioId_hit)
end

bs_102502.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_102502.LuaDispose = function(self)
  -- function num : 0_7 , upvalues : base
  (base.LuaDispose)(self)
end

return bs_102502

