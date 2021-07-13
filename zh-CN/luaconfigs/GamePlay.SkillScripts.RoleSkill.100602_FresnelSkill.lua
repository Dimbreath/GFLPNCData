-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100602 = class("bs_100602", LuaSkillBase)
local base = LuaSkillBase
bs_100602.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0, crithur_ratio = 0}
, audioId1 = 31, actionId = 1002, action_speed = 1, skill_time = 15, start_time = 8, effectId_skill = 10033, effectId_light1 = 10034, effectId_light2 = 10037, radius = 50, spd = 15}
bs_100602.ctor = function(self)
  -- function num : 0_0
end

bs_100602.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_100602_1", 1, self.BeforeEndBattle)
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
  self.Over = BindCallback(self, self.Onover)
  self.Over2 = BindCallback(self, self.Onover2)
  self.audio1 = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  local cusEffect = LuaSkillCtrl:CallEffect(target, (self.config).effectId_skill, self)
  if (self.arglist)[2] >= 1 then
    local collisionTrigger = BindCallback(self, self.OnCollision)
    local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
    local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, (self.config).radius, (self.config).spd, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, true, false, EmissionArrive)
    local cusEffect1 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, (self.config).effectId_light1, self, nil, nil, nil, true)
    local cusEffect2 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, (self.config).effectId_light2, self, nil, nil, nil, true)
  else
    do
      local collisionTrigger = BindCallback(self, self.OnCollision)
      local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, (self.config).radius, 15, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, true, true, self.Over)
      local cusEffect1 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, (self.config).effectId_light1, self, nil, nil, nil, true)
      local cusEffect2 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, (self.config).effectId_light2, self, nil, nil, nil, true)
    end
  end
end

bs_100602.OnCollision = function(self, collider, index, entity)
  -- function num : 0_4 , upvalues : _ENV
  if entity.intensity == 0 and entity.career == 1 then
    return 
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:PlayAuHit(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, false)
  skillResult:EndResult()
end

bs_100602.OnEmissionArrive = function(self, skillEmission)
  -- function num : 0_5 , upvalues : _ENV
  if self.audio1 ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.audio1)
  end
  self.audio2 = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallRestartEmit(self, skillEmission, (self.config).spd, self.caster, true, true, self.Over2)
end

bs_100602.Onover = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.audio1 ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.audio1)
  end
end

bs_100602.Onover2 = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.audio2 ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.audio2)
  end
end

bs_100602.BeforeEndBattle = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.audio1 ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.audio1)
    self.audio1 = nil
  end
  if self.audio2 ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.audio2)
    self.audio2 = nil
  end
end

bs_100602.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_100602.LuaDispose = function(self)
  -- function num : 0_10 , upvalues : base
  (base.LuaDispose)(self)
  self.audio2 = nil
  self.audio1 = nil
end

return bs_100602

