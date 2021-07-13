-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20002 = class("bs_20002", LuaSkillBase)
local base = LuaSkillBase
bs_20002.config = {}
bs_20002.ctor = function(self)
  -- function num : 0_0
end

bs_20002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.RoleDie, "bs_20002_10", 1, self.OnRoleDie)
end

bs_20002.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if killer == self.caster and role.belongNum == 2 and LuaSkillCtrl:GetRoleEfcGrid(role) == 10 then
    local grid = LuaSkillCtrl:GetGridWithRole(role)
    LuaSkillCtrl:CallEffect(self.caster, 10263, self)
    LuaSkillCtrl:SetRolePos(grid, self.caster)
    LuaSkillCtrl:CallEffect(self.caster, 10264, self)
  end
end

bs_20002.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20002

