-- params : ...
-- function num : 0 , upvalues : _ENV
local LuaGridBase = class("LuaGridBase")
LuaGridBase.ctor = function(self)
  -- function num : 0_0
end

LuaGridBase.__InitGridInternal = function(self, cEffectGrid, x, y)
  -- function num : 0_1
  self.x = x
  self.y = y
  self.cEffectGrid = cEffectGrid
end

LuaGridBase.__OnGridBattleStartInit = function(self, role)
  -- function num : 0_2
  self.cskill = (self.cEffectGrid).battleSkill
  self:OnGridBattleStart(role)
end

LuaGridBase.OnGridBattleStart = function(self, role)
  -- function num : 0_3
end

LuaGridBase.OnGridEnterRole = function(self, role)
  -- function num : 0_4
end

LuaGridBase.OnGridExitRole = function(self, role)
  -- function num : 0_5
end

LuaGridBase.OnGridRoleDead = function(self, role)
  -- function num : 0_6
end

LuaGridBase.GridLoseEffect = function(self)
  -- function num : 0_7
  (self.cEffectGrid):GridLoseEffect()
end

return LuaGridBase

-- params : ...
-- function num : 0 , upvalues : _ENV
local LuaGridBase = class("LuaGridBase")
LuaGridBase.ctor = function(self)
    -- function num : 0_0
end

LuaGridBase.__InitGridInternal = function(self, cEffectGrid, x, y)
    -- function num : 0_1
    self.x = x
    self.y = y
    self.cEffectGrid = cEffectGrid
end

LuaGridBase.__OnGridBattleStartInit = function(self, role)
    -- function num : 0_2
    self.cskill = (self.cEffectGrid).battleSkill
    self:OnGridBattleStart(role)
end

LuaGridBase.OnGridBattleStart = function(self, role)
    -- function num : 0_3
end

LuaGridBase.OnGridEnterRole = function(self, role)
    -- function num : 0_4
end

LuaGridBase.OnGridExitRole = function(self, role)
    -- function num : 0_5
end

LuaGridBase.OnGridRoleDead = function(self, role)
    -- function num : 0_6
end

LuaGridBase.GridLoseEffect = function(self)
    -- function num : 0_7
    (self.cEffectGrid):GridLoseEffect()
end

return LuaGridBase

