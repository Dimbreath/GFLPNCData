-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100502 = class("bs_100502", LuaSkillBase)
local base = LuaSkillBase
bs_100502.config = {buffId_114 = 114, buffId_67 = 67, effectId_CF = 123, effectId_start = 10067, effectId_end = 10068, effectId_Hit1 = 10071, effectId_Hit2 = 10072, effectId_Hit3 = 10073, effectId_Hit4 = 10074, effectId_Hit5 = 10075, effectId_Hit6 = 10076, effectId_Hit7 = 10077, effectId_Hit8 = 10078, effectId_Hit9 = 10079, effectId_Hit10 = 10080, audioId_start = 33, audioId_loop = 34, audioId_hit = 35, shieldFormula = 10087, shield_ex_Formula = 10116, buffId196 = 196, actionId_start = 1002, actionId_loop = 1007, action_speed = 1, start_time = 9, buffId_170 = 170}
bs_100502.ctor = function(self)
  -- function num : 0_0
end

bs_100502.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_100502_2", 30, self.OnSetHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_100502_3", 1, self.BeforeEndBattle)
  self:AddSelfTrigger(eSkillTriggerType.OnBreakShield, "bs_100502_22", 1, self.OnBreakShield)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).skill = false
  self.time = 1
end

bs_100502.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local arg4 = (self.arglist)[4]
  local bufftime = 15 + arg4
  if self.time == 1 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId196, 1, bufftime, true)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_170, 1, nil, true)
    local skilltime = 15 + arg4 + 10
    self:CallCasterWait(skilltime)
  else
    do
      self:CallCasterWait(15)
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId_start, (self.config).action_speed, (self.config).start_time, attackTrigger)
      self.hudunEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_start, self, nil, nil, nil, true)
    end
  end
end

bs_100502.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  if self.time == 1 then
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_start)
    LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    if ((self.caster).recordTable).skill == true then
      self.loop = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_loop)
    end
  end
)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_CF, self, nil, nil, nil, true)
    local bufftime = (self.arglist)[4]
    LuaSkillCtrl:StartShowSkillDurationTime(self, bufftime)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_114, 1, bufftime, true)
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_loop)
    if self.time == 1 then
      local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).shieldFormula, self.caster, nil, self)
      if shieldValue > 0 then
        LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
        LuaSkillCtrl:CallFloatText(self.caster, 11, shieldValue)
      end
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
      if targetList.Count > 0 then
        for i = 0, targetList.Count - 1 do
          if ((targetList[i]).targetRole).intensity ~= 0 then
            LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId_67, 1, bufftime)
          end
        end
      end
      do
        do
          -- DECOMPILER ERROR at PC105: Confused about usage of register: R5 in 'UnsetPending'

          ;
          ((self.caster).recordTable).skill = true
          self.time = 2
          LuaSkillCtrl:StartTimer(nil, bufftime, BindCallback(self, self.Onover), self)
          local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).shield_ex_Formula, self.caster, nil, self)
          if shieldValue > 0 then
            LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
            LuaSkillCtrl:CallFloatText(self.caster, 11, shieldValue)
          end
          -- DECOMPILER ERROR at PC143: Confused about usage of register: R3 in 'UnsetPending'

          ;
          ((self.caster).recordTable).skill = true
          self:Onover()
        end
      end
    end
  end
end

bs_100502.Onover = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((self.caster).recordTable).skill == true then
    if self.loop ~= nil then
      LuaSkillCtrl:StopAudioByBack(self.loop)
      self.loop = nil
    end
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_end, self)
    if self.hudunEffect ~= nil then
      (self.hudunEffect):Die()
      self.hudunEffect = nil
    end
    if (self.arglist)[3] > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_170, 0, true)
    end
    LuaSkillCtrl:CallRoleAction(self.caster, 100)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_114, 0, true)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId196, 0, true)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:DispelBuff((targetList[i]).targetRole, (self.config).buffId_67, 1)
    end
    -- DECOMPILER ERROR at PC82: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable).skill = false
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
  end
end

bs_100502.OnSetHurt = function(self, context)
  -- function num : 0_5 , upvalues : _ENV
  if context.target == self.caster and ((self.caster).recordTable).skill == true then
    local roll = LuaSkillCtrl:CallRange(1, 10)
    local roleeffect = (self.config)["effectId_Hit" .. tostring(roll)]
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_hit)
    LuaSkillCtrl:CallEffect(self.caster, roleeffect, self)
  end
end

bs_100502.OnBreakShield = function(self, shieldType, sender, target)
  -- function num : 0_6
  if shieldType == 0 and target == self.caster and ((self.caster).recordTable).skill == true then
    self:Onover()
  end
end

bs_100502.BeforeEndBattle = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.loop ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loop)
    self.loop = nil
  end
end

bs_100502.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_100502.LuaDispose = function(self)
  -- function num : 0_9 , upvalues : base
  (base.LuaDispose)(self)
  self.hudunEffect = nil
  self.loop = nil
end

return bs_100502

