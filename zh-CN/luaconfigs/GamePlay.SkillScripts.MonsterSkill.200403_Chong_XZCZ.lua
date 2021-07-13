-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_200403 = class("bs_200403", LuaSkillBase)
local base = LuaSkillBase
bs_200403.config = {
hurt_config = {basehurt_formula = 10007, hit_formula = 0, crit_formula = 0, correct_formula = 9989}
, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
, effectId = 10101, hitEffectId = 10100, buffId_66 = 66, buffId_151 = 151, buffTier = 1, startAnimID = 1002, audioId1 = 53, skill_time = 50, start_time = 7, skill_speed = 1, strikeBackTime = 3}
bs_200403.ctor = function(self)
  -- function num : 0_0
end

bs_200403.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_200403.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.caster, data)
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimID, (self.config).skill_speed, (self.config).start_time, attackTrigger)
end

bs_200403.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
  LuaSkillCtrl:PlayAuHit(self, target)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
  skillResult:BuffResult((self.config).buffId_66, (self.config).buffTier, (self.arglist)[2])
  skillResult:BuffResult((self.config).buffId_151, (self.config).buffTier, (self.config).strikeBackTime)
  if (skillResult.roleList).Count > 0 then
    for i = 0, (skillResult.roleList).Count - 1 do
      local role = (skillResult.roleList)[i]
      LuaSkillCtrl:CallEffect(role, (self.config).hitEffectId, self)
    end
  end
  do
    skillResult:EndResult()
  end
end

bs_200403.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_200403

