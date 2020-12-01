-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202402 = class("bs_202402", LuaSkillBase)
local base = LuaSkillBase
bs_202402.config = {effectId1 = 10438, effectId2 = 10439, 
hurtConfig = {def_formula = 9996, basehurt_formula = 10055, minhurt_formula = 9994, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000}
}
bs_202402.ctor = function(self)
  -- function num : 0_0
end

bs_202402.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_202402.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if targetlist.Count > 0 then
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
    self:CallCasterWait(20)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 13, attackTrigger)
  end
end

bs_202402.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if targetlist.Count > 0 then
    local number = (self.arglist)[1] // targetlist.Count
    for i = 0, targetlist.Count - 1 do
      LuaSkillCtrl:CallEffect((targetlist[i]).targetRole, (self.config).effectId2, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetlist[i]).targetRole)
      LuaSkillCtrl:HurtResult(skillResult, (self.config).hurtConfig, {number})
      skillResult:EndResult()
    end
  end
end

bs_202402.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202402

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202402 = class("bs_202402", LuaSkillBase)
local base = LuaSkillBase
bs_202402.config = {
    effectId1 = 10438,
    effectId2 = 10439,
    hurtConfig = {
        def_formula = 9996,
        basehurt_formula = 10055,
        minhurt_formula = 9994,
        crithur_ratio = 9995,
        correct_formula = 9989,
        lifesteal_formula = 1001,
        spell_lifesteal_formula = 1002,
        returndamage_formula = 1000
    }
}
bs_202402.ctor = function(self)
    -- function num : 0_0
end

bs_202402.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_202402.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    if targetlist.Count > 0 then
        LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
        local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
        self:CallCasterWait(20)
        LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 13,
                                               attackTrigger)
    end
end

bs_202402.OnAttackTrigger = function(self, data)
    -- function num : 0_3 , upvalues : _ENV
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    if targetlist.Count > 0 then
        local number = (self.arglist)[1] // targetlist.Count
        for i = 0, targetlist.Count - 1 do
            LuaSkillCtrl:CallEffect((targetlist[i]).targetRole,
                                    (self.config).effectId2, self)
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                     (targetlist[i]).targetRole)
            LuaSkillCtrl:HurtResult(skillResult, (self.config).hurtConfig,
                                    {number})
            skillResult:EndResult()
        end
    end
end

bs_202402.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_202402

