-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101402 = class("bs_101402", LuaSkillBase)
local base = LuaSkillBase
bs_101402.config = {effectId1 = 10649, effectId2 = 10651, buffId = 213, 
heal_config = {baseheal_formula = 10101, heal_number = 0, correct_formula = 9990}
}
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
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, nil, true)
    ;
    (self.caster):LookAtTarget((targetList[0]).targetRole)
    self:CallCasterWait(35)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole, data)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 17, attackTrigger)
  end
end

bs_101402.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self, self.SkillEventFunc)
end

bs_101402.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if effect.dataId == (self.config).effectId2 and eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuffRepeated(self, target.targetRole, (self.config).buffId, 1, (self.arglist)[1], true, self.OnBuffExecute)
    if (self.arglist)[5] > 0 and target.targetRole ~= self.caster then
      LuaSkillCtrl:CallBuffRepeated(self, self.caster, (self.config).buffId, 1, (self.arglist)[1], true, self.OnBuffExecute)
    end
  end
end

bs_101402.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_5 , upvalues : _ENV
  if targetRole:GetBuffTier((self.config).buffId) > 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config)
    skillResult:EndResult()
  end
end

bs_101402.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101402

