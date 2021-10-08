local bs_203207 = class("bs_203207", LuaSkillBase)
local base = LuaSkillBase
bs_203207.config = {buffId_196 = 196, buffId_170 = 170, buffId_66 = 66, buffId_151 = 151, buffId_259 = 259, effectIdline = 10920, effectIdmiao = 10448, effectId = 10449, effectIdtrail = 10450, antion1 = 1008, antion2 = 1007, antion3 = 1009, 
hurt_config = {hit_formula = 0, basehurt_formula = 10032, crit_formula = 0}
, start_time = 15, end_time = 18, audioId1 = 318, buffID_1158 = 1158, buffId_yun = 66}
bs_203207.ctor = function(self)
  -- function num : 0_0
end

bs_203207.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_203207.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local target = nil
  local lastAttackRole = ((self.caster).recordTable).lastAttackRole
  if lastAttackRole ~= nil and lastAttackRole.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, lastAttackRole, 1) then
    target = lastAttackRole
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget ~= nil then
      target = tempTarget.targetRole
    end
  end
  do
    self.role = target
    if self.role ~= nil then
      self:CallCasterWait((self.config).start_time + (self.arglist)[1] + (self.config).end_time)
      self:AbandonSkillCdAutoReset(true)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffID_1158, 1, (self.config).start_time + (self.arglist)[1] + (self.config).end_time, true)
      ;
      (self.caster):LookAtTarget(self.role)
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.role)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).antion1, 1, (self.config).start_time, attackTrigger)
      local time_196 = (self.arglist)[1] + (self.config).start_time - 1
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_196, 1, time_196)
      self.loop = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil, nil, nil, true)
    end
  end
end

bs_203207.OnAttackTrigger = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  self.loopline = LuaSkillCtrl:CallEffect(role, (self.config).effectIdline, self, nil, nil, nil, true)
  self.loopMZ = LuaSkillCtrl:CallEffect(role, (self.config).effectIdmiao, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion2)
  local boom = BindCallback(self, self.Onboom, role)
  LuaSkillCtrl:StartTimer(self, (self.arglist)[1], boom, self)
end

bs_203207.Onboom = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  if role.hp > 0 and LuaSkillCtrl:RoleContainsBuffFeature(role, eBuffFeatureType.NotBeSelected) ~= true and LuaSkillCtrl:RoleContainsBuffFeature(role, eBuffFeatureType.NotBeSelectedExceptSameBlong) ~= true then
    LuaSkillCtrl:CallEffect(role, (self.config).effectIdtrail, self, self.SkillEventFunc)
  end
  if self.loopMZ ~= nil then
    (self.loopMZ):Die()
    self.loopMZ = nil
  end
  if self.loopline ~= nil then
    (self.loopline):Die()
    self.loopline = nil
  end
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion3)
  LuaSkillCtrl:StartTimer(self, (self.config).end_time, function()
    -- function num : 0_4_0 , upvalues : self
    if self.loop ~= nil then
      (self.loop):Die()
      self.loop = nil
    end
  end
)
  self:CancleCasterWait()
  self:CallNextBossSkill()
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self.role = nil
end

bs_203207.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    if target ~= nil and LuaSkillCtrl:IsAbleAttackTarget(self.caster, target.targetRole, 10) then
      LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId_259, 1, 6)
      LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId_yun, 1, (self.arglist)[3])
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 1, true)
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_170, 0, true)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
      skillResult:EndResult()
    else
      do
        self:CancleCasterWait()
        self:CallNextBossSkill()
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 1, true)
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_170, 0, true)
      end
    end
  end
end

bs_203207.OnBreakSkill = function(self, role)
  -- function num : 0_6 , upvalues : _ENV, base
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 1, true)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_170, 1, true)
    self:CancleCasterWait()
    self:CallNextBossSkill()
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
  end
  ;
  (base.OnBreakSkill)(self, role)
end

bs_203207.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_203207.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  self.role = nil
  if self.loop ~= nil then
    (self.loop):Die()
    self.loop = nil
  end
  if self.loopline ~= nil then
    (self.loopline):Die()
    self.loopline = nil
  end
  if self.loopMZ ~= nil then
    (self.loopMZ):Die()
    self.loopMZ = nil
  end
end

return bs_203207

