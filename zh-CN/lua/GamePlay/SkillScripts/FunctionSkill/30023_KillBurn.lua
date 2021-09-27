local bs_30023 = class("bs_30023", LuaSkillBase)
local base = LuaSkillBase
bs_30023.config = {buffId = 1179, buffTier = 1}
bs_30023.ctor = function(self)
  -- function num : 0_0
end

bs_30023.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_30023_10", 1, self.OnRoleDie)
end

bs_30023.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if killer == self.caster and role.belongNum ~= 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, (self.arglist)[2], true)
  end
end

bs_30023.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30023

