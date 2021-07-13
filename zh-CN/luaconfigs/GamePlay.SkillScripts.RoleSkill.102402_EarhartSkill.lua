-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102402 = class("bs_102402", LuaSkillBase)
local base = LuaSkillBase
bs_102402.config = {buffId_236 = 236, buffId_196 = 196, buffId_170 = 170, skill_time = 20, effectId_DDL = 10744, effectId_DDR = 10745, 
Aoe = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10081, crit_formula = 0}
, start_time = 20, actionId = 1002, actionId_end = 1009, action_speed = 1, end_time = 32}
bs_102402.ctor = function(self)
  -- function num : 0_0
end

bs_102402.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.DD = 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).skill_arg1 = (self.arglist)[1]
end

bs_102402.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_170, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_196, 1, nil, true)
  self.action = true
end

bs_102402.OnAttackTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.action = false
  LuaSkillCtrl:StartShowSkillDurationTime(self, (self.arglist)[2])
  local over = BindCallback(self, self.Onover)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_236, 1, (self.arglist)[2], true)
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], over)
  if (self.arglist)[4] > 0 then
    self.time2 = LuaSkillCtrl:StartTimer(nil, (self.arglist)[5], function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    if (self.caster):GetBuffTier((self.config).buffId_236) > 0 then
      local last_target = ((self.caster).recordTable).lastAttackRole
      local target = nil
      if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:RoleContainsBuffFeature(last_target, eBuffFeatureType.NotBeSelected) ~= true then
        target = last_target
      else
        local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
        if targetList.Count > 0 then
          target = (targetList[0]).targetRole
        end
      end
      do
        do
          if target ~= nil then
            if self.DD == 0 then
              LuaSkillCtrl:CallEffect(target, (self.config).effectId_DDL, self, self.SkillEventFunc)
              self.DD = 1
            else
              LuaSkillCtrl:CallEffect(target, (self.config).effectId_DDR, self, self.SkillEventFunc)
              self.DD = 0
            end
          end
          if self.time2 ~= nil then
            (self.time2):Stop()
            self.time2 = nil
          end
        end
      end
    end
  end
, self, -1)
  end
end

bs_102402.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target.targetRole, (self.config).Aoe)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
  end
end

bs_102402.Onover = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.time2 ~= nil then
    (self.time2):Stop()
    self.time2 = nil
  end
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 1, true)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_170, 1, true)
  self:CallCasterWait((self.config).end_time)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_end)
end

bs_102402.OnBreakSkill = function(self, role)
  -- function num : 0_6 , upvalues : _ENV, base
  if role == self.caster and self.action == true then
    self.action = false
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 1, true)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_170, 1, true)
    self:CancleCasterWait()
  end
  ;
  (base.OnBreakSkill)(self, role)
end

bs_102402.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102402

