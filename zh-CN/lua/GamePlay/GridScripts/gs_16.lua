local gs_16 = class("gs_16", LuaGridBase)
gs_16.config = {buffId = 1137, buffTier = 1, effectId = 10855}
gs_16.ctor = function(self)
  -- function num : 0_0
end

gs_16.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_16.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  if role ~= nil then
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier, nil, true)
    LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
    self:GridLoseEffect()
  end
end

gs_16.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_16.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_16

