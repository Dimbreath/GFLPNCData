local gs_18 = class("gs_18", LuaGridBase)
gs_18.config = {effectId = 10372, buffId = 1144, buffTier = 10, sheildBuffId = 174, sheildBuffTier = 1}
gs_18.ctor = function(self)
  -- function num : 0_0
end

gs_18.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_18.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier)
  LuaSkillCtrl:CallBuff(self, role, (self.config).sheildBuffId, (self.config).sheildBuffTier)
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  self:GridLoseEffect()
end

gs_18.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_18.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_18

