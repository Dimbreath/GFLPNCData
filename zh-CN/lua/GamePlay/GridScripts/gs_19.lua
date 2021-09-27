local gs_19 = class("gs_19", LuaGridBase)
gs_19.config = {effectId = 10816}
gs_19.ctor = function(self)
  -- function num : 0_0
end

gs_19.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_19.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  LuaSkillCtrl:CallBuff(self, role, 1145, 1)
  self:GridLoseEffect()
end

gs_19.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_19.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_19

