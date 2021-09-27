local bs_102202 = class("bs_102202", LuaSkillBase)
local base = LuaSkillBase
bs_102202.config = {effectId_skill = 102210, effectId_hit = 102211, 
hurt_config = {hit_formula = 0, basehurt_formula = 3000}
, skill_time = 36, start_time = 11, actionId = 1002, action_speed = 1, skill_selectId = 1001, audioId1 = 234, audioId2 = 235}
bs_102202.ctor = function(self)
  -- function num : 0_0
end

bs_102202.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_102202.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local last_target = ((self.caster).recordTable).lastAttackRole
  local target = nil
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local moveTarget = self:GetMoveSelectTarget()
    if moveTarget ~= nil then
      target = moveTarget.targetRole
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
      LuaSkillCtrl:CallEffect(target, (self.config).effectId_skill, self, nil, nil, nil, true)
    end
  end
end

bs_102202.OnAttackTrigger = function(self, Target)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(Target, (self.config).effectId_hit, self)
  local arg = 0
  for i = 1, (self.arglist)[1] do
    LuaSkillCtrl:StartTimer(nil, ((self.arglist)[1] - i) * 2, function()
    -- function num : 0_3_0 , upvalues : _ENV, self, Target
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, Target)
    LuaSkillCtrl:PlayAuSource(Target, (self.config).audioId2)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {(self.arglist)[2]})
    skillResult:EndResult()
  end
)
  end
end

bs_102202.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102202

