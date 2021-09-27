local bs_101401 = class("bs_101401", LuaSkillBase)
local base = LuaSkillBase
bs_101401.config = {buffId_214 = 101402, effectId_passive = 101404, 
heal_config = {baseheal_formula = 3021}
, selectId_pass = 6, select_range = -1}
bs_101401.ctor = function(self)
  -- function num : 0_0
end

bs_101401.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_101401_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_101401_12", 1, self.OnAfterPlaySkill)
end

bs_101401.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    local num = (self.caster):GetBuffTier((self.config).buffId_214) * (self.arglist)[2]
    local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId_pass, (self.config).select_range)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local target = (targetList[i]).targetRole
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {num})
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(target, (self.config).effectId_passive, self)
      end
    end
    do
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_214, 0, true)
    end
  end
, self, -1)
end

bs_101401.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_3 , upvalues : _ENV
  if role == self.caster and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_214, 1, nil, true)
  end
end

bs_101401.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101401

