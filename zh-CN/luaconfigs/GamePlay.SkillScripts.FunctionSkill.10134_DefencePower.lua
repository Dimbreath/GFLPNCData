-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10134 = class("bs_10134", LuaSkillBase)
local base = LuaSkillBase
bs_10134.config = {buffId = 1074, buffTier = 1}
bs_10134.ctor = function(self)
  -- function num : 0_0
end

bs_10134.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10134_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_10134_2", 2, self.OnCasterAttributeChange)
end

bs_10134.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:OnSkillTake()
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
end

bs_10134.OnCasterAttributeChange = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
    self:PlayChipEffect()
  end
end

bs_10134.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10134

