-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10025 = class("bs_10025", LuaSkillBase)
local base = LuaSkillBase
bs_10025.config = {buffId = 74}
bs_10025.ctor = function(self)
  -- function num : 0_0
end

bs_10025.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_10025_5", 1, self.OnAfterHeal)
end

bs_10025.OnAfterHeal = function(self, sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if self:IsReadyToTake() and not isTriggerSet then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, nil, true)
    self:OnSkillTake()
  end
end

bs_10025.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10025

