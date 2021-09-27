local bs_100602 = class("bs_100602", LuaSkillBase)
local base = LuaSkillBase
bs_100602.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 3010, crit_formula = 0, crithur_ratio = 0, returndamage_formula = 0}
, 
HurtConfig2 = {hit_formula = 0, def_formula = 0, basehurt_formula = 3010, crit_formula = 0, returndamage_formula = 0, hurt_type = 2}
, actionId = 1002, action_speed = 1, skill_time = 15, start_time = 8, effectId_skill = 100608, effectId_light1 = 100609, effectId_light2 = 100610, effectId_lz = 100307, buffId_lz1 = 100601, buffId_lz2 = 100301, buffId_fire = 3011, radius = 50, spd = 15}
bs_100602.ctor = function(self)
  -- function num : 0_0
end

bs_100602.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterAddBuffTrigger("bs_100602_8", 1, self.OnAfterAddBuff, nil, nil, nil, nil, (self.config).buffId_lz1)
  self:AddBeforeBuffDispelTrigger("bs_100602_10", 1, self.OnBeforBuffDispel, nil, nil, (self.config).buffId_lz1)
end

bs_100602.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget == nil then
    return 
  end
  local realtargetrole = moveTarget.targetRole
  ;
  (self.caster):LookAtTarget(realtargetrole)
  self:CallCasterWait((self.config).skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, realtargetrole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).acton_speed, (self.config).start_time, attackTrigger)
end

bs_100602.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  local cusEffect = LuaSkillCtrl:CallEffect(target, (self.config).effectId_skill, self)
  local collisionTrigger = BindCallback(self, self.OnCollision)
  local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, (self.config).radius, (self.config).spd, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, true, false, EmissionArrive)
  local cusEffect1 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, (self.config).effectId_light1, self, nil, nil, nil, true)
  local cusEffect2 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, (self.config).effectId_light2, self, nil, nil, nil, true)
end

bs_100602.OnCollision = function(self, collider, index, entity)
  -- function num : 0_4 , upvalues : _ENV
  if entity.intensity == 0 and entity.career == 1 then
    return 
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:PlayAuHit(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {(self.arglist)[1]})
  skillResult:EndResult()
  LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId_lz1, 1)
end

bs_100602.OnEmissionArrive = function(self, skillEmission)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallRestartEmit(self, skillEmission, (self.config).spd, self.caster, true, true)
end

bs_100602.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_6 , upvalues : _ENV
  if buff.dataId == (self.config).buffId_lz1 and target ~= nil and target.hp > 0 and target:GetBuffTier((self.config).buffId_lz1) + target:GetBuffTier((self.config).buffId_lz2) == 4 then
    local buffs = LuaSkillCtrl:GetRoleBuffs(target)
    if buffs.Count <= 0 then
      return 
    end
    local _1tier = target:GetBuffTier((self.config).buffId_lz1)
    local _2tier = 0
    for i = 0, buffs.Count - 1 do
      if (buffs[i]).dataId == (self.config).buffId_lz2 and (buffs[i]).maker ~= nil and ((buffs[i]).maker).hp > 0 then
        _2tier = target:GetBuffTier((self.config).buffId_lz2)
      end
    end
    if _2tier == 0 then
      _1tier = 4
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local hurt_arg = 400 * _1tier
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig2, {hurt_arg})
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_lz, self)
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId_lz1, 0, true)
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId_lz2, 0)
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_fire, 1)
  end
end

bs_100602.OnBeforBuffDispel = function(self, target, context)
  -- function num : 0_7 , upvalues : _ENV
  if context.buffId == (self.config).buffId_lz1 then
    local _1tier = target:GetBuffTier((self.config).buffId_lz1)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local hurt_arg = 400 * _1tier
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig2, {hurt_arg})
    skillResult:EndResult()
  end
end

bs_100602.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100602

