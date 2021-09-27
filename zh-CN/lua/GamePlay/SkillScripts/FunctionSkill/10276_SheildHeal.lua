local bs_10276 = class("bs_10276", LuaSkillBase)
local base = LuaSkillBase
bs_10276.config = {buffId = 1189, buffTier = 1}
bs_10276.ctor = function(self)
  -- function num : 0_0
end

bs_10276.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10276_4", 1, self.OnSetHeal, self.caster)
end

bs_10276.OnSetHeal = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (LuaSkillCtrl:GetShield(context.target, eShieldType.Normal) > 0 or LuaSkillCtrl:GetShield(context.target, eShieldType.LongRange) > 0 or LuaSkillCtrl:GetShield(context.target, eShieldType.NoRange) > 0) then
    context.heal = context.heal + context.heal * (self.arglist)[1] // 1000
  end
end

bs_10276.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10276

