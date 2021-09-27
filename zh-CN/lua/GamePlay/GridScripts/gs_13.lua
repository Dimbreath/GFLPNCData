local gs_13 = class("gs_13", LuaGridBase)
gs_13.config = {effectId = 10479, buffId = 1051, buffTier = 1}
gs_13.ctor = function(self)
  -- function num : 0_0
end

gs_13.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_13.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier, 150)
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  self:GridLoseEffect()
end

gs_13.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_13.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_13

