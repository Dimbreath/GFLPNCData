local gs_9 = class("gs_9", LuaGridBase)
gs_9.config = {effectId = 10473, buffId = 1207, buffTier = 1}
gs_9.ctor = function(self)
  -- function num : 0_0
end

gs_9.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_9.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier)
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  self:GridLoseEffect()
end

gs_9.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_9.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_9

