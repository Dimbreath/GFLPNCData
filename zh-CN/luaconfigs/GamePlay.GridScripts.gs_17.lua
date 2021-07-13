-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_17 = class("gs_17", LuaGridBase)
gs_17.config = {effectId = 10370, buffId = 1143, buffTier = 10, sheildBuffId = 174, sheildBuffTier = 1}
gs_17.ctor = function(self)
  -- function num : 0_0
end

gs_17.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_17.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier)
  LuaSkillCtrl:CallBuff(self, role, (self.config).sheildBuffId, (self.config).sheildBuffTier)
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  self:GridLoseEffect()
end

gs_17.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_17.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_17

