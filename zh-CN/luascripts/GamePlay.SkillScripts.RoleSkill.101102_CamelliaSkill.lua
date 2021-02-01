-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101102 = class("bs_101102", LuaSkillBase)
local base = LuaSkillBase
bs_101102.config = {
HurtConfig = {hit_formula = 0, def_formula = 9996, basehurt_formula = 10079, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 0, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000}
, effectId = 10601, effectHitId = 10603, buffId = 211}
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
  self:CallCasterWait(51)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 25, attackTrigger)
end

bs_101102.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil, nil, nil, true)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local target = (targetList[i]).targetRole
      if target ~= nil then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 1, (self.arglist)[1])
      end
    end
    if (self.arglist)[2] > 0 then
      self.hurt = LuaSkillCtrl:StartTimer(nil, (self.arglist)[3], function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    local list = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    for i = 0, list.Count - 1 do
      local tar = (list[i]).targetRole
      if tar ~= nil and tar:GetBuffTier((self.config).buffId) > 0 then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, tar)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, nil, true)
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(tar, (self.config).effectHitId, self)
      end
    end
  end
, self, -1)
      LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_3_1 , upvalues : self
    if self.hurt ~= nil then
      (self.hurt):Stop()
      self.hurt = nil
    end
  end
)
    end
  end
end

bs_101102.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101102

