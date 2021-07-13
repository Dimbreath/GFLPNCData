-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10186 = class("bs_10186", LuaSkillBase)
local base = LuaSkillBase
bs_10186.config = {sheildBuffId = 174, buffId = 1019}
bs_10186.ctor = function(self)
  -- function num : 0_0
end

bs_10186.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_10186_1", 99, self.OnSetDeadHurt, self.caster)
end

bs_10186.OnSetDeadHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (context.target).belongNum ~= (self.caster).belongNum then
    local value = LuaSkillCtrl:GetShield(context.target, eShieldType.NoRange)
    local value2 = LuaSkillCtrl:GetShield(context.target, eShieldType.LongRange)
    if value > 0 or value2 > 0 then
      local buffTier = (context.target).pow * (self.arglist)[1] // 1000
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, buffTier, nil, true)
    end
  end
end

bs_10186.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10186

