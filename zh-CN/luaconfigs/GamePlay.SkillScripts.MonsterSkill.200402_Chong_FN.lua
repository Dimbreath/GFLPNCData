-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_200402 = class("bs_200402", LuaSkillBase)
local base = LuaSkillBase
bs_200402.config = {buffId_1005 = 1005}
bs_200402.ctor = function(self)
  -- function num : 0_0
end

bs_200402.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_200402_10", 1, self.OnRoleDie)
end

bs_200402.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if killer == self.caster and role.belongNum == 1 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_1005, (self.arglist)[1], nil, true)
  end
end

bs_200402.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_200402

