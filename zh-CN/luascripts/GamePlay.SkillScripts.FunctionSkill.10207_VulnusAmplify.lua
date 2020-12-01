-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10207 = class("bs_10207", LuaSkillBase)
local base = LuaSkillBase
bs_10207.config = {
damageConfig1 = {basehurt_formula = 10034}
, 
damageConfig2 = {basehurt_formula = 10073}
, buffId = 195, effectId = 1049}
bs_10207.ctor = function(self)
  -- function num : 0_0
end

bs_10207.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10207_2", 1, self.OnSetHurt)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10207_12", 1, self.OnAfterPlaySkill)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10207_AttackTimes"] = 0
end

bs_10207.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (context.skill).isCommonAttack and not context.isTriggerSet and (self.arglist)[3] < ((self.caster).recordTable)["10207_AttackTimes"] then
    local buffTier = (context.target):GetBuffTier((self.config).buffId)
    self:PlayChipEffect()
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10207_AttackTimes"] = 0
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).damageConfig2, {buffTier})
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(context.target, (self.config).effectId, self)
  end
end

bs_10207.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if skill.maker == self.caster and skill.isCommonAttack then
    ((self.caster).recordTable)["10207_AttackTimes"] = ((self.caster).recordTable)["10207_AttackTimes"] + 1
  end
end

bs_10207.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10207

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10207 = class("bs_10207", LuaSkillBase)
local base = LuaSkillBase
bs_10207.config = {
    damageConfig1 = {basehurt_formula = 10034},
    damageConfig2 = {basehurt_formula = 10073},
    buffId = 195,
    effectId = 1049
}
bs_10207.ctor = function(self)
    -- function num : 0_0
end

bs_10207.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10207_2", 1, self.OnSetHurt)
    self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10207_12", 1,
                    self.OnAfterPlaySkill) -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.caster).recordTable)["10207_AttackTimes"] = 0
end

bs_10207.OnSetHurt = function(self, context)
    -- function num : 0_2 , upvalues : _ENV
    if context.sender == self.caster and (context.skill).isCommonAttack and
        not context.isTriggerSet and (self.arglist)[3] <
        ((self.caster).recordTable)["10207_AttackTimes"] then
        local buffTier = (context.target):GetBuffTier((self.config).buffId)
        self:PlayChipEffect() -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.caster).recordTable)["10207_AttackTimes"] = 0
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                 context.target)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).damageConfig2,
                                {buffTier})
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(context.target, (self.config).effectId, self)
    end
end

bs_10207.OnAfterPlaySkill = function(self, skill, role)
    -- function num : 0_3
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

    if skill.maker == self.caster and skill.isCommonAttack then
        ((self.caster).recordTable)["10207_AttackTimes"] =
            ((self.caster).recordTable)["10207_AttackTimes"] + 1
    end
end

bs_10207.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10207

