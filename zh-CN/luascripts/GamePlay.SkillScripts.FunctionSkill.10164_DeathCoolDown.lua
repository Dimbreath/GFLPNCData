-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10164 = class("bs_10164", LuaSkillBase)
local base = LuaSkillBase
bs_10164.config = {buffId = 1040, buffTier = 1}
bs_10164.ctor = function(self)
  -- function num : 0_0
end

bs_10164.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10164_10", 1, self.OnRoleDie)
end

bs_10164.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).belongNum == role.belongNum and role.roleType == 1 then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1])
  end
end

bs_10164.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10164

