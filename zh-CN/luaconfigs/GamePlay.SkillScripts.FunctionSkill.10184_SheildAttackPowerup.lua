-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10184 = class("bs_10184", LuaSkillBase)
local base = LuaSkillBase
bs_10184.config = {sheildBuffId = 174, buffId = 1066}
bs_10184.ctor = function(self)
  -- function num : 0_0
end

bs_10184.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10184_3", 1, self.OnSetHurt, self.caster)
end

bs_10184.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and not (context.skill).isPassive then
    local value = LuaSkillCtrl:GetShield(context.target, eShieldType.NoRange)
    local value2 = LuaSkillCtrl:GetShield(context.target, eShieldType.LongRange)
    if value > 0 or value2 > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, (self.arglist)[2])
    else
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
      return 
    end
  end
end

bs_10184.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10184

