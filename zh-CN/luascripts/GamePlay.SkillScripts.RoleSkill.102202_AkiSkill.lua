-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202202 = class("bs_202202", LuaSkillBase)
local base = LuaSkillBase
bs_202202.config = {effectId1 = 10697, effectId2 = 10698, 
hurt_config1 = {hit_formula = 0, basehurt_formula = 10077}
, 
hurt_config2 = {hit_formula = 0, basehurt_formula = 10077, crit_formula = 10084}
}
bs_202202.ctor = function(self)
  -- function num : 0_0
end

bs_202202.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_202202.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local last_target = ((self.caster).recordTable).lastComAttackRole
  local target = nil
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    if targetList.Count > 0 then
      target = (targetList[0]).targetRole
    end
  end
  do
    if target ~= nil then
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
      ;
      (self.caster):LookAtTarget(target)
      self:CallCasterWait(36)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 11, attackTrigger)
      LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self, nil, nil, nil, true)
    end
  end
end

bs_202202.OnAttackTrigger = function(self, Target)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(Target, (self.config).effectId2, self)
  if (self.arglist)[3] > 0 then
    for i = 1, (self.arglist)[1] do
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, Target)
      LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config2)
      skillResult:EndResult()
    end
  else
    do
      for i = 1, (self.arglist)[1] do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, Target)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config1)
        skillResult:EndResult()
      end
    end
  end
end

bs_202202.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202202

