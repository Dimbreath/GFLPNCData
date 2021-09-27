local bs_10279 = class("bs_10279", LuaSkillBase)
local base = LuaSkillBase
bs_10279.config = {buffId = 1190, buffTier = 1, buffId2 = 1125}
bs_10279.ctor = function(self)
  -- function num : 0_0
end

bs_10279.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10279_3", 1, self.OnAfterHurt, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10279_1", 2, self.OnAfterBattleStart)
end

bs_10279.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, nil, true)
end

bs_10279.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster and isCrit and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  end
end

bs_10279.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10279

