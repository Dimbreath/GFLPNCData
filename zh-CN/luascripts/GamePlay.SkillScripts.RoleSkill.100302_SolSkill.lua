-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1039 = class("bs_1039", LuaSkillBase)
local base = LuaSkillBase
bs_1039.config = {buffId1 = 112, buffId2 = 113, buffId3 = 119, effectId1 = 10087, effectId2 = 10086, effectId3 = 10165, audioId1 = 38, 
realDamageConfig = {basehurt_formula = 10062}
, action4 = 1004, effectId_fire = 10060, effectId_firehit = 10061, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0}
}
bs_1039.ctor = function(self)
  -- function num : 0_0
end

bs_1039.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_1039.PlaySkill = function(self, data)
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
      self:CallCasterWait(31)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1004, 1, 11, attackTrigger)
      LuaSkillCtrl:CallEffect(target, (self.config).effectId_fire, self, nil, nil, nil, true)
    end
  end
end

bs_1039.OnAttackTrigger = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_firehit, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
  skillResult:EndResult()
  LuaSkillCtrl:CallBuffRepeated(self, target, 113, 1, (self.arglist)[4], false, self.OnBuffExecute)
  LuaSkillCtrl:StartTimer(self, 11, function()
    -- function num : 0_3_0 , upvalues : _ENV, target, self
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_firehit, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
    LuaSkillCtrl:CallBuffRepeated(self, target, 113, 1, (self.arglist)[4], false, self.OnBuffExecute)
  end
)
end

bs_1039.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_4 , upvalues : _ENV
  local solhurt = (self.caster).skill_intensity * (self.arglist)[5] // 1000
  if solhurt < 1 then
    solhurt = 1
  end
  LuaSkillCtrl:CallRealDamage(self, targetRole, nil, (self.config).realDamageConfig, {buff.tier}, true, true)
  LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId3, self)
end

bs_1039.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1039

