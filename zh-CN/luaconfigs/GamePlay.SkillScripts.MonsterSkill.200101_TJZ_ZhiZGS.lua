-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_200101 = class("bs_200101", LuaSkillBase)
local base = LuaSkillBase
bs_200101.config = {buffId_1129 = 1129}
bs_200101.ctor = function(self)
  -- function num : 0_0
end

bs_200101.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_200101_10", 1, self.OnRoleDie)
end

bs_200101.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).belongNum == role.belongNum then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_1129, 1, nil, true)
  end
end

bs_200101.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_200101

