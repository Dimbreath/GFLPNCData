local bs_101502 = class("bs_101502", LuaSkillBase)
local base = LuaSkillBase
bs_101502.config = {effectId_green = 101513, effectId_zong = 101502, effectId = 101512, 
HurtConfig = {hit_formula = 0, basehurt_formula = 3010, crit_formula = 0}
, 
HealConfig = {baseheal_formula = 3021}
, actionId = 1002, action_speed = 1, skill_time = 72, start_time = 6, buffId_170 = 3008, buffId_Ult = 101501, audioId_hit = 101502}
bs_101502.ctor = function(self)
  -- function num : 0_0
end

bs_101502.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101502.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_170, 1, (self.config).skill_time, true)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil, nil, nil, true)
end

bs_101502.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:StartShowSkillDurationTime(self, (self.config).skill_time - (self.config).start_time)
  local num = (self.arglist)[1] - 1
  if (self.caster):GetBuffTier((self.config).buffId_Ult) > 0 then
    num = num + ((self.caster).recordTable).Ult_skill_up
  end
  local time = 40 // (num)
  LuaSkillCtrl:StartTimer(self, time, function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    local target_fr = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
    if target_fr.Count > 0 then
      LuaSkillCtrl:CallEffect((target_fr[0]).targetRole, (self.config).effectId_green, self, self.SkillEventFunc)
    end
    local target_en_role = nil
    local target_en = LuaSkillCtrl:CallTargetSelect(self, 56, 10)
    if target_en.Count > 0 and ((target_en[0]).targetRole).intensity ~= 0 and ((target_en[0]).targetRole).roleType ~= eBattleRoleType.realSummoner then
      target_en_role = (target_en[0]).targetRole
    else
      local target_en_ex = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
      if target_en_ex.Count > 0 and ((target_en_ex[0]).targetRole).intensity ~= 0 then
        target_en_role = (target_en_ex[0]).targetRole
      end
    end
    do
      if target_en_role ~= nil then
        LuaSkillCtrl:CallEffect(target_en_role, (self.config).effectId_zong, self, self.SkillEventFunc)
      end
    end
  end
, self, num, time - 1)
end

bs_101502.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  do
    if eventId == eBattleEffectEvent.Trigger and effect.dataId == (self.config).effectId_zong then
      local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
      LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_hit)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {(self.arglist)[3]})
      skillResult:EndResult()
    end
    if eventId == eBattleEffectEvent.Trigger and effect.dataId == (self.config).effectId_green then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig, {(self.arglist)[2]})
      skillResult:EndResult()
    end
  end
end

bs_101502.OnBreakSkill = function(self, role)
  -- function num : 0_5 , upvalues : _ENV, base
  if role == self.caster then
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_170, 0, true)
  end
  ;
  (base.OnBreakSkill)(self, role)
end

bs_101502.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101502

