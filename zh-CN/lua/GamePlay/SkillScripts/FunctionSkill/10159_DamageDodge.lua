local bs_10159 = class("bs_10159", LuaSkillBase)
local base = LuaSkillBase
bs_10159.config = {buffId = 1008}
bs_10159.ctor = function(self)
  -- function num : 0_0
end

bs_10159.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10159_3", 1, self.OnAfterHurt, self.caster)
end

bs_10159.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss and LuaSkillCtrl:CallRange(1, 1000) < (self.arglist)[3] then
    local layer = (self.caster):GetBuffTier((self.config).buffId)
    self:PlayChipEffect()
    if layer ~= (self.arglist)[2] then
      if layer + (self.arglist)[1] <= (self.arglist)[2] then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], nil, true)
      else
        if (self.arglist)[2] < layer + (self.arglist)[1] then
          LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
          LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[2], nil, true)
        end
      end
    end
  end
end

bs_10159.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10159

