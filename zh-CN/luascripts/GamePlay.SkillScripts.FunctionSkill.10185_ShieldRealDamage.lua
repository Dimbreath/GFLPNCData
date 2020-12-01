-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10185 = class("bs_10185", LuaSkillBase)
local base = LuaSkillBase
bs_10185.config = {sheildBuffId = 174, 
hurt_config = {basehurt_formula = 10007}
}
bs_10185.ctor = function(self)
  -- function num : 0_0
end

bs_10185.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10185_2", 1, self.OnSetHurt)
end

bs_10185.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and not context.isTriggerSet and self:IsReadyToTake() then
    local restTier = (context.target):GetBuffTier((self.config).sheildBuffId)
    if restTier > 0 then
      self:OnSkillTake()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
      skillResult:HurtResult((self.config).hurt_config)
      skillResult:EndResult()
    end
  end
end

bs_10185.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10185

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10185 = class("bs_10185", LuaSkillBase)
local base = LuaSkillBase
bs_10185.config = {sheildBuffId = 174, hurt_config = {basehurt_formula = 10007}}
bs_10185.ctor = function(self)
    -- function num : 0_0
end

bs_10185.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10185_2", 1, self.OnSetHurt)
end

bs_10185.OnSetHurt = function(self, context)
    -- function num : 0_2 , upvalues : _ENV
    if context.sender == self.caster and not context.isTriggerSet and
        self:IsReadyToTake() then
        local restTier =
            (context.target):GetBuffTier((self.config).sheildBuffId)
        if restTier > 0 then
            self:OnSkillTake()
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                     context.target)
            skillResult:HurtResult((self.config).hurt_config)
            skillResult:EndResult()
        end
    end
end

bs_10185.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10185

