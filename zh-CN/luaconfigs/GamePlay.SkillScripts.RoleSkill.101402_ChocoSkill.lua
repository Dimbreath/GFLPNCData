-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101402 = class("bs_101402", LuaSkillBase)
local base = LuaSkillBase
bs_101402.config = {effectId_skill = 10649, effectId_trail = 10651, buffId_213 = 213, 
heal_config = {baseheal_formula = 10101, heal_number = 0, correct_formula = 9990}
, skill_time = 35, start_time = 17, actionId = 1002, action_speed = 1}
bs_101402.ctor = function(self)
  -- function num : 0_0
end

bs_101402.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101402.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
  if targetList.Count == 0 then
    return 
  end
  if (targetList[0]).targetRole ~= nil then
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_skill, self, nil, nil, nil, true)
    ;
    (self.caster):LookAtTarget((targetList[0]).targetRole)
    self:CallCasterWait((self.config).skill_time)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole, data)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
  end
end

bs_101402.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_trail, self, self.SkillEventFunc)
end

bs_101402.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if effect.dataId == (self.config).effectId_trail and eventId == eBattleEffectEvent.Trigger then
    if (self.arglist)[5] == 0 then
      LuaSkillCtrl:CallBuffRepeated(self, target.targetRole, (self.config).buffId_213, 1, (self.arglist)[1], true, self.OnBuffExecute)
    else
      if target.targetRole ~= self.caster then
        LuaSkillCtrl:CallBuffRepeated(self, target.targetRole, (self.config).buffId_213, 1, (self.arglist)[1], true, self.OnBuffExecute)
        LuaSkillCtrl:CallBuffRepeated(self, self.caster, (self.config).buffId_213, 1, (self.arglist)[1], true, self.OnBuffExecute)
      else
        LuaSkillCtrl:CallBuffRepeated(self, self.caster, (self.config).buffId_213, 2, (self.arglist)[1], true, self.OnBuffExecute)
        self.double = true
        if self.double_time ~= nil then
          (self.double_time):Stop()
          self.double_time = nil
        end
        self.double_time = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_4_0 , upvalues : self
    if self.double_time ~= nil and (self.double_time):IsOver() then
      self.double_time = nil
    end
    self.double = false
  end
, self)
      end
    end
  end
end

bs_101402.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_5 , upvalues : _ENV
  if targetRole:GetBuffTier((self.config).buffId_213) > 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config)
    skillResult:EndResult()
    if (self.arglist)[5] > 0 and self.double == true then
      LuaSkillCtrl:StartTimer(nil, 3, function()
    -- function num : 0_5_0 , upvalues : _ENV, self, targetRole
    local skillResult2 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HealResult(skillResult2, (self.config).heal_config)
    skillResult2:EndResult()
  end
)
    end
  end
end

bs_101402.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101402

