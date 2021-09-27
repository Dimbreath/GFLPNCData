local bs_10239 = class("bs_10239", LuaSkillBase)
local base = LuaSkillBase
bs_10239.config = {buffId = 1092, buffTier = 1, buffId2 = 1125}
bs_10239.ctor = function(self)
  -- function num : 0_0
end

bs_10239.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10239_3", 1, self.OnAfterHurt, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10239_1", 2, self.OnAfterBattleStart)
end

bs_10239.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, nil, true)
end

bs_10239.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster and isCrit and self:IsReadyToTake() and not isTriggerSet then
    self:OnSkillTake()
    local buffTier = target:GetBuffTier((self.config).buffId)
    if buffTier < (self.arglist)[2] then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, nil, true)
    else
      if (self.arglist)[2] < buffTier then
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.arglist)[2], nil, true)
      end
    end
  end
end

bs_10239.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10239

