local bs_10237 = class("bs_10237", LuaSkillBase)
local base = LuaSkillBase
bs_10237.config = {buffId = 1090, buffTier = 1}
bs_10237.ctor = function(self)
  -- function num : 0_0
end

bs_10237.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_10237_5", 1, self.OnAfterHeal, self.caster)
end

bs_10237.OnAfterHeal = function(self, sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isTriggerSet and self:IsReadyToTake() then
    self:OnSkillTake()
    local buffTier = target:GetBuffTier((self.config).buffId)
    if buffTier < (self.arglist)[2] then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, nil, true)
    else
      if (self.arglist)[2] < buffTier then
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.arglist)[2], nil, true)
      end
    end
  end
end

bs_10237.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10237

