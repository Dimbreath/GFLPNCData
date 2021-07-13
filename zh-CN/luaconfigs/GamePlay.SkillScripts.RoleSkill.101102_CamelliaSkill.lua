-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101102 = class("bs_101102", LuaSkillBase)
local base = LuaSkillBase
bs_101102.config = {
HurtConfig = {hit_formula = 0, def_formula = 9996, basehurt_formula = 10077, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 0, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000}
, 
heal_config = {baseheal_formula = 501, heal_number = 0, crit_formula = 0, crithur_ratio = 0, correct_formula = 9990}
, effectId_skill = 10601, effectId_Hit = 10603, effectId_heal = 10874, buffId_211 = 211, actionId = 1002, skill_time = 51, start_time = 25, action_speed = 1}
bs_101102.ctor = function(self)
  -- function num : 0_0
end

bs_101102.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101102.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
end

bs_101102.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local effect_loop = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_heal, self)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_skill, self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if targetList.Count > 0 then
    do
      for i = 0, targetList.Count - 1 do
        local target = (targetList[i]).targetRole
        if target ~= nil then
          LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_211, 1, (self.arglist)[1])
        end
      end
    end
    local hurt = LuaSkillCtrl:StartTimer(nil, (self.arglist)[5], function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    local list = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    local time = 0
    for i = 0, list.Count - 1 do
      local tar = (list[i]).targetRole
      if tar ~= nil and tar:GetBuffTier((self.config).buffId_211) > 0 then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, tar)
        LuaSkillCtrl:PlayAuHit(self, tar)
        LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, nil, true)
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(tar, (self.config).effectId_Hit, self)
        time = time + 1
      end
    end
    if (self.arglist)[3] > 0 then
      local heal = (self.caster).maxHp * (self.arglist)[4] // 1000 * (time)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {heal}, true, false)
      skillResult:EndResult()
    end
  end
, self, -1)
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_3_1 , upvalues : hurt, effect_loop
    if hurt ~= nil then
      hurt:Stop()
      hurt = nil
    end
    if effect_loop ~= nil then
      effect_loop:Die()
      effect_loop = nil
    end
  end
)
  end
end

bs_101102.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101102

