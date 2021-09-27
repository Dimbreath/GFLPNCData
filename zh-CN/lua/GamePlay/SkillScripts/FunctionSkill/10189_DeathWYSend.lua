local bs_10189 = class("bs_10189", LuaSkillBase)
local base = LuaSkillBase
bs_10189.config = {}
bs_10189.ctor = function(self)
  -- function num : 0_0
end

bs_10189.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.RoleDie, "bs_10189_10", 1, self.OnRoleDie)
end

bs_10189.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if killer == self.caster and role.belongNum == 2 and LuaSkillCtrl:GetRoleEfcGrid(role) == 10 then
    local grid = LuaSkillCtrl:GetGridWithRole(role)
    LuaSkillCtrl:CallEffect(self.caster, 10263, self)
    LuaSkillCtrl:SetRolePos(grid, self.caster)
    LuaSkillCtrl:CallEffect(self.caster, 10264, self)
  end
end

bs_10189.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10189

