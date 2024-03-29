local bs_10214 = class("bs_10214", LuaSkillBase)
local base = LuaSkillBase
bs_10214.config = {buffId1 = 1041, buffId2 = 1057}
bs_10214.ctor = function(self)
  -- function num : 0_0
end

bs_10214.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10214_1", 1, self.OnAfterBattleStart)
  self:AddSetHealTrigger("bs_10214_4", 1, self.OnSetHeal, nil, nil, nil, (self.caster).belongNum)
end

bs_10214.OnAfterBattleStart = function(self)
  -- function num : 0_2
  self:PlayChipEffect()
end

bs_10214.OnSetHeal = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if (context.target).belongNum == (self.caster).belongNum and self:IsReadyToTake() and not context.isTriggerSet then
    self:OnSkillTake()
    LuaSkillCtrl:CallBuff(self, context.target, (self.config).buffId2, 1, (self.arglist)[3], true)
  end
end

bs_10214.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10214

