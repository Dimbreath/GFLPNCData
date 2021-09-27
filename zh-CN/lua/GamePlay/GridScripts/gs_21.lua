local gs_21 = class("gs_21", LuaGridBase)
gs_21.config = {effectId = 10815}
gs_21.ctor = function(self)
  -- function num : 0_0
end

gs_21.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_21.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  LuaSkillCtrl:CallBuff(self, role, 1150, 2)
  self:GridLoseEffect()
end

gs_21.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_21.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_21

