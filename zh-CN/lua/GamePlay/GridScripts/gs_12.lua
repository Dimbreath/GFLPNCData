local gs_12 = class("gs_12", LuaGridBase)
gs_12.config = {effectId = 10477, effectId1 = 10478}
gs_12.ctor = function(self)
  -- function num : 0_0
end

gs_12.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_12.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  local grid = LuaSkillCtrl:GetNearestEmptyEfcGrid(role, 10)
  if grid ~= nil then
    LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
    LuaSkillCtrl:SetRolePos(grid, role)
    LuaSkillCtrl:CallEffect(role, (self.config).effectId1, self)
  end
  self:GridLoseEffect()
end

gs_12.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_12.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_12

