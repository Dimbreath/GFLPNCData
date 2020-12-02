-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_4 = class("gs_4", LuaGridBase)
gs_4.config = {effectId = 10261, buffId = 1032, buffTier = 1}
gs_4.ctor = function(self)
  -- function num : 0_0
end

gs_4.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_4.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.attackRange > 1 then
    LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier)
    self:GridLoseEffect()
  else
    self:GridLoseEffect()
  end
end

gs_4.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_4.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_4

