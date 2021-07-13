-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1045 = class("bs_1045", LuaSkillBase)
local base = LuaSkillBase
bs_1045.config = {buffId_254 = 254, buffId_170 = 170, buffDuration = 120, superBuffId = 271, effectId = 10188, effectId2 = 10190, 
aoe_config = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0, crithur_ratio = 0}
, audioId1 = 107, audioId2 = 108, audioId3 = 109, selectCode = 57}
bs_1045.ctor = function(self)
  -- function num : 0_0
end

bs_1045.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_1045.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local realTargetRole = self:CheckAndGetTargetRole()
  if realTargetRole == nil then
    return 
  end
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, realTargetRole, data)
  ;
  (self.caster):LookAtTarget(realTargetRole)
  self:CallCasterWait(15)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1.5, 7, attackTrigger)
end

bs_1045.CheckAndGetTargetRole = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local lastAtkRole = ((self.caster).recordTable).lastAttackRole
  if lastAtkRole ~= nil and LuaSkillCtrl:IsAbleAttackTarget(self.caster, lastAtkRole, (self.cskill).SkillRange) and lastAtkRole:GetBuffTier((self.config).buffId_254) <= 0 and lastAtkRole.belongNum ~= eBattleRoleBelong.neutral then
    return lastAtkRole
  end
  local realTargetRole = nil
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget ~= nil then
    realTargetRole = moveTarget.targetRole
  end
  do
    if realTargetRole == nil or realTargetRole:GetBuffTier((self.config).buffId_254) > 0 or realTargetRole:ContainFeature(eBuffFeatureType.AbadonDebuff) then
      local roles = LuaSkillCtrl:CallTargetSelectWithRange(self, (self.config).selectCode, (self.cskill).SkillRange)
      if (roles == nil or roles.Count <= 0) and realTargetRole == nil then
        (self.cskill):ResetCDTimeRatio((ConfigData.game_config).skillBreakCd)
        return 
      end
      realTargetRole = self:AnalysisSelectRoles(realTargetRole, roles)
    end
    return realTargetRole
  end
end

bs_1045.AnalysisSelectRoles = function(self, realTargetRole, roles)
  -- function num : 0_4 , upvalues : _ENV
  local result = realTargetRole
  if roles == nil or roles.Count <= 0 then
    return result
  end
  for i = 0, roles.Count - 1 do
    local targetRole = (roles[i]).targetRole
    if targetRole.belongNum ~= eBattleRoleBelong.neutral and targetRole:GetBuffTier((self.config).buffId_254) <= 0 and not targetRole:ContainFeature(eBuffFeatureType.AbadonDebuff) then
      result = targetRole
      break
    end
  end
  do
    return result
  end
end

bs_1045.OnAttackTrigger = function(self, target, data)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillEventFunc)
  LuaSkillCtrl:StartTimer(nil, 5, BindCallback(self, self.PhaseMove))
end

bs_1045.PhaseMove = function(self)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, 1007)
  ;
  (LuaSkillCtrl:CallTargetSelect(self, (self.config).selectCode, 10))
  local selectRoles = nil
  local grid = nil
  if selectRoles ~= nil and selectRoles.Count > 0 then
    local targetRole = (selectRoles[0]).targetRole
    LuaSkillCtrl:CallSelectTargetEffect(self, targetRole)
    local grids = LuaSkillCtrl:FindEmptyGridsWithinRange(targetRole.x, targetRole.y, (self.caster).attackRange, true)
    if grids ~= nil and grids.Count > 0 then
      grid = grids[0]
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.caster).recordTable).lastAttackRole = targetRole
    end
  end
  do
    if grid == nil then
      grid = LuaSkillCtrl:FindEmptyGridWithinRange(self.caster, 2)
    end
    if grid ~= nil then
      LuaSkillCtrl:CallPhaseMove(self, self.caster, grid.x, grid.y, 6, 69)
      LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId3)
    end
    LuaSkillCtrl:StartTimer(nil, 6, function()
    -- function num : 0_6_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallRoleAction(self.caster, 1009)
    if (self.arglist)[3] > 0 then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).superBuffId, 1, (self.arglist)[4])
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_170, 1, (self.arglist)[4], true)
      LuaSkillCtrl:StartShowSkillDurationTime(self, (self.arglist)[4])
    end
  end
)
  end
end

bs_1045.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_7 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
    local effect = LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self)
    local collisionEnter = BindCallback(self, self.OnCollisionEnter)
    local collisionExit = BindCallback(self, self.OnCollisionExit)
    LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Enemy, nil, collisionEnter, collisionExit)
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], BindCallback(self, function(table, effect)
    -- function num : 0_7_0
    if effect ~= nil then
      effect:Die()
      effect = nil
    end
  end
, effect))
  end
end

bs_1045.OnCollisionEnter = function(self, collider, index, entity)
  -- function num : 0_8 , upvalues : _ENV
  if entity ~= nil and entity.hp > 0 and entity.belongNum ~= (self.caster).belongNum and not entity.unableSelect and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId_254, 1)
  end
end

bs_1045.OnCollisionExit = function(self, collider, entity)
  -- function num : 0_9 , upvalues : _ENV
  if entity ~= nil and entity.hp > 0 and entity:GetBuffTier((self.config).buffId_254) >= 1 and entity.belongNum ~= (self.caster).belongNum and not entity.unableSelect and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:DispelBuff(entity, (self.config).buffId_254, 1)
  end
end

bs_1045.OnCasterDie = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1045

