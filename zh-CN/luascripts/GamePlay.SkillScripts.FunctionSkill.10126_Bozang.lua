-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10126 = class("bs_10126", LuaSkillBase)
local base = LuaSkillBase
bs_10126.config = {buffId = 99, buffTier = 1, buffDuration = 45}
bs_10126.ctor = function(self)
  -- function num : 0_0
end

bs_10126.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_10126_3", 1, self.OnSetHurt)
end

bs_10126.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and self:IsReadyToTake() and (self.caster).hp <= context.hurt and (self.caster).hp > 0 then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, (self.arglist)[1], true)
    self:OnSkillTake()
  end
end

bs_10126.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10126

