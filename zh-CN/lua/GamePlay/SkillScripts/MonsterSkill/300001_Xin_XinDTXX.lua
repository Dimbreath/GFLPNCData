local bs_300001 = class("bs_300001", LuaSkillBase)
local base = LuaSkillBase
bs_300001.config = {
hurt_config = {basehurt_formula = 10011}
, effectId = 10103, damageEffectId = 10104, startAnimID = 1004, skillCount = 1, totalDamage = 0, audioId1 = 20, skillId = 300001, commonAttackId = 505, select_id = 1001, select_range = 0, skill_time = 25, start_time = 10, skill_speed = 1, healCallBackDelay = 3}
bs_300001.ctor = function(self)
  -- function num : 0_0
end

bs_300001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_300001_1", 1, self.OnBeforePlaySkill)
  self:AddAfterHurtTrigger("bs_300001_2", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, 300001)
end

bs_300001.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R9 in 'UnsetPending'

  if sender == self.caster and skill.dataId == (self.config).skillId and (self.config).skillCount ~= 0 then
    (self.config).totalDamage = (self.config).totalDamage + hurt
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.config).skillCount = (self.config).skillCount - 1
  end
end

bs_300001.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_3 , upvalues : _ENV
  if (context.skill).maker == self.caster and (context.skill).dataId == (self.config).commonAttackId and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[2] then
    context.active = false
    local targetRole = ((self.caster).recordTable).lastAttackRole
    do
      if targetRole == nil then
        local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range)
        if targetlist.Count > 0 then
          targetRole = (targetlist[0]).targetRole
        else
          return 
        end
      end
      if LuaSkillCtrl:IsAbleAttackTarget(self.caster, targetRole, 1) then
        (self.caster):LookAtTarget(targetRole)
        local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetRole)
        self:CallCasterWait((self.config).skill_time)
        LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId, self, nil, nil, nil, true)
        LuaSkillCtrl:CallRoleAction(self.caster, (self.config).startAnimID, (self.config).skill_speed)
        LuaSkillCtrl:StartTimer(self, (self.config).start_time, attackTrigger)
        LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
      end
    end
  end
end

bs_300001.OnAttackTrigger = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.config).skillCount = 1
  local targets = (self:GetBehindTargetsPos(2, (self.caster).x, (self.caster).y, target.x, target.y))
  -- DECOMPILER ERROR at PC11: Overwrote pending register: R3 in 'AssignReg'

  local targetNext = .end
  if targets ~= nil and (table.length)(targets) >= 2 and (targets[2]).belongNum ~= (self.caster).belongNum then
    targetNext = targets[2]
    LuaSkillCtrl:CallEffect(targetNext, (self.config).damageEffectId, self)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.config).skillCount = 2
  end
  LuaSkillCtrl:CallEffect(target, (self.config).damageEffectId, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
  skillResult:EndResult()
  local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetNext)
  LuaSkillCtrl:HurtResult(self, skillResult1, (self.config).hurt_config)
  skillResult1:EndResult()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, (self.config).healCallBackDelay, self.CallBack, self, 0, (self.config).healCallBackDelay)
end

bs_300001.CallBack = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.damTimer ~= nil and (self.damTimer):IsOver() then
    self.damTimer = nil
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  if (self.config).totalDamage ~= 0 then
    (self.config).totalDamage = (self.config).totalDamage * (self.arglist)[3] // 1000
    LuaSkillCtrl:CallHeal((self.config).totalDamage, self, self.caster)
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.config).totalDamage = 0
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.config).skillCount = 0
end

bs_300001.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_300001

