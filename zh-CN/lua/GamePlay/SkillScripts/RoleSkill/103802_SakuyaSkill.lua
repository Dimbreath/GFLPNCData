local bs_103802 = class("bs_103802", LuaSkillBase)
local base = LuaSkillBase
bs_103802.config = {buffId_blood = 103801, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 2}
, 
hurt_config = {hit_formula = 0, basehurt_formula = 3000, crit_formula = 0, crithur_ratio = 0}
, effectId_skill = 10389, buffId_195 = 195, skill_time = 20, start_time = 10, actionId = 1002, action_speed = 1.5, audioId1 = 293, audio_loop = 294}
bs_103802.ctor = function(self)
  -- function num : 0_0
end

bs_103802.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.again = false
end

bs_103802.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.again = false
  self:CallCasterWait((self.config).skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
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
      LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_195, (self.arglist)[2], (self.arglist)[3])
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {(self.arglist)[1]})
      skillResult:EndResult()
      if role:GetBuffTier((self.config).buffId_195) == 10 and role:GetBuffTier((self.config).buffId_blood) == 0 then
        LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_blood, 1, nil, true)
        self.again = true
      end
    end
    if self.again == true then
      LuaSkillCtrl:CallReFillMainSkillCdForRole(self.caster)
    else
      local targetList_all = LuaSkillCtrl:CallTargetSelect(self, 33, 10)
      for i = 0, targetList_all.Count - 1 do
        local role = (targetList_all[i]).targetRole
        if role:GetBuffTier((self.config).buffId_blood) ~= 0 then
          LuaSkillCtrl:DispelBuff(role, (self.config).buffId_blood, 0, true)
        end
      end
    end
  end
end

bs_103802.OnBreakSkill = function(self, role)
  -- function num : 0_4
end

bs_103802.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103802

