local gs_100 = class("gs_100", LuaGridBase)
gs_100.config = {effectGridId = 10824}
gs_100.ctor = function(self)
  -- function num : 0_0
end

gs_100.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_100.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(role, (self.config).effectGridId, self)
end

gs_100.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_100.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

gs_100.OnGridBattleEnd = function(self, role)
  -- function num : 0_5
  local healNum = role.maxHp * 300 // 1000
  role:AddHp(healNum)
end

return gs_100

