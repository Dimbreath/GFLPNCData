local bs_100502 = class("bs_100502", LuaSkillBase)
local base = LuaSkillBase
bs_100502.config = {buffId_Taunt = 3002, effectId_CF = 123, effectId_start = 100504, effectId_Hit1 = 100506, effectId_Hit2 = 100507, effectId_Hit3 = 100508, effectId_Hit4 = 100509, effectId_Hit5 = 100510, effectId_Hit6 = 100511, effectId_Hit7 = 100512, effectId_Hit8 = 100513, effectId_Hit9 = 100514, effectId_Hit10 = 100515, shieldFormula = 3021, buffId_Super = 3003, actionId_start = 1002, actionId_loop = 1007, action_speed = 1, skill_time = 15, start_time = 5, buffId_170 = 170}
bs_100502.ctor = function(self)
  -- function num : 0_0
end

bs_100502.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_100502_2", 30, self.OnSetHurt, nil, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.OnBreakShield, "bs_100502_22", 1, self.OnBreakShield)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).peopleNum = 0
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).skill = false
  self.time = 1
end

bs_100502.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local times = (self.arglist)[3]
  if self.time == 1 then
    times = (self.arglist)[2]
  end
  local bufftime = (self.config).skill_time + times + 5
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_Super, 1, bufftime, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_170, 1, nil, true)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.time, times)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId_start, (self.config).action_speed, (self.config).start_time, attackTrigger)
  self.hudunEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_start, self, nil, nil, nil, true)
end

bs_100502.OnAttackTrigger = function(self, time, duration)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_CF, self, nil, nil, nil, true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, duration)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_loop)
  local Arg = (self.arglist)[4]
  if time == 1 then
    Arg = (self.arglist)[1]
  end
  local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).shieldFormula, self.caster, nil, self, Arg)
  if shieldValue > 0 then
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
  end
  local rangeOffset = 1
  if time == 1 then
    rangeOffset = 10
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, rangeOffset)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if ((targetList[i]).targetRole).intensity ~= 0 then
        LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId_Taunt, 1, duration)
        -- DECOMPILER ERROR at PC83: Confused about usage of register: R11 in 'UnsetPending'

        ;
        ((self.caster).recordTable).peopleNum = ((self.caster).recordTable).peopleNum + 1
      end
    end
  end
  do
    -- DECOMPILER ERROR at PC87: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.caster).recordTable).skill = true
    self.time = self.time + 1
    LuaSkillCtrl:StartTimer(nil, duration, BindCallback(self, self.Onover), self)
  end
end

bs_100502.Onover = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((self.caster).recordTable).skill == true then
    if self.hudunEffect ~= nil then
      (self.hudunEffect):Die()
      self.hudunEffect = nil
    end
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_170, 0, true)
    LuaSkillCtrl:CallRoleAction(self.caster, 100)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_Super, 0, true)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.caster).recordTable).skill = false
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.caster).recordTable).peopleNum = 0
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetList.Count <= 0 then
      return 
    end
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:DispelBuffByMaker(self.caster, (targetList[i]).targetRole, (self.config).buffId_Taunt, 1)
    end
  end
end

bs_100502.OnSetHurt = function(self, context)
  -- function num : 0_5 , upvalues : _ENV
  if context.target == self.caster and ((self.caster).recordTable).skill == true then
    local roll = LuaSkillCtrl:CallRange(1, 10)
    local roleeffect = (self.config)["effectId_Hit" .. tostring(roll)]
    LuaSkillCtrl:CallEffect(self.caster, roleeffect, self)
  end
end

bs_100502.OnBreakShield = function(self, shieldType, sender, target)
  -- function num : 0_6
  if shieldType == 0 and target == self.caster and ((self.caster).recordTable).skill == true then
    self:Onover()
  end
end

bs_100502.OnBreakSkill = function(self, role)
  -- function num : 0_7 , upvalues : base
  if role == self.caster and ((self.caster).recordTable).skill == true then
    self:Onover()
  end
  ;
  (base.OnBreakSkill)(self, role)
end

bs_100502.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_100502.LuaDispose = function(self)
  -- function num : 0_9 , upvalues : base
  (base.LuaDispose)(self)
  self.hudunEffect = nil
end

return bs_100502

