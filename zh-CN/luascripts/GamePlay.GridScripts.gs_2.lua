-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_2 = class("gs_2", LuaGridBase)
gs_2.config = {effectCFId = 10176, effectId = 10175}
gs_2.ctor = function(self)
  -- function num : 0_0
end

gs_2.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_2.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, role, 1024, 1, 75)
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  LuaSkillCtrl:CallEffect(role, (self.config).effectCFId, self)
  self:GridLoseEffect()
end

gs_2.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_2.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_2

