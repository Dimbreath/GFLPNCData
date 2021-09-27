local bs_10220 = class("bs_10220", LuaSkillBase)
local base = LuaSkillBase
bs_10220.config = {buffId_shixue = 257, buffTier = 1}
bs_10220.ctor = function(self)
  -- function num : 0_0
end

bs_10220.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10220_3", 1, self.OnAfterHurt, nil, self.caster)
  self.triggerNum = 0
end

bs_10220.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and not isMiss and hurt > 0 then
    self.triggerNum = self.triggerNum + 1
    if (self.arglist)[1] <= self.triggerNum then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_shixue, 1)
      self:PlayChipEffect()
      self:OnSkillTake()
      self.triggerNum = 0
    end
  end
end

bs_10220.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10220

