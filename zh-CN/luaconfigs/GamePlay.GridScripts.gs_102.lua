-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_102 = class("gs_102", LuaGridBase)
gs_102.config = {effectGridId = 10826}
gs_102.ctor = function(self)
  -- function num : 0_0
end

gs_102.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_102.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(role, (self.config).effectGridId, self)
  self:GridLoseEffect()
end

gs_102.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_102.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_102

