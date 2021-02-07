-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102802 = class("bs_102802", LuaSkillBase)
local base = LuaSkillBase
bs_102802.config = {effectId = 10707, buffId = 228, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10079, crit_formula = 0}
}
bs_102802.ctor = function(self)
  -- function num : 0_0
end

bs_102802.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_102802.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local last_target = ((self.caster).recordTable).lastComAttackRole
  local target = nil
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral then
    target = last_target
  else
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 33, 10)
    if targetList.Count > 0 then
      target = (targetList[0]).targetRole
    end
  end
  do
    if target ~= nil then
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
      ;
      (self.caster):LookAtTarget(target)
      self:CallCasterWait(31)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 11, attackTrigger)
    end
  end
end

bs_102802.OnAttackTrigger = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillEventFunc)
end

bs_102802.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuffRepeated(self, target.targetRole, (self.config).buffId, 1, (self.arglist)[1], false, self.OnBuffExecute)
  end
end

bs_102802.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_5 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
  skillResult:EndResult()
end

bs_102802.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102802

