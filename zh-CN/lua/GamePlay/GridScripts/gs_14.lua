local gs_14 = class("gs_14", LuaGridBase)
gs_14.config = {effectId = 10482, effectId1 = 10484, buffId = 1162, buffTier = 1}
gs_14.ctor = function(self)
  -- function num : 0_0
end

gs_14.OnGridBattleStart = function(self, role)
  -- function num : 0_1
end

gs_14.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier, nil, true)
  local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
end

gs_14.OnGridExitRole = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:DispelBuff(role, (self.config).buffId, 0, true)
  LuaSkillCtrl:CallEffect(role, (self.config).effectId1, self)
end

gs_14.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_14

