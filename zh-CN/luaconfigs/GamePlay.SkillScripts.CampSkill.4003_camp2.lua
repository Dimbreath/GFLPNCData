-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_4003 = class("bs_4003", LuaSkillBase)
local base = LuaSkillBase
bs_4003.config = {buffId = 99, buffDuration = 60}
bs_4003.ctor = function(self)
  -- function num : 0_0
end

bs_4003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddSetHurtTrigger("bs_4003_3", 1, self.OnSetHurt, nil, self.caster)
end

bs_4003.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and self:IsReadyToTake() and (self.caster).hp <= context.hurt then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, (self.config).buffDuration, true)
    self:OnSkillTake()
  end
end

bs_4003.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_4003

