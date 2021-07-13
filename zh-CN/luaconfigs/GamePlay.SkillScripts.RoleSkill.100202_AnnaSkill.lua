-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100202 = class("bs_100202", LuaSkillBase)
local base = LuaSkillBase
bs_100202.config = {skill_time = 15, start_time = 9, 
hurt_config = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0, crithur_ratio = 0, returndamage_formula = 0}
, 
hurt_config_extra = {hit_formula = 0, basehurt_formula = 10059, crit_formula = 0, crithur_ratio = 0, returndamage_formula = 0, lifesteal_formula = 0, spell_lifesteal_formula = 0, returndamage_formula = 0}
, effectId_line = 10049, effectId_trail = 10050, audioId_start = 29, skill_speed = 1, actionId = 1002, selectId_skill = 9, select_range = 10}
bs_100202.ctor = function(self)
  -- function num : 0_0
end

bs_100202.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_100202.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget == nil then
    return 
  end
  local target = moveTarget.targetRole
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data)
  ;
  (self.caster):LookAtTarget(target)
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).skill_speed, (self.config).start_time, attackTrigger)
end

bs_100202.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_start)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_line, self)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_trail, self, self.SkillEventFunc)
end

bs_100202.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, false, false)
    skillResult:EndResult()
    local transferList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId_skill, (self.config).select_range)
    if transferList == 0 then
      return 
    end
    for i = 0, transferList.Count - 1 do
      local role = (transferList[i]).targetRole
      if role ~= target.targetRole and role.intensity ~= 0 then
        LuaSkillCtrl:CallEffect(role, (self.config).effectId_line, self, nil, target.targetRole)
        if (self.arglist)[3] >= 1 then
          LuaSkillCtrl:CallEffect(role, (self.config).effectId_trail, self, self.SkillEventFunc_extra, target.targetRole)
        end
      end
    end
  end
end

bs_100202.SkillEventFunc_extra = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config_extra, nil, true)
    skillResult:EndResult()
  end
end

bs_100202.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100202

