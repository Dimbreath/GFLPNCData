local bs_30005 = class("bs_30005", LuaSkillBase)
local base = LuaSkillBase
bs_30005.config = {}
bs_30005.ctor = function(self)
  -- function num : 0_0
end

bs_30005.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnAfterShieldHurt, "bs_30005_1", 1, self.OnAfterShieldHurt)
end

bs_30005.OnAfterShieldHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  local target = context.target
  local shieldType = context.shield_type
  local costValue = context.shield_cost_hurt * (self.arglist)[1] // 1000
  if target == self.caster and shieldType ~= eShieldType.Beelneith then
    LuaSkillCtrl:CallHeal(costValue, self, self.caster, true)
  end
end

bs_30005.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30005

