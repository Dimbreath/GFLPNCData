-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100302 = class("bs_100302", LuaSkillBase)
local base = LuaSkillBase
bs_100302.config = {buffId_113 = 113, effectId_bnfffire = 10165, audioId1 = 38, action4 = 1004, effectId_fire = 10060, effectId_firehit = 10061, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0}
, 
HurtConfig_ex = {hit_formula = 0, basehurt_formula = 10062, crit_formula = 0, lifesteal_formula = 0, spell_lifesteal_formula = 0, returndamage_formula = 0}
, 
hurt_ex = {basehurt_formula = 10124}
, skill_time = 33, start_time = 11, actionId = 1004, action_speed = 1}
bs_100302.ctor = function(self)
  -- function num : 0_0
end

bs_100302.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_100302_2", 99, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, 8)
end

bs_100302.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local last_target = ((self.caster).recordTable).lastAttackRole
  local target = nil
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    target = tempTarget.targetRole
  end
  do
    if target ~= nil then
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
      ;
      (self.caster):LookAtTarget(target)
      self:CallCasterWait((self.config).skill_time)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
      LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
      LuaSkillCtrl:CallEffect(target, (self.config).effectId_fire, self, nil, nil, nil, true)
    end
  end
end

bs_100302.OnAttackTrigger = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_firehit, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:PlayAuHit(self, target)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig)
  skillResult:EndResult()
  LuaSkillCtrl:CallBuffRepeated(self, target, (self.config).buffId_113, 1, (self.arglist)[4], false, self.OnBuffExecute)
  LuaSkillCtrl:StartTimer(self, 11, function()
    -- function num : 0_3_0 , upvalues : _ENV, target, self
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_firehit, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
    LuaSkillCtrl:CallBuffRepeated(self, target, (self.config).buffId_113, 1, (self.arglist)[4], false, self.OnBuffExecute)
  end
)
end

bs_100302.OnSetHurt = function(self, context)
  -- function num : 0_4 , upvalues : _ENV
  if context.sender == self.caster and (context.skill).isCommonAttack and (self.arglist)[2] > 0 and (self.arglist)[6] <= (context.target):GetBuffTier((self.config).buffId_113) then
    local hurt_ex = BindCallback(self, self.OnHurt_ex, context.target)
    LuaSkillCtrl:StartTimer(nil, 3, hurt_ex)
  end
end

bs_100302.OnHurt_ex = function(self, target)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallRealDamage(self, target, nil, (self.config).hurt_ex, {(self.arglist)[7]}, true)
end

bs_100302.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_6 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig_ex, {buff.tier})
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId_bnfffire, self)
end

bs_100302.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100302

