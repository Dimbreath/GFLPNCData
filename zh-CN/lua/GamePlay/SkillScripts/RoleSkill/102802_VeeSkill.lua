local bs_102802 = class("bs_102802", LuaSkillBase)
local base = LuaSkillBase
bs_102802.config = {effectId_skill = 10707, buffId_228 = 102802, 
HurtConfig = {hit_formula = 0, basehurt_formula = 3010, crit_formula = 0}
, actionId = 1002, action_speed = 1, skill_time = 31, start_time = 11, audioId1 = 269}
bs_102802.ctor = function(self)
  -- function num : 0_0
end

bs_102802.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_102802.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local last_target = ((self.caster).recordTable).lastAttackRole
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
      self:CallCasterWait((self.config).skill_time)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
      LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
    end
  end
end

bs_102802.OnAttackTrigger = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_skill, self, self.SkillEventFunc)
end

bs_102802.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuffRepeated(self, target.targetRole, (self.config).buffId_228, 1, (self.arglist)[1] + 1, false, self.OnBuffExecute)
  end
end

bs_102802.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_5 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {(self.arglist)[3]})
  skillResult:EndResult()
end

bs_102802.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102802

