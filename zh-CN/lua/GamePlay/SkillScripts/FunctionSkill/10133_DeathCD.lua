local bs_10133 = class("bs_10133", LuaSkillBase)
local base = LuaSkillBase
bs_10133.config = {buffId = 1204, buffTier = 1}
bs_10133.ctor = function(self)
  -- function num : 0_0
end

bs_10133.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10133_1", 1, self.OnRoleDie)
end

bs_10133.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.belongNum == (self.caster).belongNum and self:IsReadyToTake() then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
    self:OnSkillTake()
  end
end

bs_10133.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10133

