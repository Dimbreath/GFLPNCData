-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101301 = class("bs_101301", LuaSkillBase)
local base = LuaSkillBase
bs_101301.config = {effectId = 10526, 
HurtConfig = {basehurt_formula = 10086}
}
bs_101301.ctor = function(self)
  -- function num : 0_0
end

bs_101301.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_101301_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_101301_12", 1, self.OnAfterPlaySkill)
  self.last = nil
end

bs_101301.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill ~= nil and skill.isCommonAttack and not isMiss then
    local low = (self.arglist)[1]
    do
      local high = (self.arglist)[2]
      local prob = LuaSkillCtrl:CallRange(low, high)
      if (self.arglist)[3] >= 1 and target ~= self.last then
        prob = (self.arglist)[2]
      end
      LuaSkillCtrl:StartTimer(self, 4, function()
    -- function num : 0_2_0 , upvalues : _ENV, target, self, prob
    LuaSkillCtrl:CallEffect(target, 10526, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {prob})
    skillResult:EndResult()
  end
)
      self.last = target
    end
  end
end

bs_101301.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_3
end

bs_101301.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101301

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101301 = class("bs_101301", LuaSkillBase)
local base = LuaSkillBase
bs_101301.config = {effectId = 10526, HurtConfig = {basehurt_formula = 10086}}
bs_101301.ctor = function(self)
    -- function num : 0_0
end

bs_101301.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_101301_3", 1,
                    self.OnAfterHurt)
    self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_101301_12", 1,
                    self.OnAfterPlaySkill)
    self.last = nil
end

bs_101301.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                 isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster and skill ~= nil and skill.isCommonAttack and
        not isMiss then
        local low = (self.arglist)[1]
        do
            local high = (self.arglist)[2]
            local prob = LuaSkillCtrl:CallRange(low, high)
            if (self.arglist)[3] >= 1 and target ~= self.last then
                prob = (self.arglist)[2]
            end
            LuaSkillCtrl:StartTimer(self, 4, function()
                -- function num : 0_2_0 , upvalues : _ENV, target, self, prob
                LuaSkillCtrl:CallEffect(target, 10526, self)
                local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                         target)
                LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig,
                                        {prob})
                skillResult:EndResult()
            end)
            self.last = target
        end
    end
end

bs_101301.OnAfterPlaySkill = function(self, skill, role)
    -- function num : 0_3
end

bs_101301.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_101301

