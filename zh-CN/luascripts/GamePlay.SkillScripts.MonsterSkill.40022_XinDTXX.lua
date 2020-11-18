-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40022 = class("bs_40022", LuaSkillBase)
local base = LuaSkillBase
bs_40022.config = {
hurt_config = {basehurt_formula = 10011}
, effectId = 10103, damageEffectId = 10104, healEffectId = 10022, startAnimID = 1004, skillCount = 1, totalDamage = 0, audioId1 = 20}
bs_40022.ctor = function(self)
  -- function num : 0_0
end

bs_40022.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_40022_1", 1, self.OnBeforePlaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_40022_2", 1, self.OnAfterHurt)
end

bs_40022.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.skill).maker == self.caster and (context.skill).dataId == 504 and LuaSkillCtrl:CallRange(1, 1000) < (self.arglist)[2] then
    context.active = false
    local targetRole = ((self.caster).recordTable).lastAttackRole
    do
      if targetRole == nil then
        local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
        if targetlist.Count > 0 then
          targetRole = (targetlist[0]).targetRole
        else
          return 
        end
      end
      if LuaSkillCtrl:IsAbleAttackTarget(self.caster, targetRole, 1) then
        (self.caster):LookAtTarget(targetRole)
        local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetRole, data)
        self:CallCasterWait(25)
        LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId, self)
        LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimID, 1, 10, attackTrigger)
        ;
        ((self.caster).auSource):PlayAudioById((self.config).audioId1)
      end
    end
  end
end

bs_40022.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.config).skillCount = 1
  local targets = (self:GetBehindTargetsPos(2, (self.caster).x, (self.caster).y, target.x, target.y))
  local targetNext = nil
  if targets ~= nil and (table.length)(targets) >= 2 and (targets[2]).belongNum ~= (self.caster).belongNum then
    targetNext = targets[2]
    LuaSkillCtrl:CallEffect(targetNext, (self.config).damageEffectId, self)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.config).skillCount = 2
  end
  LuaSkillCtrl:CallEffect(target, (self.config).damageEffectId, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
  skillResult:EndResult()
  local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetNext)
  LuaSkillCtrl:HurtResult(skillResult1, (self.config).hurt_config)
  skillResult1:EndResult()
  self.damTimer = LuaSkillCtrl:StartTimer(self, 3, self.CallBack, self, 0, 3)
end

bs_40022.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R8 in 'UnsetPending'

  if sender == self.caster and skill.dataId == 40022 and (self.config).skillCount ~= 0 then
    (self.config).totalDamage = (self.config).totalDamage + hurt
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.config).skillCount = (self.config).skillCount - 1
  end
end

bs_40022.CallBack = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (self.config).totalDamage ~= 0 then
    LuaSkillCtrl:CallHeal((self.config).totalDamage, self, self.caster)
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.config).totalDamage = 0
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.config).skillCount = 0
end

bs_40022.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40022

