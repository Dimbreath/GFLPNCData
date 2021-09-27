local bs_10180 = class("bs_10180", LuaSkillBase)
local base = LuaSkillBase
bs_10180.config = {}
bs_10180.ctor = function(self)
  -- function num : 0_0
end

bs_10180.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10180_1", 1000, self.OnSetHurt, self.caster)
  self:AddTrigger(eSkillTriggerType.OnAfterShieldHurt, "bs_10180_1", 1, self.OnAfterShieldHurt)
end

bs_10180.OnAfterShieldHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  local sender = context.sender
  local shieldType = context.shield_type
  local costValue = context.shield_cost_hurt
  local healValue = costValue * (self.arglist)[2] // 1000
  if sender == self.caster and (shieldType == eShieldType.LongRange or shieldType == eShieldType.NoRange) then
    LuaSkillCtrl:CallHeal(healValue, self, self.caster, true)
  end
end

bs_10180.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if not context.isTriggerSet then
    if context.sender == self.caster and (self.caster).attackRange > 1 and (context.target):GetShield(eShieldType.LongRange) > 0 then
      context.hurt = context.hurt * (1000 + (self.arglist)[1]) // 1000
    end
    if context.sender == self.caster and (self.caster).attackRange == 1 and (context.target):GetShield(eShieldType.NoRange) > 0 then
      context.hurt = context.hurt * (1000 + (self.arglist)[1]) // 1000
    end
  end
end

bs_10180.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10180

