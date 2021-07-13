-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_8 = class("gs_8", LuaGridBase)
gs_8.config = {effectId = 10472, buffId = 1049, buffTier = 1}
gs_8.ctor = function(self)
  -- function num : 0_0
end

gs_8.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_8.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier)
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  self:GridLoseEffect()
end

gs_8.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_8.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_8

