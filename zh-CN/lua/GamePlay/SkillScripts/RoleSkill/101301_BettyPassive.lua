local bs_101301 = class("bs_101301", LuaSkillBase)
local base = LuaSkillBase
bs_101301.config = {effectId_hit = 101304, 
HurtConfig = {basehurt_formula = 3000}
}
bs_101301.ctor = function(self)
  -- function num : 0_0
end

bs_101301.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_101301_3", 1, self.OnAfterHurt, self.caster)
end

bs_101301.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill ~= nil and skill.isCommonAttack and not isMiss then
    local low = (self.arglist)[1]
    do
      local high = (self.arglist)[2]
      local prob = LuaSkillCtrl:CallRange(low, high)
      LuaSkillCtrl:StartTimer(nil, 4, function()
    -- function num : 0_2_0 , upvalues : _ENV, target, self, prob
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_hit, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {prob})
    skillResult:EndResult()
  end
)
    end
  end
end

bs_101301.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101301

