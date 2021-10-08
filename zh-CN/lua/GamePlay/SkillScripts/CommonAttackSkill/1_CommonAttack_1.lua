local bs_1 = class("bs_1", LuaSkillBase)
local base = LuaSkillBase
bs_1.config = {rangeOffset = 0, effectId_trail = nil, effectId_trail_ex = nil, effectId_action_1 = nil, effectId_action_2 = nil, effectId_start1 = nil, effectId_start2 = nil, effectId_start3 = nil, effectId_start4 = nil, effectId_hit_target = nil, effectId_1 = nil, effectId_2 = nil, effectId_3 = nil, targetSelect = 1001, action1 = 1001, action2 = 1004, audioId1 = nil, time1 = 0, audioId2 = nil, time2 = 0, audioId3 = nil, audioId4 = nil, audioId5 = nil, Imp = false, baseActionSpd = 1, atkDirectionRange = 30}
bs_1.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.hurt_config = {}
  self.lastAttackRole = nil
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).lastAttackRole = nil
  self.lastBewitch = false
  self.attackNum = 0
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["1_attack_effect"] = nil
end

bs_1.PlaySkill = function(self, passdata)
  -- function num : 0_1 , upvalues : _ENV
  self:CheckAndRecordIsDoubleAttack(passdata)
  local data = nil
  if passdata ~= nil then
    data = setmetatable(passdata, {__index = self.config})
  else
    data = self.config
  end
  self.displaySelectEfc = false
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
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, self.lastAttackRole, data.rangeOffset + (self.caster).attackRange) and LuaSkillCtrl:IsWorthAttacking(self, self.lastAttackRole) then
      (self.caster):LookAtTarget(self.lastAttackRole)
      if LuaSkillCtrl:IsAbleAttackCheckExcludedDir(self.caster, self.lastAttackRole, (self.config).atkDirectionRange) then
        self.rotateWaited = true
        LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, self.RealPlaySkill, self.lastAttackRole, data))
      else
        self.rotateWaited = false
        self:RealPlaySkill(self.lastAttackRole, data)
      end
    else
      self.lastAttackRole = nil
      -- DECOMPILER ERROR at PC81: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.caster).recordTable).lastAttackRole = nil
      self:ClearDoubleAttackNum()
      self:CancleCasterWait()
    end
  end
end

bs_1.CallSelectEffect = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if ((self.caster).recordTable).completeFirstComatk and self.displaySelectEfc and self.lastAttackRole ~= nil then
    LuaSkillCtrl:CallSelectTargetEffect(self, self.lastAttackRole)
    self.displaySelectEfc = false
  end
end

bs_1.RealPlaySkill = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action1
  local atkTriggerFrame = 0
  if self.attackNum > 1 then
    local prob = LuaSkillCtrl:CallRange(1, 2)
    if prob == 1 then
      if data.audioId2 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time2, function()
    -- function num : 0_3_0 , upvalues : _ENV, self, data
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId2)
  end
)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 2) * (self.config).baseActionSpd
      atkActionId = data.action2
      atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
      self.attackNum = 0
    else
      if data.audioId1 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time1, function()
    -- function num : 0_3_1 , upvalues : _ENV, self, data
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
      if data.audioId1 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time1, function()
    -- function num : 0_3_2 , upvalues : _ENV, self, data
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
  end
)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1) * (self.config).baseActionSpd
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed)
      atkActionId = data.action1
      self.attackNum = self.attackNum + 1
      -- DECOMPILER ERROR at PC102: Confused about usage of register: R7 in 'UnsetPending'

      if not LuaSkillCtrl.IsInTDBattle then
        ((self.caster).recordTable).lastAttackRole = target
      end
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
      local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
      if waitTime > 0 then
        self:CallCasterWait(waitTime + 2)
      end
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
      -- DECOMPILER ERROR at PC156: Confused about usage of register: R9 in 'UnsetPending'

      if (self.caster).attackRange == 1 then
        if data.effectId_1 ~= nil then
          if atkActionId == data.action1 then
            ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_1, self, nil, nil, atkSpeedRatio, true)
          else
            -- DECOMPILER ERROR at PC169: Confused about usage of register: R9 in 'UnsetPending'

            ;
            ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_2, self, nil, nil, atkSpeedRatio, true)
          end
        end
        if data.effectId_3 ~= nil then
          LuaSkillCtrl:StartTimer(self, atkTriggerFrame, function()
    -- function num : 0_3_3 , upvalues : _ENV, target, data, self, atkSpeedRatio
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

bs_1.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  -- function num : 0_4 , upvalues : _ENV
  if (self.caster).attackRange == 1 then
    if data.audioId3 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
    end
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      if data.Imp == true then
        LuaSkillCtrl:PlayAuHit(self, target)
      end
      LuaSkillCtrl:HurtResult(self, skillResult)
      skillResult:EndResult()
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R7 in 'UnsetPending'

      if ((self.caster).recordTable).completeFirstComatk == nil then
        ((self.caster).recordTable).completeFirstComatk = true
      end
    else
      do
        self:BreakSkill()
        if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
          if data.effectId_action_1 ~= nil then
            if atkActionId == data.action1 then
              LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_1, self)
            else
              LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_2, self)
            end
          end
          if data.effectId_start3 ~= nil then
            if atkActionId == data.action1 then
              LuaSkillCtrl:CallEffect(target, data.effectId_start3, self, nil, nil, atkSpeedRatio)
            else
              LuaSkillCtrl:CallEffect(target, data.effectId_start4, self, nil, nil, atkSpeedRatio)
            end
          end
          local extraTarget = self:CheckAndGetExtraEffectTarget(target)
          self:ExecuteEffectAttack(data, atkActionId, target)
          if extraTarget ~= nil then
            self:ExecuteEffectAttack(data, atkActionId, extraTarget)
          end
          -- DECOMPILER ERROR at PC126: Confused about usage of register: R7 in 'UnsetPending'

          if ((self.caster).recordTable).completeFirstComatk == nil then
            ((self.caster).recordTable).completeFirstComatk = true
          end
        else
          do
            self:BreakSkill()
            if self.isDoubleAttack then
              local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
              self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
            else
              do
                self:CancleCasterWait()
              end
            end
          end
        end
      end
    end
  end
end

bs_1.ExecuteEffectAttack = function(self, data, atkActionId, target)
  -- function num : 0_5 , upvalues : _ENV
  if data.effectId_trail ~= nil then
    if data.audioId4 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
    end
    if data.effectId_trail_ex ~= nil then
      if atkActionId == data.action1 then
        LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail, self, nil, false, self.SkillEventFunc, data)
      else
        LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail_ex, self, nil, false, self.SkillEventFunc, data)
      end
    else
      LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail, self, nil, false, self.SkillEventFunc, data)
    end
  else
    if data.effectId_hit_target ~= nil then
      LuaSkillCtrl:CallEffectWithArg(target, data.effectId_hit_target, self, nil, false, self.SkillEventFunc, data)
    end
  end
end

bs_1.CheckAndGetExtraEffectTarget = function(self, targetRole, skillSelectId)
  -- function num : 0_6 , upvalues : _ENV
  if not LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.SplitShoot) then
    return nil
  end
  if skillSelectId == nil then
    skillSelectId = 10001
  end
  local targets = LuaSkillCtrl:CallTargetSelect(self, skillSelectId, 2)
  if targets == nil or targets.Count <= 0 then
    return nil
  end
  for i = 0, targets.Count - 1 do
    local role = (targets[i]).targetRole
    if role ~= targetRole then
      return role
    end
  end
end

bs_1.CheckAndExecuteSecondAttack = function(self, data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  -- function num : 0_7
  self.recordDoubleAttackNum = self.recordDoubleAttackNum + 1
  if self.recordDoubleAttackNum <= 1 then
    self:CallDoubleAttackData(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  end
  if self.recordDoubleAttackNum >= 2 then
    self:ClearDoubleAttackNum()
    self:CancleCasterWait()
  end
end

bs_1.CallDoubleAttackData = function(self, data, target, attackFrame, atkSpeedRatio, actionId, attackTrigger)
  -- function num : 0_8 , upvalues : _ENV
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
    LuaSkillCtrl:CallRoleAction(self.caster, actionId, atkSpeedRatio)
    LuaSkillCtrl:StartTimer(self, attackFrame, attackTrigger)
  end
end

bs_1.CheckAndRecordIsDoubleAttack = function(self, passdata)
  -- function num : 0_9 , upvalues : _ENV
  self.isDoubleAttack = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.DoubleAttack)
  self:ClearDoubleAttackNum()
  self.passdata = passdata
end

bs_1.ClearDoubleAttackNum = function(self)
  -- function num : 0_10
  self.recordDoubleAttackNum = 0
end

bs_1.SkillEventFunc = function(self, configData, effect, eventId, target)
  -- function num : 0_11 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, generalHurtConfig)
    skillResult:EndResult()
  end
end

bs_1.OnCasterDie = function(self)
  -- function num : 0_12 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_1.LuaDispose = function(self)
  -- function num : 0_13 , upvalues : base
  self:ClearDoubleAttackNum()
  self.lastAttackRole = nil
  self.passdata = nil
  ;
  (base.LuaDispose)(self)
end

return bs_1

