local gs_6 = class("gs_6", LuaGridBase)
gs_6.config = {effectId = 10370, buffId = 1047, buffTier = 10, sheildBuffId = 174, sheildBuffTier = 1}
gs_6.ctor = function(self)
  -- function num : 0_0
end

gs_6.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_6.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier)
  LuaSkillCtrl:CallBuff(self, role, (self.config).sheildBuffId, (self.config).sheildBuffTier)
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  self:GridLoseEffect()
end

gs_6.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_6.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_6

