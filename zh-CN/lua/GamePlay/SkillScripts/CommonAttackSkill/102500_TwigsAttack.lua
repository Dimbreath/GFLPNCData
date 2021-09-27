local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_102500 = class("bs_102500", bs_1)
local base = bs_1
bs_102500.config = {effectId_trail = 102503, effectId_P = 102506, effectId_hit2 = 102505, effectId_new = 102507, 
HurtConfig = {hit_formula = 0, basehurt_formula = 3000, crit_formula = 0, crithur_ratio = 0}
, ex_hurttime = 3, buffId_170 = 170, buffId_tip = 102503, audioId1 = 248, audioId2 = 249, audioId5 = 250, audioId_three = 251, audioId_three_hit = 253}
bs_102500.config = setmetatable(bs_102500.config, {__index = base.config})
bs_102500.ctor = function(self)
  -- function num : 0_0
end

bs_102500.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.three = false
end

bs_102500.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster):GetBuffTier((self.config).buffId_170) > 0 then
    self.three = true
  else
    self.three = false
  end
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action1
  local atkTriggerFrame = 0
  if self.attackNum > 1 then
    local prob = LuaSkillCtrl:CallRange(1, 2)
    if prob == 1 then
      if data.audioId2 ~= nil and self.three == false then
        LuaSkillCtrl:StartTimer(self, data.time2, function()
    -- function num : 0_2_0 , upvalues : _ENV, self, data
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId2)
  end
)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 2) * (self.config).baseActionSpd
      atkActionId = data.action2
      atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
      self.attackNum = 0
    else
      if data.audioId1 ~= nil and self.three == false then
        LuaSkillCtrl:StartTimer(self, data.time1, function()
    -- function num : 0_2_1 , upvalues : _ENV, self, data
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
  end
)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
      atkActionId = data.action1
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed) * (self.config).baseActionSpd
      self.attackNum = self.attackNum + 1
    end
  else
    do
      if data.audioId1 ~= nil and self.three == false then
        LuaSkillCtrl:StartTimer(self, data.time1, function()
    -- function num : 0_2_2 , upvalues : _ENV, self, data
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
  end
)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1) * (self.config).baseActionSpd
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed)
      atkActionId = data.action1
      self.attackNum = self.attackNum + 1
      -- DECOMPILER ERROR at PC117: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.caster).recordTable).lastAttackRole = target
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
      local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
      if waitTime > 0 then
        self:CallCasterWait(waitTime + 2)
      end
      if self.three == true then
        LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
        -- DECOMPILER ERROR at PC174: Confused about usage of register: R9 in 'UnsetPending'

        if (self.caster).attackRange == 1 then
          if data.effectId_1 ~= nil then
            if atkActionId == data.action1 then
              ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_1, self, nil, nil, atkSpeedRatio, true)
            else
              -- DECOMPILER ERROR at PC187: Confused about usage of register: R9 in 'UnsetPending'

              ;
              ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_2, self, nil, nil, atkSpeedRatio, true)
            end
          end
          if data.effectId_3 ~= nil then
            LuaSkillCtrl:StartTimer(self, atkTriggerFrame, function()
    -- function num : 0_2_3 , upvalues : _ENV, target, data, self, atkSpeedRatio
    LuaSkillCtrl:CallEffect(target, data.effectId_3, self, nil, nil, atkSpeedRatio)
  end
)
          end
        end
        if data.effectId_start1 ~= nil then
          if atkActionId == data.action1 then
            LuaSkillCtrl:CallEffect(target, data.effectId_start1, self, nil, nil, atkSpeedRatio, true)
          else
            LuaSkillCtrl:CallEffect(target, data.effectId_start2, self, nil, nil, atkSpeedRatio, true)
          end
        end
      end
    end
  end
end

bs_102500.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  -- function num : 0_3 , upvalues : _ENV, base
  if self.three == true then
    local extraTarget = self:CheckAndGetExtraEffectTarget(target)
    self:CallColliderEmission(target)
    if extraTarget ~= nil then
      self:CallColliderEmission(extraTarget)
    end
    if self.isDoubleAttack then
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
      self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
    else
      do
        do
          self:CancleCasterWait()
          ;
          (base.OnAttackTrigger)(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
        end
      end
    end
  end
end

bs_102500.CallColliderEmission = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_three)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_P, self)
  local collisionTrigger = BindCallback(self, self.OnCollision, target)
  self.emissionCount = 3
  LuaSkillCtrl:CallCircledEmissionStraightlyWithThreeExtraChild(self, self.caster, target, 15, 5, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, 16, true, true, (BindCallback(self, self.OnEmissionArive)), nil)
  self.cusEffect = LuaSkillCtrl:CallEffect(target, (self.config).effectId_new, self, nil, nil, 0.5)
end

bs_102500.OnEmissionArive = function(self, emission)
  -- function num : 0_5
  if self.emissionCount > 0 then
    self.emissionCount = self.emissionCount - 1
  end
  if self.emissionCount <= 0 and self.cusEffect ~= nil then
    (self.cusEffect):Die()
    self.cusEffect = nil
  end
end

bs_102500.OnCollision = function(self, target, collider, index, entity)
  -- function num : 0_6 , upvalues : _ENV
  if self.caster == nil or (self.caster).hp <= 0 or entity:GetBuffTier((self.config).buffId_tip) > 0 then
    return 
  end
  local arg1 = ((self.caster).recordTable).skill_arg
  LuaSkillCtrl:PlayAuSource(target, (self.config).audioId_three_hit)
  LuaSkillCtrl:CallEffect(entity, (self.config).effectId_hit2, self)
  local _Cskill = ((self.caster).recordTable).cs_Skill
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {arg1})
  skillResult:EndResult()
  LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId_tip, 1, 1)
end

bs_102500.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
  if self.cusEffect ~= nil then
    (self.cusEffect):Die()
    self.cusEffect = nil
  end
end

bs_102500.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  if self.cusEffect ~= nil then
    (self.cusEffect):Die()
    self.cusEffect = nil
  end
end

return bs_102500

