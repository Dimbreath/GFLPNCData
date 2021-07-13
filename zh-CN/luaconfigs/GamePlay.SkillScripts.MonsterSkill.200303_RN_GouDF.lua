-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_200303 = class("bs_200303", LuaSkillBase)
local base = LuaSkillBase
bs_200303.config = {
hurt_config = {basehurt_formula = 10076, hit_formula = 0, crit_formula = 0, correct_formula = 9989, spell_lifesteal_formula = 10102}
, buffId_1017 = 1017, buffTier = 1, startAnimID = 1002, effectId = 10095, hurtEffectId = 10096, audioId1 = 49, audioId2 = 50, passive_select_id = 9, passive_select_range = 0, skill_time = 28, skill_speed = 1, start_time = 16, emissionRadius = 40, emissionSpeed = 4}
bs_200303.ctor = function(self)
  -- function num : 0_0
end

bs_200303.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_200303.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local moveTarget = self:GetMoveSelectTarget()
  do
    if moveTarget ~= nil then
      local curAtkRole = moveTarget.targetRole
      if curAtkRole ~= nil then
        if self.lastAttackRole ~= curAtkRole then
          self.displaySelectEfc = true
        end
        self.lastAttackRole = curAtkRole
      end
    end
    if ((self.caster).recordTable).life_num ~= nil then
      local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).passive_select_id, (self.config).passive_select_range)
      if targetlist.Count > 0 then
        self.life_num = ((self.caster).recordTable).life_num * targetlist.Count
      end
    else
      do
        self.life_num = 0
        if moveTarget ~= nil then
          self:CallCasterWait((self.config).skill_time)
          local role = moveTarget.targetRole
          ;
          (self.caster):LookAtTarget(role)
          self:DamageAnimation(role)
        end
      end
    end
  end
end

bs_200303.DamageAnimation = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, target, data, grid)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimID, (self.config).skill_speed, (self.config).start_time, moveAttackTrigger)
end

bs_200303.OnMoveAttackTrigger = function(self, target, data)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  local cusEffect = LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
  local collisionTrigger = BindCallback(self, self.OnCollision)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, (self.config).emissionRadius, (self.config).emissionSpeed, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, false, true)
end

bs_200303.OnCollision = function(self, collider, index, entity)
  -- function num : 0_5 , upvalues : _ENV
  if entity ~= self.caster then
    LuaSkillCtrl:CallEffect(entity, (self.config).hurtEffectId, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    LuaSkillCtrl:PlayAuHit(self, entity)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {self.life_num})
    skillResult:BuffResult((self.config).buffId_1017, (self.config).buffTier, (self.arglist)[2])
    skillResult:EndResult()
  end
end

bs_200303.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_200303

