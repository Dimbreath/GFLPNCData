local gs_20 = class("gs_20", LuaGridBase)
gs_20.config = {effectId = 10819}
gs_20.ctor = function(self)
  -- function num : 0_0
end

gs_20.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_20.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  self:GridLoseEffect()
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  LuaSkillCtrl:CallBuff(self, role, 1149, 1)
end

gs_20.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_20.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_20

