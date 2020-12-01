-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_7 = class("gs_7", LuaGridBase)
gs_7.config = {effectId = 10372, buffId = 1048, buffTier = 10, sheildBuffId = 174, sheildBuffTier = 1}
gs_7.ctor = function(self)
  -- function num : 0_0
end

gs_7.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_7.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier)
  LuaSkillCtrl:CallBuff(self, role, (self.config).sheildBuffId, (self.config).sheildBuffTier)
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  self:GridLoseEffect()
end

gs_7.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_7.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_7

-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_7 = class("gs_7", LuaGridBase)
gs_7.config = {
    effectId = 10372,
    buffId = 1048,
    buffTier = 10,
    sheildBuffId = 174,
    sheildBuffTier = 1
}
gs_7.ctor = function(self)
    -- function num : 0_0
end

gs_7.OnGridBattleStart = function(self, role)
    -- function num : 0_1
    if role == nil then self:GridLoseEffect() end
end

gs_7.OnGridEnterRole = function(self, role)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId,
                          (self.config).buffTier)
    LuaSkillCtrl:CallBuff(self, role, (self.config).sheildBuffId,
                          (self.config).sheildBuffTier)
    LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
    self:GridLoseEffect()
end

gs_7.OnGridExitRole = function(self, role)
    -- function num : 0_3
end

gs_7.OnGridRoleDead = function(self, role)
    -- function num : 0_4
end

return gs_7

