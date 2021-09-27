local bs_10293 = class("bs_10293", LuaSkillBase)
local base = LuaSkillBase
bs_10293.config = {buffId = 1203, buffTier = 1}
bs_10293.ctor = function(self)
  -- function num : 0_0
end

bs_10293.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10293_10", 1, self.OnRoleDie)
end

bs_10293.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.belongNum == (self.caster).belongNum and role.roleType == 1 then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, (self.arglist)[1], true)
  end
end

bs_10293.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10293

