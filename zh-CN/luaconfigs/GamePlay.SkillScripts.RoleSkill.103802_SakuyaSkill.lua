-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103802 = class("bs_103802", LuaSkillBase)
local base = LuaSkillBase
bs_103802.config = {
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 2}
, 
hurt_config = {hit_formula = 0, basehurt_formula = 10138, crit_formula = 0, crithur_ratio = 0}
, effectId_skill = 10389, buffId_195 = 195, buff_time = 75, skill_time = 20, start_time = 10, actionId = 1002, action_speed = 1.5}
bs_103802.ctor = function(self)
  -- function num : 0_0
end

bs_103802.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103802.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait((self.config).skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_skill, self, nil, nil, 1, true)
end

bs_103802.OnAttackTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local ex_arg = 2 - (self.caster).attackRange
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 33, ex_arg)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = (targetList[i]).targetRole
      local hurt_ex = 0
      if (self.arglist)[2] > 0 then
        hurt_ex = role:GetBuffTier((self.config).buffId_195)
      end
      LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_195, 1, (self.config).buff_time)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:PlayAuHit(self, role)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {hurt_ex})
      skillResult:EndResult()
    end
  end
end

bs_103802.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103802

