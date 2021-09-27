local bs_10275 = class("bs_10275", LuaSkillBase)
local base = LuaSkillBase
bs_10275.config = {}
bs_10275.ctor = function(self)
  -- function num : 0_0
end

bs_10275.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10275_4", 1, self.OnSetHeal, self.caster)
end

bs_10275.OnSetHeal = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and not context.isTriggerSet then
    local shieldValue = context.heal * (self.arglist)[1] // 1000
    LuaSkillCtrl:AddRoleShield(context.target, eShieldType.Normal, shieldValue)
  end
end

bs_10275.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10275

