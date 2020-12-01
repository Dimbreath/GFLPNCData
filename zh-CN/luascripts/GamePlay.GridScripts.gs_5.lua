-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_5 = class("gs_5", LuaGridBase)
gs_5.config = {effectId = 10566, buffId = 1052, buffTier = 1}
gs_5.ctor = function(self)
  -- function num : 0_0
end

gs_5.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_5.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier)
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  self:GridLoseEffect()
end

gs_5.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_5.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_5

-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_5 = class("gs_5", LuaGridBase)
gs_5.config = {effectId = 10566, buffId = 1052, buffTier = 1}
gs_5.ctor = function(self)
    -- function num : 0_0
end

gs_5.OnGridBattleStart = function(self, role)
    -- function num : 0_1
    if role == nil then self:GridLoseEffect() end
end

gs_5.OnGridEnterRole = function(self, role)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId,
                          (self.config).buffTier)
    LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
    self:GridLoseEffect()
end

gs_5.OnGridExitRole = function(self, role)
    -- function num : 0_3
end

gs_5.OnGridRoleDead = function(self, role)
    -- function num : 0_4
end

return gs_5

