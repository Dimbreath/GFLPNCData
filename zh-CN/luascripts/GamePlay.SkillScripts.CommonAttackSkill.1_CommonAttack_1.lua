-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = class("bs_1", LuaSkillBase)
local base = LuaSkillBase
bs_1.config = {rangeOffset = 0, effectId = 52, effectStartId = nil, effectStartId3 = nil, effectstartId1 = nil, effectstartId2 = nil, effectstartId4 = nil, effectstartId5 = nil, effectId1 = nil, effectId2 = nil, effectId3 = nil, targetSelect = 1001, action1 = 1001, action2 = 1004, audioId1 = nil, time1 = 0, audioId2 = nil, time2 = 0, audioId3 = nil, audioId4 = nil, audioId5 = nil, baseActionSpd = 1}
bs_1.ctor = function(self)
  -- function num : 0_0
end

bs_1.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
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
  -- function num : 0_2 , upvalues : _ENV
  self.displaySelectEfc = false
  self.lastAttackRole = ((self.caster).recordTable).lastAttackRole
  local data = nil
  if passdata ~= nil then
    data = setmetatable(passdata, {__index = self.config})
  else
    data = self.config
  end
  local bewitch = (self.caster):ContainBuffFeature(eBuffFeatureType.Bewitch)
  if bewitch ~= self.lastBewitch then
    self.lastAttackRole = nil
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.caster).recordTable).lastAttackRole = nil
    self.lastBewitch = bewitch
  else
    if self.lastAttackRole ~= nil and (self.lastAttackRole).belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, self.lastAttackRole, data.rangeOffset + (self.caster).attackRange) and LuaSkillCtrl:IsWorthAttacking(self.lastAttackRole) then
      (self.caster):LookAtTarget(self.lastAttackRole)
      if LuaSkillCtrl:IsAbleAttackCheckExcludedDir(self.caster, self.lastAttackRole, 30) then
        self.rotateWaited = true
        LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, self.RealPlaySkill, self.lastAttackRole, data))
      else
        self.rotateWaited = false
        self:RealPlaySkill(self.lastAttackRole, data)
      end
      return 
    end
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, data.targetSelect, data.rangeOffset)
  if targetList.Count ~= 0 then
    if self.lastAttackRole ~= (targetList[0]).targetRole then
      self.displaySelectEfc = true
    end
    self.lastAttackRole = (targetList[0]).targetRole
    -- DECOMPILER ERROR at PC109: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.caster).recordTable).lastAttackRole = self.lastAttackRole
    ;
    (self.caster):LookAtTarget(self.lastAttackRole)
    if LuaSkillCtrl:IsAbleAttackCheckExcludedDir(self.caster, self.lastAttackRole, 30) then
      self.rotateWaited = true
      LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, function(atkRole, data)
    -- function num : 0_2_0 , upvalues : _ENV, self
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, atkRole, data.rangeOffset + (self.caster).attackRange) then
      self:RealPlaySkill(atkRole, data)
    end
  end
, self.lastAttackRole, data))
    else
      self.rotateWaited = false
      if LuaSkillCtrl:IsAbleAttackTarget(self.caster, self.lastAttackRole, data.rangeOffset + (self.caster).attackRange) then
        self:RealPlaySkill(self.lastAttackRole, data)
      end
    end
    return 
  else
    self.lastAttackRole = nil
    -- DECOMPILER ERROR at PC156: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.caster).recordTable).lastAttackRole = nil
  end
end

bs_1.CallSelectEffect = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if ((self.caster).recordTable).completeFirstComatk and self.displaySelectEfc and self.lastAttackRole ~= nil then
    LuaSkillCtrl:CallSelectTargetEffect(self, self.lastAttackRole)
    self.displaySelectEfc = false
  end
end

bs_1.RealPlaySkill = function(self, target, data)
  -- function num : 0_4 , upvalues : _ENV
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
    -- function num : 0_4_0 , upvalues : self, data
    ((self.caster).auSource):PlayAudioById(data.audioId2)
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
    -- function num : 0_4_1 , upvalues : self, data
    ((self.caster).auSource):PlayAudioById(data.audioId1)
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
    -- function num : 0_4_2 , upvalues : self, data
    ((self.caster).auSource):PlayAudioById(data.audioId1)
  end
)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1) * (self.config).baseActionSpd
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed)
      atkActionId = data.action1
      self.attackNum = self.attackNum + 1
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId)
      local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
      if waitTime > 0 then
        self:CallCasterWait(waitTime)
      end
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
      -- DECOMPILER ERROR at PC147: Confused about usage of register: R9 in 'UnsetPending'

      if (self.caster).attackRange == 1 then
        if data.effectId1 ~= nil then
          if atkActionId == data.action1 then
            ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId1, self, nil, nil, atkSpeedRatio)
          else
            -- DECOMPILER ERROR at PC159: Confused about usage of register: R9 in 'UnsetPending'

            ;
            ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId2, self, nil, nil, atkSpeedRatio)
          end
        end
        if data.effectId3 ~= nil then
          LuaSkillCtrl:StartTimer(self, atkTriggerFrame, function()
    -- function num : 0_4_3 , upvalues : _ENV, target, data, self, atkSpeedRatio
    LuaSkillCtrl:CallEffect(target, data.effectId3, self, nil, nil, atkSpeedRatio)
  end
)
        end
      end
      if data.effectstartId1 ~= nil then
        if atkActionId == data.action1 then
          LuaSkillCtrl:CallEffect(target, data.effectstartId1, self, nil, nil, atkSpeedRatio)
        else
          LuaSkillCtrl:CallEffect(target, data.effectstartId2, self, nil, nil, atkSpeedRatio)
        end
      end
    end
  end
end

bs_1.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_5 , upvalues : _ENV
  if (self.caster).attackRange == 1 then
    if data.audioId3 ~= nil then
      ((self.caster).auSource):PlayAudioById(data.audioId3)
    end
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(skillResult, generalHurtConfig)
      skillResult:EndResult()
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

      if ((self.caster).recordTable).completeFirstComatk == nil then
        ((self.caster).recordTable).completeFirstComatk = true
      end
    else
      do
        self:BreakSkill()
        if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
          if data.effectStartId ~= nil then
            if atkActionId == data.action1 then
              LuaSkillCtrl:CallEffect(self.caster, data.effectStartId, self)
            else
              LuaSkillCtrl:CallEffect(self.caster, data.effectStartId3, self)
            end
          end
          if data.effectstartId4 ~= nil then
            if atkActionId == data.action1 then
              LuaSkillCtrl:CallEffect(target, data.effectstartId4, self, nil, nil, atkSpeedRatio)
            else
              LuaSkillCtrl:CallEffect(target, data.effectstartId5, self, nil, nil, atkSpeedRatio)
            end
          end
          if data.effectId ~= nil then
            if data.audioId4 ~= nil then
              ((self.caster).auSource):PlayAudioById(data.audioId4)
            end
            LuaSkillCtrl:CallEffectWithArg(target, data.effectId, self, true, self.SkillEventFunc, data)
          end
          -- DECOMPILER ERROR at PC123: Confused about usage of register: R5 in 'UnsetPending'

          if ((self.caster).recordTable).completeFirstComatk == nil then
            ((self.caster).recordTable).completeFirstComatk = true
          end
        else
          self:BreakSkill()
        end
        self:CancleCasterWait()
      end
    end
  end
end

bs_1.SkillEventFunc = function(self, configData, effect, eventId, target)
  -- function num : 0_6 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      ((self.caster).auSource):PlayAudioById(configData.audioId5)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, generalHurtConfig)
    skillResult:EndResult()
  end
end

bs_1.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1

