-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40018 = class("bs_40018", LuaSkillBase)
local base = LuaSkillBase
bs_40018.config = {
hurt_config = {basehurt_formula = 10007}
, buffId = 1017, buffTier = 1, startAnimID = 1002, effectId = 10095, hurtEffectId = 10096, audioId1 = 49, audioId2 = 50}
bs_40018.ctor = function(self)
  -- function num : 0_0
end

bs_40018.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_40018.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
  if targetList.Count > 0 then
    self:CallCasterWait(28)
    local role = (targetList[0]).targetRole
    ;
    (self.caster):LookAtTarget(role)
    self:DamageAnimation(role)
  end
end

bs_40018.DamageAnimation = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, target, data, grid)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimID, 1, 16, moveAttackTrigger)
end

bs_40018.OnMoveAttackTrigger = function(self, target, data)
  -- function num : 0_4 , upvalues : _ENV
  local cusEffect = LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
  local collisionTrigger = BindCallback(self, self.OnCollision)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 40, 4, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, false, true)
end

bs_40018.OnCollision = function(self, index, entity)
  -- function num : 0_5 , upvalues : _ENV
  if entity ~= self.caster then
    LuaSkillCtrl:CallEffect(entity, (self.config).hurtEffectId, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:BuffResult((self.config).buffId, (self.config).buffTier, (self.arglist)[2])
    skillResult:EndResult()
  end
end

bs_40018.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40018

